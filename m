From: Jari Aalto <jari.aalto@cante.net>
Subject: [PATCH] git-send-email.perl: add option --smtp-debug
Date: Fri, 12 Mar 2010 23:53:06 +0200
Organization: Private
Message-ID: <87r5nptdfh.fsf@jondo.cante.net>
References: <87vdd1ti9f.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 22:53:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqCne-0006S9-Az
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 22:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758702Ab0CLVx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 16:53:28 -0500
Received: from lo.gmane.org ([80.91.229.12]:49617 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758432Ab0CLVxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 16:53:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NqCnG-0006F5-Nh
	for git@vger.kernel.org; Fri, 12 Mar 2010 22:53:18 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 22:53:18 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 22:53:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:1LxcaIqPW+Q4p5NnBjz6bCBcMRg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142066>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 git-send-email.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

This patch makes it possible to see what's really going on instead of
reading a cryptic message like "Unable to initialize SMTP properly".

An example:

$ git send-email --smtp-debug 1  ...

Net::SMTP>>> Net::SMTP(2.31)
Net::SMTP>>>   Net::Cmd(2.29)
Net::SMTP>>>     Exporter(5.63)
Net::SMTP>>>   IO::Socket::INET(1.31)
Net::SMTP>>>     IO::Socket(1.31)
Net::SMTP>>>       IO::Handle(1.28)
Net::SMTP=GLOB(0x267ec28)<<< 220 picasso.cante.net ESMTP Exim 4.71 Fri, 12 Mar 2010 23:49:15 +0200
Net::SMTP=GLOB(0x267ec28)>>> EHLO localhost.localdomain
Net::SMTP=GLOB(0x267ec28)<<< 550 EHLO argument does not match calling host
Net::SMTP=GLOB(0x267ec28)>>> HELO localhost.localdomain
Net::SMTP=GLOB(0x267ec28)<<< 550 HELO argument does not match calling host


diff --git a/git-send-email.perl b/git-send-email.perl
index 221506c..6af7bd3 100755
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
-- 
1.7.0
