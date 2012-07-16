From: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
Subject: [PATCH v2] Fix notes handling in rev-list
Date: Mon, 16 Jul 2012 21:30:09 +0300
Message-ID: <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
References: <20120325005504.GA27651@sigill.intra.peff.net>
Cc: peff@peff.net, Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 20:31:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqq4v-00058p-TA
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 20:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab2GPSbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 14:31:25 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34332 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab2GPSbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 14:31:23 -0400
Received: by lbbgm6 with SMTP id gm6so9043000lbb.19
        for <git@vger.kernel.org>; Mon, 16 Jul 2012 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qkPkjOdGD6+ITuOHHhP52voEs79qdEiskvlsiE8soa8=;
        b=fP7zbbzYfbbnLGs4vNWaplb2NYiYiF6M/WM8XBDaulBXTK6DgYo8oM6V+lZ/lyw/fi
         +b/y+03cYdxoNMeGyNJUaAm/bPNv7hgmUnXAwUV3Ad7pZj8eZ154GXznn6QRi4lLiIwh
         NsN9GV9W2RCpfnE/oJlbJzDIeAEl4wU1G4gcC7IXg1+xNZ+2ZmfZ6poiMEOLLa0hcEb7
         b4L1697rGJSmpvwzXL+BNHtnuPmUpTxiezvgjkI49t053hpmIuaVpFJywyXeMILQKuYu
         bHDj2TvyRJaVk8uIs4OyGbVzOPjyJpd6215ls0C94oQHlubjm68hFjRALiFp+Hfit3qO
         Tllg==
Received: by 10.152.112.233 with SMTP id it9mr12366461lab.40.1342463482179;
        Mon, 16 Jul 2012 11:31:22 -0700 (PDT)
Received: from localhost.localdomain (dsl-hkibrasgw3-ff2cc000-82.dhcp.inet.fi. [88.192.44.82])
        by mx.google.com with ESMTPS id j5sm3658173lbg.1.2012.07.16.11.31.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jul 2012 11:31:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <20120325005504.GA27651@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201543>

Display notes in the rev-list when switch '--notes' is used.
Also expand notes place holder (%N) in user format.
Previously rev-list ignored both of these.

Signed-off-by: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
---

Thanks for your feedback Peff!

 builtin/rev-list.c         |   16 +++++++++++++++-
 t/t6006-rev-list-format.sh |   22 +++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff5a383..ad8abcb 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -7,6 +7,7 @@
 #include "log-tree.h"
 #include "graph.h"
 #include "bisect.h"
+#include "notes.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -111,6 +112,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.date_mode = revs->date_mode;
 		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
+		ctx.show_notes = revs->show_notes;
 		pretty_print_commit(&ctx, commit, &buf);
 		if (revs->graph) {
 			if (buf.len) {
@@ -159,6 +161,12 @@ static void show_commit(struct commit *commit, void *data)
 	} else {
 		if (graph_show_remainder(revs->graph))
 			putchar('\n');
+		if (revs->show_notes_given) {
+			struct strbuf buf = STRBUF_INIT;
+			format_display_notes(commit->object.sha1, &buf, 0, NOTES_SHOW_HEADER|NOTES_INDENT); 
+			fwrite(buf.buf, 1, buf.len, stdout);
+			strbuf_release(&buf);
+		}
 	}
 	maybe_flush_or_die(stdout, "stdout");
 	finish_commit(commit, data);
@@ -309,6 +317,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct rev_list_info info;
+	struct userformat_want userformat_want = {0};
 	int i;
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
@@ -322,9 +331,14 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
+
+	userformat_find_requirements(NULL, &userformat_want);
+	if (userformat_want.notes)
+		revs.show_notes = 1;
 	if (revs.bisect)
 		bisect_list = 1;
-
+	if (revs.show_notes)
+		init_display_notes(&revs.notes_opt);
 	if (DIFF_OPT_TST(&revs.diffopt, QUICK))
 		info.flags |= REV_LIST_QUIET;
 	for (i = 1 ; i < argc; i++) {
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index f94f0c4..ab616a0 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -7,7 +7,8 @@ test_description='git rev-list --pretty=format test'
 test_tick
 test_expect_success 'setup' '
 touch foo && git add foo && git commit -m "added foo" &&
-  echo changed >foo && git commit -a -m "changed foo"
+  echo changed >foo && git commit -a -m "changed foo" &&
+  git notes add -m "note foo"
 '
 
 # usage: test_format name format_string <expected_output
@@ -19,6 +20,25 @@ test_cmp expect.$1 output.$1
 "
 }
 
+test_expect_success 'notes switch' "
+cat >expect.notes_switch <<'EOF'
+131a310eb913d107dd3c09a65d1651175898735d
+
+Notes:
+    note foo
+86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+EOF
+git rev-list --notes master >output.notes_switch &&
+test_cmp expect.notes_switch output.notes_switch
+"
+
+test_format notes %N <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+note foo
+
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+EOF
+
 test_format percent %%h <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
 %h
-- 
1.7.4.1
