From: David Kastrup <dak@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 27 Sep 2007 08:43:14 +0200
Message-ID: <85sl50ehh9.fsf@lola.goethe.zz>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	<7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
	<20070927023633.GA28902@coredump.intra.peff.net>
	<854phgfxn7.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ian5w-0000z9-GB
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 08:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbXI0GnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 02:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbXI0GnS
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 02:43:18 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:47275 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754639AbXI0GnR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 02:43:17 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 49DFA15C3ED;
	Thu, 27 Sep 2007 08:43:15 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 35A8F2DAC94;
	Thu, 27 Sep 2007 08:43:15 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-116.pools.arcor-ip.net [84.61.13.116])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id F06A91B3262;
	Thu, 27 Sep 2007 08:43:14 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 034701C0039C; Thu, 27 Sep 2007 08:43:14 +0200 (CEST)
In-Reply-To: <854phgfxn7.fsf@lola.goethe.zz> (David Kastrup's message of "Thu\, 27 Sep 2007 08\:08\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4411/Wed Sep 26 23:43:35 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59272>

David Kastrup <dak@gnu.org> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Sep 26, 2007 at 01:05:59PM -0700, Junio C Hamano wrote:
>>
>>> * jk/diff-rename (Tue Sep 25 15:29:42 2007 -0400) 1 commit
>>>  + diffcore-rename: cache file deltas
>>> 
>>> Parked in 'next' for now but is 'master' material.
>>
>> My tests after this patch show that spanhash_find is responsible for
>> a large portion of the processing time in large renames, so I am going
>> to look into speeding that up.
>
> In itself, it does not look like there is all too much room for
> optimization.  One can remove the temporary pointer "optimization" and
> see whether this makes strength reduction possible for the compiler.
> Making this an endless loop wrapped around a loop on bucket might also
> help the compiler in that effect.
>
> But there is really not all too much leeway, and it might be better
> spent in the caller.  For example, the search will take something like
> r/(1-r) iterations on average where r is the fill ratio of the hash
> array.  So one would not want to, say, let r grow above 0.75 or
> something like that.

Ok, here is some suggestion:

Here is the inner loop for this stuff:

	for (i = 0; i < ssz; i++) {
		struct spanhash *s = &(src_count->data[i]);
		struct spanhash *d;
		unsigned dst_cnt, src_cnt;
		if (!s->cnt)
			continue;
		src_cnt = s->cnt;
		d = spanhash_find(dst_count, s->hashval);
		dst_cnt = d ? d->cnt : 0;
		if (src_cnt < dst_cnt) {
			la += dst_cnt - src_cnt;
			sc += src_cnt;
		}
		else
			sc += dst_cnt;
	}

Now here is how one could optimize the data structures: The hash
structures are with linear probing, and we try to find any hash
matches from source to destination.  If we sort all hashes indexed to
a given first hash bucket by their full hash value, then one could
basically use passes similar to list merges for figuring the 1:1
relations.  That cuts down the O(l n) cost (where n is the number of
elements and l their average run length) to O(n).

Of course, making l close to 1 by keeping the hash utilization
reasonably low is much simpler.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
