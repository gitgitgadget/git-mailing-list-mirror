From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't work on file names with square brackets
Date: Wed, 10 Feb 2016 10:45:10 -0500
Message-ID: <20160210154510.GB19867@sigill.intra.peff.net>
References: <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
 <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
 <20160208141552.GC27054@sigill.intra.peff.net>
 <20160208150709.GA13664@sigill.intra.peff.net>
 <xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
 <20160208195230.GA30693@sigill.intra.peff.net>
 <20160208202043.GA6002@sigill.intra.peff.net>
 <20160208205637.GA13732@sigill.intra.peff.net>
 <xmqqlh6u6d8v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 16:45:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTWxE-0003tp-MY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 16:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbcBJPpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 10:45:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:39779 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750757AbcBJPpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 10:45:13 -0500
Received: (qmail 1087 invoked by uid 102); 10 Feb 2016 15:45:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 10:45:12 -0500
Received: (qmail 28825 invoked by uid 107); 10 Feb 2016 15:45:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 10:45:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 10:45:10 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlh6u6d8v.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285905>

On Mon, Feb 08, 2016 at 02:36:32PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But having looked at this, I can't help but wonder if the rule should
> > not be "does the file exist" in the first place, but "is the file in the
> > index". This dwimmery is about commands like "log" that are reading
> > existing commits. I cannot think of a case where we would want to
> > include something that exists in the filesystem but not in the index.
> 
> Yeah, checking in the index, once it is loaded, is reasonably quick
> check.  A path that is not in the index or the current HEAD may or
> may not exist on the filesystem, so at some point you would need an
> explicit disambiguation anyway, and the reason why we check the
> filesystem is not because that is conceptually better than checking
> in the index but merely because "does lstat(2) tell us the path is
> there?" check was fairly a cheap way on the platform the system was
> primarily developed on initially.  Looking it up from HEAD would be
> a lot more heavyweight and would not buy us anything, but looking it
> up in the index may turn out to be comparable to a single lstat(2).

Yeah, I had a notion that looking in the index would not be all that
expensive, since we often load it anyway. But this _is_ "git log" we are
talking about, which does not otherwise need to read the index at all. I
suspect lstat(2) is way faster if you have a huge repo, as it is should
be constant-ish, as opposed to O(size-of-index).

> I dunno.  I have a suspicion that anything conceptually more
> expensive than a single lstat(2) is probably not worth doing, as
> this "sometimes you do not have to give --" is merely a usability
> hack, and we have to always do "git log -- removed-sometime-ago"
> to find where in the history a certain path was lost.

Yeah, it just seemed a shame to me that things which clearly _aren't_
ambiguous to any sane viewer would be reported as such by git. I think
the "--" DWIM has worked so well precisely because people do not have
silly-named files in their repositories, so it Just Works most of the
time. The wildcard rule switches it from "you put a file named HEAD in
your repository, now you pay the price for being silly" to "whoops,
everything with a metacharacter is now ambiguous".

-Peff
