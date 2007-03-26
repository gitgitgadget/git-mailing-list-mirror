From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Type mismatches in safe_read and friends?
Date: Mon, 26 Mar 2007 12:47:55 -0400
Message-ID: <20070326164755.GH13247@spearce.org>
References: <4607D4F6.80703@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 18:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsMZ-0001hE-Bx
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 18:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbXCZQsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 12:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbXCZQsE
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 12:48:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59986 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbXCZQsB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 12:48:01 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVsMI-0003kW-J8; Mon, 26 Mar 2007 12:47:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E8E720FBAE; Mon, 26 Mar 2007 12:47:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4607D4F6.80703@dawes.za.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43158>

Rogan Dawes <lists@dawes.za.net> wrote:
> I'm starting to learn a little C, and I figured I'd learn from the 
> masters ;-) I needed to read in some data from the network, and I 
> figured the safe_* calls would be a good example of how to do it correctly.
...
> static void safe_read(int fd, void *buffer, unsigned size)
> {
>         int n = 0;
> 
>         while (n < size) {
>                 int ret = xread(fd, (char *) buffer + n, size - n);
...
> Surely size and 'n' should have the same signed-ness?

Gah.  Yes.  And ret should be ssize_t.
 
> And, in fact, shouldn't they actually be size_t, rather than 'int', 
> since xread is defined as:

Yes.

> static inline ssize_t xread(int fd, void *buf, size_t len)
...
> And finally, 'ret' in safe_read should be a 'ssize_t', not an int, right?

Oh, I see you noticed that too.  ;-)
 
> Or is it just a case that we don't really care, since we control the 
> ranges of the values, and the underlying types are int anyway? Patches 
> to follow if I get an indication that anyone cares, otherwise I'd be 
> posting my question to a C newbies group. ;-)

It is sort of a case we don't care.  These probably should be fixed.
A patch would be nice.  You want to learn C...  ;-)

We currently assume that sizeof(unsigned) == sizeof(int) == 4,
and that nobody is crazy enough to call this functions with values
over ~2,000,000,000 so we don't practically have signed/unsigned
issues here.  Right now anyway.  But it shouldn't be like this.

So size_t/ssize_t are the right types.


The one that cracks me up is what moron declared read(2) to take
size_t as the input argument and ssize_t as the return value.
So I can pass in a value that if successfully read by the kernel
will actually be < 0 upon return, making my code think the read
call failed - but it didn't.  Riiiiiiiiight.

xread was just following that standard, broken model.

-- 
Shawn.
