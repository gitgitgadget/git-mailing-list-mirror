From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 07/11] vcs-svn,svn-fe: allow to specify dump destination ref
Date: Wed, 13 Jul 2011 18:21:09 +0600
Message-ID: <1310559673-5026-8-git-send-email-divanorama@gmail.com>
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
	id 1QgyRL-0004QA-6D
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab1GMMVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:21:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1GMMVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:21:04 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2egXLljthSAtPNoBuSq4XjUwmz/RkzRE7CWjcjyElJg=;
        b=qAAd/Kt+53vfnCWslj853Gg1sepa58XzYDc5UHsBuZqpIsizQPoDgiAt/8JYfRDSuT
         JLL9wXSYlLlMLs/PPPHRGOSJgM8vdXTJEt6IR9vcXhM42EbSHNSjQjK/icGa8bUdW3rU
         Q3WOMEtOONhTZeOLYcKbT/npxq1nz6B9EQN14=
Received: by 10.204.35.195 with SMTP id q3mr524627bkd.174.1310559664162;
        Wed, 13 Jul 2011 05:21:04 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.21.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:21:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177032>

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
 contrib/svn-fe/svn-fe.c   |    3 ++
 contrib/svn-fe/svn-fe.txt |    3 ++
 t/t9010-svn-fe.sh         |   49 +++++++++++++++++++++++++++++---------------
 test-svn-fe.c             |    5 +++-
 vcs-svn/svndump.c         |   11 ++++++---
 vcs-svn/svndump.h         |    1 +
 6 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 59141d6..11739bc 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -17,11 +17,14 @@ static struct svndump_args args;
 static struct option svn_fe_options[] = {
 	OPT_STRING(0, "git-svn-id-url", &args.url, "url",
 		"append git-svn metadata line to commit messages"),
+	OPT_STRING(0, "ref", &args.ref, "dst_ref",
+		"write to dst_ref instead of refs/heads/master"),
 	OPT_END()
 };
 
 int main(int argc, const char **argv)
 {
+	args.ref = "refs/heads/master";
 	argc = parse_options(argc, argv, NULL, svn_fe_options,
 						svn_fe_usage, 0);
 	if (argc == 1) {
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
index 9e5b1a6..bc437b3 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -10,7 +10,7 @@
 #include "vcs-svn/line_buffer.h"
 
 static const char * const test_svnfe_usage[] = {
-	"test-svn-fe (<dumpfile> | -d <preimage> <delta> <len>)",
+	"test-svn-fe ([options] <dumpfile> | -d <preimage> <delta> <len>)",
 	NULL
 };
 
@@ -20,6 +20,8 @@ static int d;
 
 static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', NULL, &d, "test apply_delta", 1),
+	OPT_STRING(0, "ref", &args.ref, "dst_ref",
+		"write to dst_ref instead of refs/heads/master"),
 	OPT_END()
 };
 
@@ -51,6 +53,7 @@ static int apply_delta(int argc, const char *argv[])
 
 int main(int argc, const char *argv[])
 {
+	args.ref = "refs/heads/master";
 	argc = parse_options(argc, argv, NULL, test_svnfe_options,
 						test_svnfe_usage, 0);
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index c58262a..616f9ec 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -57,6 +57,7 @@ static struct {
 	uint32_t version;
 	struct strbuf uuid, url;
 	int first_commit_done;
+	struct strbuf ref_name;
 } dump_ctx;
 
 static void reset_node_ctx(char *fname)
@@ -82,7 +83,7 @@ static void reset_rev_ctx(uint32_t revision)
 	strbuf_reset(&rev_ctx.author);
 }
 
-static void reset_dump_ctx(const char *url)
+static void reset_dump_ctx(const char *url, const char *dst_ref)
 {
 	strbuf_reset(&dump_ctx.url);
 	if (url)
@@ -90,6 +91,8 @@ static void reset_dump_ctx(const char *url)
 	dump_ctx.version = 1;
 	strbuf_reset(&dump_ctx.uuid);
 	dump_ctx.first_commit_done = 0;
+	strbuf_reset(&dump_ctx.ref_name);
+	strbuf_addstr(&dump_ctx.ref_name, dst_ref);
 }
 
 static void handle_property(const struct strbuf *key_buf,
@@ -324,7 +327,7 @@ static void begin_revision(void)
 
 	fast_export_begin_commit(rev_ctx.revision, author, author, domain,
 		&rev_ctx.log, gitsvnline, rev_ctx.timestamp,
-		from_mark);
+		from_mark, dump_ctx.ref_name.buf);
 }
 
 static void end_revision(void)
@@ -488,7 +491,7 @@ int svndump_init(const struct svndump_args *args)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(args->url);
+	reset_dump_ctx(args->url, args->ref);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
@@ -497,7 +500,7 @@ int svndump_init(const struct svndump_args *args)
 void svndump_deinit(void)
 {
 	fast_export_deinit();
-	reset_dump_ctx(NULL);
+	reset_dump_ctx(NULL, "");
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index b3dbf24..904e628 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -3,6 +3,7 @@
 
 struct svndump_args {
 	const char *filename, *url;
+	const char *ref;
 };
 
 int svndump_init(const struct svndump_args *args);
-- 
1.7.3.4
