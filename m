From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pickaxe: use textconv for -S counting
Date: Wed, 21 Nov 2012 15:27:05 -0500
Message-ID: <20121121202704.GH16280@sigill.intra.peff.net>
References: <20121028124540.GF11434@sigill.intra.peff.net>
 <20121028124701.GB24548@sigill.intra.peff.net>
 <7vk3tpcd0w.fsf@alter.siamese.dyndns.org>
 <20121115012131.GA17894@sigill.intra.peff.net>
 <7v3905uncf.fsf@alter.siamese.dyndns.org>
 <7vr4npt7zd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 21:27:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbGtI-00049J-DJ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 21:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab2KUU1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 15:27:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54515 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755843Ab2KUU1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 15:27:07 -0500
Received: (qmail 10061 invoked by uid 107); 21 Nov 2012 20:28:00 -0000
Received: from ip68-100-44-35.dc.dc.cox.net (HELO sigill.intra.peff.net) (68.100.44.35)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Nov 2012 15:28:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2012 15:27:05 -0500
Content-Disposition: inline
In-Reply-To: <7vr4npt7zd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210176>

On Mon, Nov 19, 2012 at 04:48:22PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> Exact renames are the obvious one, but they are not handled here.
> >
> > That is half true.  Before this change, we will find the same number
> > of needles and this function would have said "no differences" in a
> > very inefficient way.  After this change, we may apply different
> > textconv filters and this function will say "there is a difference",
> > even though we wouldn't see such a difference at the content level
> > if there wasn't any rename.
> 
> ... but I think that is a good thing anyway.
> 
> If you renamed foo.c to foo.cc with different conversions from C
> code to the text that explain what the code does, if we special case
> only the exact rename case but let pickaxe examine the converted
> result in a case where blobs are modified only by one byte, we would
> get drastically different results between the two cases.

Right, exactly. I think the only sane thing is to always textconv or
always not textconv (whether they are identical renames or not), and any
"these are the same" optimization for identical content needs to take
into account whether we _would have_ done a different textconv (which
most of the time is going to be "no", as textconv is either not in use,
or both paths use the same diff driver; but it is not too expensive to
look up).

The diff_unmodified_pair at the top off diff_flush_patch is correct,
because it treats renames as interesting (because we have to show the
diff header, anyway). I do not know offhand if we avoid feeding
identical content to xdiff at all, but if so, we should be doing so only
after checking that the textconv filters are identical.

> Corollary to this is what should happen when you update the attributes
> between two trees so that textconv for a path that did not change
> between preimage and postimage are different.  Ideally, we should
> notice that the two converted result are different, perhaps, but I
> do not like the performance implications very much.

The content to compare cannot be different unless either the input
content changed or the path changed, and we treat either as
"interesting" in most code paths. So I do not think there are any
performance implications, except that we may need to make sure to look
up textconvs a few lines sooner in some cases.

I'll re-roll the series next week and break out the rename-optimization
bits separately so it is more obvious that it is doing the right thing.

As an aside, I also need to revisit the regex half of that code, which
is still buggy (before and after my patch, due to the expecting-a-NUL
behavior we talked about a week or two ago).  That is a separate topic,
but the same area of code.

-Peff
