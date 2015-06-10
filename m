From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Wed, 10 Jun 2015 15:27:35 -0400
Message-ID: <20150610192734.GA23715@peff.net>
References: <5570F094.10007@quantopian.com>
 <20150607124001.GA11042@peff.net>
 <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
 <20150610185635.GA22800@peff.net>
 <xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?b=C3=A4r?= <crashcookie@gmail.com>,
	Jonathan Kamens <jkamens@quantopian.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:27:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2lf6-0000qq-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 21:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbbFJT1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 15:27:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:44366 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753288AbbFJT1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 15:27:40 -0400
Received: (qmail 19566 invoked by uid 102); 10 Jun 2015 19:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Jun 2015 14:27:39 -0500
Received: (qmail 30766 invoked by uid 107); 10 Jun 2015 19:27:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Jun 2015 15:27:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jun 2015 15:27:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271348>

On Wed, Jun 10, 2015 at 12:16:25PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I am trying to figure out what the use case here is. Clearly the
> > above is a toy case, but why is "stash -k" followed by a quick pop
> > useful in general? Certainly I use "stash" (without "-k") and a quick
> > pop all the time, and I think that is what stash was designed for.
> >
> > The best use case I can think of is Jonathan's original: to see only the
> > staged content in the working tree, and then restore the original state.
> > But stash does not currently work very well for that, as shown above.
> 
> The canonical use case for "stash -k" is to see only the content to
> be committed (for testing), commit it after testing and then pop on
> top of the committed result, which is the same as what you saw in
> the working tree and the index when you did "stash -k".  I do not
> think "stash -k && stash pop" was in the design parameter when "-k"
> was added (as you demonstrated, it would not fundamentally work
> reliably depending on the differences between HEAD-Index-Worktree).

It seems like applying a stash made with "-k" is fundamentally
misdesigned in the current code. We would want to apply to the working
tree the difference between the index and the working tree, but instead
we try to apply the difference between the HEAD and the working tree.
Which is nonsensical for this use case (i.e., to apply the diff between
$stash and $stash^2, not $stash^1).

I don't think there is any way to tell that "-k" was used, though. But
even if the user knew that, I do not think there is any option to tell
"stash apply" to do it this way.

I dunno. With respect to the original patch, I am OK if we just want to
revert it. This area of stash seems a bit under-designed IMHO, but if
people were happy enough with it before, I do not think the safety
benefit from ed178ef is that great (it is not saving you from destroying
working tree content, only the index state; the individual content blobs
are still available from git-fsck).

-Peff
