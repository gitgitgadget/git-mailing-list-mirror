From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 10/11] vcs-svn,svn-fe: add --incremental option
Date: Wed, 13 Jul 2011 18:21:12 +0600
Message-ID: <1310559673-5026-11-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:21:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyRL-0004QA-Mh
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab1GMMVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:21:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab1GMMVL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:21:11 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AvvgRE5o07lTbL8wSXetrbTYQlAB6h/VTS8OOpaa3fs=;
        b=MFgQAMNoLxBa6s/zniO7qt6V+g9ket+Fx2kXLCajvK+zfuuXP0onAka/4nKIpXIIm/
         PDDu3E76wb+5KUELNLr7UPfm9vdPmOilkl94cbHAL290qQEqfqL9BR+gAXtw+YxPSYfG
         A7ojKZuA5m4j/D7wzMAr8Mb9PNImr5B85hp9Q=
Received: by 10.205.35.194 with SMTP id sx2mr461904bkb.384.1310559670357;
        Wed, 13 Jul 2011 05:21:10 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.21.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:21:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177031>

This option is to make svn-fe write commits on top of the existing ref
instead of overwriting it. More precise, the first commit's parent is
set to be :(first_revision_in_current_dump - 1) mark.

Prerequisite is to (re)use import marks (from previous imports). It is
safe to use this option on a svn dump that starts with r0/r1. The svn
dump itself should be incremental too.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    3 +++
 contrib/svn-fe/svn-fe.txt |    5 +++++
 t/t9010-svn-fe.sh         |   34 +++++++++++++++++++++++++++++-----
 test-svn-fe.c             |    3 +++
 vcs-svn/svndump.c         |   13 +++++++++----
 vcs-svn/svndump.h         |    2 +-
 6 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index a388750..211dc4d 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -18,6 +18,9 @@ static struct option svn_fe_options[] = {
 	{ OPTION_BIT, 0, "progress", &args.progress,
 		NULL, "don't write a progress line after each commit",
 		PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
+	OPT_BIT(0, "incremental", &args.incremental,
+		"resume export, requires marks and incremental dump",
+		1),
 	OPT_STRING(0, "git-svn-id-url", &args.url, "url",
 		"append git-svn metadata line to commit messages"),
 	OPT_STRING(0, "ref", &args.ref, "dst_ref",
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index f1a459e..0b6c29e 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -42,6 +42,11 @@ OPTIONS
 --[no-]progress::
 	Write 'progress' lines to fast-import stream. These
 	can be displayed by fast-import.
+--incremental::
+	If the first revision in dump has number greater than
+	1, make :(revision - 1) it's parent. For this to work
+	fast-import must be supplied with import-marks file
+	and the dump must be incremental.
 
 INPUT FORMAT
 ------------
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 6dcad94..e5b78a9 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -19,7 +19,8 @@ reinit_git () {
 try_dump_ext () {
 	args=$1 &&
 	fd=${2:-3} &&
-	shift 2 &&
+	fi_args=${3:-} &&
+	shift 3 &&
 	input=$1 &&
 	maybe_fail_svnfe=${2:+test_$2} &&
 	maybe_fail_fi=${3:+test_$3} &&
@@ -27,12 +28,12 @@ try_dump_ext () {
 	{
 		eval "$maybe_fail_svnfe test-svn-fe $args "$input" >stream $fd<backflow" &
 	} &&
-	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
+	eval "$maybe_fail_fi git fast-import $fi_args --cat-blob-fd=3 <stream 3>backflow" &&
 	wait $!
 }
 
 try_dump () {
-	try_dump_ext "" "" $@
+	try_dump_ext "" "" "" $@
 }
 
 properties () {
@@ -76,6 +77,15 @@ Content-length: 10
 
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
@@ -1121,7 +1131,7 @@ test_expect_success SVNREPO,PIPE 't9135/svn.dump' '
 
 test_expect_success PIPE 'import to notmaster ref' '
 	reinit_git &&
-	try_dump_ext "--ref=refs/heads/notmaster" 3 emptyprop.dump &&
+	try_dump_ext "--ref=refs/heads/notmaster" 3 "" emptyprop.dump &&
 
 	git rev-parse --verify notmaster &&
 	test_must_fail git rev-parse --verify master
@@ -1170,10 +1180,24 @@ test_expect_success PIPE 'use different backflow fd' '
 		Node-copyfrom-path: directory/somefile
 		EOF
 	} >directory.dump &&
-	try_dump_ext "--read-blob-fd=7" 7 directory.dump &&
+	try_dump_ext "--read-blob-fd=7" 7 "" directory.dump &&
 
 	git checkout HEAD otherfile &&
 	test_cmp hi otherfile
 '
 
+test_expect_success PIPE 'incremental import' '
+	reinit_git &&
+	>./marks &&
+
+	try_dump_ext "--incremental" "" "--export-marks=./marks" emptyprop.dump &&
+	test_line_count = 2 ./marks &&
+
+	try_dump_ext "--incremental" "" "--import-marks=./marks --export-marks=./marks" moreempty.dump &&
+	test_line_count = 3 ./marks &&
+
+	git log --format=oneline >history &&
+	test_line_count = 3 ./history
+'
+
 test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
index f2711e6..8d3cc99 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -22,6 +22,9 @@ static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
 	OPT_STRING(0, "ref", &args.ref, "dst_ref",
 		"write to dst_ref instead of refs/heads/master"),
+	OPT_BIT(0, "incremental", &args.incremental,
+		"resume export, requires marks and incremental dump",
+		1),
 	OPT_INTEGER(0, "read-blob-fd", &args.backflow_fd,
 		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 6ad9f63..2b11f96 100644
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
@@ -321,7 +323,10 @@ static void begin_revision(void)
 	} else {
 		*gitsvnline = 0;
 	}
-	from_mark = dump_ctx.first_commit_done ? rev_ctx.revision - 1 : 0;
+	if (dump_ctx.incremental)
+		from_mark = rev_ctx.revision - 1;
+	else
+		from_mark = dump_ctx.first_commit_done ? rev_ctx.revision - 1 : 0;
 	author = *rev_ctx.author.buf ? rev_ctx.author.buf : "nobody";
 	domain = *dump_ctx.uuid.buf ? dump_ctx.uuid.buf : "local";
 
@@ -493,7 +498,7 @@ int svndump_init(const struct svndump_args *args)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(args->url, args->ref);
+	reset_dump_ctx(args->url, args->ref, args->incremental);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
@@ -502,7 +507,7 @@ int svndump_init(const struct svndump_args *args)
 void svndump_deinit(void)
 {
 	fast_export_deinit();
-	reset_dump_ctx(NULL, "");
+	reset_dump_ctx(NULL, "", 0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index af63edb..f2bb58c 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -5,7 +5,7 @@ struct svndump_args {
 	const char *filename, *url;
 	const char *ref;
 	int backflow_fd;
-	int progress;
+	int progress, incremental;
 };
 
 int svndump_init(const struct svndump_args *args);
-- 
1.7.3.4
