From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-send-email.perl - Fix 550 EHLO argument does not match calling host
Date: Sun, 14 Mar 2010 01:56:41 +0200
Organization: Private
Message-ID: <87eijng4hy.fsf@jondo.cante.net>
References: <4B97C157.4020806@gmail.com>
	<20100311081213.GA13575@sigill.intra.peff.net>
	<20100311083148.GA13786@sigill.intra.peff.net>
	<7vaaueziv8.fsf@alter.siamese.dyndns.org> <4B9A74CA.4080507@gmail.com>
	<7vy6hxnnfx.fsf@alter.siamese.dyndns.org>
	<87bpesi0om.fsf_-_@jondo.cante.net>
	<7vfx433l9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 14 00:57:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqbCY-0003X8-Ao
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 00:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759424Ab0CMX45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 18:56:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:39936 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759415Ab0CMX44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 18:56:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqbCP-0003Vt-IV
	for git@vger.kernel.org; Sun, 14 Mar 2010 00:56:53 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 00:56:53 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 00:56:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:WUmjVSBs83L7i+w39boR3PpDsTc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142123>

Add new function maildomain() which returns FQDN for use in
send_message(). The value is passed to Net::SMTP HELO/EHLO handshake.
The domain name can also be set via --smtp-domain option.

The default value in Net::SMTP may not get through:

  Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
  Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host

whereas using the FQDN, the result is:

  Net::SMTP=GLOB(0x15b8e80)>>> EHLO host.example.com
  Net::SMTP=GLOB(0x15b8e80)<<< 250-host.example.com Hello host.example.com [192.168.1.7]

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |   57 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 2 deletions(-)

> Junio C Hamano <gitster@pobox.com> writes:
> I think you identified a good issue to tackle.  But is it really the
> optimal solution?
>
>  - Is it the best we can do to always make an empty connection only to
>    check if the we have hosts locally known as mailhost or localhost
>    listens to SMTP port?  And calling this function again and again, even
>    after sending one message to the same $smtp_server successfully ($smtp
>    in the global scope is already set in that case)?

A new patch below. I made the value global, so that it's set only once
for the duration of program.

>  - You are trying to improve the chance that $smtp_server likes the name
>    your side identifies as; what does it have to do with your local
>    "mailhost" or "localhost" listening to the SMTP port?  These local MTA
>    may be configured for local-only delivery after all.

There is now explicit option to set the name with option --mail-domain.
Hope this address the issue.

    ** applies after the other two patches **

Jari

diff --git a/git-send-email.perl b/git-send-email.perl
index 6af7bd3..ef7cc30 100755
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
+my $MAIL_DOMAIN;			# See maildomain()
 
 sub unique_email_list(@);
 sub cleanup_compose_files();
@@ -274,6 +276,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-debug:i" => \$debug_net_smtp,
+		    "smtp-domain:s" => \$MAIL_DOMAIN,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
 		    "compose" => \$compose,
@@ -834,6 +837,48 @@ sub sanitize_address
 
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
+        return $MAIL_DOMAIN if $MAIL_DOMAIN;
+
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
+	$MAIL_DOMAIN = $maildomain;
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -917,6 +962,8 @@ X-Mailer: git-send-email $gitversion
 		}
 	}
 
+	my $maildomain;
+
 	if ($dry_run) {
 		# We don't want to send the email.
 	} elsif ($smtp_server =~ m#^/#) {
@@ -936,13 +983,18 @@ X-Mailer: git-send-email $gitversion
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
@@ -962,9 +1014,10 @@ X-Mailer: git-send-email $gitversion
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
