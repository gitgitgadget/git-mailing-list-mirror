From: Eric Wong <e@80x24.org>
Subject: [PATCH v2 3/3] am: support --patch-format=mboxrd
Date: Sun,  5 Jun 2016 04:46:41 +0000
Message-ID: <20160605044641.9221-4-e@80x24.org>
References: <20160605044641.9221-1-e@80x24.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 06:47:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9Pxn-0006ip-AM
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 06:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbcFEEq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 00:46:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35416 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbcFEEq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 00:46:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025091FE8F;
	Sun,  5 Jun 2016 04:46:45 +0000 (UTC)
In-Reply-To: <20160605044641.9221-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296464>

Combined with "git format-patch --pretty=mboxrd", this should
allow us to round-trip commit messages with embedded mbox
"From " lines without corruption.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/git-am.txt |  3 ++-
 builtin/am.c             | 14 +++++++++++---
 t/t4150-am.sh            | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 13cdd7f..6348c29 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -116,7 +116,8 @@ default.   You can use `--no-utf8` to override this.
 	By default the command will try to detect the patch format
 	automatically. This option allows the user to bypass the automatic
 	detection and specify the patch format that the patch(es) should be
-	interpreted as. Valid formats are mbox, stgit, stgit-series and hg.
+	interpreted as. Valid formats are mbox, mboxrd,
+	stgit, stgit-series and hg.
 
 -i::
 --interactive::
diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..d5da5fe 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -70,7 +70,8 @@ enum patch_format {
 	PATCH_FORMAT_MBOX,
 	PATCH_FORMAT_STGIT,
 	PATCH_FORMAT_STGIT_SERIES,
-	PATCH_FORMAT_HG
+	PATCH_FORMAT_HG,
+	PATCH_FORMAT_MBOXRD
 };
 
 enum keep_type {
@@ -712,7 +713,8 @@ done:
  * Splits out individual email patches from `paths`, where each path is either
  * a mbox file or a Maildir. Returns 0 on success, -1 on failure.
  */
-static int split_mail_mbox(struct am_state *state, const char **paths, int keep_cr)
+static int split_mail_mbox(struct am_state *state, const char **paths,
+				int keep_cr, int mboxrd)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf last = STRBUF_INIT;
@@ -724,6 +726,8 @@ static int split_mail_mbox(struct am_state *state, const char **paths, int keep_
 	argv_array_push(&cp.args, "-b");
 	if (keep_cr)
 		argv_array_push(&cp.args, "--keep-cr");
+	if (mboxrd)
+		argv_array_push(&cp.args, "--mboxrd");
 	argv_array_push(&cp.args, "--");
 	argv_array_pushv(&cp.args, paths);
 
@@ -965,13 +969,15 @@ static int split_mail(struct am_state *state, enum patch_format patch_format,
 
 	switch (patch_format) {
 	case PATCH_FORMAT_MBOX:
-		return split_mail_mbox(state, paths, keep_cr);
+		return split_mail_mbox(state, paths, keep_cr, 0);
 	case PATCH_FORMAT_STGIT:
 		return split_mail_conv(stgit_patch_to_mail, state, paths, keep_cr);
 	case PATCH_FORMAT_STGIT_SERIES:
 		return split_mail_stgit_series(state, paths, keep_cr);
 	case PATCH_FORMAT_HG:
 		return split_mail_conv(hg_patch_to_mail, state, paths, keep_cr);
+	case PATCH_FORMAT_MBOXRD:
+		return split_mail_mbox(state, paths, keep_cr, 1);
 	default:
 		die("BUG: invalid patch_format");
 	}
@@ -2201,6 +2207,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 		*opt_value = PATCH_FORMAT_STGIT_SERIES;
 	else if (!strcmp(arg, "hg"))
 		*opt_value = PATCH_FORMAT_HG;
+	else if (!strcmp(arg, "mboxrd"))
+		*opt_value = PATCH_FORMAT_MBOXRD;
 	else
 		return error(_("Invalid value for --patch-format: %s"), arg);
 	return 0;
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index b41bd17..9ce9424 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -957,4 +957,24 @@ test_expect_success 'am -s unexpected trailer block' '
 	test_cmp expect actual
 '
 
+test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	echo mboxrd >>file &&
+	git add file &&
+	cat >msg <<-\INPUT_END &&
+	mboxrd should escape the body
+
+	From could trip up a loose mbox parser
+	>From extra escape for reversibility
+	INPUT_END
+	git commit -F msg &&
+	git format-patch --pretty=mboxrd --stdout -1 >mboxrd1 &&
+	grep "^>From could trip up a loose mbox parser" mboxrd1 &&
+	git checkout -f first &&
+	git am --patch-format=mboxrd mboxrd1 &&
+	git cat-file commit HEAD | tail -n4 >out &&
+	test_cmp msg out
+'
+
 test_done
