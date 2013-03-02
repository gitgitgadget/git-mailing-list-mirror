From: Jeff King <peff@peff.net>
Subject: Re: two-way merge corner case bug
Date: Fri, 1 Mar 2013 19:54:41 -0500
Message-ID: <20130302005441.GA15836@sigill.intra.peff.net>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
 <20130226201820.GD13830@sigill.intra.peff.net>
 <7vwqtulplp.fsf@alter.siamese.dyndns.org>
 <20130301092201.GA17254@sigill.intra.peff.net>
 <7va9qngisg.fsf@alter.siamese.dyndns.org>
 <20130301223612.GA862@sigill.intra.peff.net>
 <7vppzien3i.fsf@alter.siamese.dyndns.org>
 <20130301230845.GA7317@sigill.intra.peff.net>
 <7va9qmel4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 02 01:55:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBajE-0008CY-2n
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 01:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab3CBAyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 19:54:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39681 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab3CBAyn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 19:54:43 -0500
Received: (qmail 5992 invoked by uid 107); 2 Mar 2013 00:56:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 19:56:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 19:54:41 -0500
Content-Disposition: inline
In-Reply-To: <7va9qmel4s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217316>

On Fri, Mar 01, 2013 at 03:49:23PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> I actually was wondering if we can remove that sole uses of two-way
> >> merge with --reset -u from "git am" and replace them with something
> >> else.  But we do want to keep local change that existed before "am"
> >> started, so we cannot avoid use of two-way merge, I guess...
> >
> > Yeah, I think that is a case we definitely want to keep, as it means any
> > intermediate work done by the user in applying the patch is not lost.
> 
> I am not sure what you mean by "intermediate" here.  When the user
> attempts to resolve conflict in a path manually and gives up, we do
> want to revert changes to such a path to that of HEAD.

I thought we left it unchanged intentionally, but I cannot seem to find
the conversation I am thinking of. I did find this:

  http://thread.gmane.org/gmane.comp.version-control.git/164002

But that is not about "save the intermediate work done on applying the
series", but rather to help with this case:

  1. You "git am" a series. It doesn't apply.

  2. You get distracted and work on something else, forgetting that the
     dotest directory is sitting there.

  3. Time passes.

  4. You try to "git am" a new series. An "am" is already in progress,
     so you are advised to "git am --abort".

At that point you do not want to reset the commit to the original head
(which was fixed by 7b3b7e3), but you do not necessarily want to reset
the working tree contents either. We leave them in the name of safety
and letting the user deal with it.

> Clarifying the semantics of "--reset" needs to be done carefully.
> 
> I think any difference "git diff --cached" shows are fair game to
> revert to HEAD.  In the earlier example, path "Z" that was created
> by recursive merge in an attempt to rename "A" should be removed,
> and path "A" should be recreated to that of HEAD, as we know at the
> point of "am --skip/--abort" that these two paths were involved in
> the recursive merge invoked by the patch application process (that
> is the only possible reason why these are different in the index
> from HEAD).  Also any conflicting entries can only come from
> three-way merge and they should be reverted to that of HEAD.
> 
> On the other hand, the paths that appear in "git diff" (except for
> those that appear in "git diff --cached", which we will revert to
> HEAD following the logic of the previous paragraph) must be kept.
> They are changes that were already present in the working tree
> before the user decided to accept a trivial patch via "am" that does
> not overlap with what the user was doing.  We allow a dirty working
> tree but disallow a dirty index when "git am" starts, exactly
> because we want to ensure this property.
> 
> By doing both of the above, we should be able to satisfy the user
> who uses "am --abort/--skip", in order to restore paths that were
> involved in the failed attempt to three-way merge to revert back to
> that of HEAD, while keeping unrelated changes that were present
> before "am" started.

I think that makes sense, but I don't think we have a read-tree mode to
do that in one pass, do we? Not that we can't add one if we need.

-Peff
