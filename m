From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 7/8] vcs-svn: convert REPORT_FILENO to an option
Date: Sun,  3 Jul 2011 23:57:56 +0600
Message-ID: <1309715877-13814-8-git-send-email-divanorama@gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:57:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQuu-00025S-Uz
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab1GCR46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:56:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40345 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab1GCR4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:54 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so3614757bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DAJ+jI9HHiJIO5DxJgvgfP9WjVYPjhNXXfdtyWoHL+g=;
        b=HE0STNgV1PBqEML4DbgBAqzLzmCD7i/BTmapGg797iyP5slrOAPrrCr9ECmnlXuAVF
         0AW/a4ssoksUBfKsoIVjZe/hwUmJ+m5Uccy/zOS3Z3sEsfdwj2gvtNpSZE96KODx/mHv
         naAIQm8EtVR5x4oAMOXfwl8Pdo61Nfd5dDrRI=
Received: by 10.205.37.193 with SMTP id tf1mr230887bkb.67.1309715812954;
        Sun, 03 Jul 2011 10:56:52 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176581>

svn-fe needs to read fast-import's responses to "ls" and "cat-blob".
These come through a file descriptor number 3.

Sometimes it is easier to setup variable fd than a fixed one. It is
the case with pipe() call and even more fd=3 can be already taken.
On Windows file descriptors are not by default inherited by a child
process, nor there is an option to setup descriptors other than
standard stdin, stdout, stderr at a process creation time.

Add an option for this file descriptor number in vcs-svn/ and svn-fe,
add a simple test for it.

To be used like following:
$ svn-fe --read-blob-fd=7 ... 7<somewhere

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    5 +++-
 contrib/svn-fe/svn-fe.txt |    8 ++++-
 t/t9010-svn-fe.sh         |   58 +++++++++++++++++++++++++++++++++++++++++---
 test-svn-fe.c             |    5 +++-
 vcs-svn/svndump.c         |    6 +---
 vcs-svn/svndump.h         |    2 +-
 6 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 78c7cd0..32755b1 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -14,12 +14,15 @@ static const char * const svn_fe_usage[] = {
 
 static const char *url;
 static const char *ref = "refs/heads/master";
+static int backflow_fd = 3;
 
 static struct option svn_fe_options[] = {
 	OPT_STRING(0, "git-svn-id-url", &url, "url",
 		"append git-svn metadata line to commit messages"),
 	OPT_STRING(0, "ref", &ref, "dst_ref",
 		"write to dst_ref instead of refs/heads/master"),
+	OPT_INTEGER(0, "read-blob-fd", &backflow_fd,
+		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
 };
 
@@ -35,7 +38,7 @@ int main(int argc, const char **argv)
 		url = argv[0];
 	} else if (argc)
 		usage_with_options(svn_fe_usage, svn_fe_options);
-	if (svndump_init(NULL, url, ref))
+	if (svndump_init(NULL, url, ref, backflow_fd))
 		return 1;
 	svndump_read();
 	svndump_deinit();
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 20c3315..a7ad368 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -8,9 +8,9 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
 SYNOPSIS
 --------
 [verse]
-mkfifo backchannel &&
+mkfifo backchannel && fd=3 &&
 svnadmin dump --deltas REPO |
-	svn-fe [options] [git-svn-id-url] 3<backchannel |
+	eval "svn-fe [options] [git-svn-id-url] $fd<backchannel" |
 	git fast-import --cat-blob-fd=3 3>backchannel
 
 DESCRIPTION
@@ -35,6 +35,10 @@ OPTIONS
 --ref=<dst_ref>::
 	Ref to be written by the generated stream.
 	Default is refs/heads/master.
+--read-blob-fd=<fd>::
+	Integer number of file descriptor from which
+	responses to 'ls' and 'cat-blob' requests will come.
+	Default is fd=3.
 
 INPUT FORMAT
 ------------
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 52efabe..6dcad94 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -18,20 +18,21 @@ reinit_git () {
 
 try_dump_ext () {
 	args=$1 &&
-	shift &&
+	fd=${2:-3} &&
+	shift 2 &&
 	input=$1 &&
 	maybe_fail_svnfe=${2:+test_$2} &&
 	maybe_fail_fi=${3:+test_$3} &&
 
 	{
-		$maybe_fail_svnfe test-svn-fe $args "$input" >stream 3<backflow &
+		eval "$maybe_fail_svnfe test-svn-fe $args "$input" >stream $fd<backflow" &
 	} &&
 	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
 	wait $!
 }
 
 try_dump () {
-	try_dump_ext "" $@
+	try_dump_ext "" "" $@
 }
 
 properties () {
@@ -1120,10 +1121,59 @@ test_expect_success SVNREPO,PIPE 't9135/svn.dump' '
 
 test_expect_success PIPE 'import to notmaster ref' '
 	reinit_git &&
-	try_dump_ext "--ref=refs/heads/notmaster" emptyprop.dump &&
+	try_dump_ext "--ref=refs/heads/notmaster" 3 emptyprop.dump &&
 
 	git rev-parse --verify notmaster &&
 	test_must_fail git rev-parse --verify master
 '
 
+test_expect_success PIPE 'use different backflow fd' '
+	reinit_git &&
+	echo hi >hi &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-01T00:01:002.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props &&
+	{
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props
+	} >revprops &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		cat revprops &&
+		cat <<-EOF &&
+		Node-path: directory
+		Node-kind: dir
+		Node-action: add
+		Node-path: directory/somefile
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hi &&
+
+		echo "Revision-number: 2" &&
+		cat revprops &&
+		cat <<-\EOF
+		Node-path: otherfile
+		Node-kind: file
+		Node-action: add
+		Node-copyfrom-rev: 1
+		Node-copyfrom-path: directory/somefile
+		EOF
+	} >directory.dump &&
+	try_dump_ext "--read-blob-fd=7" 7 directory.dump &&
+
+	git checkout HEAD otherfile &&
+	test_cmp hi otherfile
+'
+
 test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
index afa551c..7885eb1 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -16,11 +16,14 @@ static const char * const test_svnfe_usage[] = {
 
 static const char *ref = "refs/heads/master";
 static int d;
+static int backflow_fd = 3;
 
 static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
 	OPT_STRING(0, "ref", &ref, "dst_ref",
 		"write to dst_ref instead of refs/heads/master"),
+	OPT_INTEGER(0, "read-blob-fd", &backflow_fd,
+		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
 };
 
@@ -59,7 +62,7 @@ int main(int argc, const char *argv[])
 		return apply_delta(argc, argv);
 
 	if (argc == 1) {
-		if (svndump_init(argv[0], NULL, ref))
+		if (svndump_init(argv[0], NULL, ref, backflow_fd))
 			return 1;
 		svndump_read();
 		svndump_deinit();
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index f0df381..c52faf1 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -19,8 +19,6 @@
  */
 #define constcmp(s, ref) memcmp(s, ref, sizeof(ref) - 1)
 
-#define REPORT_FILENO 3
-
 #define NODEACT_REPLACE 4
 #define NODEACT_DELETE 3
 #define NODEACT_ADD 2
@@ -454,11 +452,11 @@ void svndump_read(void)
 		end_revision();
 }
 
-int svndump_init(const char *filename, const char *url, const char *dst_ref)
+int svndump_init(const char *filename, const char *url, const char *dst_ref, int report_fileno)
 {
 	if (buffer_init(&input, filename))
 		return error("cannot open %s: %s", filename, strerror(errno));
-	fast_export_init(REPORT_FILENO, dst_ref);
+	fast_export_init(report_fileno, dst_ref);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index 08922fb..85c82c5 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,7 +1,7 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
 
-int svndump_init(const char *filename, const char *url, const char *dst_ref);
+int svndump_init(const char *filename, const char *url, const char *dst_ref, int report_fileno);
 void svndump_read(void);
 void svndump_deinit(void);
 void svndump_reset(void);
-- 
1.7.3.4
