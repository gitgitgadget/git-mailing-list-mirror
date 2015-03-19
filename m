From: Jeff King <peff@peff.net>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 21:27:22 -0400
Message-ID: <20150319012722.GA26867@peff.net>
References: <5509836D.2020304@aegee.org>
 <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan>
 <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 02:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYPFB-0003rx-Tv
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 02:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbbCSB1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 21:27:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:34971 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751198AbbCSB1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 21:27:25 -0400
Received: (qmail 19677 invoked by uid 102); 19 Mar 2015 01:27:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 20:27:25 -0500
Received: (qmail 8818 invoked by uid 107); 19 Mar 2015 01:27:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 21:27:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 21:27:22 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265775>

On Thu, Mar 19, 2015 at 07:31:48AM +0700, Duy Nguyen wrote:

> Or we could count/estimate the number of loose objects again after
> repack/prune. Then we can maybe have a way to prevent the next gc that
> we know will not improve the situation anyway. One option is pack
> unreachable objects in the second pack. This would stop the next gc,
> but that would screw prune up because st_mtime info is gone.. Maybe we
> just save a file to tell gc to ignore the number of loose objects
> until after a specific date.

I don't think packing the unreachables is a good plan. They just end up
accumulating then, and they never expire, because we keep refreshing
their mtime at each pack (unless you pack them once and then leave them
to expire, but then you end up with a large number of packs).

Keeping a file that says "I ran gc at time T, and there were still N
objects left over" is probably the best bet. When the next "gc --auto"
runs, if T is recent enough, subtract N from the estimated number of
objects. I'm not sure of the right value for "recent enough" there,
though. If it is too far back, you will not gc when you could. If it is
too close, then you will end up running gc repeatedly, waiting for those
objects to leave the expiration window.

I guess leaving a bunch of loose objects around longer than necessary
isn't the end of the world. It wastes space, but it does not actively
make the rest of git slower (whereas having a large number of packs does
impact performance). So you could probably make "recent enough" be "T <
now - gc.pruneExpire / 4" or something. At most we would try to gc 4
times before dropping unreachable objects, and for the default period,
that's only once every couple days.

-Peff
