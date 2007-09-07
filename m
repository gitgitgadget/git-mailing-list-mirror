From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 10:26:08 +0200
Message-ID: <851wda7ufz.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
	<fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>
	<fbr1a2$qm7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 10:26:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITZAU-0003aC-3f
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 10:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbXIGI0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 04:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbXIGI0P
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 04:26:15 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:56667 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964854AbXIGI0O (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 04:26:14 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id AA16A17F663;
	Fri,  7 Sep 2007 10:26:13 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 8F11228EBDA;
	Fri,  7 Sep 2007 10:26:13 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-044-151.pools.arcor-ip.net [84.61.44.151])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 56B8D1280B;
	Fri,  7 Sep 2007 10:26:09 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CC62A1CAD71B; Fri,  7 Sep 2007 10:26:08 +0200 (CEST)
In-Reply-To: <fbr1a2$qm7$1@sea.gmane.org> (Walter Bright's message of "Fri\, 07 Sep 2007 01\:15\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4176/Fri Sep  7 08:46:21 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58004>

Walter Bright <boost@digitalmars.com> writes:

> A canonical example is that of a loop. Consider a simple C loop over
> an array:
>
> void foo(int array[10])
> {
>     for (int i = 0; i < 10; i++)
>     {   int value = array[i];
>         ... do something ...
>     }
> }
>
> It's simple, but it has a lot of problems:
>
> 1) i should be size_t, not int

Wrong.  size_t is for holding the size of memory objects in bytes, not
in terms of indices.  For indices, the best variable is of the same
type as the declared index maximum size, so here it is typeof(10),
namely int.

> 2) array is not checked for overflow

Why should it?

> 3) 10 may not be the actual array dimension

Your point is?

> 4) may be more efficient to step through the array with pointers,
> rather than indices

No.  It is a beginners' and advanced users' mistake to think using
pointers for access is a good idea.  Trivial optimizations are what a
compiler is best at, not the user.  Using pointer manipulation will
more often than not break loop unrolling, loop reversal, strength
reduction and other things.

> 5) type of array may change, but the type of value may not get
> updated

Huh?

> 6) crashes if array is NULL

Certainly.  Your point being?

> 7) only works with arrays and pointers

Since there are only arrays and pointers in C, not really a restriction.

>
> Since this thread is talking about C++, let's look at the C++ version:
>
> void foo(std::vector<int> array)
> {
>   for (std::vector<int>::const_iterator
>        i = array.begin();
>        i != array.end();
>        i++)
>   {
>     int value = *i;
>     ... do something ...
>   }
> }

Where is my barf bag?

> Frankly, I don't want to write loops that way. I want to write them
> like this:
>
> void foo(int[] array)
> {
>   foreach (value; array)
>   {
>     ... do something ...
>   }
> }
>
> As a programmer, I'm specifying exactly what I want to happen without
> much extra puffery. It's less typing, simpler, and more resistant to
> bugs.
>
> 1) correct loop index type is selected based on the type of array
> 2) arrays carry with them their dimension, so foreach is guaranteed to
> step through the loop the correct number of times
> 3) implementation decides if pointers will do a better job than
> indices, based on the compilation target
> 4) type of value is inferred automatically from the type of array, so
> no worries if the type changes
> 5) Null arrays have 0 length, so no crashing
> 6) works with any collection type

Most of those are toy concerns.  They prevent problems that don't
actually occur much in practice.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
