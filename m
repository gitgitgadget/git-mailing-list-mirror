From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 03/10] git-send-email.perl: Handle shell metacharacters in $EDITOR properly
Date: Sun,  4 May 2008 01:37:53 -0400
Message-ID: <1209879480-16910-4-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-3-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWwh-0004V4-F4
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbYEDFin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbYEDFin
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:38:43 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37806 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYEDFim (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:38:42 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Md-UR; Sun, 04 May 2008 05:38:07 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvA-0004PB-Px; Sun, 04 May 2008 01:38:00 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1209879480-16910-3-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81141>

This fixes the git-send-perl semantics for launching an editor when
$GIT_EDITOR (or friends) contains shell metacharacters to match
launch_editor() in builtin-tag.c. If we use the current approach
(sh -c '$0 $@' "$EDITOR" files ...), we see it fails when $EDITOR has
shell metacharacters:

$ sh -x -c '$0 $@' "$VISUAL" "foo"
+ "$FAKE_EDITOR" foo
"$FAKE_EDITOR": 1: "$FAKE_EDITOR": not found

Whereas builtin-tag.c will invoke sh -c "$EDITOR \"$@\"".

Thus, this patch changes git-send-email.perl to use the same method as the
C utilities, and additionally updates t/t9001-send-email.sh to test for this bug.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 git-send-email.perl   |    2 +-
 t/t9001-send-email.sh |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9e568bf..b502396 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -512,7 +512,7 @@ EOT
 	close(C);
 
 	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-	system('sh', '-c', '$0 $@', $editor, $compose_filename);
+	system('sh', '-c', $editor.' "$@"', $editor, $compose_filename);
 
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
1.5.5.1.128.g03a943
