From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH 3/8] git-send-email.perl: Handle shell metacharacters in $EDITOR properly
Date: Tue,  8 Apr 2008 21:29:59 -0400
Message-ID: <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
References: <>
 <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 03:32:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjPAc-0007yb-8O
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYDIBbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbYDIBbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:31:16 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49037 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbYDIBbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:31:16 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JjP8b-0007dL-FX; Wed, 09 Apr 2008 01:30:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JjP8W-0007v9-F1; Tue, 08 Apr 2008 21:30:04 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79064>

Also, update t/t9001-send-email.sh to test for this bug.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 git-send-email.perl   |    2 +-
 t/t9001-send-email.sh |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index be4a20d..975df1c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -510,7 +510,7 @@ EOT
 	close(C);
 
 	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-	system('sh', '-c', '$0 $@', $editor, $compose_filename);
+	system('sh', '-c', $editor.' $@', $editor, $compose_filename);
 
 	open(C2,">",$compose_filename . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c0973b4..030f66c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -139,15 +139,19 @@ test_expect_success 'Valid In-Reply-To when prompting' '
 
 test_expect_success 'setup fake editor' '
 	(echo "#!/bin/sh" &&
-	 echo "echo fake edit >>\$1"
+	 echo "echo fake edit >>\"\$1\""
 	) >fake-editor &&
 	chmod +x fake-editor
 '
 
+FAKE_EDITOR="$(pwd)/fake-editor"
+export FAKE_EDITOR
+GIT_EDITOR='"$FAKE_EDITOR"'
+export GIT_EDITOR
+
 test_expect_success '--compose works' '
 	clean_fake_sendmail &&
 	echo y | \
-		GIT_EDITOR=$(pwd)/fake-editor \
 		GIT_SEND_EMAIL_NOTTY=1 \
 		git send-email \
 		--compose --subject foo \
-- 
1.5.5.8.gbbd98
