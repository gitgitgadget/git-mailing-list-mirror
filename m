From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 03/10] git-send-email.perl: Handle shell metacharacters in $EDITOR properly
Date: Thu, 10 Apr 2008 02:50:09 -0400
Message-ID: <1207810216-27871-4-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjqe7-0003D5-2P
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbYDJGvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbYDJGvn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:51:43 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34049 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbYDJGvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:51:42 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003w8-OG; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbw-0007Fv-T5; Thu, 10 Apr 2008 02:50:16 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79178>

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
1.5.5.33.gc0a39.dirty
