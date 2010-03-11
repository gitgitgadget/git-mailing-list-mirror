From: Jeff King <peff@peff.net>
Subject: Re: 'git add' regression in git-1.7?
Date: Thu, 11 Mar 2010 02:15:43 -0500
Message-ID: <20100311071543.GA8750@sigill.intra.peff.net>
References: <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
 <20100309223729.GA25265@sigill.intra.peff.net>
 <20100309230931.GC25265@sigill.intra.peff.net>
 <7veijsmza0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 08:15:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npcca-0005LZ-Jw
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 08:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab0CKHPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 02:15:46 -0500
Received: from peff.net ([208.65.91.99]:41168 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787Ab0CKHPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 02:15:45 -0500
Received: (qmail 26505 invoked by uid 107); 11 Mar 2010 07:16:09 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 11 Mar 2010 02:16:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Mar 2010 02:15:43 -0500
Content-Disposition: inline
In-Reply-To: <7veijsmza0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141938>

On Tue, Mar 09, 2010 at 11:06:15PM -0800, Junio C Hamano wrote:

> > And something like this seems to fix the OP's problem:
> > ...
> > Which is similar to your fix, but hoisted into the ignore-collection
> > phase. Like the original code and your patch, it suffers from using a
> > straight memcmp. I think it should actually be checking the pathspec
> > expansion to catch things like 'sub*/file' being relevant to 'subdir'.
> 
> Yeah.  Care to roll a patch to replace 13bb0ce (builtin-add: fix exclude
> handling, 2010-02-28)?  We probably should build the glob matching on top
> of your version instead.

Patch is below. It's based on your 13bb0ce^, and assumes 13bb0c3 itself
will be reverted. However, doesn't your patch 2/3 that adds t2204 break
bisectability? The fix doesn't come until 3/3. It should
test_expect_failure, or it should come after.

I thought about globbing for a minute. I don't think the change in dir.c
would be too hard, but it will expose another corner case for add. If we
have _anything_ in dir->ignored, add currently complains. But if I do
something like:

  $ touch bar baz
  $ echo baz >.gitignore
  $ git add 'b*'

right now it adds 'bar' and silently ignores 'baz', because
COLLECT_IGNORED fails to realize that 'baz' is interesting to us. If we
fix the COLLECT_IGNORED bug with globbing, it will start to complain
that 'baz' was ignored.

I think we could get around it by switching git-add to complain about
ignored files _only_ if there is a pathspec that is not "seen". If
everything was seen, then we know that even if there are ignored paths,
they were all part of pathspecs that at least partially matched.
However, it is still a bit unsatisfying; in the case of failure, we
don't know which of the ignored files came from which pathspec. So we
will print the whole list of ignored paths, even though some of them may
not have been responsible for the error.

Another option is to declare the current behavior wrong. Letting the
shell glob produces different results for obvious reasons:

  $ git add b* ;# will fail, because we see individual pathspecs

but perhaps that is the "feature" of letting add glob itself. Personally
I have never asked "git add" to glob on my behalf, so I don't know why
people would do it.

Anyway, here's the patch.

-- >8 --
Subject: [PATCH] dir: fix COLLECT_IGNORED on excluded prefixes

As we walk the directory tree, if we see an ignored path, we
want to add it to the ignored list only if it matches any
pathspec that we were given. We used to check for the
pathspec to appear explicitly. E.g., if we see "subdir/file"
and it is excluded, we check to see if we have "subdir/file"
in our pathspec.

However, this interacts badly with the optimization to avoid
recursing into ignored subdirectories. If "subdir" as a
whole is ignored, then we never recurse, and consider only
whether "subdir" itself is in our pathspec.  It would not
match a pathspec of "subdir/file" explicitly, even though it
is the reason that subdir/file would be excluded.

This manifests itself to the user as "git add subdir/file"
failing to correctly note that the pathspec was ignored.

This patch extends the in_pathspec logic to include prefix
directory case.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 00d698d..14ac91a 100644
--- a/dir.c
+++ b/dir.c
@@ -554,13 +554,29 @@ static int simplify_away(const char *path, int pathlen, const struct path_simpli
 	return 0;
 }
 
-static int in_pathspec(const char *path, int len, const struct path_simplify *simplify)
+/*
+ * This function tells us whether an excluded path matches a
+ * list of "interesting" pathspecs. That is, whether a path matched
+ * by any of the pathspecs could possibly be ignored by excluding
+ * the specified path. This can happen if:
+ *
+ *   1. the path is mentioned explicitly in the pathspec
+ *
+ *   2. the path is a directory prefix of some element in the
+ *      pathspec
+ */
+static int exclude_matches_pathspec(const char *path, int len,
+		const struct path_simplify *simplify)
 {
 	if (simplify) {
 		for (; simplify->path; simplify++) {
 			if (len == simplify->len
 			    && !memcmp(path, simplify->path, len))
 				return 1;
+			if (len < simplify->len
+			    && simplify->path[len] == '/'
+			    && !memcmp(path, simplify->path, len))
+				return 1;
 		}
 	}
 	return 0;
@@ -638,7 +654,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 {
 	int exclude = excluded(dir, path, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-	    && in_pathspec(path, *len, simplify))
+	    && exclude_matches_pathspec(path, *len, simplify))
 		dir_add_ignored(dir, path, *len);
 
 	/*
-- 
1.7.0.2.393.g3eb23
