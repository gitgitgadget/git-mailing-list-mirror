From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 08/11] vcs-svn,svn-fe: convert REPORT_FILENO to an option
Date: Wed, 13 Jul 2011 18:21:10 +0600
Message-ID: <1310559673-5026-9-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyRM-0004QA-6t
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab1GMMVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:21:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1GMMVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:21:07 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1bK/8Q7z4ivm7jCO0tRuGfPg1It9lwp3RKXRRhis5eU=;
        b=scwZqbrRpcXCWFHGZAjNq9fIwQD1PLUi2+6ZrZVHISIAk5a5w50HXQW2RADrswiB5z
         c59VGnrqQbsdgAZpmg/qi3I6TVDa3rVP7LvJrcm3RvshjFxnI59GapFkQkPo8qWuNTm3
         m5ZF09fJgvFeX19VswUC4gqOM2SCgd5sV6ojY=
Received: by 10.204.41.15 with SMTP id m15mr519343bke.219.1310559666377;
        Wed, 13 Jul 2011 05:21:06 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.21.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:21:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177030>

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
 contrib/svn-fe/svn-fe.c   |    3 ++
 contrib/svn-fe/svn-fe.txt |    8 ++++-
 t/t9010-svn-fe.sh         |   58 +++++++++++++++++++++++++++++++++++++++++---
 test-svn-fe.c             |    3 ++
 vcs-svn/svndump.c         |    4 +--
 vcs-svn/svndump.h         |    1 +
 6 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 11739bc..cd9e449 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -19,12 +19,15 @@ static struct option svn_fe_options[] = {
 		"append git-svn metadata line to commit messages"),
 	OPT_STRING(0, "ref", &args.ref, "dst_ref",
 		"write to dst_ref instead of refs/heads/master"),
+	OPT_INTEGER(0, "read-blob-fd", &args.backflow_fd,
+		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
 };
 
 int main(int argc, const char **argv)
 {
 	args.ref = "refs/heads/master";
+	args.backflow_fd = 3;
 	argc = parse_options(argc, argv, NULL, svn_fe_options,
 						svn_fe_usage, 0);
 	if (argc == 1) {
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
index bc437b3..43e19b2 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -22,6 +22,8 @@ static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
 	OPT_STRING(0, "ref", &args.ref, "dst_ref",
 		"write to dst_ref instead of refs/heads/master"),
+	OPT_INTEGER(0, "read-blob-fd", &args.backflow_fd,
+		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
 };
 
@@ -54,6 +56,7 @@ static int apply_delta(int argc, const char *argv[])
 int main(int argc, const char *argv[])
 {
 	args.ref = "refs/heads/master";
+	args.backflow_fd = 3;
 	argc = parse_options(argc, argv, NULL, test_svnfe_options,
 						test_svnfe_usage, 0);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 616f9ec..4194052 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -20,8 +20,6 @@
  */
 #define constcmp(s, ref) memcmp(s, ref, sizeof(ref) - 1)
 
-#define REPORT_FILENO 3
-
 #define NODEACT_REPLACE 4
 #define NODEACT_DELETE 3
 #define NODEACT_ADD 2
@@ -484,7 +482,7 @@ int svndump_init(const struct svndump_args *args)
 {
 	if (buffer_init(&input, args->filename))
 		return error("cannot open %s: %s", args->filename, strerror(errno));
-	fast_export_init(REPORT_FILENO);
+	fast_export_init(args->backflow_fd);
 	strbuf_init(&dump_ctx.uuid, 4096);
 	strbuf_init(&dump_ctx.url, 4096);
 	strbuf_init(&rev_ctx.log, 4096);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index 904e628..d266b68 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -4,6 +4,7 @@
 struct svndump_args {
 	const char *filename, *url;
 	const char *ref;
+	int backflow_fd;
 };
 
 int svndump_init(const struct svndump_args *args);
-- 
1.7.3.4
