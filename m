From: Jeff King <peff@peff.net>
Subject: Re: How do I resolve conflict after popping stash without adding the
 file to index?
Date: Wed, 22 Apr 2015 14:35:41 -0400
Message-ID: <20150422183540.GC3535@peff.net>
References: <5535697E.2030204@yandex.ru>
 <xmqqsibujyit.fsf@gitster.dls.corp.google.com>
 <553583C0.6090404@yandex.ru>
 <20150421212922.GC13230@peff.net>
 <5536D099.1000103@yandex.ru>
 <20150421225228.GB26322@peff.net>
 <xmqqa8y0f4cv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Gutov <dgutov@yandex.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 20:35:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkzUz-0003bY-9d
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 20:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbbDVSfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 14:35:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:48701 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751072AbbDVSfn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 14:35:43 -0400
Received: (qmail 6307 invoked by uid 102); 22 Apr 2015 18:35:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 13:35:43 -0500
Received: (qmail 12584 invoked by uid 107); 22 Apr 2015 18:36:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:36:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 14:35:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8y0f4cv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267608>

On Wed, Apr 22, 2015 at 10:41:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Right, I am suggesting that latter: that stash should abort if the index
> > has modified entries. The abort for modified working tree files is done
> > by git-merge, which can be selective about which entries will be changed
> > (since it knows which ones need written).  I haven't thought hard enough
> > to say whether it should be doing the same for the index (i.e., whether
> > this is a "merge" problem or a "stash" problem).
> 
> This is a stash problem.  I've always thought that it insisted on
> having a clean index and a clean working tree, but apparently it
> doesn't, as shown in Dmitry's example sequence.

It did check the working tree manually, until my e0e2a9c (stash: drop
dirty worktree check on apply, 2011-04-05). But I don't think we ever
checked that the index was clean with respect to HEAD.

> Generally speaking, any mergy operation should be done with a clean
> index (i.e. matches HEAD) so that any difference between the index
> and the HEAD after it stops in the middle is purely the result of
> that mergy operation, and the commands should stop when the index is
> not clean as a safety measure (e.g. "git am -3", "git merge") [*1*].

I guess this was the heart of my question. Should a mergy operation
start with a clean index (which the caller can enforce), or does it only
need the index entries that it is going to touch to be clean (which is
known only to the merging code)? The latter is more permissive, as we
know that we will not create conflict entries that overwrite what is
staged in the index. But I don't think we have good tool support for
operating on only those entries afterwards (e.g., "git reset --keep"
would hose your staged changes along with undoing the parts modified by
the merge).  So probably asking for a completely clean index is the only
sane thing.

> An especially tricky command may also insist on a clean working tree
> if it is not easy to guarantee that it will not clobber changes by
> the user when it stops in the middle (e.g. "git rebase").  But this
> is an escape hatch for lazy implementations ;-) It would be ideal if
> a command stops without doing anything when the set of paths it
> needs to touch would overlap the set of paths in which user has
> changes before the command is run (e.g. "git merge" works that way).

Right, and I think we do that appropriately in stash since e0e2a9c.

> I think that "stash apply" requires a clean working tree for the
> latter reason, and does not require a clean index because it just
> forgot that it must do so.

Ironically, the message before e0e2a9c actually recommends staging
changes before applying the stash, which would lead to this exact
situation! So I think the most trivial patch is:

diff --git a/git-stash.sh b/git-stash.sh
index d4cf818..f1865c9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -442,6 +442,7 @@ apply_stash () {
 	assert_stash_like "$@"
 
 	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
+	git diff-index --cached HEAD || die "dirty index; cannot apply stash"
 
 	# current index state
 	c_tree=$(git write-tree) ||

but it makes me wonder if somebody would find it annoying that they
cannot apply a stash into their work-in-progress (i.e., it _might_ cause
annoyance, but most of the time it will be convenient to do so).

We also have require_clean_work_tree() in git-sh-setup.sh. We definitely
don't want the first half of that, but we do want the diff-index check.
So probably we'd want to refactor that into two separate functions, and
only call the require_clean_index part.

-Peff
