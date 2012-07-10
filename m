From: Jeff King <peff@peff.net>
Subject: Re: "git commit --amend --only --" nevertheless commits staged
 changes
Date: Tue, 10 Jul 2012 16:40:29 -0400
Message-ID: <20120710204028.GC23798@sigill.intra.peff.net>
References: <4FFC06C9.5050405@syntevo.com>
 <7vwr2bgyqf.fsf@alter.siamese.dyndns.org>
 <20120710203052.GB23798@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:40:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SohEa-0001bQ-G2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 22:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab2GJUkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 16:40:31 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56854
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab2GJUkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 16:40:31 -0400
Received: (qmail 2219 invoked by uid 107); 10 Jul 2012 20:40:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jul 2012 16:40:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2012 16:40:29 -0400
Content-Disposition: inline
In-Reply-To: <20120710203052.GB23798@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201277>

On Tue, Jul 10, 2012 at 04:30:52PM -0400, Jeff King wrote:

> On Tue, Jul 10, 2012 at 01:14:32PM -0700, Junio C Hamano wrote:
> 
> > I do not think the combination with --amend, --only and no paths
> > ever worked.  We rejected such a combination before 6a74642c5, which
> > merely made us to accept the combination but I do not think the
> > commit did anything to re-read the tree from the HEAD being amended
> > to the index.
> > 
> > Something like this, but I haven't thought about what other things
> > it may break.
> 
> Our emails just crossed. I came to the exact same conclusion, and just
> wrote almost the exact same patch.

Here it is with a test and commit message. I believe this fix could also
make:

  git commit --allow-empty --only --

work if we removed the "--only does not make sense without paths" check.
But I seriously doubt that anybody cares, given that "--only" is the
default (i.e., just omitting it already does what you want there,
whether you have pathspecs or not).

-- >8 --
Subject: [PATCH] commit: fix "--amend --only" with no pathspec

When we do not have any pathspec, we typically disallow an
explicit "--only", because it makes no sense (your commit
would, by definition, be empty). But since 6a74642
(git-commit --amend: two fixes., 2006-04-20), we have
allowed "--amend --only" with the intent that it would amend
the commit, ignoring any contents staged in the index.

However, while that commit allowed the combination, we never
actually implemented the logic to make it work. The current
code notices that we have no pathspec and assumes we want to
do an as-is commit (i.e., the "--only" is ignored).

Instead, we must make sure to follow the partial-commit
code-path. We also need to tweak the list_paths function to
handle a NULL pathspec.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c  |  5 ++++-
 t/t7501-commit.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f43eaaf..3c3385c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -184,6 +184,9 @@ static int list_paths(struct string_list *list, const char *with_tree,
 	int i;
 	char *m;
 
+	if (!pattern)
+		return 0;
+
 	for (i = 0; pattern[i]; i++)
 		;
 	m = xcalloc(1, i);
@@ -345,7 +348,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
 	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
-	if (!pathspec || !*pathspec) {
+	if (!only && (!pathspec || !*pathspec)) {
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed) {
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b20ca0e..9f8d423 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -108,6 +108,16 @@ test_expect_success 'amend commit' '
 	EDITOR=./editor git commit --amend
 '
 
+test_expect_success 'amend --only ignores staged contents' '
+	test_when_finished "git reset --hard" &&
+	cp file file.expect &&
+	echo changed >file &&
+	git add file &&
+	git commit --no-edit --amend --only &&
+	git cat-file blob HEAD:file >file.actual &&
+	test_cmp file.expect file.actual
+'
+
 test_expect_success 'set up editor' '
 	cat >editor <<-\EOF &&
 	#!/bin/sh
-- 
1.7.11.35.gbaf554e.dirty
