From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH 3/3] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 17:16:45 +0200
Organization: Private
Message-ID: <87sk83aq76.fsf_-_@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
	<87eijng4hy.fsf@jondo.cante.net>
	<7vtysjs9hi.fsf@alter.siamese.dyndns.org>
	<878w9vdx01.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 16:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqph6-00021x-CE
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 16:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab0CNPZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 11:25:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:54805 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab0CNPZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 11:25:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nqpgd-0001pm-Bd
	for git@vger.kernel.org; Sun, 14 Mar 2010 16:25:03 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:25:03 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:25:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:kaUSgPZXtFzUYgKGoBjsZVEAQko=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142145>

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

The maildomain*() code is based on ideas in Perl library
Test::Reporter by Graham Barr <gbarr@pobox.com> and Mark Overmeer
<mailtools@overmeer.net> released under 'the same terms as Perl
itself'.

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 1 deletions(-)



    ================================
    This is REVISION SET 4, reworked
    ================================



diff --git a/git-send-email.perl b/git-send-email.perl
index a8887ea..5fe8246 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -64,6 +64,7 @@ git send-email [options] <file | directory | rev-list options >
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
+    --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
   Automating:
@@ -131,6 +132,8 @@ my $have_email_valid = eval { require Email::Valid; 1 };
 my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
+my $mail_domain_default = "localhost.localdomain";
+my $mail_domain;
 
 sub unique_email_list(@);
 sub cleanup_compose_files();
@@ -274,6 +277,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-debug:i" => \$debug_net_smtp,
+		    "smtp-domain:s" => \$mail_domain,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
 		    "compose" => \$compose,
@@ -834,6 +838,65 @@ sub sanitize_address
 
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
+#
+# This maildomain*() code is based on ideas in Perl library Test::Reporter
+# /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
+
+sub maildomain_net
+{
+	my $maildomain;
+
+	if (eval { require Net::Domain; 1 }) {
+		eval "use Net::Domain";
+		unless ($@) {
+		    my $domain = Net::Domain::domainname();
+		    $maildomain = $domain
+			    unless $^O eq 'darwin' && $domain =~ /\.local$/;
+		}
+	}
+
+	return $maildomain;
+}
+
+sub maildomain_mta
+{
+	my $maildomain;
+
+	if (eval { require Net::SMTP; 1 }) {
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
+	return $maildomain;
+}
+
+sub maildomain
+{
+	return maildomain_net() || maildomain_mta() || $mail_domain_default;
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -936,13 +999,18 @@ X-Mailer: git-send-email $gitversion
 		if ($smtp_encryption eq 'ssl') {
 			$smtp_server_port ||= 465; # ssmtp
 			require Net::SMTP::SSL;
-			$smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
+			$mail_domain ||= maildomain();
+			$smtp ||= Net::SMTP::SSL->new($smtp_server,
+						      Hello => $mail_domain,
+						      Port => $smtp_server_port);
 		}
 		else {
 			require Net::SMTP;
+			$mail_domain ||= maildomain();
 			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
 						 ? "$smtp_server:$smtp_server_port"
 						 : $smtp_server,
+						 Hello => $mail_domain,
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
@@ -965,6 +1033,7 @@ X-Mailer: git-send-email $gitversion
 			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
 			    "VALUES: server=$smtp_server ",
 			    "encryption=$smtp_encryption ",
+			    "maildomain=$mail_domain",
 			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
 		}
 
-- 
1.7.0
