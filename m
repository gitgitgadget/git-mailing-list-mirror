From: Jeff King <peff@peff.net>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 16:42:06 -0500
Message-ID: <20110310214206.GA15828@sigill.intra.peff.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
 <20110309215841.GC4400@sigill.intra.peff.net>
 <20110310001017.GA24169@elie>
 <201103101815.23477.trast@student.ethz.ch>
 <20110310184653.GA17832@sigill.intra.peff.net>
 <7vpqpy4w8k.fsf@alter.siamese.dyndns.org>
 <20110310192851.GB19257@sigill.intra.peff.net>
 <7vtyfa3ddm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:42:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxncc-0008Sj-8c
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 22:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab1CJVmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 16:42:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41913
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab1CJVmH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 16:42:07 -0500
Received: (qmail 31262 invoked by uid 107); 10 Mar 2011 21:42:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 16:42:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 16:42:06 -0500
Content-Disposition: inline
In-Reply-To: <7vtyfa3ddm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168853>

On Thu, Mar 10, 2011 at 12:54:29PM -0800, Junio C Hamano wrote:

> Forgetting for now the implementation, I _think_ what you would want is
> for "git add -p" to notice that you are resolving conflicts, and do not
> bother you about cleanly merged parts (I take it is a given that you would
> always want to add them to the index without even inspecting when running
> "add -p"), and make the per-hunk selection loop ask only about the parts
> that originally had conflicts.

Yes, I don't want to see cleanly merged parts. And "--cc" already does
what I want by not showing them. But of course they still need to be
added to the index.

So my thinking was more along the lines of:

  1. Get "git diff HEAD file" and store its hunks.

  2. Get "git diff --cc file" and stores its hunks.

  3. For each hunk in (1), if it does not have an analagous hunk in (2),
     mark it for staging without asking the user.

  4. For the remaining hunks in (1), show the user the analagous --cc
     hunk from (2), and mark the hunk from (1) for staging if requested.

  5. Create the final patch from the marked hunks, apply it to
     HEAD:file, and put that in the index.

There are two issues (and I think you know this, but it took me
reasoning out why this wouldn't work to quite understand what you were
saying in your email, so I'll elaborate here for the benefit of other
readers):

  a. Step (3) glosses over the definition of "analagous hunk". In simple
     cases the hunk headers match up (i.e., they start at the same
     offsets). But the --cc diff is actually a diff against the merge
     base, and the diff in step (1) is against HEAD. So actually we
     would want step (1) and (5) to deal not with the file in HEAD, but
     the file in the merge-base.

     Or we can use "-c" in the first place, which gives us interesting
     and uninteresting parts, and then suppress the uninteresting ones.

  b. You can't stage part of a resolution. This is the "adding a path
     collapses stages to #0" that you mentioned. So either you need an
     index extension, or you need to make it all-or-nothing.

> [discussion of how this could be done right]

That description makes sense to me, but is way overkill for my workflow.
I think at its simplest, what I would like is to be shown the entire
--cc diff, have it say "do you want this and all of the cleanly merged
bits added?" and then either stage the whole thing or not.

Which really I could do with:

  for i in `git diff-files --name-only --diff-filter=U`; do
    git diff --cc $i
    echo 'OK?'
    read r
    test "$r" = y && git add $i
  done

It would just be a little nicer to have it integrated into the "git add
-p" loop.

Even though it is obviously a less featureful solution than what you
proposed, I am tempted to implement it anyway because the current
behavior is so bad (it shows the diff but doesn't consider it a
selectable hunk at all, so it just skips it, exiting immediately if
there are no other files).

And then if somebody wants to spend time allowing partial resolution
selection, it would be a nice improvement on top of that.

-Peff
