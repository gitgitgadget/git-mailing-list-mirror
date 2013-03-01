From: Jeff King <peff@peff.net>
Subject: Re: two-way merge corner case bug
Date: Fri, 1 Mar 2013 04:22:01 -0500
Message-ID: <20130301092201.GA17254@sigill.intra.peff.net>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
 <20130226201820.GD13830@sigill.intra.peff.net>
 <7vwqtulplp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 10:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBMAk-0005m7-8k
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 10:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab3CAJWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 04:22:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39053 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab3CAJWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 04:22:05 -0500
Received: (qmail 31937 invoked by uid 107); 1 Mar 2013 09:23:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 04:23:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 04:22:01 -0500
Content-Disposition: inline
In-Reply-To: <7vwqtulplp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217267>

On Tue, Feb 26, 2013 at 01:41:54PM -0800, Junio C Hamano wrote:

> > Isn't this a repeat of:
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/202440/focus=212316
> [...]
> 
> Yeah, I think the patch in your message is a good starting point to
> solve a half of the issue (i.e. unmerged current one should be
> replaced with the version from the "going to" tree).  Attached is
> with a slight update.

Thanks for picking this up. I'm not sure, though, about the trigger
here:

> +		if (current->ce_flags & CE_CONFLICTED) {
> +			if (same(oldtree, newtree) || o->reset) {
> +				if (!newtree)
> +					return deleted_entry(current, current, o);
> +				else
> +					return merged_entry(newtree, current, o);
> +			}
> +			return o->gently ? -1 : reject_merge(current, o);

We have a conflicted state in the index for a path. If o->reset is true,
then we want to throw it out in favor of where we are moving to. So that
part makes sense.

But if we are not in "--reset", and we see that oldtree and newtree are
the same, do we still want to move to newtree? It seems like we are
throwing away the conflicted state that the user has. Usually this isn't
a big deal, but with "-u" it could mean losing any in-progress
resolution in the working tree.

I think this generally shouldn't happen, as "-m" does not operate when
the index contains unmerged entries. So it would really just be a safety
valve for somebody calling into unpack_trees without having done the
index check. IOW, should the same(newtree, oldtree) call be cut there,
and we trigger this just on reset? Any other case would be rejected
(which _shouldn't_ happen, but this keeps us conservative, and if we
find a case where it does happen, we can figure out the semantics then).

> The other half that is not solved by this patch is that we will lose
> Z because merge-recursive removed it when it renamed it and left
> three stages for A in the index, and to "read-tree --reset -u HEAD
> ORIG_HEAD", it looks as if you removed Z yourself while on HEAD and
> want to carry your local change forward to ORIG_HEAD.
>
> I think this too needs to be fixed.  We are saying "-u --reset" to
> mean "I want to go there no matter what", not "-u -m" that means "I
> am carrying my changes forward while checking out another branch".

Yeah, hmm. Since we cannot distinguish between such a staged removal and
what merge-recursive deposits in the index, we have to err on on side
(either losing a staged removal, or failing to move to the new state).
What we really want is to detect that Z's removal is related to the
conflicted path A, but we can't do so; that information was never put
into the index in the first place.

We could do this:

diff --git a/unpack-trees.c b/unpack-trees.c
index 3d17108..1e84131 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1788,7 +1788,7 @@ int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 		}
 	}
 	else if (newtree) {
-		if (oldtree && !o->initial_checkout) {
+		if (oldtree && !o->initial_checkout && !o->reset) {
 			/*
 			 * deletion of the path was staged;
 			 */

which solves the case you presented. My worry would be that somebody is
using "--reset" but expecting the removal to be carried through
(technically, "--reset" is documented as "-m but discard unmerged
entries", but we are not really treating it that way here). The test
suite passes, but we may not be covering some oddball case.

-Peff

PS I wonder if the "initial_checkout" hack can just go away under this
   new rule. Although we don't seem to use "o->reset" for the initial
   checkout. Which seems kind of weird. I would think the initial
   checkout would actually just be a oneway merge. Is the point to try
   to leave any existing working tree contents untouched or something?
