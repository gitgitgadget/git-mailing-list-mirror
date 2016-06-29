Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A0720FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 22:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbcF2WX5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 18:23:57 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:52872 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcF2WXz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 18:23:55 -0400
Received: from [91.113.179.170] (helo=[192.168.92.22])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1bINkU-0004zY-Dq; Thu, 30 Jun 2016 00:14:22 +0200
Subject: Re: topological index field for commit objects
To:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
Cc:	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
From:	Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <2fff9bc4-0c40-dc51-1cf6-68b359cb16bf@syntevo.com>
Date:	Thu, 30 Jun 2016 00:15:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 29.06.2016 22:39, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Jun 29, 2016 at 11:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On Wed, Jun 29, 2016 at 11:31 AM, Marc Strapetz
>>> <marc.strapetz@syntevo.com> wrote:
>>>> This is no RFE but rather recurring thoughts whenever I'm working with
>>>> commit graphs: a topological index attribute for commit objects would be
>>>> incredible useful. By "topological index" I mean a simple integer for which
>>>> following condition holds true:
>>>
>>> Look for "generation numbers" in the list archive, perhaps?
>>
>> Thanks for the pointer to the interesting discussions.
>>
>> In http://www.spinics.net/lists/git/msg161363.html
>> Linus wrote in a discussion with Jeff:
>>
>>> Right now, we do *have* a "generation number". It's just that it's
>>> very easy to corrupt even by mistake. It's called "committer date". We
>>> could improve on it.
>>
>> Would it make sense to refuse creating commits that have a commit date
>> prior to its parents commit date (except when the user gives a
>> `--dammit-I-know-I-break-a-wildy-used-heuristic`)?
>
> I think that has also been discussed in the past.  I do not think it
> would help very much in practice, as projects already have up to 10
> years (and the ones migrated from CVS, even more) worth of commits
> they cannot rewrite that may record incorrect committer dates.
> You'd need something like "you can trust committer dates that are
> newer that this date" per project to switch between slow path and
> fast path, with an updated fsck that knows how to compute that
> number after you pulled from somebody who used that overriding
> option.
>
> If the use of generation number can somehow be limited narrowly, we
> may be able to incrementally introduce it only for new commits, but
> I haven't thought things through, so let me do so aloud here ;-)
>
> Suppose we use it only for this purpose:
>
>  * When we have two commits, C1 and C2, with generation numbers G1
>    and G2, we can say "C1 cannot possibly be an ancestor of C2" if
>    G1 > G2.  We cannot say anything else based on generation
>    numbers (or lack thereof).
>
> then I think we could just say "A newly created commit must record
> generation number G that is larger than generation numbers of its
> parent commits; ignore parents that lack generation number for the
> purpose of this sentence".

 From algorithm perspective, for already existing repositories you would 
still have to switch from an optimized generation number code to the 
current commit-time based code. That could things make even more complex 
and it's possibly expensive to determine whether a repository has full 
generation number support or not.

On the other hand, for new repositories, you could immediately use 
generation number based algorithms. So it could be "A newly created 
commit must record generation number G that is larger than generation 
numbers of its parent commits if all parents commits have a generation 
number recorded; otherwise do not record a generation number". Something 
like "git filter-branch" might already be sufficient to convert 
repositories.

Git versions released in 2019 may start issuing warnings if HEAD has no 
generation number assigned and Git versions released in 2025 may 
completely refuse to work with such repositories.

In the interim period, a local cache as Jeff is proposing could serve as 
secondary source for generation numbers. This would allow to phase out 
current algorithms immediately.

-Marc



