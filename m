From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 09/10] vcs-svn,svn-fe: add --incremental option
Date: Tue, 16 Aug 2011 15:54:54 +0600
Message-ID: <1313488495-2203-10-git-send-email-divanorama@gmail.com>
References: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGM3-0008Ps-KA
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab1HPJyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:54:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33656 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab1HPJyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:54:11 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585375bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sTCbKhci3WOnJZVS281fcf3FeYB3PP22Qj+zJJhjBkA=;
        b=psf6I2GGcLVvGZFhqVP3pXT82DFefsCVz0PRyjPfnqPXhDsohdKdvTAHR/hzCtIkqY
         c4/85AcfgsFoQUJJWGPxBvlHK/gG/2fUw9DR//8e33+kyDDll4HRE07LpWGV/2IXyPxq
         VF32TpjECgaqS3cmh8/MVXsa/9gNYGrkrEmFI=
Received: by 10.204.175.194 with SMTP id bb2mr618201bkb.298.1313488451180;
        Tue, 16 Aug 2011 02:54:11 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.54.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179420>

This option is to make svn-fe write commits on top of the existing ref
instead of overwriting it. More precise, the first commit's parent is
set to be :(first_revision_in_current_dump - 1) mark.

Prerequisite is to (re)use import marks (from previous imports). It is
safe to use this option on a svn dump that starts with r0/r1. The svn
dump itself should be incremental too.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    3 +++
 contrib/svn-fe/svn-fe.txt |    6 ++++++
 t/t9010-svn-fe.sh         |   26 +++++++++++++++++++++++++-
 test-svn-fe.c             |    3 +++
 vcs-svn/svndump.c         |   13 +++++++++----
 vcs-svn/svndump.h         |    2 +-
 6 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 6aedba2..9e0be17 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -18,6 +18,9 @@ static struct option svn_fe_options[] = {
 	{ OPTION_SET_INT, 0, "progress", &options.progress,
 		NULL, "don't write a progress line after each commit",
 		PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
+	OPT_SET_INT(0, "incremental", &options.incremental,
+		"resume export, requires marks and incremental dump",
+		1),
 	OPT_STRING(0, "git-svn-id-url", &options.git_svn_url, "url",
 		"add git-svn-id line to log messages, imitating git-svn"),
 	OPT_STRING(0, "ref", &options.ref, "refname",
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index abeebfe..f13648c 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -46,6 +46,12 @@ OPTIONS
 	Write 'progress' lines to fast-import stream. These
 	can be displayed by fast-import.
 
+--incremental::
+	If the first revision in dump has number greater than
+	1, make :(revision - 1) it's parent. For this to work
+	fast-import must be supplied with import-marks file
+	and the dump must be incremental.
+
 INPUT FORMAT
 ------------
 Subversion's repository dump format is documented in full in
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index efb4925..845e227 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -22,11 +22,12 @@ try_dump () {
 	maybe_fail_fi=${3:+test_$3} &&
 	args=${4:-} &&
 	fd=${5:-3} &&
+	fi_args=${6:-} &&
 
 	{
 		eval "$maybe_fail_svnfe test-svn-fe $args "$input" >stream $fd<backflow" &
 	} &&
-	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
+	eval "$maybe_fail_fi git fast-import $fi_args --cat-blob-fd=3 <stream 3>backflow" &&
 	wait $!
 }
 
@@ -71,6 +72,15 @@ Content-length: 10
 
 PROPS-END
 EOF
+cat >moreempty.dump <<-EOF &&
+SVN-fs-dump-format-version: 3
+
+Revision-number: 3
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+EOF
 
 test_expect_success 'setup: have pipes?' '
 	rm -f frob &&
@@ -1171,4 +1181,18 @@ test_expect_success PIPE 'use different backflow fd' '
 	test_cmp hi otherfile
 '
 
+test_expect_success PIPE 'incremental import' '
+	reinit_git &&
+	>./marks &&
+
+	try_dump emptyprop.dump "" "" "--incremental" "" "--export-marks=./marks" &&
+	test_line_count = 2 ./marks &&
+
+	try_dump moreempty.dump "" "" "--incremental" "" "--import-marks=./marks --export-marks=./marks" &&
+	test_line_count = 3 ./marks &&
+
+	git log --format=oneline >history &&
+	test_line_count = 3 ./history
+'
+
 test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
index e51a9bb..206827e 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -23,6 +23,9 @@ static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', "apply-delta", &delta_test, "test apply_delta", 1),
 	OPT_STRING(0, "ref", &options.ref, "refname",
 		"write to <refname> instead of refs/heads/master"),
+	OPT_SET_INT(0, "incremental", &options.incremental,
+		"resume export, requires marks and incremental dump",
+		1),
 	OPT_INTEGER(0, "read-blob-fd", &options.backflow_fd,
 		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index ec68649..75ea49f 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -58,6 +58,7 @@ static struct {
 	struct strbuf uuid, url;
 	int first_commit_done;
 	struct strbuf ref_name;
+	int incremental;
 } dump_ctx;
 
 static void reset_node_ctx(char *fname)
@@ -83,7 +84,7 @@ static void reset_rev_ctx(uint32_t revision)
 	strbuf_reset(&rev_ctx.author);
 }
 
-static void reset_dump_ctx(const char *url, const char *dst_ref)
+static void reset_dump_ctx(const char *url, const char *dst_ref, int incremental)
 {
 	strbuf_reset(&dump_ctx.url);
 	if (url)
@@ -93,6 +94,7 @@ static void reset_dump_ctx(const char *url, const char *dst_ref)
 	dump_ctx.first_commit_done = 0;
 	strbuf_reset(&dump_ctx.ref_name);
 	strbuf_addstr(&dump_ctx.ref_name, dst_ref);
+	dump_ctx.incremental = incremental;
 }
 
 static void handle_property(const struct strbuf *key_buf,
@@ -322,7 +324,10 @@ static void begin_revision(void)
 
 	if (!rev_ctx.revision)	/* revision 0 gets no git commit. */
 		return;
-	prev = dump_ctx.first_commit_done ? rev_ctx.revision - 1 : 0;
+	if (dump_ctx.incremental)
+		prev = rev_ctx.revision - 1;
+	else
+		prev = dump_ctx.first_commit_done ? rev_ctx.revision - 1 : 0;
 	if (prev)
 		snprintf(buf, 32, ":%"PRIu32, prev);
 	else
@@ -508,7 +513,7 @@ int svndump_init(const struct svndump_options *o)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(o->git_svn_url, ref);
+	reset_dump_ctx(o->git_svn_url, ref, o->incremental);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
@@ -517,7 +522,7 @@ int svndump_init(const struct svndump_options *o)
 void svndump_deinit(void)
 {
 	fast_export_deinit();
-	reset_dump_ctx(NULL, "");
+	reset_dump_ctx(NULL, "", 0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index de54969..32062e4 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -8,7 +8,7 @@ struct svndump_options {
 	const char *dumpfile, *git_svn_url;
 	const char *ref;
 	int backflow_fd;
-	int progress;
+	int progress, incremental;
 };
 
 int svndump_init(const struct svndump_options *o);
-- 
1.7.3.4
