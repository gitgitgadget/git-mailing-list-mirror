From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH 2/3] git-send-email.perl: add option --smtp-debug
Date: Sun, 14 Mar 2010 17:16:09 +0200
Organization: Private
Message-ID: <87wrxfaq86.fsf_-_@jondo.cante.net>
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
X-From: git-owner@vger.kernel.org Sun Mar 14 16:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqpby-0008Nn-Qz
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 16:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041Ab0CNPUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 11:20:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:58640 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab0CNPUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 11:20:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nqpbm-0008Gc-RN
	for git@vger.kernel.org; Sun, 14 Mar 2010 16:20:02 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:20:02 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:20:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:AtzGpDZnFxiHz0STOhFYofhEsEc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142144>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)


    ================================
    This is REVISION SET 4, reworked
    ================================


diff --git a/git-send-email.perl b/git-send-email.perl
index 221506c..a8887ea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -64,6 +64,7 @@ git send-email [options] <file | directory | rev-list options >
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
+    --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
@@ -187,6 +188,8 @@ my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($validate, $confirm);
 my (@suppress_cc);
 
+my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
+
 my $not_set_by_user = "true but not set by the user";
 
 my %config_bool_settings = (
@@ -270,6 +273,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
+		    "smtp-debug:i" => \$debug_net_smtp,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
 		    "compose" => \$compose,
@@ -938,7 +942,8 @@ X-Mailer: git-send-email $gitversion
 			require Net::SMTP;
 			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
 						 ? "$smtp_server:$smtp_server_port"
-						 : $smtp_server);
+						 : $smtp_server,
+						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
 				$smtp->command('STARTTLS');
@@ -957,7 +962,7 @@ X-Mailer: git-send-email $gitversion
 		}
 
 		if (!$smtp) {
-			die "Unable to initialize SMTP properly. Check config. ",
+			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
 			    "VALUES: server=$smtp_server ",
 			    "encryption=$smtp_encryption ",
 			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
-- 
1.7.0
