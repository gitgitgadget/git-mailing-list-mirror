From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: new 'add-envelope' option
Date: Sat, 21 Nov 2009 19:43:30 +0200
Message-ID: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 21:53:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwrt-00041R-Q7
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557AbZKURne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 12:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbZKURnd
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 12:43:33 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34791 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546AbZKURnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 12:43:33 -0500
Received: by ewy19 with SMTP id 19so573774ewy.21
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sAQfNovw4+vWqHG873cBC1ghvQoWfYcpJODJ5PMWogc=;
        b=Qh+4UTh4AliHI07G3uBHkjRIWomHPo9KKhMf85PkQGcRgRK847iT94SUfEYFmWgNGo
         D8BF4IuOKM4DQIr7SQPxWbwRlnYQpexrHcMyyXlOFqyEjXIskcvquULtOw55yIIpt6xo
         3Lz6+PJkF2R3vkGTQ1TsLt+f17YRrtial2btU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=O1a4NG/n0xXxER1vxQjuzCFVq3VVhqxmKh7x3EQLbXrePqq5IxjDIdBLQa7r4/mfjj
         XlM5Cf2dNOMNPxe9WVgO8/DS9bO9iUdjUf8oPZtgkm+ZzUDvN2dNqZPlu1RKRIN5aiKI
         IpEb6jTeLDhkwkJiHs9keRXpb6l7mlfxS8mp4=
Received: by 10.213.100.65 with SMTP id x1mr2746075ebn.67.1258825418357;
        Sat, 21 Nov 2009 09:43:38 -0800 (PST)
Received: from localhost (74.Red-80-24-4.staticIP.rima-tde.net [80.24.4.74])
        by mx.google.com with ESMTPS id 10sm649061eyz.23.2009.11.21.09.43.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 09:43:36 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.1.ga9388c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133407>

Some MTAs make smart decisions based on the 'from' envelope (i.e. msmtp)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a0279de..92bf491 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -140,6 +140,7 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 
 my $envelope_sender;
+my $envelope_from;
 
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
@@ -208,6 +209,7 @@ my %config_settings = (
     "aliasesfile" => \@alias_files,
     "suppresscc" => \@suppress_cc,
     "envelopesender" => \$envelope_sender,
+    "envelopefrom" => \$envelope_from,
     "multiedit" => \$multiedit,
     "confirm"   => \$confirm,
     "from" => \$sender,
@@ -265,6 +267,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "confirm=s" => \$confirm,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
+		    "envelope-from" => \$envelope_from,
 		    "thread!" => \$thread,
 		    "validate!" => \$validate,
 		    "format-patch!" => \$format_patch,
@@ -861,10 +864,13 @@ X-Mailer: git-send-email $gitversion
 
 	my @sendmail_parameters = ('-i', @recipients);
 	my $raw_from = $sanitized_sender;
-	$raw_from = $envelope_sender if (defined $envelope_sender);
+	if (defined $envelope_sender) {
+		$raw_from = $envelope_sender;
+		$envelope_from = 1;
+	}
 	$raw_from = extract_valid_address($raw_from);
 	unshift (@sendmail_parameters,
-			'-f', $raw_from) if(defined $envelope_sender);
+			'-f', $raw_from) if(defined $envelope_from);
 
 	if ($needs_confirm && !$dry_run) {
 		print "\n$header\n";
-- 
1.6.5.3.1.ga9388c
