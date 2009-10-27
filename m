From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git update --prune issue
Date: Wed, 28 Oct 2009 00:30:56 +0100
Message-ID: <20091027233056.GA25689@atjola.homenet>
References: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com>
 <4AE6B28F.9010407@drmicha.warpmail.net>
 <4389ce950910270807o69d51155xb083f34bb31e1dae@mail.gmail.com>
 <20091027162936.GA8130@sigill.intra.peff.net>
 <20091027164040.GB12464@localhost>
 <20091027165054.GA8554@sigill.intra.peff.net>
 <20091027184627.GA19292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>,
	Jeffrey Middleton <jefromi@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2vVN-0007c7-6c
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 00:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbZJ0Xa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 19:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756842AbZJ0Xa6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 19:30:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:43516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756837AbZJ0Xa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 19:30:58 -0400
Received: (qmail invoked by alias); 27 Oct 2009 23:31:00 -0000
Received: from i59F54A77.versanet.de (EHLO atjola.homenet) [89.245.74.119]
  by mail.gmx.net (mp055) with SMTP; 28 Oct 2009 00:31:00 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+TYt0ZI8GTcrPOAHRoY2fX9tBIhnlA7MLwwXNF/+
	yt6xxh4P9DgCv+
Content-Disposition: inline
In-Reply-To: <20091027184627.GA19292@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131389>

On 2009.10.27 14:46:27 -0400, Jeff King wrote:
> On Tue, Oct 27, 2009 at 12:50:55PM -0400, Jeff King wrote:
> 
> > > Actually, it's beta_gc_dev_old and beta_gc_dev, not the same refs.
> > 
> > OK, I'm a bit blind. Thanks for pointing it out. I'll still see if I can
> > replicate it.
> 
> I'm not having any luck reproducing here with a simple case. :( I'm
> trying:

You need more parent repos, and you need packs. What I guess what
happens is:

The first remote gets fetched from.
The first remote gets pruned. This initializes the pack stuff.
The second remote gets fetched from, and creates a _new_ _pack_.
The second remote gets pruned (*)
The third remote gets fetched from.
The third remote gets pruned.

Now, this prune step calls for_each_ref, which looks through the new
refs for the second remote. This fails, because the new pack was not
present when the pack "system" got initialzed.

(*) I have no idea why this step doesn't fail... But hey, I have no idea
about the whole pack handling either. I just recall that there's some
initialization step...

This reproduces the issue here:

#!/bin/sh

rm -rf parent* child

commit() {
  echo $1 >file && git add file && git commit -m $1
}

mkdir parent0 && (
  cd parent0 &&
  git init &&
  commit one
) &&
mkdir parent1 && (
  cd parent1 &&
  git init &&
  commit two &&
  commit three &&
  git checkout -b other
) &&
mkdir parent2 && (
  cd parent2 &&
  git init &&
  commit four
) &&
mkdir child && (
  cd child &&
  git init &&
  git config fetch.unpackLimit 1
  git remote add parent0 file://$PWD/../parent0 &&
  git remote add parent1 file://$PWD/../parent1 &&
  git remote add parent2 file://$PWD/../parent2 &&
  git remote update
) && (
  cd parent1 &&
  git checkout master &&
  git branch -d other &&
  git reset --hard HEAD^ &&
  commit five
) && (
  cd child &&
  git remote update --prune
)
