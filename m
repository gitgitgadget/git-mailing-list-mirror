From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [NON-PATCH] vcs-svn: avoid 'ls' and filedelete with empty path
Date: Sat, 10 Mar 2012 01:00:16 -0600
Message-ID: <20120310070016.GC1992@burratino>
References: <CAFfmPPMxcs0ySgnD7UfUS1yq=qaqfn1qCxdh1HYgFu6WPfpWQg@mail.gmail.com>
 <1331184656-98629-1-git-send-email-davidbarr@google.com>
 <20120308070951.GA2181@burratino>
 <7vty1zdp2b.fsf@alter.siamese.dyndns.org>
 <20120310031228.GA3008@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 08:00:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6GHz-0003GN-IA
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 08:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab2CJHAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 02:00:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40420 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab2CJHAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 02:00:21 -0500
Received: by iagz16 with SMTP id z16so3422513iag.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 23:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T3C23a8MhFyUvNUk453EaOYG49yHBPJn39LnVVLiBrQ=;
        b=zNRw5ApRrJXGWlc3ztXiOVozkMn+CDxe6kvkLgI5U+5a597Q8CjjtMHYDzPUQUwBKn
         nrcyTNl+izW1sU5CCiMqAx27C2iYk8Y+Y3EbP0jrIq0Aiv8ct4zTJtd+nrDi8QZ034hb
         qJiMwemwU9S8eAL1jkrnclL9XDPCA8JUT4bTvUBQs/SAJQ7GfJY4+VorVLvmt/TCqyg2
         BLgdFYVsXFxwC2jkgCemR3euJnKI7givNhD1nRLiHJ7oDy11SfLLAWchnePAFL3cT3nT
         HdI20nlWYb5w17vD7Jy/rftRKd/AqSuGbGqo+THlLhCUANXwuqgDPOFwFRiAMrXplSTE
         ZXEA==
Received: by 10.182.14.34 with SMTP id m2mr1975372obc.38.1331362820799;
        Fri, 09 Mar 2012 23:00:20 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x5sm10800251obn.5.2012.03.09.23.00.19
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 23:00:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120310031228.GA3008@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192770>

Jonathan Nieder wrote:

> svn-fe should probably also be tweaked to handle this case without
> demanding support for the (nice) 'ls empty path' extension in
> fast-import backends, and this could even happen before 1.7.10.
> I can't promise to get to that quickly enough, though.

On second thought, svn-fe will need the 'ls empty path' extension
before it can handle this case again. :(

-- >8 --
There is a pathological Subversion operation that svn-fe handles
incorrectly due to an unexpected response from fast-import:

  svn cp $SVN_ROOT $SVN_ROOT/subdirectory

svn-fe tries to handle this as a copy from "" to "subdirectory", in
two steps: first, "ls :1 " to retrieve a <dataref> for the root, and
then "M 040000 <dataref> subdirectory" to use it in the active commit.

In git 1.7.9.3 and earlier, the fast-import "ls" command does not
understand that by the empty path we mean the root of the tree.  The
unrecognized path is reported as "missing", so svn-fe emits "D
subdirectory" and continues unaware of the miscommunication that has
taken place.

This is a regression introduced by commit 723b7a27 (vcs-svn: eliminate
repo_tree structure, 2010-12-10).

A patch in flight teaches fast-import to error out, which is a little
better, but still does not win us a successful and accurate import.
Because the meaning of empty paths was not specified in the
fast-import manual until recently, other backends are likely to handle
this construct inconsistently, too.

svn-fe never actually needs to pass "" as an argument to 'ls',
'C', 'R', or 'D'. (*)  There is always another way to spell what it is
trying to do:

. Making a 'ls <foo> ""' request and waiting for a response is a
  complicated way to spell the identity operation.  When <foo> is
  a commit, <foo> can be used directly to name the root of the
  corresponding tree. (*)

. Emitting 'ls ""' to get a name for the root of the current tree
  would be useful in general and there is no other command that
  does that.  Svn-fe never does that: translating non-copy nodes from
  the Subversion dump format does not involve retrieving current
  directory listings to apply a delta to them, and for copies, the
  copyfrom information refers to a specific previous revision.

. svn-fe does not use the filerename (R) and filecopy (C) commands.

. The intent of the command 'D ""' is more clearly written as
  'deleteall'.

Reported-by: Andrew Sayers <andrew-git@pileofstuff.org>
Explained-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Toy patch, not intended for application.

(*) Lies.
---
 t/t9010-svn-fe.sh     |   69 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/fast_export.c |   25 +++++++++++++++++-
 vcs-svn/fast_export.h |    2 +-
 vcs-svn/repo_tree.c   |    6 +++--
 vcs-svn/repo_tree.h   |    2 +-
 vcs-svn/svndump.c     |    3 ++-
 6 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed248..45706bde 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -271,6 +271,75 @@ test_expect_success PIPE 'directory with files' '
 	test_cmp hi directory/file2
 '
 
+test_expect_success PIPE 'copy from root to directory' '
+	reinit_git &&
+	echo hello >hello &&
+	hello_blob=$(git hash-object -w -t blob hello) &&
+	subtree=$(
+		echo "100644 blob $hello_blob	README.txt" |
+		git mktree
+	) &&
+	expect=$(
+		git mktree <<-EOF
+			100644 blob $hello_blob	README.txt
+			040000 tree $subtree	trunk
+		EOF
+	) &&
+
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "2012-10-10T00:01:003.000000Z" \
+			svn:log "created README.txt" &&
+		echo PROPS-END
+	} >r1.props &&
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "2012-10-10T00:02:005.000000Z" \
+			svn:log "created trunk" &&
+		echo PROPS-END
+	} >r2.props &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		echo Prop-content-length: $(wc -c <r1.props) &&
+		echo Content-length: $(wc -c <r1.props) &&
+		echo &&
+		cat r1.props &&
+		cat <<-\EOF &&
+
+		Node-path: README.txt
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hello &&
+		echo Revision-number: 2
+		echo Prop-content-length: $(wc -c <r2.props) &&
+		echo Content-length: $(wc -c <r2.props) &&
+		echo &&
+		cat r2.props &&
+		sed -e "s/X\$//" <<-\EOF
+
+		Node-path: trunk
+		Node-kind: dir
+		Node-action: add
+		Node-copyfrom-rev: 1
+		Node-copyfrom-path: X
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+		EOF
+	} >copy-root.dump &&
+	try_dump copy-root.dump &&
+
+	git diff-tree --exit-code $expect HEAD
+'
+
 test_expect_success PIPE 'branch name with backslash' '
 	reinit_git &&
 	sort <<-\EOF >expect.branch-files &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 19d7c34c..24232618 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -49,6 +49,12 @@ void fast_export_reset(void)
 
 void fast_export_delete(const char *path)
 {
+	/* delete("") means to return to a clean slate. */
+	if (!*path) {
+		printf("deleteall\n");
+		return;
+	}
+
 	putchar('D');
 	putchar(' ');
 	quote_c_style(path, NULL, stdout, 0);
@@ -113,6 +119,8 @@ void fast_export_end_commit(uint32_t revision)
 
 static void ls_from_rev(uint32_t rev, const char *path)
 {
+	assert(*path);
+
 	/* ls :5 path/to/old/file */
 	printf("ls :%"PRIu32" ", rev);
 	quote_c_style(path, NULL, stdout, 0);
@@ -122,6 +130,8 @@ static void ls_from_rev(uint32_t rev, const char *path)
 
 static void ls_from_active_commit(const char *path)
 {
+	assert(*path);
+
 	/* ls "path/to/file" */
 	printf("ls \"");
 	quote_c_style(path, NULL, stdout, 1);
@@ -285,12 +295,25 @@ static int parse_ls_response(const char *response, uint32_t *mode,
 int fast_export_ls_rev(uint32_t rev, const char *path,
 				uint32_t *mode, struct strbuf *dataref)
 {
+	if (!*path) {
+		/*
+		 * The easy case: when path is "", the caller can use
+		 * :<rev> directly to refer to the root of the tree. (*)
+		 */
+		strbuf_addf(dataref, ":%"PRIu32, rev);
+		*mode = REPO_MODE_DIR;
+		return 0;
+	}
+
 	ls_from_rev(rev, path);
 	return parse_ls_response(get_response_line(), mode, dataref);
 }
 
-int fast_export_ls(const char *path, uint32_t *mode, struct strbuf *dataref)
+int fast_export_ls_nonroot(const char *path, uint32_t *mode,
+				struct strbuf *dataref)
 {
+	assert(*path);
+
 	ls_from_active_commit(path);
 	return parse_ls_response(get_response_line(), mode, dataref);
 }
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index 43d05b65..53e208e2 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -22,7 +22,7 @@ void fast_export_blob_delta(uint32_t mode,
 /* If there is no such file at that rev, returns -1, errno == ENOENT. */
 int fast_export_ls_rev(uint32_t rev, const char *path,
 			uint32_t *mode_out, struct strbuf *dataref_out);
-int fast_export_ls(const char *path,
+int fast_export_ls_nonroot(const char *path,
 			uint32_t *mode_out, struct strbuf *dataref_out);
 
 #endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 67d27f0b..1547b8ce 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -8,13 +8,15 @@
 #include "repo_tree.h"
 #include "fast_export.h"
 
-const char *repo_read_path(const char *path, uint32_t *mode_out)
+const char *repo_read_nonroot_path(const char *path, uint32_t *mode_out)
 {
 	int err;
 	static struct strbuf buf = STRBUF_INIT;
 
+	assert(*path);
+
 	strbuf_reset(&buf);
-	err = fast_export_ls(path, mode_out, &buf);
+	err = fast_export_ls_nonroot(path, mode_out, &buf);
 	if (err) {
 		if (errno != ENOENT)
 			die_errno("BUG: unexpected fast_export_ls error");
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 889c6a3c..466d5a63 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -11,7 +11,7 @@ struct strbuf;
 uint32_t next_blob_mark(void);
 void repo_copy(uint32_t revision, const char *src, const char *dst);
 void repo_add(const char *path, uint32_t mode, uint32_t blob_mark);
-const char *repo_read_path(const char *path, uint32_t *mode_out);
+const char *repo_read_nonroot_path(const char *path, uint32_t *mode_out);
 void repo_delete(const char *path);
 void repo_commit(uint32_t revision, const char *author,
 		const struct strbuf *log, const char *uuid, const char *url,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index ca63760f..d610184d 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -248,7 +248,8 @@ static void handle_node(void)
 		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_data = repo_read_path(node_ctx.dst.buf, &mode);
+		assert(*node_ctx.dst.buf);
+		old_data = repo_read_nonroot_path(node_ctx.dst.buf, &mode);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
-- 
1.7.9.2
