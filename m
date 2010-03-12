From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sat, 13 Mar 2010 01:04:39 +0200
Organization: Private
Message-ID: <87hbolta48.fsf_-_@jondo.cante.net>
References: <87vdd1ti9f.fsf@jondo.cante.net> <87r5nptdfh.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 00:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqDut-0007Bj-EG
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 00:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757Ab0CLXE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 18:04:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:57342 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932279Ab0CLXE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 18:04:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqDuV-000735-LF
	for git@vger.kernel.org; Sat, 13 Mar 2010 00:04:51 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Mar 2010 00:04:51 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Mar 2010 00:04:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:2Q/PlAZWIGbOLak71qYLf8miPgw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142067>

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


This patch is applied *after* the other 2 sent in this thread.

diff --git a/git-send-email.perl b/git-send-email.perl
index 6af7bd3..2eabed6 100755
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
+sub maildomain ()
+{
+	my $maildomain;
+	eval "use Net::Domain";
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
