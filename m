From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/6] grep: turn off gitlink detection for --no-index
Date: Mon, 7 Mar 2016 10:51:21 -0500
Message-ID: <20160307155121.GB23010@sigill.intra.peff.net>
References: <20160305220829.GA31316@sigill.intra.peff.net>
 <20160305221551.GE31508@sigill.intra.peff.net>
 <xmqqk2lfrs82.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 16:51:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acxRQ-0003GV-Uv
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 16:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbcCGPv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 10:51:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:55755 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752840AbcCGPvY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 10:51:24 -0500
Received: (qmail 7920 invoked by uid 102); 7 Mar 2016 15:51:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Mar 2016 10:51:23 -0500
Received: (qmail 26073 invoked by uid 107); 7 Mar 2016 15:51:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Mar 2016 10:51:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2016 10:51:21 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk2lfrs82.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288393>

On Sun, Mar 06, 2016 at 05:29:01PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If we are running "git grep --no-index" outside of a git
> > repository, we behave roughly like "grep -r", examining all
> > files in the current directory and its subdirectories.
> > However, because we use fill_directory() to do the
> > recursion, it will skip over any directories which look like
> > sub-repositories.
> >
> > For a normal git operation (like "git grep" in a repository)
> > this makes sense; we do not want to cross the boundary out
> > of our current repository into a submodule. But for
> > "--no-index" without a repository, we should look at all
> > files, including embedded repositories.
> >
> > There is one exception, though: we probably should _not_
> > descend into ".git" directories. Doing so is inefficient and
> > unlikely to turn up useful hits.
> >
> > This patch drops our use of dir.c's gitlink-detection, but
> > we do still avoid ".git". That makes us more like tools such
> > as "ack" or "ag", which also know to avoid cruft in .git.
> >
> > As a bonus, this also drops our usage of the ref code
> > when we are outside of a repository, making the transition
> > to pluggable ref backends cleaner.
> >
> > Based-on-a-patch-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I hope the reasoning above makes sense. My ulterior motive is the
> > "bonus", but I really think the new behavior is what people would expect
> > (i.e., that "git grep --no-index" is basically a replacement for "ack",
> > etc).
> 
> I agree with --no-index part, but the caller of grep_directory() is
> "either no-index, or untracked".  I am not sure if the latter wants
> this new behaviour.

I didn't consider that. I could see arguments either way for
--untracked, but I think I'd lean towards it doing the "usual" thing
with embedded untracked repos (i.e., ignoring them).

We could do that by checking startup_info->have_repository. Which makes
me wonder if that check should actually go deep into dir.c, and all
callers (if there are any) who don't have a repository should not treat
gitlinks specially.

But I guess one can actually do "--no-index" inside a repository, so we
really do need to predicate it on that option, not "are we in a repo".

So here's a replacement patch:

-- >8 --
Subject: grep: turn off gitlink detection for --no-index

If we are running "git grep --no-index" outside of a git
repository, we behave roughly like "grep -r", examining all
files in the current directory and its subdirectories.
However, because we use fill_directory() to do the
recursion, it will skip over any directories which look like
sub-repositories.

For a normal git operation (like "git grep" in a repository)
this makes sense; we do not want to cross the boundary out
of our current repository into a submodule. But for
"--no-index" without a repository, we should look at all
files, including embedded repositories.

There is one exception, though: we probably should _not_
descend into ".git" directories. Doing so is inefficient and
unlikely to turn up useful hits.

This patch drops our use of dir.c's gitlink-detection, but
we do still avoid ".git". That makes us more like tools such
as "ack" or "ag", which also know to avoid cruft in .git.

As a bonus, this also drops our usage of the ref code
when we are outside of a repository, making the transition
to pluggable ref backends cleaner.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c  |  6 ++++--
 t/t7810-grep.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index aa7435f..111b6f6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -522,12 +522,14 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
-			  int exc_std)
+			  int exc_std, int use_index)
 {
 	struct dir_struct dir;
 	int i, hit = 0;
 
 	memset(&dir, 0, sizeof(dir));
+	if (!use_index)
+		dir.flags |= DIR_NO_GITLINKS;
 	if (exc_std)
 		setup_standard_excludes(&dir);
 
@@ -902,7 +904,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
 		if (list.nr)
 			die(_("--no-index or --untracked cannot be used with revs."));
-		hit = grep_directory(&opt, &pathspec, use_exclude);
+		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
 	} else if (!list.nr) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index b540944..1e72971 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -905,6 +905,33 @@ test_expect_success 'inside git repository but with --no-index' '
 	)
 '
 
+test_expect_success 'grep --no-index descends into repos, but not .git' '
+	rm -fr non &&
+	mkdir -p non/git &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+
+		echo magic >file &&
+		git init repo &&
+		(
+			cd repo &&
+			echo magic >file &&
+			git add file &&
+			git commit -m foo &&
+			echo magic >.git/file
+		) &&
+
+		cat >expect <<-\EOF &&
+		file
+		repo/file
+		EOF
+		git grep -l --no-index magic >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
-- 
2.8.0.rc1.318.g2193183
