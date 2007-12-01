From: Jeff King <peff@peff.net>
Subject: Re: [RFC] use typechange as rename source
Date: Fri, 30 Nov 2007 23:34:07 -0500
Message-ID: <20071201043407.GD30725@coredump.intra.peff.net>
References: <20071121171235.GA32233@sigill.intra.peff.net> <7vir3l2a1i.fsf@gitster.siamese.dyndns.org> <20071129141452.GA32670@coredump.intra.peff.net> <7vmyswsfl6.fsf@gitster.siamese.dyndns.org> <20071130015716.GA15224@coredump.intra.peff.net> <7vsl2n87jr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 05:34:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyK3j-0000pI-Iy
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 05:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbXLAEeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 23:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756085AbXLAEeL
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 23:34:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3885 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006AbXLAEeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 23:34:10 -0500
Received: (qmail 13898 invoked by uid 111); 1 Dec 2007 04:34:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 23:34:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 23:34:07 -0500
Content-Disposition: inline
In-Reply-To: <7vsl2n87jr.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66697>

On Fri, Nov 30, 2007 at 06:36:56PM -0800, Junio C Hamano wrote:

> > I have always been a bit confused about diffcore-break, so I am probably
> > misunderstanding what you mean. But are you saying that
> > diffcore-break.c:should_break should return 1 for typechanges?
> 
> What I had in mind was to do something like that in spirit, but instead
> break such a filepair inside diffcore-rename (iow, even when the user
> did not say -B) early on.

Ah, I see. BTW, I totally screwed up the tests I did earlier. Returning
1 from should_break _does_ produce the same results for my simple case
(copy + typechange).

> But after re-reading your patch and the surrounding code, that is
> more or less what you are doing (without actually recording the extra
> broken pair to be merged back later).

I don't think we need to, because they are never actually "broken"; we
simply consider the source a candidate for renaming, but keep the pair
together to note the typechange.

> which is essentially doing the same thing but only for the "remove the
> regular file" half.  One has to wonder how the lack of handling the
> other half affects the outcome and still produce a result more intuitive
> than the current code.

AIUI, because we never broke the pair in the first place, we don't need
to look for a source for that dest (the "add a new symlink" half). It's
already part of the same filepair.

Whether this is by design or simply a happy accident that we record both
renames and typechanges in diff_filepairs, I'm not sure. Or perhaps I'm
totally misunderstanding how the breaking works.

> In your test case, the "new" symlink won't have any similar symlink that
> is removed from the preimage, so registering it as a rename destination
> would not make a difference (it will say "no match found, so create this
> as usual"), but I am not convinced if that would work well in general.

I don't know that it makes a difference. We are impacting only a
'typechange', which implies that we have a filepair in which both p->one
and p->two are valid; thus, the current code doesn't use it as a rename
dst at all.

-Peff
