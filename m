From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sat, 13 Mar 2010 19:36:09 +0200
Organization: Private
Message-ID: <87bpesi0om.fsf_-_@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 18:40:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqVJs-0008HV-AZ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 18:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934224Ab0CMRkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 12:40:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:36529 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933453Ab0CMRkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 12:40:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqVJj-0008Cc-Te
	for git@vger.kernel.org; Sat, 13 Mar 2010 18:40:03 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Mar 2010 18:40:03 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Mar 2010 18:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:ewlafXY5i0XzVaYlRi8J+CfRg4Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142101>

Add new function maildomain() which returns FQDN for use in
send_message(). The value is passed to Net::SMTP HELO/EHLO handshake.

The default value in Net::SMTP may not get through:

  Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
  Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host

whereas using the FQDN, the result is:

  Net::SMTP=GLOB(0x15b8e80)>>> EHLO host.example.com
  Net::SMTP=GLOB(0x15b8e80)<<< 250-host.example.com Hello host.example.com [192.168.1.7]

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |   52 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 2 deletions(-)


        This is a reworked patch

        - In maildomain() start with "use Net::SMTP". Had "use Net::Domain" twice.
        - In maildomain() lose the "()" prototype.


diff --git a/git-send-email.perl b/git-send-email.perl
index 6af7bd3..f743d9e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -834,6 +834,46 @@ sub sanitize_address
 
 }
 
+# Returns the local Fully Qualified Domain Name (FQDN) if available,
+# If this is not given to EHLO, the receiving SMTP may deny connection
+# Here is an example of Net::SMTP without explicit Helo: it
+# uses by default "localhost.localdomain"
+#
+# Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
+# Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host
+
+sub maildomain
+{
+	my $maildomain;
+	eval "use Net::SMTP";
+
+	unless ( $@ ) {
+		for my $host ( qw(mailhost localhost) ) {
+			my $smtp = Net::SMTP->new($host);
+			if (defined $smtp) {
+				my $domain = $smtp->domain;
+				$smtp->quit;
+
+				$maildomain = $domain
+					unless $^O eq 'darwin' && $domain =~ /\.local$/;
+
+				last if $maildomain;
+			}
+		}
+	}
+
+	unless ($maildomain) {
+		eval "use Net::Domain";
+		unless ( $@ ) {
+		    my $domain = Net::Domain::domainname();
+		    $maildomain = $domain
+			    unless $^O eq 'darwin' && $domain =~ /\.local$/;
+		}
+	}
+
+	$maildomain;
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -917,6 +957,8 @@ X-Mailer: git-send-email $gitversion
 		}
 	}
 
+	my $maildomain;
+
 	if ($dry_run) {
 		# We don't want to send the email.
 	} elsif ($smtp_server =~ m#^/#) {
@@ -936,13 +978,18 @@ X-Mailer: git-send-email $gitversion
 		if ($smtp_encryption eq 'ssl') {
 			$smtp_server_port ||= 465; # ssmtp
 			require Net::SMTP::SSL;
-			$smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
+			$maildomain = maildomain() || "localhost.localdomain";
+			$smtp ||= Net::SMTP::SSL->new($smtp_server,
+						      Hello => $maildomain,
+						      Port => $smtp_server_port);
 		}
 		else {
 			require Net::SMTP;
+			$maildomain = maildomain() || "localhost.localdomain";
 			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
 						 ? "$smtp_server:$smtp_server_port"
 						 : $smtp_server,
+						 Hello => $maildomain,
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
@@ -962,9 +1009,10 @@ X-Mailer: git-send-email $gitversion
 		}
 
 		if (!$smtp) {
-			die "Unable to initialize SMTP properly. Check config. ",
+			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
 			    "VALUES: server=$smtp_server ",
 			    "encryption=$smtp_encryption ",
+			    "maildomain=$maildomain",
 			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
 		}
 
-- 
1.7.0
