Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85F51F404
	for <e@80x24.org>; Thu,  8 Feb 2018 00:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeBHAG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 19:06:28 -0500
Received: from grym.ekleog.org ([94.23.42.210]:52844 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbeBHAG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 19:06:28 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id f5373d64;
        Thu, 8 Feb 2018 00:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=piUNvi6asE4PMFxpVG5K1vr/V+A=; b=fZduuOqMLbJ53c
        3YSlQPI9nVhZMu6ENBVi+8Ol8y8D1XUDUAXqsyLR/E8B3nNzIPtewTiQlFx9d4Qp
        kiXHZPhrIz2Cl39xzMvz8QlC4K2Xdm4nsNupoj2DQJvk0pGfK+cl61xJpAYiTQ46
        4DdgQe+4OCeOVLeJV1fD6tO+DK6iM=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 83e3c208 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 8 Feb 2018 00:06:26 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, joey@kitenet.net
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
Date:   Thu, 8 Feb 2018 01:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87inb8mn0w.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07/2018 11:51 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 07 2018, Leo Gaspard jotted:
> 
>> Hello,
>>
>> tl;dr: Is there currently a way to have fetch hooks, and if not do you
>> think it could be a nice feature?
>>
>> I was in the process of implementing hooks for git that ensure the
>> repository is always cleanly signed by someone allowed to by the
>> repository itself. I think I've completed the signature-checking part
>> [1] and the push hook [2] (even though it isn't really configurable at
>> the moment).
>>
>> However, I was starting to think about handling the fetch step, and
>> couldn't find any fetch hook. Is there one?
>>
>> If not, would you think it is would be a good idea to add one, that
>> would eg. be passed the commit-before, commit-after and could block the
>> changing of the reference if it failed?
>>
>> The only other solution I could think of is using a separate script for
>> fetching, but that would be fragile, as the user could always not think
>> about it well and run a git fetch, breaking the objective that after the
>> first clone all commits were correctly signature-checked.
>>
>> Thanks for reading me!
>> Leo
>>
>> PS1: I am not subscribed to the ML.
>>
>> PS2: I've tried asking freenode#git, without success so far.
>>
>>
>> [1]
>> https://github.com/Ekleog/signed-git/blob/master/git-hooks/check-range-signed.sh
>>
>> [2] https://github.com/Ekleog/signed-git/blob/master/git-hooks/pre-push
> 
> There is no fetch hook, however you may find that the
> post-{checkout,merge} hooks are suitable for what you want to do.
> 
> Setting those to some custom comand is a common pattern for
> e.g. compiling some assets on "git pull", so you could similarly check
> the commits from HEAD, of course those are post-* hooks, so they won't
> stop the checkout.

Hmm, I don't think these would fit the bill. For post-merge, simply
because I spend my life rebasing stuff around, and very rarely merge.
For post-checkout, it could work, but then I'd need to keep track
manually of up to where the commits have been checked and to search the
git graph for the latest checked ancestor (as otherwise checking-out
another branch then checking-out the first branch again would likely
trigger a failure, due to the keyring being dynamic), so it would likely
be a dealbreaker, due to the hook becoming too complex to be trusted.

(Just in case you wonder, by “the keyring being dynamic” I mean the PGP
keys allowed to sign commits are stored directly inside the git repository)

That said, I just came upon [1] (esp. the description [2] and the patch
[3]), and wondered: it looks like the patch was abandoned midway in
favor of a hook refactoring. Would you happen to know whether the hook
refactoring eventually took place, and/or whether this patch was
resubmitted later, and/or whether it would still be possible to merge
this now? (not having any experience with git's internals yet, I don't
really know whether these are stupid questions or not)

Thanks!
Leo

PS: Cc'ing Joey, as you most likely know best what eventually happened,
if you can remember it?


[1] https://marc.info/?t=132477041500001&r=1&w=2

[2] https://marc.info/?l=git&m=132483581218382&w=2

[3] https://marc.info/?l=git&m=132486687023893&w=2
