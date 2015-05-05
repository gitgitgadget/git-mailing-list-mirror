From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/12] remote.c: drop "remote" pointer from "struct
 branch"
Date: Tue, 5 May 2015 15:31:05 -0400
Message-ID: <20150505193105.GE10463@peff.net>
References: <20150501224414.GA25551@peff.net>
 <20150501224515.GB1534@peff.net>
 <CAPig+cQny16Jei9AtDWVY3ADbPGshFw7CYofD_TnyA+GL58AOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 05 21:31:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpiYk-0003MX-4L
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378AbbEETbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:31:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:54424 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757375AbbEETbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:31:08 -0400
Received: (qmail 23836 invoked by uid 102); 5 May 2015 19:31:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 14:31:07 -0500
Received: (qmail 9771 invoked by uid 107); 5 May 2015 19:31:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 15:31:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 May 2015 15:31:05 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQny16Jei9AtDWVY3ADbPGshFw7CYofD_TnyA+GL58AOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268418>

On Sat, May 02, 2015 at 11:34:25PM -0400, Eric Sunshine wrote:

> > -       if (ret && ret->remote_name) {
> > -               ret->remote = remote_get(ret->remote_name);
> > -               if (ret->merge_nr)
> > -                       set_merge(ret);
> > -       }
> > +       if (ret)
> > +              set_merge(ret);
> 
> When reading the actual patch, I was surprised to see unmentioned
> changes to the reg->merge_nr check. Although the merge_nr
> simplification seems sensible, it appears to be unrelated to the
> stated purpose of the patch, and made the review more difficult since
> it required keeping track of two distinct (yet textually intertwined)
> changes. I wonder if it would make more sense to apply the merge_nr
> simplification as a separate preparatory patch?

I didn't actually mean to change any behavior with respect to
ret->merge_nr here (and I don't think I did). What I did was blindly
move everything in the conditional after the remote_get into set_merge,
so that it happened in the same order (and the remote_get moves into
set_merge, because we no longer have the struct element that it was
formerly passed down in).

But actually, ret->merge_nr comes from make_branch, and we could
continue to respect it regardless of the remote values (i.e., they are
both preconditions to setting up the merge data, but it doesn't matter
in which order we check them).

One thing I did notice while looking at this is that it seems like we
may leak if you call branch_get multiple times. The make_branch()
function may sometimes return a brand-new branch and sometimes return a
cached version from the "branches" array. In the latter case, we
continue to update the "remote" pointer (which is wasteful but at least
does not leak because the remotes themselves are part of a cached list).
But then we will repeatedly re-allocate the ret->merge array. We
probably should make sure it is NULL before trying to fill it in.

I'll see if I can insert a cleanup patch in this part of the series.

-Peff
