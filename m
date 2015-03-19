From: Mike Hommey <mh@glandium.org>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 13:26:17 +0900
Message-ID: <20150319042617.GA1072@glandium.org>
References: <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan>
 <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com>
 <20150319012722.GA26867@peff.net>
 <20150319020117.GA31689@glandium.org>
 <20150319041453.GB29437@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, John Keeping <john@keeping.me.uk>,
	=?iso-2022-jp?B?GyRCJyUnWiddJ3EnXxsoQiAbJEInMSdRJ10nUSdlJ1knYCdTGyhC?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYS2m-0003VT-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 05:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbbCSE0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 00:26:47 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:59383 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbbCSE0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 00:26:46 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YYS2D-0000Ip-Ja; Thu, 19 Mar 2015 13:26:17 +0900
Content-Disposition: inline
In-Reply-To: <20150319041453.GB29437@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265782>

On Thu, Mar 19, 2015 at 12:14:53AM -0400, Jeff King wrote:
> On Thu, Mar 19, 2015 at 11:01:17AM +0900, Mike Hommey wrote:
> 
> > > I don't think packing the unreachables is a good plan. They just end up
> > > accumulating then, and they never expire, because we keep refreshing
> > > their mtime at each pack (unless you pack them once and then leave them
> > > to expire, but then you end up with a large number of packs).
> > 
> > Note, sometimes I wish unreachables were packed. Recently, I ended up in
> > a situation where running gc created something like 3GB of data as per
> > du, because I suddenly had something like 600K unreachable objects, each
> > of them, as a loose object, taking at least 4K on disk. This made my
> > .git take 5GB instead of 2GB. That surely didn't feel like garbage
> > collection.
> 
> That's definitely a thing that happens, but it is a bit of a corner
> case. It's unusual to have such a large number of unreferenced objects
> all at once.
> 
> I don't suppose you happen to remember the details, but would a lower
> expiration time (e.g., 1 day or 1 hour) have made all of those objects
> go away? Or were they really from some extremely recent event (of
> course, "event" here might just have been "I did a full repack right
> before rewriting history" which would freshen the mtimes on everything
> in the pack).

Unfortunately, I don't know the exact details. But yes, I guess a lower
expiration time might have helped.

> Certainly the "loosening" behavior for unreachable objects has corner
> cases like this, and they suck when you hit one. Leaving the objects
> packed would be better, but IMHO is not a viable alternative unless
> somebody comes up with a plan for segregating the "old" objects in a way
> that they actually expire eventually, and don't just keep getting
> repacked and freshened over and over.

It sure is a corner case, otoh, when it happens, every single git
operation calls git gc --auto, which happily spends 5 minutes sucking
CPU to end up doing nothing in practice. And add more salt on the
injury if you are on battery

6700 loose objects seems easy to reach on a repo with 6M objects...

Mike
