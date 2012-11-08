From: Jeff King <peff@peff.net>
Subject: Re: Long clone time after "done."
Date: Thu, 8 Nov 2012 17:33:19 -0500
Message-ID: <20121108223319.GA11734@sigill.intra.peff.net>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
 <20121108155607.GD15560@sigill.intra.peff.net>
 <CAMJd5AQ24u11BH6rMAHvR95N4ys6KHfEQKD1uLzr+=TDgN_69Q@mail.gmail.com>
 <20121108203332.GQ15560@sigill.intra.peff.net>
 <CAMJd5ARLCk_WQTbyLciv0LnrMa_J0YstNsrq-hLYM5DXiO0hLA@mail.gmail.com>
 <20121108221128.GA11186@sigill.intra.peff.net>
 <CAMJd5ATX5Ru9Orp2t3p39q7tsNRfGjqDYGnf4-9QYNSTpQ-YuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 23:33:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWafI-0007Fo-KR
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 23:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665Ab2KHWdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 17:33:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36792 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756631Ab2KHWdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 17:33:23 -0500
Received: (qmail 1473 invoked by uid 107); 8 Nov 2012 22:34:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 17:34:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 17:33:19 -0500
Content-Disposition: inline
In-Reply-To: <CAMJd5ATX5Ru9Orp2t3p39q7tsNRfGjqDYGnf4-9QYNSTpQ-YuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209195>

On Thu, Nov 08, 2012 at 04:16:59PM -0600, Uri Moszkowicz wrote:

> I ran "git cat-file commit some-tag" for every tag. They seem to be
> roughly uniformly distributed between 0s and 2s and about 2/3 of the
> time seems to be system. My disk is mounted over NFS so I tried on the
> local disk and it didn't make a difference.
> 
> I have only one 1.97GB pack. I ran "git gc --aggressive" before.

Ah. NFS. That is almost certainly the source of the problem. Git will
aggressively mmap. I would not be surprised to find that RHEL4's NFS
implementation is not particularly fast at mmap-ing 2G files, and is
spending a bunch of time in the kernel servicing the requests.

Aside from upgrading your OS or getting off of NFS, I don't have a lot
of advice.  The performance characteristics you are seeing are so
grossly off of what is normal that using git is probably going to be
painful. Your 2s cat-files should be more like .002s. I don't think
there's anything for git to fix here.

You could try building with NO_MMAP, which will emulate it with pread.
That might fare better under your NFS implementation. Or it might be
just as bad.

-Peff
