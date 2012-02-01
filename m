From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] grep: respect diff attributes for binary-ness
Date: Wed, 1 Feb 2012 18:21:29 -0500
Message-ID: <20120201232129.GB2652@sigill.intra.peff.net>
References: <20120201221437.GA19044@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: =?utf-8?Q?Conrad=C2=A0Irwin?= <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 00:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsjUl-0002L1-Kl
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 00:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab2BAXVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 18:21:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52497
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab2BAXVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 18:21:32 -0500
Received: (qmail 14474 invoked by uid 107); 1 Feb 2012 23:28:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 18:28:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 18:21:29 -0500
Content-Disposition: inline
In-Reply-To: <20120201221437.GA19044@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189554>

There is currently no way for users to tell git-grep that a
particular path is or is not a binary file; instead, grep
always relies on its auto-detection (or the user specifying
"-a" to treat all binary-looking files like text).

This patch teaches git-grep to use the same attribute lookup
that is used by git-diff. We could add a new "grep" flag,
but that is unnecessarily complex and unlikely to be useful.
Despite the name, the "-diff" attribute (or "diff=foo" and
the associated diff.foo.binary config option) are really
about describing the contents of the path. It's simply
historical that diff was the only thing that cared about
these attributes in the past.

And if this simple approach turns out to be insufficient, we
still have a backwards-compatible path forward: we can add a
separate "grep" attribute, and fall back to respecting
"diff" if it is unset.

There are a few things worth nothing about the
implementation.

One is that the attribute lookup happens outside of the
grep.[ch] interface (i.e., outside of grep_buffer). We could
do it at a lower level, which would be slightly more
convenient for callers. However, this interacts badly with
threading.  The attribute-lookup code performs best when
lookup order matches the filesystem order (so looking up
"a/b/c" is cheaper if we just looked up "a/b/d" than if we
just did "x/y/z"). Because we issue many simultaneous
requests to grep_buffer, performing the attribute lookup at
that level will cause requests from unrelated paths to
interleave, and we lose the locality that makes the lookup
optimization work.

Instead, in the threaded case we check the attributes as
they are added to the work queue, meaning they are looked up
in the optimal order (in the single threaded case, this is a
non-issue, as we process the files serially in the optimal
order).

Here are a few numbers showing the difference. The first is
a best-of-five time for "git grep foo" on the linux-2.6 repo
before this patch (on a 4-core HT processor, using 8
threads):

  real    0m0.306s
  user    0m1.512s
  sys     0m0.412s

Now here's the time for the same operation with a trial
implementation looking up attributes in grep_buffer,
showing a 31% slowdown:

  real    0m0.401s
  user    0m1.760s
  sys     0m0.636s

And here's the same operation with this patch, with only an
11% slowdown:

  real    0m0.339s
  user    0m1.444s
  sys     0m0.584s

Note that while the percentages are big, the absolute
numbers are pretty small. In particular, this is a very
inexpensive grep to do. A more complex regex should have the
same absolute slowdown from the attribute lookup, but it
would be a much smaller percentage of the total processing
time.  So doing it this way is not a huge win, but it does
help on small greps.

The second issue worth noting is that while we do a full
attribute lookup, we pass along only the binary flag to
grep_buffer. When the "-p" flag is given to grep, we will
actually look up the same attributes to find funcname
patterns of matches. We could pass along the pointer to the
userdiff driver for reuse.

However, it's not worth doing this. It clutters the code, as
the driver has to be passed through a large number of helper
functions (and pollutes the grep_buffer interface with
userdiff code). And in my tests, it didn't actually improve
performance. Because we only have to look up the attribute
for a grep hit, in most cases we will only do the funcname
lookup for a small subset of files. The cost of the extra
lookups turns out to be negligible.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c         |   26 ++++++++++++++++++++++----
 t/t7008-grep-binary.sh |   24 ++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e328316..bb38804 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -42,6 +42,7 @@ enum work_type {WORK_SHA1, WORK_FILE};
 struct work_item {
 	enum work_type type;
 	char *name;
+	int is_binary;
 
 	/* if type == WORK_SHA1, then 'identifier' is a SHA1,
 	 * otherwise type == WORK_FILE, and 'identifier' is a NUL
@@ -113,6 +114,14 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
+static int path_is_binary(const char *path)
+{
+	struct userdiff_driver *drv = userdiff_find_by_path(path);
+	if (drv)
+		return drv->binary;
+	return -1;
+}
+
 static void add_work(enum work_type type, char *name, void *id)
 {
 	grep_lock();
@@ -123,6 +132,11 @@ static void add_work(enum work_type type, char *name, void *id)
 
 	todo[todo_end].type = type;
 	todo[todo_end].name = name;
+
+	pthread_mutex_lock(&grep_attr_mutex);
+	todo[todo_end].is_binary = path_is_binary(name);
+	pthread_mutex_unlock(&grep_attr_mutex);
+
 	todo[todo_end].identifier = id;
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
@@ -221,14 +235,16 @@ static void *run(void *arg)
 			void* data = load_sha1(w->identifier, &sz, w->name);
 
 			if (data) {
-				hit |= grep_buffer(opt, w->name, -1, data, sz);
+				hit |= grep_buffer(opt, w->name, w->is_binary,
+						   data, sz);
 				free(data);
 			}
 		} else if (w->type == WORK_FILE) {
 			size_t sz;
 			void* data = load_file(w->identifier, &sz);
 			if (data) {
-				hit |= grep_buffer(opt, w->name, -1, data, sz);
+				hit |= grep_buffer(opt, w->name, w->is_binary,
+						   data, sz);
 				free(data);
 			}
 		} else {
@@ -421,7 +437,8 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		if (!data)
 			hit = 0;
 		else
-			hit = grep_buffer(opt, name, -1, data, sz);
+			hit = grep_buffer(opt, name, path_is_binary(name),
+					  data, sz);
 
 		free(data);
 		free(name);
@@ -483,7 +500,8 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		if (!data)
 			hit = 0;
 		else
-			hit = grep_buffer(opt, name, -1, data, sz);
+			hit = grep_buffer(opt, name, path_is_binary(name),
+					  data, sz);
 
 		free(data);
 		free(name);
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 917a264..fd6410f 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -99,4 +99,28 @@ test_expect_success 'git grep y<NUL>x a' "
 	test_must_fail git grep -f f a
 "
 
+test_expect_success 'grep respects binary diff attribute' '
+	echo text >t &&
+	git add t &&
+	echo t:text >expect &&
+	git grep text t >actual &&
+	test_cmp expect actual &&
+	echo "t -diff" >.gitattributes &&
+	echo "Binary file t matches" >expect &&
+	git grep text t >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep respects not-binary diff attribute' '
+	echo binQary | q_to_nul >b &&
+	git add b &&
+	echo "Binary file b matches" >expect &&
+	git grep bin b >actual &&
+	test_cmp expect actual &&
+	echo "b diff" >.gitattributes &&
+	echo "b:binQary" >expect &&
+	git grep bin b | nul_to_q >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.9.3.gc3fce1.dirty
