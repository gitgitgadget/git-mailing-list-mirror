Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E214207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 12:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbcI2MwX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 29 Sep 2016 08:52:23 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43394 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752387AbcI2MwW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Sep 2016 08:52:22 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail)
        by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
        iface 141.3.10.81 id 1bpaos-0001is-4W; Thu, 29 Sep 2016 14:52:10 +0200
Received: from apache by webmail with local (Exim 4.84_2)
        (envelope-from <szeder@ira.uka.de>)
        id 1bpaos-00073N-2K; Thu, 29 Sep 2016 14:52:10 +0200
Received: from x4db0e95c.dyn.telefonica.de (x4db0e95c.dyn.telefonica.de
 [77.176.233.92]) by webmail.informatik.kit.edu (Horde Framework) with HTTPS;
 Thu, 29 Sep 2016 14:52:10 +0200
Date:   Thu, 29 Sep 2016 14:52:10 +0200
Message-ID: <20160929145210.Horde.g9CV6T-OpWCeozsbBpTood-@webmail.informatik.kit.edu>
From:   SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, torvalds@linux-foundation.org,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
References: <20160928233047.14313-5-gitster@pobox.com>
 <20160929024400.22605-1-szeder@ira.uka.de>
 <20160929091509.2n4mdrevwxechqol@sigill.intra.peff.net>
In-Reply-To: <20160929091509.2n4mdrevwxechqol@sigill.intra.peff.net>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1475153530.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Quoting Jeff King <peff@peff.net>:

> On Thu, Sep 29, 2016 at 04:44:00AM +0200, SZEDER Gábor wrote:
>
>> >     So 12 seems reasonable, and the only downside for it (or for "13", for
>> >     that matter) is a few extra bytes. I dunno, maybe people will really
>> >     hate that, but I have a feeling these are mostly  
>> cut-and-pasted anyway.
>>
>> I for one raise my hand in protest...
>>
>> "few extra bytes" is not the only downside, and it's not at all about
>> how many characters are copy-and-pasted.  In my opinion it's much more
>> important that this change wastes 5 columns worth of valuable screen
>> real estate e.g. for 'git blame' or 'git log --oneline' in projects
>> that don't need it and certainly won't ever need it.
>
> True. The core of the issue is that we really only care about this
> minimum length when _storing_ an abbreviation, but we don't know when
> the user is just looking at it in the moment, and when they are going to
> stick it in a commit message, email, or bug tracker.
>
> In an ideal world, anybody who was about to store it would run "git
> describe" or something to come up with some canonical reference format.
> And we could just bump the default minimum there. Personally, I almost
> exclusively cite commits as the output of:
>
>   git log -1 --pretty='tformat:%h (%s, %ad)' --date=short

Interesting, I have a pretty format alias that looks almost like this,
except that I carry a patch locally allowing me to say %as for short
date format :)

What I sometimes wished for is a pretty format specifier for 'git
describe --contains', which would make it convenient to cite commits
like this: v0.99~954 (Initial revision of "git", the information manager
from hell, 2005-04-07).  It's better than the abbreviated object name,
because it will stay unique, assuming that the chosen tag is never
deleted, and it carries extra information for humans (the first release
containing the referenced commit), while the abbreviated object name is
completely meaningless.

The obvious drawback that makes it a non-solution for the problem at
hand is that this format can only refer to commits that are reachable
from a tag and can't be used for commits that are descendants of the
most recent tag, e.g. when fixing a bug introduced after the last
release.  Oh, and the user has to fetch the tag first to be able to
make sense of such a reference.

> and I'd be fine to stick "--abbrev=12" in there for future-proofing. But
> I don't know what the kernel or other projects do.
>
> I'd also be curious to know if the patch I sent in [1] to more
> aggressively prefer commits would make this less of an issue, and people
> wouldn't care as much about using longer hashes in the first place. So
> one option is to merge that (and possibly even make it the default) and
> see if people still care in 6 months.
>
> -Peff
>
> [1]  
> http://public-inbox.org/git/20160927123801.3bpdg3hap3kzzfmv@sigill.intra.peff.net/


