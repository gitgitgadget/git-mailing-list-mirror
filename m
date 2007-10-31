From: "Andy C" <andychup@gmail.com>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 17:06:02 -0700
Message-ID: <596909b30710301706u78a326a4y88afac92f1480cec@mail.gmail.com>
References: <20071030042118.GA14729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In16D-00008v-U6
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759669AbXJaAGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759664AbXJaAGG
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:06:06 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:23168 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759668AbXJaAGF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 20:06:05 -0400
Received: by an-out-0708.google.com with SMTP id b36so299951ana
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CM86TkgZl9Whi8S7By12HxfK/QkokoZ7n5xC/t0tKWA=;
        b=lz2vri9qnSNvBc/LNMW9s7nQWxlDW0xkklAQAFToxc6B7Bl++9rATchWkfBP9fbER+X+sAr7bIbgVxgsB2rfZaUn98S12W6HrUDw13+oKqeWxDfE1POvRSj046duz+p6PJiv0gbGOx5rQymRnPuw8xOzGeavou2fnjQIEv/7Imc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KIWeeglnsDLKbSG5fxntgLuJuV20QO1dFK0y3OPh5aG33t/wvi78ZOi6xSjFzzas04tn5Zf1FaQqwizJcH86T8Z9bWXyw8kagCTsd7gRiykLh1RV7XL035G8iQd/bL10YjyIPmZHh+jm0Q5X6K7MM4wDITZAjBpX9Ol+DM6+ASU=
Received: by 10.142.255.14 with SMTP id c14mr1917765wfi.1193789162883;
        Tue, 30 Oct 2007 17:06:02 -0700 (PDT)
Received: by 10.142.203.3 with HTTP; Tue, 30 Oct 2007 17:06:02 -0700 (PDT)
In-Reply-To: <20071030042118.GA14729@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62766>

Sorry I have been AWOL... I was going to try to work on this, but I
got abjectly sick (long story).  But it's great to see this out.


On 10/29/07, Jeff King <peff@peff.net> wrote:
> This is my first stab at faster rename handling based on Andy's code.
> The patches are on top of next (to get Linus' recent work on exact
> renames). Most of the interesting stuff is in 2/3.
>
>   1/3: extension of hash interface
>   2/3: similarity detection code
>   3/3: integrate similarity detection into diffcore-rename
>
> The implementation is pretty basic, so I think there is room for
> code optimization (50% of the time is spent in hash lookups, so we might
> be able to micro-optimize that) as well as algorithmic improvements (like the
> sampling Andy mentioned).

For microoptimization, I was thinking that the hash tables could be
implemented without pointers per value (or memory allocation per
value), so everything is in a contiguous block of memory.   In C++ you
can do this trivially by declaring a small struct as the second
template parameter of the container; in C I guess you can simulate it
with a macro or something.

For the inverted indexing step, the values in the hash are going to be
quite small, especially if line_threshold=1.  Then you only need 2
integers for the left side and right side == 4 integers.  The integers
could just be indexes into the lists (like the current code uses).

For the count matrix step, the values are just going to be integers,
so storing it right in the hash table makes sense.

The sampling should be only necessary for binary files, I think.


> With these patches, I can get my monster binary diff down from about 2
> minutes to 17 seconds. And comparing all of linux-2.4 to all of
> linux-2.6 (similar to Andy's previous demo) takes about 10 seconds.

Hopefully that should be close to just reading the files off disk.
The algorithm should take a fraction of the time that simply reading
the files does, which presumably a git diff has to do.

I was timing that by comparing it to doing a "| xargs wc -l" on the
lists of files.


> There are a few downsides:
>   - the current implementation tends to give lower similarity values
>     compared to the old code (see discussion in 2/3), but this should be
>     tweakable
>   - on large datasets, it's more memory hungry than the old code because
>     the hash grows very large. This can be helped by bumping up the
>     binary chunk size (actually, the 17 seconds quoted above is using
>     256-byte chunks rather than 64-byte -- with 64-byte chunks, it's
>     more like 24 seconds) as well as sampling.
>   - no improvement on smaller datasets. Running "git-whatchanged -M
>     --raw -l0" on the linux-2.6 repo takes about the same time with the
>     old and new code (presumably the algorithmic savings of the new code
>     are lost in a higher constant factor, so when n is small, it is a
>     wash).

I think the old code tries to respect the cache as much as possible,
from what I can tell.  The new code has to use hash tables which are
unpredictable of course.  Though for smaller data sets I would expect
the hash table to fit in cache.  What's your definition of small here?
 Are you sure the old code isn't triggering one of the limits that was
there?

thanks,
Andy
