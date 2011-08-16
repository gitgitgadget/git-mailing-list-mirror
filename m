From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 06/10] vcs-svn,svn-fe: allow to specify dump destination ref
Date: Tue, 16 Aug 2011 15:54:51 +0600
Message-ID: <1313488495-2203-7-git-send-email-divanorama@gmail.com>
References: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGLh-00089W-JI
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab1HPJyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:54:10 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab1HPJyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:54:06 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585259bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=p2gBjvYT9BEnnonvL/Bihm7vDMY0in1dYd6spSDw3e0=;
        b=yAIYXoxd32S6gktbHGnlAxipFatChlXNkVQoF5VrTN6Ms3Mlp+H7E1ctyERPIwFoy/
         3ZoIKF+SljZqKQTROaXnj43NDQ5ylD35VYSdPXxjcg9x5ZM0wVzosA9bAhn8le48X/qc
         GRH1YA8rt7qhsNNO/2tNwHSCa5Wu0B/GjGZV4=
Received: by 10.205.64.68 with SMTP id xh4mr1249773bkb.164.1313488445366;
        Tue, 16 Aug 2011 02:54:05 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.54.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:54:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179417>

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
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    2 ++
 contrib/svn-fe/svn-fe.txt |    4 ++++
 t/t9010-svn-fe.sh         |   42 ++++++++++++++++++++++++++----------------
 test-svn-fe.c             |    4 +++-
 vcs-svn/svndump.c         |   16 +++++++++++-----
 vcs-svn/svndump.h         |    1 +
 6 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 0165c3f..9dd8336 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -17,6 +17,8 @@ static struct svndump_options options;
 static struct option svn_fe_options[] = {
 	OPT_STRING(0, "git-svn-id-url", &options.git_svn_url, "url",
 		"add git-svn-id line to log messages, imitating git-svn"),
+	OPT_STRING(0, "ref", &options.ref, "refname",
+		"write to <refname> instead of refs/heads/master"),
 	OPT_END()
 };
 
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 8c6d347..0d19475 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -33,6 +33,10 @@ OPTIONS
 	metadata lines format. See NOTES for more detailed
 	description.
 
+--ref=<refname>::
+	Ref to be written by the generated stream.
+	Default is refs/heads/master.
+
 INPUT FORMAT
 ------------
 Subversion's repository dump format is documented in full in
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed24..b45527e 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -20,9 +20,10 @@ try_dump () {
 	input=$1 &&
 	maybe_fail_svnfe=${2:+test_$2} &&
 	maybe_fail_fi=${3:+test_$3} &&
+	args=${4:-} &&
 
 	{
-		$maybe_fail_svnfe test-svn-fe "$input" >stream 3<backflow &
+		$maybe_fail_svnfe test-svn-fe $args "$input" >stream 3<backflow &
 	} &&
 	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
 	wait $!
@@ -54,6 +55,22 @@ text_no_props () {
 
 >empty
 
+cat >emptyprop.dump <<\EOF
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
@@ -97,26 +114,19 @@ test_expect_failure PIPE 'empty revision' '
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
 '
 
+test_expect_success PIPE 'import to notmaster ref' '
+	reinit_git &&
+	try_dump emptyprop.dump "" "" "--ref=refs/heads/notmaster" &&
+
+	git rev-parse --verify notmaster &&
+	test_must_fail git rev-parse --verify master
+'
+
 test_expect_success PIPE 'author name and commit message' '
 	reinit_git &&
 	echo "<author@example.com, author@example.com@local>" >expect.author &&
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 0dd0657..fddd3e8 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -10,7 +10,7 @@
 #include "vcs-svn/line_buffer.h"
 
 static const char * const test_svnfe_usage[] = {
-	"test-svn-fe <dumpfile>",
+	"test-svn-fe [options] <dumpfile>",
 	"test-svn-fe -d <preimage> <delta> <len>",
 	NULL
 };
@@ -21,6 +21,8 @@ static int delta_test;
 
 static struct option test_svnfe_options[] = {
 	OPT_SET_INT('d', "apply-delta", &delta_test, "test apply_delta", 1),
+	OPT_STRING(0, "ref", &options.ref, "refname",
+		"write to <refname> instead of refs/heads/master"),
 	OPT_END()
 };
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 28d84c9..3a64708 100644
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
@@ -336,8 +339,8 @@ static void begin_revision(void)
 
 	add_metadata_trailer(&rev_ctx.log);
 
-	fast_export_begin_commit("refs/heads/master", rev_ctx.revision, buf,
-		author, email.buf, &rev_ctx.log, rev_ctx.timestamp);
+	fast_export_begin_commit(dump_ctx.ref_name.buf, rev_ctx.revision, buf,
+				author, email.buf, &rev_ctx.log, rev_ctx.timestamp);
 }
 
 static void end_revision(void)
@@ -491,6 +494,9 @@ void svndump_read(void)
 
 int svndump_init(const struct svndump_options *o)
 {
+	const char *ref = o->ref;
+	if (!ref)
+		ref = "refs/heads/master";
 	if (buffer_init(&input, o->dumpfile))
 		return error("cannot open %s: %s", o->dumpfile, strerror(errno));
 	fast_export_init(REPORT_FILENO);
@@ -500,7 +506,7 @@ int svndump_init(const struct svndump_options *o)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(o->git_svn_url);
+	reset_dump_ctx(o->git_svn_url, ref);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
@@ -509,7 +515,7 @@ int svndump_init(const struct svndump_options *o)
 void svndump_deinit(void)
 {
 	fast_export_deinit();
-	reset_dump_ctx(NULL);
+	reset_dump_ctx(NULL, "");
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index db39dfe..0b01ccd 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -6,6 +6,7 @@ struct svndump_options {
 	 * dumpfile is opened in svndump_init and is read in svndump_read.
 	 */
 	const char *dumpfile, *git_svn_url;
+	const char *ref;
 };
 
 int svndump_init(const struct svndump_options *o);
-- 
1.7.3.4
