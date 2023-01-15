Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF8C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 03:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjAODlb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 14 Jan 2023 22:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjAODl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 22:41:29 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A85EA253
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:41:28 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 30F3fPME068812
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 14 Jan 2023 22:41:26 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jacob Abel'" <jacobabel@nullpo.dev>
Cc:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Phillip Wood'" <phillip.wood123@gmail.com>,
        "=?UTF-8?Q?'Rub=C3=A9n_Justo'?=" <rjusto@gmail.com>,
        "'Taylor Blau'" <me@ttaylorr.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev>        <20221104213401.17393-1-jacobabel@nullpo.dev>        <20221110233137.10414-1-jacobabel@nullpo.dev>        <20221212014003.20290-1-jacobabel@nullpo.dev>        <20221220023637.29042-1-jacobabel@nullpo.dev>        <20221228061539.13740-1-jacobabel@nullpo.dev>        <20230107045757.30037-1-jacobabel@nullpo.dev>        <20230109173227.29264-1-jacobabel@nullpo.dev>        <20230109173227.29264-4-jacobabel@nullpo.dev>        <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>        <20230114224715.ewec6sz5h3q3iijs@phi> <xmqqo7r0ijdv.fsf@gitster.g>
In-Reply-To: <xmqqo7r0ijdv.fsf@gitster.g>
Subject: RE: [PATCH v8 3/4] worktree add: add --orphan flag
Date:   Sat, 14 Jan 2023 22:41:21 -0500
Organization: Nexbridge Inc.
Message-ID: <013701d92893$3fad5d10$bf081730$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE22lwqqtRnm7NdUsbYQkIIWv78MAIh0bodAb/gU/sBu16C+gMWDrzbAZmfodsBfLAVVAFImrY1Av50x+sDDQcL4gJ+La47AZCsK2OvKg4OAA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 14, 2023 10:09 PM, Junio C Hamano wrote:
>Jacob Abel <jacobabel@nullpo.dev> writes:
>
>>> 	git worktree add --orphan -b topic main
>>> 	git worktree add --orphan -B topic main
>>
>> I am hesitant to add these as they break away from the syntax used in
>> `git switch` and `git checkout`.
>
>Not that I care too deeply, but doesn't it introduce end-user confusion if we try to
>be compatible with "git checkout --orphan <branch>", while allowing this to be
>compatible with the default choice of the branch name done by "git worktree
>add"?  "--orphan" in "git checkout" behaves similar to "-b|-B" in that it always
>wants a name, but "git worktree add" wants to make it optional.
>
>By the way "--orphan" in checkout|switch wants to take a name for itself, e.g.
>
>	git checkout --orphan $name [$commit]
>	git checkout -b $name [$commit]
>	git checkout -B $name [$commit]
>
>so it is impossible to force their "--orphan" to rename an existing branch, which is
>probalby a design mistake we may want to fix.
>
>In any case, as I said, I do not care too deeply which way you guys decide to go,
>because I think the whole "orphan" UI is a design mistake that instills a broken
>mental model to its users [*].
>
>But let's wait a bit more to see which among
>
>(1) git worktree add [[--orphan] -b $branch] $path
>    This allows --orphan to act as a modifier to existing -b,
>
>(2) git worktree add [(--orphan|-b) $branch] $path
>    This allows --orphan to be another mode of -b, or
>
>(3) git worktree add [--orphan [$branch]|(-b $branch)] $path
>    This allows --orphan to default to $(basename $path)
>
>people prefer.
>
>
>[Footnote]
>
>* I am not saying that it is wrong or useless to keep an unrelated
>  history, especially one that records trees that have no relevance
>  to the main history like created with "switch --orphan", in the
>  same repository.  Allowing "git switch --orphan" to create such a
>  separate history in the same repository blurs the distinction.  It
>  would help newbies to form the right mental model if they start a
>  separate repository that the separate history originates in, and
>  pull from it to bootstrap the unrelated history in the local
>  repository.

I am wondering whether --detached is a more semantically consistent option. While --orphan has meaning in checkout (not one I ever liked), detached makes more sense as a description of what is intended here - as in not connected.

--Randall

