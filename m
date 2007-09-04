From: Andreas Ericsson <ae@op5.se>
Subject: Re: Calculating tree nodes
Date: Tue, 04 Sep 2007 16:41:14 +0200
Message-ID: <46DD6E8A.7000802@op5.se>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>	 <20070904025153.GS18160@spearce.org>	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>	 <e1dab3980709032119r381f7a91ia84ba09039c21be1@mail.gmail.com>	 <9e4733910709032252x1fe6f436wdd13bcb1a6f76636@mail.gmail.com>	 <46DCF361.2090402@op5.se> <20070904061611.GY18160@spearce.org> <9e4733910709040719n135a1c2dw3a2d5c470b74791a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Tweed <david.tweed@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:41:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZam-0007xS-Pw
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbXIDOlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbXIDOlT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:41:19 -0400
Received: from mail.op5.se ([193.201.96.20]:36323 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195AbXIDOlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:41:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2B028194438;
	Tue,  4 Sep 2007 16:41:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LcGJkclOhT1C; Tue,  4 Sep 2007 16:41:16 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 265B7194429;
	Tue,  4 Sep 2007 16:41:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709040719n135a1c2dw3a2d5c470b74791a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57581>

Jon Smirl wrote:
> On 9/4/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Andreas Ericsson <ae@op5.se> wrote:
>>> Jon Smirl wrote:
>>>> On 9/4/07, David Tweed <david.tweed@gmail.com> wrote:
>>>>> On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>>>>>> Git has picked up the hierarchical storage scheme since it was built
>>>>>> on a hierarchical file system.
>> ...
>>>>> One of the nice things about tree nodes is that for doing a diff
>>>>> between versions you can, to overwhelming probability, decide
>>>>> equality/inequality of two arbitrarily deep and complicated subtrees
>>>>> by comparing 40 characters, regardless of how remote and convoluted
>>>>> their common ancestry. With delta chains don't you end up having to
>>>>> trace back to a common "entry" in the history? (Of course, I don't
>>>>> know how packs affect this - presumably there's some delta chasing to
>>>>> get to the bare objects as well.)
>>>> While it is a 40 character compare, how many disk accesses were needed
>>>> to get those two SHAs into memory?
>>> One more than there would have been to read only the commit, and one more
>>> per level of recursion, assuming you never ever pack your repository.
>>>
>>> If you *do* pack it, the tree(s) needed to compare are likely already
>>> inside the sliding packfile window. In that case, there are no extra
>>> disk accesses.
>> Even better, lets do some back of the napkin math on the Linux
>> kernel tree.  My local (out of date but close enough) copy has
>> 22,730 files in the tip revision.  Values shown are uncompressed
>> and compressed (gzip -9 | wc -c), but are excluding deltification.
>>
>>                  Current Scheme       Jon's Flat Scheme
>>                  -----------------    -----------------
>> commit raw       932                  932 + 22,730*20 = 455,532
>> (compressed)     521                  456,338
>>
>> root tree raw    876                  0
>> (compressed)     805                  0
> 
> This is not a fair comparison. The current scheme is effectively
> diffed against the previous version. You aren't showing an equivalent
> diff for the flat scheme. Both schemes are dealing with the same
> 22,000 SHAs.
> 

How, with your scheme, would you solve

	git diff -M master pu

in the git repo?

You'd have to build both trees completely, utilizing the last known
complete tree-listing (the root commit, since you propose to do away
with trees altogether) and then applying diffs on top of that to
finally generate an in-memory tree-structure in which you will have
to compare every single file against every single other file to find
out which code has been moved/copied/renamed/whatever.

That's (n*(n+1))/2 operations for file-level diffs alone. For the
kernels 22730 files, you're looking at 258337815 file comparisons
without the tree objects.

Sure, you can probably shave away quite a few of those comparisons
at the expense of computing the tree-hashes on the fly, but in that
case, why get rid of them in the first place?

> The size win is from diffing, not compressing.
> 

It was declared in May 2006 by someone insightful that diskspace
and bandwidth are cheap, while human time is priceless.

IOW, size wins had better be proportionally huge to justify slowing
git down and thereby taking more than necessary of the users' time.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
