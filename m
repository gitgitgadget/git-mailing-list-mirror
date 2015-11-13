From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Fri, 13 Nov 2015 16:29:15 +0100
Message-ID: <20151113152915.GC16219@inner.h.apk.li>
References: <20150316142026.GJ7847@inner.h.apk.li> <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com> <20150316184040.GA8902@inner.h.apk.li> <20150317024005.GA26313@peff.net> <xmqqd248p4o9.fsf@gitster.dls.corp.google.com> <20150317054759.GA16860@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 16:29:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxGIN-0000DG-9O
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 16:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbbKMP3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 10:29:43 -0500
Received: from continuum.iocl.org ([217.140.74.2]:38783 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180AbbKMP3m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 10:29:42 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tADFTFS30770;
	Fri, 13 Nov 2015 16:29:15 +0100
Content-Disposition: inline
In-Reply-To: <20150317054759.GA16860@peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281253>

On Tue, 17 Mar 2015 01:48:00 +0000, Jeff King wrote:
> On Mon, Mar 16, 2015 at 10:35:18PM -0700, Junio C Hamano wrote:
> 
> > > It looks like we don't even really care about the value of HEAD. We just
> > > want to know "is it a git directory?". I think in other places (like
> > > "git add"), we just do an existence check for "$dir/.git". That would
> > > not catch a bare repository, but I do not think the current check does
> > > either (it is looking for submodules, which always have a .git).
> > 
> > If we wanted to be consistent, perhaps we should be reusing the "is
> > this a git repository?" check used by the auto-discovery codepath
> > (setup.c:is_git_directory(), perhaps?), but the idea looks simple
> > enough and sounds sensible.
> 
> Yeah, I almost suggested that, but I'm concerned that would make us
> inconsistent with how we report untracked files. I thought that dir.c
> used ".git" as a magic token there.
> 
> But it seems I'm wrong. We do ignore ".git" directly in treat_path(),
> but treat_directory actually checks resolve_gitlink_ref. I think this
> will suffer the same problem as Andreas's original issue (e.g., if you
> run "git ls-files -o").

Guess what landed on my desk this week. Same repo, same
application test suite, same problem, now with 'git ls-files -o'.

> Likewise, I think dir.c:remove_dir_recurse is in a similar boat.
> Grepping for resolve_gitlink_ref, it looks like there may be others,
> too.

Can't we handle this in resolve_gitlink_ref itself? As I understand it,
it should resolve a ref (here "HEAD") when path points to a submodule.
When there isn't one it should return -1, so:

diff --git a/refs.c b/refs.c
index 132eff5..f8648c5 100644
--- a/refs.c
+++ b/refs.c
@@ -1553,6 +1553,10 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	if (!len)
 		return -1;
 	submodule = xstrndup(path, len);
+	if (!is_git_directory(submodule)) {
+		free(submodule);
+		return -1;
+	}
 	refs = get_ref_cache(submodule);
 	free(submodule);

I'm way too little into the code to see what may this may get wrong.

But this, as well as the old hash-ref-cache patch speeds me
up considerably, in this case a git ls-files -o from half a
minute of mostly user CPU to a second.

> All of these should be using the same test, I think. Doing that with
> is_git_directory() is probably OK. It is a little more expensive than we
> might want for mass-use (it actually opens and parses the HEAD file in
> each directory),

This happens as well when we let resolve_gitlink_ref run its old course.
(It (ls-files) even seems to try to open .git and then .git/HEAD, even
if the former fails with ENOENT.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
