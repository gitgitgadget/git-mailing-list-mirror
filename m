From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 12:21:34 +0200
Organization: Private
Message-ID: <878w9vdx01.fsf@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 11:32:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nql7M-0000OJ-AH
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 11:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828Ab0CNKcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 06:32:15 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:46650 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747Ab0CNKcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 06:32:14 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id C772BC7F79;
	Sun, 14 Mar 2010 12:21:38 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A048FBC3FBF; Sun, 14 Mar 2010 12:21:38 +0200
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 784FFE51A3;
	Sun, 14 Mar 2010 12:21:34 +0200 (EET)
In-Reply-To: <7vtysjs9hi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 13 Mar 2010 22:28:09 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142131>

Add new functions maildomain_net(), maildomain_mta() and
maildomain(), which return FQDN where possible for use in
send_message(). The value is passed to Net::SMTP HELO/EHLO
handshake. The domain name can also be set via new --smtp-domain
option.

The default value in Net::SMTP may not get through:

  Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
  Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host

whereas using the FQDN that matches the IP, the result is:

  Net::SMTP=GLOB(0x15b8e80)>>> EHLO host.example.com
  Net::SMTP=GLOB(0x15b8e80)<<< 250-host.example.com Hello host.example.com [192.168.1.7]

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |   83 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 81 insertions(+), 2 deletions(-)


    ==============================
    This is REVISION 3, reworked
    ==============================


diff --git a/git-send-email.perl b/git-send-email.perl
index 6af7bd3..80de092 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -64,6 +64,7 @@ git send-email [options] <file | directory | rev-list options >
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
+    --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
   Automating:
@@ -131,6 +132,7 @@ my $have_email_valid = eval { require Email::Valid; 1 };
 my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
+my $mail_domain;
 
 sub unique_email_list(@);
 sub cleanup_compose_files();
@@ -274,6 +276,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-debug:i" => \$debug_net_smtp,
+		    "smtp-domain:s" => \$mail_domain,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
 		    "compose" => \$compose,
@@ -834,6 +837,74 @@ sub sanitize_address
 
 }
 
+# Returns the local Fully Qualified Domain Name (FQDN) if available.
+#
+# Tightly configured MTAa require that a caller sends a real DNS
+# domain name that corresponds the IP address in the HELO/EHLO
+# handshake. This is used to verify the connection and prevent
+# spammers from trying to hide their identity. If the DNS and IP don't
+# match, the receiveing MTA may deny the connection.
+#
+# Here is a deny example of Net::SMTP with the default "localhost.localdomain"
+#
+# Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
+# Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host
+
+sub maildomain_net
+{
+	my $maildomain;
+	eval "use Net::Domain";
+
+	unless ($@) {
+		eval "use Net::Domain";
+		unless ($@) {
+		    my $domain = Net::Domain::domainname();
+		    $maildomain = $domain
+			    unless $^O eq 'darwin' && $domain =~ /\.local$/;
+		}
+	}
+
+	$maildomain;
+}
+
+sub maildomain_mta
+{
+	my $maildomain;
+	eval "use Net::SMTP";
+
+	unless ($@) {
+		for my $host (qw(mailhost localhost)) {
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
+	$maildomain;
+}
+
+{
+    my $mail_domain_system;		# Static variable
+sub maildomain
+{
+    if ($mail_domain) {
+	    $mail_domain		# Command line
+    } elsif ($mail_domain_system) {	# Saved system default
+	    $mail_domain_system;
+    } else {
+	    $mail_domain_system = maildomain_net() ||
+				 maildomain_mta() ||
+				 "localhost.localdomain";
+    }
+}}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -917,6 +988,8 @@ X-Mailer: git-send-email $gitversion
 		}
 	}
 
+	my $maildomain;
+
 	if ($dry_run) {
 		# We don't want to send the email.
 	} elsif ($smtp_server =~ m#^/#) {
@@ -936,13 +1009,18 @@ X-Mailer: git-send-email $gitversion
 		if ($smtp_encryption eq 'ssl') {
 			$smtp_server_port ||= 465; # ssmtp
 			require Net::SMTP::SSL;
-			$smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
+			$maildomain = maildomain();
+			$smtp ||= Net::SMTP::SSL->new($smtp_server,
+						      Hello => $maildomain,
+						      Port => $smtp_server_port);
 		}
 		else {
 			require Net::SMTP;
+			$maildomain = maildomain();
 			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
 						 ? "$smtp_server:$smtp_server_port"
 						 : $smtp_server,
+						 Hello => $maildomain,
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
@@ -962,9 +1040,10 @@ X-Mailer: git-send-email $gitversion
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
