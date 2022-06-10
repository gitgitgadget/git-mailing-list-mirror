Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C93C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 16:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbiFJQo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiFJQo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 12:44:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CBD1C5939
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 09:44:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B16013DDBC;
        Fri, 10 Jun 2022 12:44:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wi/3RLTGCalB
        +7cC32B4OIqRt09nCGfKDKhmg4CjFwE=; b=Nu/86Fvvucp4lnqzfzq7FaNvawgV
        Pz4Mmc6+wzEDgOM5d94x2csV7Y9f4PanAR7GjSQHG55ix3mxIx6pxHjWws3NVUSg
        JDlo4mGPrtSYn6+7orFJD21LI2fjQCIMpcRZlAlC+d49zIUgE+JiSBYAQKrWZcd5
        xVxQhEE9nstLbAI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 614B613DDBB;
        Fri, 10 Jun 2022 12:44:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B658E13DDBA;
        Fri, 10 Jun 2022 12:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6+ 4/7] scalar: implement `scalar diagnose`
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <20220528231118.3504387-1-gitster@pobox.com>
        <20220528231118.3504387-5-gitster@pobox.com>
        <220610.86ilp9s1x7.gmgdl@evledraar.gmail.com>
Date:   Fri, 10 Jun 2022 09:44:53 -0700
In-Reply-To: <220610.86ilp9s1x7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 10 Jun 2022 04:08:34 +0200")
Message-ID: <xmqqpmjgfoxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A7D17E18-E8DC-11EC-B381-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, May 28 2022, Junio C Hamano wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> [...]
>> The `diagnose` command is the culmination of this hard-won knowledge: =
it
>> gathers the installed hooks, the config, a couple statistics describin=
g
>> the data shape, among other pieces of information, and then wraps
>> everything up in a tidy, neat `.zip` archive.
>> [...]
>> +	if ((res =3D add_directory_to_archiver(&archiver_args, ".git", 0)) |=
|
>> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/hooks",=
 0)) ||
>> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/info", =
0)) ||
>> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/logs", =
1)) ||
>> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/objects=
/info", 0)))
>> +		goto diagnose_cleanup;
>
> Noticed on top of some local changes I have to not add a
> .git/hooks (the --no-template topic), but this fails to diagnose
> any repo that doesn't have these paths, which are optional, either
> because a user could have manually removed them, or used
> --template=3D.

Quite honestly, if it lacks any directory that we traditionally
created upon "git init", with our standard templates, we can and
should call such a repository "broken" and move on.


