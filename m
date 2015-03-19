From: Jeff King <peff@peff.net>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 00:14:53 -0400
Message-ID: <20150319041453.GB29437@peff.net>
References: <5509836D.2020304@aegee.org>
 <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan>
 <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
 <20150319012722.GA26867@peff.net>
 <20150319020117.GA31689@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, John Keeping <john@keeping.me.uk>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:15:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYRrI-0002Pv-SU
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 05:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbbCSEO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 00:14:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:35008 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750796AbbCSEO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 00:14:56 -0400
Received: (qmail 31974 invoked by uid 102); 19 Mar 2015 04:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 23:14:56 -0500
Received: (qmail 9743 invoked by uid 107); 19 Mar 2015 04:15:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 00:15:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 00:14:53 -0400
Content-Disposition: inline
In-Reply-To: <20150319020117.GA31689@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265779>

On Thu, Mar 19, 2015 at 11:01:17AM +0900, Mike Hommey wrote:

> > I don't think packing the unreachables is a good plan. They just end up
> > accumulating then, and they never expire, because we keep refreshing
> > their mtime at each pack (unless you pack them once and then leave them
> > to expire, but then you end up with a large number of packs).
> 
> Note, sometimes I wish unreachables were packed. Recently, I ended up in
> a situation where running gc created something like 3GB of data as per
> du, because I suddenly had something like 600K unreachable objects, each
> of them, as a loose object, taking at least 4K on disk. This made my
> .git take 5GB instead of 2GB. That surely didn't feel like garbage
> collection.

That's definitely a thing that happens, but it is a bit of a corner
case. It's unusual to have such a large number of unreferenced objects
all at once.

I don't suppose you happen to remember the details, but would a lower
expiration time (e.g., 1 day or 1 hour) have made all of those objects
go away? Or were they really from some extremely recent event (of
course, "event" here might just have been "I did a full repack right
before rewriting history" which would freshen the mtimes on everything
in the pack).

Certainly the "loosening" behavior for unreachable objects has corner
cases like this, and they suck when you hit one. Leaving the objects
packed would be better, but IMHO is not a viable alternative unless
somebody comes up with a plan for segregating the "old" objects in a way
that they actually expire eventually, and don't just keep getting
repacked and freshened over and over.

-Peff
