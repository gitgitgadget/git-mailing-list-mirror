Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD771FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 21:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbdCJVwN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 16:52:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58374 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbdCJVwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 16:52:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8B2F609FB; Fri, 10 Mar 2017 21:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489182730;
        bh=muyZHHd8i/EXbOmC0WRyg3o/NfTl92cy5Myq+v6ElQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQbBxx27+1wzh3TM1Vnk95D0hVZZAnsxiQ18ffP174S/EUDgSEdtZdp959CPkV1YB
         Ecik8pTcWX36AtOABtRbB9lEl84tpGavMM5VFNJpqj43PxcazKnY2+8xpFzoaT/HYg
         2MeqPJlnSp/JlsCoukDAKmv2l5oN8mvFeuMEASts=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 14DE2609FB;
        Fri, 10 Mar 2017 21:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489182730;
        bh=muyZHHd8i/EXbOmC0WRyg3o/NfTl92cy5Myq+v6ElQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQbBxx27+1wzh3TM1Vnk95D0hVZZAnsxiQ18ffP174S/EUDgSEdtZdp959CPkV1YB
         Ecik8pTcWX36AtOABtRbB9lEl84tpGavMM5VFNJpqj43PxcazKnY2+8xpFzoaT/HYg
         2MeqPJlnSp/JlsCoukDAKmv2l5oN8mvFeuMEASts=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 10 Mar 2017 14:52:10 -0700
From:   jmelvin@codeaurora.org
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, nasserg@codeaurora.org, mfick@codeaurora.org,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH] repack: Add options to preserve and prune old pack files
In-Reply-To: <xmqq4lz4968p.fsf@gitster.mtv.corp.google.com>
References: <20170307164035.27866-1-jmelvin@codeaurora.org>
 <xmqq4lz4968p.fsf@gitster.mtv.corp.google.com>
Message-ID: <5b578a236338771fbb08007417b26438@codeaurora.org>
X-Sender: jmelvin@codeaurora.org
User-Agent: Roundcube Webmail/1.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-07 13:33, Junio C Hamano wrote:
> James Melvin <jmelvin@codeaurora.org> writes:
> 
...
> 
> I am not sure if I understand your design.  Your model looks to me
> like there are two modes of operation.  #1 uses "--preserve-old" and
> sends old ones to purgatory instead of removing them and #2 uses
> "--prune-preserved" to remove all the ones in the purgatory
> immediately.  A few things that come to my mind immediately:
> 
>  * When "--prune-preseved" is used, it removes both ancient ones and
>    more recent ones indiscriminately.  Would it make more sense to
>    "expire" only the older ones while keeping the more recent ones?
> 
>  * It appears that the main reason you would want --prune-preserved
>    in this design is after running with "--preserve-old" number of
>    times, you want to remove really old ones that have accumulated,
>    and I would imagine that at that point of time, you are only
>    interested in repack, but the code structure tells me that this
>    will force the users to first run a repack before pruning.
> 
> I suspect that a design that is simpler to explain to the users may
> be to add a command line option "--preserve-pruned=<expiration>" and
> a matching configuration variable repack.preservePruned, which
> defaults to "immediate" (i.e. no preserving), and
> 
>  - When the value of preserve_pruned is not "immediate", use
>    preserve_pack() instead of unlink();
> 
>  - At the end, find preserved packs that are older than the value in
>    preserve_pruned and unlink() them.
> 
> It also may make sense to add another command line option
> "--prune-preserved-packs-only" (without matching configuration
> variable) that _ONLY_ does the "find older preserved packs and
> unlink them" part, without doing any repack.

I like the idea of only having a single option to do both the preserving 
and the pruning. It makes the operation more cycle based, which is more 
closely tied to the use case this is intended for. Ie. Run repack while 
preserving old pack files so that any open file handles to those pack 
files will continue to work, while the next time repack is run it is 
highly likely those will no longer be needed, so they can be cleaned up. 
Obviously this depends on how frequent repack is run, but something an 
Administrator can determine.

I'll push a patch that combines that functionality into a single option 
to review.


-James

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
