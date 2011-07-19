From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git commit generation numbers
Date: Tue, 19 Jul 2011 06:14:38 +0200
Message-ID: <201107190614.38431.chriscool@tuxfamily.org>
References: <20110714200144.GE26918@sigill.intra.peff.net> <CAP8UFD3p8rv9BoPkTYSr_qRztKhWmmHgjHi0pZ6gN9YzkSX0Jw@mail.gmail.com> <20110718034106.GB2468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 19 06:16:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj1j6-0003xq-LI
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 06:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab1GSEOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 00:14:53 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:52431 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab1GSEOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 00:14:52 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 305AEA6133;
	Tue, 19 Jul 2011 06:14:39 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <20110718034106.GB2468@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177435>

On Monday 18 July 2011 05:41:06 Jeff King wrote:
> On Sat, Jul 16, 2011 at 11:16:45AM +0200, Christian Couder wrote:
> > If  "git tag --contains" and "git branch --contains" give incorrect
> > answers because the commiter date is wrong in some commits, then why
> > not use "git replace" to "change" the commiter date in the commits
> > that have a wrong date? Is it because you don't want to use "git
> > replace", or because there is no script to do it automatically, or is
> > there another reason?
> 
> That would work. There are a few tricky things, though:
> 
>   1. Most commits have less than 100 skewed commits. But some have many
>      (e.g., thousands in the mesa repo). How well does git cope with
>      large numbers of replace refs, performance-wise?

If it did not cope well, it should be possible to improve the performance.

Anyway, another way to fix the problem with "git replace" could be to create 
branches with commits that have a fixed commiter date and then to use "git 
replace" only to connect these branches to the graph.

For example if you have this:

A - B - X1 - X2 - X3 - C - D

where X1, X2 and X3 are skewed, then you can create this:

A - B - X1 - X2 - X3 - C - D
         \ Y1 - Y2 - Y3

where Y1, Y2, Y3 are the same as X1, X2, X3 except they are not skewed.
Then you only need to do "git replace X3 Y3" so you create only one replace 
ref.

> 
>   2. Declaring which commits are skewed is actually tricky. You can find
>      a commit whose timestamp is less than the timestamp of one of its
>      ancestors. But you don't know whether it is skewed, or the
>      ancestor.
> 
>      If you are implementing a list of commits whose timestamps
>      shouldn't be used for traversal cutoff, it doesn't really matter
>      who is _right_; you just care about whether the timestamps are
>      strictly increasing from that point.
> 
>      But once you start replacing commits, you need to put in a
>      reasonable value for the timestamp. So you may well be replacing a
>      perfectly valid commit with one that has bogus, skewed information
>      in the commit timestamp.

Perhaps but with "git replace" you can choose to create new replace refs and 
deprecate the old replace refs to fix this where you got it wrong.

It would be easier to do that if "git replace" supported sub directories like 
"refs/replace/clock-skew/ted-july-2011/", so you could manage the replace refs 
more easily.

For example you could create new refs in "refs/replace/clock-skew/ted-
july-2011-2/" if you found a better fix. And then use these new refs instead of 
those in "refs/replace/clock-skew/ted-july-2011/".

>   3. Any value you put in is actually going to be a lie during things
>      like "git log --pretty=raw". That may be OK. But it is letting an
>      optimization meant to make traversal fast and accurate bleed into
>      the actual data we show the user.

With replace refs, the user could choose the "lies" told to him/her by 
selecting the replace refs or set of replace refs that are used.

As commits are immutable, when they are created with bad data, the best we can 
do is let the user choose if they want to see the original or another "fixed" 
version. Because the original will always be "true" in a way.

>   4. Sometimes we need to do traversals on the real objects (e.g.,
>      because we are doing upload-pack). To get the benefit, those
>      traversals would presumably need to look at both the original
>      object and the replacement, use the timestamp from the replacement
>      for traversal, but otherwise use the original object.

Yeah, or maybe when we do traversals on real objects we could afford not to 
rely on commiter date or some other "fragile" data.

Thanks,
Christian.
