Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DEAC761AF
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjCWQre (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCWQrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:03 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034ACC24
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:32 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id B540C241F0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:34 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-Axn-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] t/lib-rebase: (mostly) cosmetic improvements to set_fake_editor()
Date:   Thu, 23 Mar 2023 17:22:34 +0100
Message-Id: <20230323162234.995450-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Make the documentation reflect better what actually happens, and add
  some missing info
- Fix recognition of reset's short command in FAKE_LINES
- Default next action after 'fakesha' to preserving the command instead
  of forcing 'pick'. This is consistent with other "instant-effect"
  keywords.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 t/lib-rebase.sh | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 7ca5b918f0..184b25b427 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -8,18 +8,21 @@
 # - check that non-commit messages have a certain line count with $EXPECT_COUNT
 # - check the commit count in the commit message header with $EXPECT_HEADER_COUNT
 # - rewrite a rebase -i script as directed by $FAKE_LINES.
-#   $FAKE_LINES consists of a sequence of words separated by spaces.
-#   The following word combinations are possible:
+#   $FAKE_LINES consists of a sequence of words separated by spaces;
+#   spaces inside the words are encoded as underscores.
+#   The following words are possible:
 #
-#   "<lineno>" -- add a "pick" line with the SHA1 taken from the
-#       specified line.
+#   "<cmd>" -- override the command for the next line specification. Can be
+#       "pick", "squash", "fixup"|"fixup_-C"|"fixup_-c", "edit", "reword",
+#       "drop", "merge[_-{c|C}_<SHA1>]", or "bad" for an invalid command.
 #
-#   "<cmd> <lineno>" -- add a line with the specified command
-#       ("pick", "squash", "fixup"|"fixup_-C"|"fixup_-c", "edit", "reword" or "drop")
-#       and the SHA1 taken from the specified line.
+#   "<lineno>" -- add a command, using the specified line as a template.
+#       If the command has not been overridden, the line will be copied
+#       verbatim, usually resulting in a "pick" line.
 #
-#   "_" -- add a space, like "fixup_-C" implies "fixup -C" and
-#       "exec_cmd_with_args" add an "exec cmd with args" line.
+#   "fakesha" -- add a command ("pick" by default), using a fake SHA1.
+#
+#   "exec_[...]", "break" -- add the specified command.
 #
 #   "#" -- Add a comment line.
 #
@@ -49,7 +52,7 @@ set_fake_editor () {
 	action=\&
 	for line in $FAKE_LINES; do
 		case $line in
-		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
+		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|t|merge|m)
 			action="$line";;
 		exec_*|x_*|break|b)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
@@ -64,7 +67,7 @@ set_fake_editor () {
 		fakesha)
 			test \& != "$action" || action=pick
 			echo "$action XXXXXXX False commit" >> "$1"
-			action=pick;;
+			action=\&;;
 		*)
 			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"
 			action=\&;;
-- 
2.40.0.152.g15d061e6df

