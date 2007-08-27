From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Keep last used delta base in the delta window
Date: Mon, 27 Aug 2007 23:04:20 +0200
Message-ID: <8564308zaj.fsf@lola.goethe.zz>
References: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
	<7v3ay5l5wq.fsf@gitster.siamese.dyndns.org>
	<86veb1thmp.fsf@lola.quinscape.zz>
	<20070827204320.GA17126@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Tue Aug 28 00:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPllE-0003Rq-Et
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 23:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760205AbXH0VEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 17:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762833AbXH0VEY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 17:04:24 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:50454 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758308AbXH0VEW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 17:04:22 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 8BFD231EA26;
	Mon, 27 Aug 2007 23:04:21 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id 64947ABAA2;
	Mon, 27 Aug 2007 23:04:21 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-058-178.pools.arcor-ip.net [84.61.58.178])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 1FBFD2351AF;
	Mon, 27 Aug 2007 23:04:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A63421C3C7A6; Mon, 27 Aug 2007 23:04:20 +0200 (CEST)
In-Reply-To: <20070827204320.GA17126@auto.tuwien.ac.at> (Martin Koegler's message of "Mon\, 27 Aug 2007 22\:43\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4077/Mon Aug 27 20:40:44 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56883>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> On Mon, Aug 27, 2007 at 12:07:58PM +0200, David Kastrup wrote:
>> Well, given the little amount of spare time I have for personal
>> projects, I should not go flaunting them too much, but anyway...
>> 
>> I am just drafting implementing a delta-diff size estimator: for every
>> hash value it does not store hash chains or pointers to memory images,
>> but just a bit map of at most 32 (possibly 64 where ulong delivers it,
>> possibly even just 16 bits when one restricts oneself to 16 element
>> windows in order to save memory) delta window files, telling which of
>> the files show such a hash value anywhere. 
>
> How do you want to select these few hash values?

Hm?  Are you familiar with diff-delta.c?  I was not going to change
the hash value computation in there.  It is a 32bit CRC over 16byte
passages: the delta source is checksummed with a stride of 16 bytes
and the resulting CRC values are masked to a convenient number of bits
and used as index into a hash table with disambiguation to actual code
passages using linked lists.  Then the destination delta is
checksummed in the same manner but with a stride of 1, and the sums
are looked up in the hash until a matching prefix is found.

So I was going to do the same calculation, but look up a bit mask
rather than a linked list (namely calculating under the assumption
that a hash hit implies an actual match).

> I eg. dump database tables as SQL statements in per table files and
> commit all changes. All lines in each file share a common prefix
> (INSERT INTO tablename (COL1, COL2, ...) VALUES). Statistics showed,
> that up to 50% of the hash elements of the delta index were dropped,
> because they had equal hash values.

Yes, I am aware of that.  One somewhat crazy consequence of that is
that git's deltaing works better on Linux style indentation than on
GNU style indentation.

> With you apropach:
>
> If rare used values are selected as the 32 hash values, you will
> probably regard files, which contain different tables (and therefore
> a different prefix), as "similar", although the files have not very
> much similarity otherwise.

It's statistics.  Random matches will tend to level out.

> If you select the hash values of the prefixes, you will create for
> each table one cluster (if the table count is < 32/64). This already
> happens by using the hash value of the path name in the sorting.
>
> I don't belive, that your idea will improve very much in this case.
> I fear, that it will be even worser than the current algorithm.

Huh?  I am not replacing the current algorithm.  I am doing some
upfront estimates for getting a good order for doing the current
algorithm, so that I might abort parts of it early when I know they
can't improve things.  If the estimates are completely random and/or
useless, it will mean that you get a slowdown by a comparatively small
constant factor.

>> When a file is considered for deltaing, it is run once against this
>> delta-diff estimator which does not even look at the files again.
>> This delivers a lower bound for the size a delta towards each of
>> the delta candidates can take.  The candidates are then sorted in
>> increasing size of expected delta size and are considered in turn.
>> Once a delta has a lower size than the lowest bound for further
>> delta candidates, no further candidates need to get considered.
>
> So this means, that we have to hash the target entry too (which
> could be merged with creating the delta index).

Huh?  I don't see what you are getting at.

> We currently only hash an entry, if it is really needed as source in
> a delta-diff.

Why would you want to hash a non-candidate?

>> Also the calculation of a delta can get aborted once it exceeds the
>> size of a previous delta.
>
> This already happens.

Ah yes.  Overlooked this.  Presorting the candidates should be helpful
right away then.

> Do you want to do your estimations only against a small window of
> objects or all objects?

The estimates are made against the candidates in the window.  When a
candidate leaves the window, its bit in the bit masks gets reused for
the next candidate entering the window.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
