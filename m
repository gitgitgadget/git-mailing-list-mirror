From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] cat-file: disable object/refname ambiguity check for
 batch mode
Date: Fri, 12 Jul 2013 02:20:05 -0400
Message-ID: <20130712062004.GA15572@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:20:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWiF-0007mP-5B
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab3GLGUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:20:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:36494 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab3GLGUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:20:07 -0400
Received: (qmail 16467 invoked by uid 102); 12 Jul 2013 06:21:25 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 01:21:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 02:20:05 -0400
Content-Disposition: inline
In-Reply-To: <20130712061533.GA11297@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230171>

A common use of "cat-file --batch-check" is to feed a list
of objects from "rev-list --objects" or a similar command.
In this instance, all of our input objects are 40-byte sha1
ids. However, cat-file has always allowed arbitrary revision
specifiers, and feeds the result to get_sha1().

Fortunately, get_sha1() recognizes a 40-byte sha1 before
doing any hard work trying to look up refs, meaning this
scenario should end up spending very little time converting
the input into an object sha1. However, since 798c35f
(get_sha1: warn about full or short object names that look
like refs, 2013-05-29), when we encounter this case, we
spend the extra effort to do a refname lookup anyway, just
to print a warning. This is further exacerbated by ca91993
(get_packed_ref_cache: reload packed-refs file when it
changes, 2013-06-20), which makes individual ref lookup more
expensive by requiring a stat() of the packed-refs file for
each missing ref.

With no patches, this is the time it takes to run:

  $ git rev-list --objects --all >objects
  $ time git cat-file --batch-check='%(objectname)' <objects

on the linux.git repository:

  real    1m13.494s
  user    0m25.924s
  sys     0m47.532s

If we revert ca91993, the packed-refs up-to-date check, it
gets a little better:

  real    0m54.697s
  user    0m21.692s
  sys     0m32.916s

but we are still spending quite a bit of time on ref lookup
(and we would not want to revert that patch, anyway, which
has correctness issues).  If we revert 798c35f, disabling
the warning entirely, we get a much more reasonable time:

  real    0m7.452s
  user    0m6.836s
  sys     0m0.608s

This patch does the moral equivalent of this final case (and
gets similar speedups). We introduce a global flag that
callers of get_sha1() can use to avoid paying the price for
the warning.

Signed-off-by: Jeff King <peff@peff.net>
---
The solution feels a little hacky, but I'm not sure there is a better
one short of reverting the warning entirely.

We could also tie it to warn_ambiguous_refs (or add another config
variable), but I don't think that makes sense. It is not about "do I
care about ambiguities in this repository", but rather "I am going to
do a really large number of sha1 resolutions, and I do not want to pay
the price in this particular code path for the warning").

There may be other sites that resolve a large number of refs and run
into this, but I couldn't think of any. Doing for_each_ref would not
have the same problem, as we already know they are refs there.

 builtin/cat-file.c |  9 +++++++++
 cache.h            |  1 +
 environment.c      |  1 +
 sha1_name.c        | 14 ++++++++------
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0e64b41..fe5c77f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -266,6 +266,15 @@ static int batch_objects(struct batch_options *opt)
 	strbuf_expand(&buf, opt->format, expand_format, &data);
 	data.mark_query = 0;
 
+	/*
+	 * We are going to call get_sha1 on a potentially very large number of
+	 * objects. In most large cases, these will be actual object sha1s. The
+	 * cost to double-check that each one is not also a ref (just so we can
+	 * warn) ends up dwarfing the actual cost of the object lookups
+	 * themselves. We can work around it by just turning off the warning.
+	 */
+	warn_on_object_refname_ambiguity = 0;
+
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
 		char *p;
 		int error;
diff --git a/cache.h b/cache.h
index 2d06169..c1fd82c 100644
--- a/cache.h
+++ b/cache.h
@@ -575,6 +575,7 @@ extern int warn_ambiguous_refs;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
+extern int warn_on_object_refname_ambiguity;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
diff --git a/environment.c b/environment.c
index 0cb67b2..5398c36 100644
--- a/environment.c
+++ b/environment.c
@@ -22,6 +22,7 @@ int warn_ambiguous_refs = 1;
 int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
+int warn_on_object_refname_ambiguity = 1;
 int repository_format_version;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
diff --git a/sha1_name.c b/sha1_name.c
index 90419ef..6f8812a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -452,13 +452,15 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	int at, reflog_len, nth_prior = 0;
 
 	if (len == 40 && !get_sha1_hex(str, sha1)) {
-		refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
-		if (refs_found > 0 && warn_ambiguous_refs) {
-			warning(warn_msg, len, str);
-			if (advice_object_name_warning)
-				fprintf(stderr, "%s\n", _(object_name_msg));
+		if (warn_on_object_refname_ambiguity) {
+			refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
+			if (refs_found > 0 && warn_ambiguous_refs) {
+				warning(warn_msg, len, str);
+				if (advice_object_name_warning)
+					fprintf(stderr, "%s\n", _(object_name_msg));
+			}
+			free(real_ref);
 		}
-		free(real_ref);
 		return 0;
 	}
 
-- 
1.8.3.rc3.24.gec82cb9
