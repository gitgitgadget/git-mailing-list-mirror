From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 15:56:16 -0400
Message-ID: <20130826195616.GB21074@sigill.intra.peff.net>
References: <20130826195331.GA21051@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 21:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE2tk-0001IK-E4
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 21:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab3HZT4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 15:56:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:39538 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab3HZT4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 15:56:20 -0400
Received: (qmail 28302 invoked by uid 102); 26 Aug 2013 19:56:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 14:56:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 15:56:16 -0400
Content-Disposition: inline
In-Reply-To: <20130826195331.GA21051@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233018>

From: Phil Hord <hordp@cisco.com>

When a commit is grepped and matching filenames are printed, grep-objects
creates the filename by prefixing the original cmdline argument to the
matched path separated by a colon.  Normally this forms a valid blob
reference to the filename, like this:

  git grep -l foo HEAD
  HEAD:some/path/to/foo.txt
      ^

But a tree path may be given to grep instead; in this case the colon is
not a valid delimiter to use since it is placed inside a path.

  git grep -l foo HEAD:some
  HEAD:some:path/to/foo.txt
           ^

The slash path delimiter should be used instead.  Fix git grep to
discern the correct delimiter so it can report valid object names.

  git grep -l foo HEAD:some
  HEAD:some/path/to/foo.txt
           ^

Also, prevent the delimiter being added twice, as happens now in these
examples:

  git grep -l foo HEAD:
  HEAD::some/path/to/foo.txt
       ^
  git grep -l foo HEAD:some/
  HEAD:some/:path/to/foo.txt
            ^

Add a test to confirm correct path forming.

Signed-off-by: Jeff King <peff@peff.net>
---
I left the author as you, since you have done all the hard work; this is
really just me rebasing your patch on top of mine. But note that you did
not signoff the original.

 builtin/grep.c  | 13 +++++++++----
 t/t7810-grep.sh | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index ee47d49..2df7986 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -26,6 +26,7 @@ struct object_to_grep {
 struct object_to_grep {
 	struct object *item;
 	const char *name;
+	unsigned has_path:1;
 };
 
 static int use_threads = 1;
@@ -462,7 +463,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
-		       struct object *obj, const char *name)
+		       struct object *obj, const char *name, char delimiter)
 {
 	if (obj->type == OBJ_BLOB)
 		return grep_sha1(opt, obj->sha1, name, 0, NULL);
@@ -485,7 +486,8 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		strbuf_init(&base, PATH_MAX + len + 1);
 		if (len) {
 			strbuf_add(&base, name, len);
-			strbuf_addch(&base, ':');
+			if (name[len-1] != delimiter)
+				strbuf_addch(&base, delimiter);
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
@@ -506,7 +508,8 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
 		real_obj = deref_tag(list[i].item, NULL, 0);
-		if (grep_object(opt, pathspec, real_obj, list[i].name)) {
+		if (grep_object(opt, pathspec, real_obj, list[i].name,
+				list[i].has_path ? '/' : ':')) {
 			hit = 1;
 			if (opt->status_only)
 				break;
@@ -822,8 +825,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		unsigned char sha1[20];
+		struct object_context oc;
 		/* Is it a rev? */
-		if (!get_sha1(arg, sha1)) {
+		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
 			struct object *object = parse_object_or_die(sha1, arg);
 			if (!seen_dashdash)
 				verify_non_filename(prefix, arg);
@@ -831,6 +835,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			ALLOC_GROW(list, list_nr+1, list_alloc);
 			list[list_nr].item = object;
 			list[list_nr].name = arg;
+			list[list_nr].has_path = !!oc.path[0];
 			list_nr++;
 			continue;
 		}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f698001..2494bfc 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -886,6 +886,21 @@ cat >expected <<EOF
 '
 
 cat >expected <<EOF
+HEAD:t/a/v:1:vvv
+HEAD:t/v:1:vvv
+EOF
+
+test_expect_success "grep HEAD -- path/" '
+	git grep -n -e vvv HEAD -- t/ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success "grep HEAD:path" '
+	git grep -n -e vvv HEAD:t/ >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 hello.c:int main(int argc, const char **argv)
 hello.c:	printf("Hello world.\n");
 EOF
-- 
1.8.4.2.g87d4a77
