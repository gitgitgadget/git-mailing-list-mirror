From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 6/8] vcs-svn: allow to specify dump destination ref
Date: Sun,  3 Jul 2011 23:57:55 +0600
Message-ID: <1309715877-13814-7-git-send-email-divanorama@gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:57:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQuw-00025S-Lb
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab1GCR5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:57:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62342 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1GCR4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:52 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so3614734bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RfyyeM163Dn4MwT0+9cYZjX/rYDHggozjzKOQo9RRbo=;
        b=rGqiqMR4l8iyEXLLp3O4o4kU8AxxkjaK7enD2aWhcgyHU8KsgSdwkwxnzee1oTH+eD
         +2MewFAbRFNL1zSMz48zTm0VL4VrainPMokNkTI7yhGUHi59cNNxLLX+hM2m+hTPpTJM
         SMdHQuEFNv3mcBuAoMrHKAqQis/NmWFGcBbRc=
Received: by 10.204.7.17 with SMTP id b17mr4814057bkb.61.1309715811073;
        Sun, 03 Jul 2011 10:56:51 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176583>

svn-fe produces fast-import stream for a fixed refs/heads/master ref.
It is usually desired to write to a different ref. In a remote helper
it would be a ref in private namespace. If svn-fe is used by someone
directly it'll be more safe to remind where the commits can go. And
in both cases it may be needed to import from two repos and hence to
different refs.

Add a destination ref parameter to vcs-svn/, a corresponding parameter
to svn-fe and a simple test for it.

$ svn-fe --ref=refs/heads/master ...
is an explicit way to stay with the default destination.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    5 +++-
 contrib/svn-fe/svn-fe.txt |    3 ++
 t/t9010-svn-fe.sh         |   49 +++++++++++++++++++++++++++++---------------
 test-svn-fe.c             |    7 ++++-
 vcs-svn/fast_export.c     |    8 +++++-
 vcs-svn/fast_export.h     |    2 +-
 vcs-svn/svndump.c         |    4 +-
 vcs-svn/svndump.h         |    2 +-
 8 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 033dd5b..78c7cd0 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -13,10 +13,13 @@ static const char * const svn_fe_usage[] = {
 };
 
 static const char *url;
+static const char *ref = "refs/heads/master";
 
 static struct option svn_fe_options[] = {
 	OPT_STRING(0, "git-svn-id-url", &url, "url",
 		"append git-svn metadata line to commit messages"),
+	OPT_STRING(0, "ref", &ref, "dst_ref",
+		"write to dst_ref instead of refs/heads/master"),
 	OPT_END()
 };
 
@@ -32,7 +35,7 @@ int main(int argc, const char **argv)
 		url = argv[0];
 	} else if (argc)
 		usage_with_options(svn_fe_usage, svn_fe_options);
-	if (svndump_init(NULL, url))
+	if (svndump_init(NULL, url, ref))
 		return 1;
 	svndump_read();
 	svndump_deinit();
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 8c6d347..20c3315 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -32,6 +32,9 @@ OPTIONS
 	Url to be used in git-svn-id: lines in git-svn
 	metadata lines format. See NOTES for more detailed
 	description.
+--ref=<dst_ref>::
+	Ref to be written by the generated stream.
+	Default is refs/heads/master.
 
 INPUT FORMAT
 ------------
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed24..52efabe 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -16,18 +16,24 @@ reinit_git () {
 	mkfifo stream backflow
 }
 
-try_dump () {
+try_dump_ext () {
+	args=$1 &&
+	shift &&
 	input=$1 &&
 	maybe_fail_svnfe=${2:+test_$2} &&
 	maybe_fail_fi=${3:+test_$3} &&
 
 	{
-		$maybe_fail_svnfe test-svn-fe "$input" >stream 3<backflow &
+		$maybe_fail_svnfe test-svn-fe $args "$input" >stream 3<backflow &
 	} &&
 	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
 	wait $!
 }
 
+try_dump () {
+	try_dump_ext "" $@
+}
+
 properties () {
 	while test "$#" -ne 0
 	do
@@ -54,6 +60,22 @@ text_no_props () {
 
 >empty
 
+cat >emptyprop.dump <<-EOF &&
+SVN-fs-dump-format-version: 3
+
+Revision-number: 1
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+Revision-number: 2
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+EOF
+
 test_expect_success 'setup: have pipes?' '
 	rm -f frob &&
 	if mkfifo frob
@@ -97,21 +119,6 @@ test_expect_failure PIPE 'empty revision' '
 test_expect_success PIPE 'empty properties' '
 	reinit_git &&
 	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
-	cat >emptyprop.dump <<-\EOF &&
-	SVN-fs-dump-format-version: 3
-
-	Revision-number: 1
-	Prop-content-length: 10
-	Content-length: 10
-
-	PROPS-END
-
-	Revision-number: 2
-	Prop-content-length: 10
-	Content-length: 10
-
-	PROPS-END
-	EOF
 	try_dump emptyprop.dump &&
 	git log -p --format="rev <%an, %ae>: %s" HEAD >actual &&
 	test_cmp expect actual
@@ -1111,4 +1118,12 @@ test_expect_success SVNREPO,PIPE 't9135/svn.dump' '
 	)
 '
 
+test_expect_success PIPE 'import to notmaster ref' '
+	reinit_git &&
+	try_dump_ext "--ref=refs/heads/notmaster" emptyprop.dump &&
+
+	git rev-parse --verify notmaster &&
+	test_must_fail git rev-parse --verify master
+'
+
 test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 603d3fb..afa551c 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -10,14 +10,17 @@
 #include "vcs-svn/line_buffer.h"
 
 static const char * const test_svnfe_usage[] = {
-	"test-svn-fe (<dumpfile> | -d <preimage> <delta> <len>)",
+	"test-svn-fe ([options] <dumpfile> | -d <preimage> <delta> <len>)",
 	NULL
 };
 
+static const char *ref = "refs/heads/master";
 static int d;
 
 static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
+	OPT_STRING(0, "ref", &ref, "dst_ref",
+		"write to dst_ref instead of refs/heads/master"),
 	OPT_END()
 };
 
@@ -56,7 +59,7 @@ int main(int argc, const char *argv[])
 		return apply_delta(argc, argv);
 
 	if (argc == 1) {
-		if (svndump_init(argv[0], NULL))
+		if (svndump_init(argv[0], NULL, ref))
 			return 1;
 		svndump_read();
 		svndump_deinit();
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 19d7c34..cfb0f2b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -18,6 +18,7 @@
 static uint32_t first_commit_done;
 static struct line_buffer postimage = LINE_BUFFER_INIT;
 static struct line_buffer report_buffer = LINE_BUFFER_INIT;
+static struct strbuf ref_name = STRBUF_INIT;
 
 /* NEEDSWORK: move to fast_export_init() */
 static int init_postimage(void)
@@ -29,15 +30,18 @@ static int init_postimage(void)
 	return buffer_tmpfile_init(&postimage);
 }
 
-void fast_export_init(int fd)
+void fast_export_init(int fd, const char *dst_ref)
 {
 	first_commit_done = 0;
+	strbuf_reset(&ref_name);
+	strbuf_addstr(&ref_name, dst_ref);
 	if (buffer_fdinit(&report_buffer, fd))
 		die_errno("cannot read from file descriptor %d", fd);
 }
 
 void fast_export_deinit(void)
 {
+	strbuf_release(&ref_name);
 	if (buffer_deinit(&report_buffer))
 		die_errno("error closing fast-import feedback stream");
 }
@@ -89,7 +93,7 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 	} else {
 		*gitsvnline = '\0';
 	}
-	printf("commit refs/heads/master\n");
+	printf("commit %s\n", ref_name.buf);
 	printf("mark :%"PRIu32"\n", revision);
 	printf("committer %s <%s@%s> %ld +0000\n",
 		   *author ? author : "nobody",
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 43d05b6..d7eb7cc 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -4,7 +4,7 @@
 struct strbuf;
 struct line_buffer;
 
-void fast_export_init(int fd);
+void fast_export_init(int fd, const char *dst_ref);
 void fast_export_deinit(void);
 void fast_export_reset(void);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index a88d392..f0df381 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -454,11 +454,11 @@ void svndump_read(void)
 		end_revision();
 }
 
-int svndump_init(const char *filename, const char *url)
+int svndump_init(const char *filename, const char *url, const char *dst_ref)
 {
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
-	fast_export_init(REPORT_FILENO);
+	fast_export_init(REPORT_FILENO, dst_ref);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index 1bcaab6..08922fb 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,7 +1,7 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
 
-int svndump_init(const char *filename, const char *url);
+int svndump_init(const char *filename, const char *url, const char *dst_ref);
 void svndump_read(void);
 void svndump_deinit(void);
 void svndump_reset(void);
-- 
1.7.3.4
