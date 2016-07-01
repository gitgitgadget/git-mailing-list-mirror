Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF5120FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 09:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbcGAJtQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 05:49:16 -0400
Received: from plane.gmane.org ([80.91.229.3]:47614 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752629AbcGAJtN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 05:49:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bIv4N-0002lR-7x
	for git@vger.kernel.org; Fri, 01 Jul 2016 11:49:07 +0200
Received: from enw201.neoplus.adsl.tpnet.pl ([83.20.12.201])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 11:49:07 +0200
Received: from jnareb by enw201.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 11:49:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: topological index field for commit objects
Date:	Fri, 1 Jul 2016 11:48:40 +0200
Message-ID: <57763C78.3020509@gmail.com>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net> <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net> <5774F4C7.805@gmail.com>
 <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
 <20160701031711.GA4832@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@ger.gmane.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
X-Gmane-NNTP-Posting-Host: enw201.neoplus.adsl.tpnet.pl
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <20160701031711.GA4832@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-01 o 05:17, Jeff King pisze:
> On Thu, Jun 30, 2016 at 11:12:52AM -0700, Linus Torvalds wrote:
> 
>> I do think that it's ok to cache generation numbers somewhere if there
>> is an algorithm that can make use of them, but every time this comes
>> up, it's just not been important enough to make a big deal and a new
>> incompatible object format for it. The committer date is preexisting
>> and has existing pseudo-generation-number usage, so..improving on the
>> quality of it sounds like a good idea.
> 
> If you are OK with a cache, I don't think one needs to change the object
> format at all. It can be computed on the fly, and is purely a local
> optimization.

Note that if cache is generated during (re)packing, it could be optimized
for reading. If we want a cache that follow replacements, it would need
to be adjusted after each new or modified replacement; assuming that one
doesn't modify replacements by hand (then Git would need to detect changes,
and modify cache if needed, perhaps on query, e.g. "git log").

>> The first step should probably be to make fsck warn about the existing
>> cases of "commit has older date than parents". Something like the
>> attached patch, perhaps?
> 
> I have mixed feelings on this, because it forces the user to confront
> the issue at a time that's potentially very far from when it actually
> happened (and often when it is not their fault).

It would be nice to have as an optional check, like e.g. unreachable
objects, or use warning instead of error, like e.g. dangling objects
warning. This would be the default; it can always be changed using
the `fsck.<msg-id>` and `receive.fsck.<msg-id>` configuration variables.

This way we could use this mode to adjust clock-skew heuristics that
Git uses to speed up reachability queries (including time slop), be
it automatically or via a configuration variable.

[...]
> E.g., imagine somebody else has their clock set forward, and you fetch
> from them. Their object by itself is not broken. It is only when you
> want to commit on top of it, with the correct clock, that the broken
> state is created (and then, we cannot know whether it is your clock or
> the original committer's clock that is bad).
> 
> So I think it would be more productive to put a check like this in "git
> commit" rather than (or perhaps in addition to) fsck. That prevents
> us creating the broken relationship, but it does still mean the user may
> have to to go back and tell the original committer that their clock was
> broken.

Well, check at "git commit" time (perhaps with automatic fixing to used
committerdate for the commit being created, within specified conditions)
cannot distinguish between the two cases:

 * committerdate in parent commit(s) is correct,
   but the clock is in the past

 * committerdate in parent commit(s) is incorrect, and in the future,
   while the clock is correct
 
> You could also have the fsck check look not only for out-of-order
> commits, but also commits in the future (from the perspective of the
> receiver). That would reject such broken commits before they even hit
> your repository (though again, it is unclear in such a case if the
> commit is broken or the clock of the checker).

Well, one heuristics is that if commits in the future, and/or commits
with committerdate out of order have all the same committer, then
probably commits are broken. Another "heuristics" would be to assume
that if you invoked date-checking functionality, you have ensured that
your clock is correct.

-- 
Jakub Narębski


