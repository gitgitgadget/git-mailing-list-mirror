Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA2BC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 09:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiKNJvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiKNJun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 04:50:43 -0500
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 01:50:42 PST
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942C41EC52
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 01:50:42 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F15331F910
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 09:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1668418875;
        bh=eRZIhUP4LHeWFs8uHM4OfhJyND74FOd7Lqq8hwy8UFk=;
        h=From:To:Subject:Date:From;
        b=dgu3MTSr9XL665htNMn6NZocjWnyyTDo7zPN4jKEfCpxl1SEWFJTqKYsjvzQuI6AJ
         k7us+d9uLniuWU3NHVH+dLc1MyBuY3aApAIOjXKcVmhx1F13IpQjBrjnNG5E+eT7Hc
         3Yc7C3VS74OtmpLdK7Md/SKW8AM4QjIMTQuDm2+4=
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: [PATCH] format-patch: add --mboxrd alias for --pretty=mboxrd
Date:   Mon, 14 Nov 2022 09:41:14 +0000
Message-Id: <20221114094114.18986-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mboxrd is a superior output format when used with --stdout and
needs more exposure.  Including pretty-formats.txt would be
excessive, since documenting --pretty= for `git format-patch'
would likely be confusing to users.

Instead of documenting --pretty, add an --mboxrd alias to save
keystrokes and improve documentation.

Signed-off-by: Eric Wong <e@80x24.org>
---
 Also, --mboxrd without --stdout makes no sense to me,
 so I'm considering warning on it...

 Side note: some of the OPT_* switches might be misplaced
 under the "Messaging" OPT_GROUP...

 Documentation/git-format-patch.txt     | 6 +++++-
 builtin/log.c                          | 7 +++++++
 contrib/completion/git-completion.bash | 2 +-
 t/t4014-format-patch.sh                | 6 ++++--
 t/t4150-am.sh                          | 2 +-
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index dfcc7da4c211..b080d3c61e31 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
+'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout] [--mboxrd]
 		   [--no-thread | --thread[=<style>]]
 		   [(--attach|--inline)[=<boundary>] | --no-attach]
 		   [-s | --signoff]
@@ -145,6 +145,10 @@ include::diff-options.txt[]
 	Print all commits to the standard output in mbox format,
 	instead of creating a file for each one.
 
+--mboxrd::
+	Use the robust "mboxrd" format with `--stdout` to escape
+	"^>+From " lines.
+
 --attach[=<boundary>]::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
diff --git a/builtin/log.c b/builtin/log.c
index 5eafcf26b49b..13f5deb7a5c0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1872,6 +1872,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
 	int creation_factor = -1;
+	int mboxrd = 0;
 
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1883,6 +1884,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('s', "signoff", &do_signoff, N_("add a Signed-off-by trailer")),
 		OPT_BOOL(0, "stdout", &use_stdout,
 			    N_("print patches to standard out")),
+		OPT_BOOL(0, "mboxrd", &mboxrd,
+			    N_("use the robust mboxrd format with --stdout")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
@@ -2106,6 +2109,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				  rev.diffopt.close_file, "--output",
 				  !!output_directory, "--output-directory");
 
+	/* should we warn on --mboxrd w/o --stdout? */
+	if (mboxrd)
+		rev.commit_format = CMIT_FMT_MBOXRD;
+
 	if (use_stdout) {
 		setup_pager();
 	} else if (!rev.diffopt.close_file) {
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba5c395d2d80..f6e2fbdcfa68 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1815,7 +1815,7 @@ _git_fetch ()
 
 __git_format_patch_extra_options="
 	--full-index --not --all --no-prefix --src-prefix=
-	--dst-prefix= --notes
+	--dst-prefix= --notes --mboxrd
 "
 
 _git_format_patch ()
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index de1da4673da9..69ed8b1ffaa1 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2281,7 +2281,7 @@ test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
 	test_line_count = 1 output
 '
 
-test_expect_success 'format-patch --pretty=mboxrd' '
+test_expect_success 'format-patch --mboxrd' '
 	sp=" " &&
 	cat >msg <<-INPUT_END &&
 	mboxrd should escape the body
@@ -2316,7 +2316,9 @@ test_expect_success 'format-patch --pretty=mboxrd' '
 	INPUT_END
 
 	C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&
-	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >patch &&
+	git format-patch --mboxrd --stdout -1 $C~1..$C >patch &&
+	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >compat &&
+	test_cmp patch compat &&
 	git grep -h --no-index -A11 \
 		"^>From could trip up a loose mbox parser" patch >actual &&
 	test_cmp expect actual
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index cdad4b688078..9a128c16a6ee 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1033,7 +1033,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
 	>From extra escape for reversibility
 	INPUT_END
 	git commit -F msg &&
-	git format-patch --pretty=mboxrd --stdout -1 >mboxrd1 &&
+	git format-patch --mboxrd --stdout -1 >mboxrd1 &&
 	grep "^>From could trip up a loose mbox parser" mboxrd1 &&
 	git checkout -f first &&
 	git am --patch-format=mboxrd mboxrd1 &&
