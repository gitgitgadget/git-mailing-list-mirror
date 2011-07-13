From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 11/11] vcs-svn,svn-fe: add an option to write svnrev notes
Date: Wed, 13 Jul 2011 18:21:13 +0600
Message-ID: <1310559673-5026-12-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyRe-0004ak-PR
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209Ab1GMMVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:21:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1GMMVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:21:13 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i0HTkCm1zZZ1PDCRyq0Nt77P+NNvGPsPPpV3d46uO8Y=;
        b=olLAvdclfjwhlYz/hN1td8PjnYbCA676pTljFT1W93h1UH7JJegXWbGkx6mwu2eoTV
         UqzLwHEFSDSv1pmUBpoebzdQ3soAtkKBPxTPym8UAzAWEpfpFUVEsG++bdFxXImtHu42
         XGVQd9nlKsTZp1l5exQAlgWej25+NQbXdijAw=
Received: by 10.205.64.197 with SMTP id xj5mr463945bkb.407.1310559672444;
        Wed, 13 Jul 2011 05:21:12 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.21.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:21:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177036>

There are already a few options to determine svn revision from which
a git commit imported with svn-fe came from. One is to make svn-fe
write a git-svn-id: line to commit messages. Another one is to calc
distance to the root commit. The former includes a "url" and is for
git-svn compatibility, the latter is obviously slow and a bit fragile.

$ svn-fe --notes_ref=notes_tree --ref=branch...
will write annotations for branch commits to the notes_tree, each
annotation is a simple "rN" string. Then these annotations can be
viewed manually or used in incremental import to detect the last
imported revision or to (re)create the import marks for further
imports.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/svn-fe.c   |    2 ++
 contrib/svn-fe/svn-fe.txt |    3 +++
 t/t9010-svn-fe.sh         |   32 ++++++++++++++++++++++++++++++++
 test-svn-fe.c             |    2 ++
 vcs-svn/svndump.c         |   28 ++++++++++++++++++++++++----
 vcs-svn/svndump.h         |    2 +-
 6 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index 211dc4d..8410221 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -25,6 +25,8 @@ static struct option svn_fe_options[] = {
 		"append git-svn metadata line to commit messages"),
 	OPT_STRING(0, "ref", &args.ref, "dst_ref",
 		"write to dst_ref instead of refs/heads/master"),
+	OPT_STRING(0, "notes-ref", &args.notes_ref, "notes",
+		"write \"rN\" notes to the <notes> tree"),
 	OPT_INTEGER(0, "read-blob-fd", &args.backflow_fd,
 		"read blobs and trees from this fd instead of 3"),
 	OPT_END()
diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 0b6c29e..ce0582d 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -35,6 +35,9 @@ OPTIONS
 --ref=<dst_ref>::
 	Ref to be written by the generated stream.
 	Default is refs/heads/master.
+--notes-ref=<notes_ref>::
+	Write "rN" notes to the notes_ref tree for each
+	imported commit.
 --read-blob-fd=<fd>::
 	Integer number of file descriptor from which
 	responses to 'ls' and 'cat-blob' requests will come.
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index e5b78a9..2841a3e 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -1200,4 +1200,36 @@ test_expect_success PIPE 'incremental import' '
 	test_line_count = 3 ./history
 '
 
+test_expect_success PIPE 'write notes' '
+	reinit_git &&
+	cat >expect <<-EOF &&
+	r2
+
+	r1
+
+	EOF
+	try_dump_ext "--notes=refs/notes/test" "" "" emptyprop.dump &&
+	git log --show-notes=refs/notes/test --format=%N >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success PIPE 'write notes incremental' '
+	reinit_git &&
+	>./marks &&
+	cat >expect <<-EOF &&
+	r3
+
+	r2
+
+	r1
+
+	EOF
+
+	try_dump_ext "--notes=refs/notes/test" "" "--export-marks=marks" emptyprop.dump &&
+	try_dump_ext "--incremental --notes=refs/notes/test" "" "--import-marks=marks" moreempty.dump &&
+
+	git log --show-notes=refs/notes/test --format=%N >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 8d3cc99..e6d9ae6 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -27,6 +27,8 @@ static struct option test_svnfe_options[] = {
 		1),
 	OPT_INTEGER(0, "read-blob-fd", &args.backflow_fd,
 		"read blobs and trees from this fd instead of 3"),
+	OPT_STRING(0, "notes-ref", &args.notes_ref, "notes",
+		"write \"rN\" notes to the <notes> tree"),
 	OPT_END()
 };
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 2b11f96..514703f 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -57,7 +57,7 @@ static struct {
 	uint32_t version;
 	struct strbuf uuid, url;
 	int first_commit_done;
-	struct strbuf ref_name;
+	struct strbuf ref_name, notes_ref_name;
 	int incremental;
 } dump_ctx;
 
@@ -84,7 +84,7 @@ static void reset_rev_ctx(uint32_t revision)
 	strbuf_reset(&rev_ctx.author);
 }
 
-static void reset_dump_ctx(const char *url, const char *dst_ref, int incremental)
+static void reset_dump_ctx(const char *url, const char *dst_ref, int incremental, const char *dst_notes_ref)
 {
 	strbuf_reset(&dump_ctx.url);
 	if (url)
@@ -95,6 +95,9 @@ static void reset_dump_ctx(const char *url, const char *dst_ref, int incremental
 	strbuf_reset(&dump_ctx.ref_name);
 	strbuf_addstr(&dump_ctx.ref_name, dst_ref);
 	dump_ctx.incremental = incremental;
+	strbuf_reset(&dump_ctx.notes_ref_name);
+	if (dst_notes_ref)
+		strbuf_addstr(&dump_ctx.notes_ref_name, dst_notes_ref);
 }
 
 static void handle_property(const struct strbuf *key_buf,
@@ -337,8 +340,25 @@ static void begin_revision(void)
 
 static void end_revision(void)
 {
+	char buf[32];
+	char tmbuf[32];
 	if (rev_ctx.revision) {
 		fast_export_end_commit(rev_ctx.revision);
+		if (dump_ctx.notes_ref_name.len) {
+			datestamp(tmbuf, 32);
+			printf("commit %s\n", dump_ctx.notes_ref_name.buf);
+			printf("committer %s <%s@%s> %s\n",
+					"vcs-svn", "vcs-svn", "local", tmbuf);
+			printf("data <<EOF\n");
+			printf("imported r%d\n", rev_ctx.revision);
+			printf("EOF\n\n");
+			if (!dump_ctx.first_commit_done && dump_ctx.incremental && rev_ctx.revision > 1)
+				printf("from %s^0\n", dump_ctx.notes_ref_name.buf);
+			snprintf(buf, 32, "r%d", rev_ctx.revision);
+			printf("N inline :%d\n", rev_ctx.revision);
+			printf("data %ld\n", strlen(buf));
+			printf("%s\n", buf);
+		}
 		if (print_progress)
 			printf("progress Imported commit %"PRIu32".\n\n", rev_ctx.revision);
 		dump_ctx.first_commit_done = 1;
@@ -498,7 +518,7 @@ int svndump_init(const struct svndump_args *args)
 	strbuf_init(&rev_ctx.author, 4096);
 	strbuf_init(&node_ctx.src, 4096);
 	strbuf_init(&node_ctx.dst, 4096);
-	reset_dump_ctx(args->url, args->ref, args->incremental);
+	reset_dump_ctx(args->url, args->ref, args->incremental, args->notes_ref);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	return 0;
@@ -507,7 +527,7 @@ int svndump_init(const struct svndump_args *args)
 void svndump_deinit(void)
 {
 	fast_export_deinit();
-	reset_dump_ctx(NULL, "", 0);
+	reset_dump_ctx(NULL, "", 0, "");
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	strbuf_release(&rev_ctx.log);
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index f2bb58c..928bb0b 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -3,7 +3,7 @@
 
 struct svndump_args {
 	const char *filename, *url;
-	const char *ref;
+	const char *ref, *notes_ref;
 	int backflow_fd;
 	int progress, incremental;
 };
-- 
1.7.3.4
