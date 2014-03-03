From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying
 HEAD~<number>
Date: Mon, 3 Mar 2014 05:13:03 -0500
Message-ID: <20140303101303.GA23977@sigill.intra.peff.net>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-3-git-send-email-pclouds@gmail.com>
 <CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
 <CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
 <vpqlhwsr3ww.fsf@anie.imag.fr>
 <53144881.6090702@alum.mit.edu>
 <vpq7g8bfws8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKPs2-0003up-Bn
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbaCCKNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:13:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:60261 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754301AbaCCKNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:13:06 -0500
Received: (qmail 6156 invoked by uid 102); 3 Mar 2014 10:13:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Mar 2014 04:13:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Mar 2014 05:13:03 -0500
Content-Disposition: inline
In-Reply-To: <vpq7g8bfws8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243212>

On Mon, Mar 03, 2014 at 10:37:11AM +0100, Matthieu Moy wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > Or perhaps "-NUM" should fail with an error message if any of the last
> > NUM commits are merges.  In that restricted scenario (which probably
> > accounts for 99% of rebases), "-NUM" is equivalent to "HEAD~NUM".
> 
> Makes sense to me. So, -NUM would actually mean "rebase the last NUM
> commits" (as well as being an alias for HEAD~NUM), but would fail when
> it does not make sense (with an error message explaining the situation
> and pointing the user to HEAD~N if this is what he wanted).

Yeah, I agree with this. I think "-NUM" is only useful for linear
string-of-pearls history. With merges, it either means:

  - linearize history (a la git-log), go back NUM commits, and treat the
    result as the upstream. This is useless, because it's difficult to
    predict where you're going to end up. Using explicit "~" and "^"
    relative-commit operators to specify the upstream is more flexible
    if you really want to do this (but I don't know why you would).

  - do not use an UNINTERESTING upstream as the cutoff, but instead
    try to rebase exactly NUM commits. In the face of non-linear
    history, I'm not even sure what this would mean, or how we would
    implement it.

Neither of those is useful, so I don't think erroring out on them is a
bad thing. And by erroring out (rather than documenting some weird and
useless behavior), we don't have to worry about backwards compatibility
if we later _do_ come up with a useful behavior (the best I can think of
is that "--first-parent -3" might have a use, but I think that should
already be covered, as the results of --first-parent are by-definition
linear).

> This would actually be a feature for me: I often want to rebase "recent
> enough" history, and when my @{upstream} isn't well positionned, I
> randomly type HEAD~N without remembering what N should be. When N is too
> small, the rebase doesn't reach the interesting commit, and when N is
> too big, it reaches a merge commit and I get a bunch of commits I'm not
> allowed to edit in my todo-list. Then I have to abort the commit
> manually. With -N failing on merge commits, the rebase would abort
> itself automatically.

I do the same thing.

-Peff
