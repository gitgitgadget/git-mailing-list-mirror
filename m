Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C2C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 20:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIXURJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 16:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiIXURH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 16:17:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193432ED7
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 13:17:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76D5414CFE6;
        Sat, 24 Sep 2022 16:17:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DIwl/lLvGVTe
        s5cFfYLgSAydO0cOT5TrPqJkrxdzmxE=; b=hzxVm4kreQzvUFi90aeKdmPZu0MP
        OanLVUR5d66eC9xnR5Xry+0GMJg6tML/wkMXZgcW04I+6GsZ60aTZ19VNcHdDs8o
        9Qfxj699kMKFRprdo6dc2vsfbnJstP4+Jw3X6fzAVhnnSnh8bijWcGZ1BOJd1dG1
        EPObaIJxRdYbWoM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FB8414CFE5;
        Sat, 24 Sep 2022 16:17:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8522F14CFE4;
        Sat, 24 Sep 2022 16:17:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-5-calvinwan@google.com>
        <220923.86o7v64ik0.gmgdl@evledraar.gmail.com>
Date:   Sat, 24 Sep 2022 13:17:02 -0700
In-Reply-To: <220923.86o7v64ik0.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 23 Sep 2022 10:06:56 +0200")
Message-ID: <xmqqsfkgr0ht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA8FBFEC-3C45-11ED-885E-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Sep 22 2022, Calvin Wan wrote:
>
>> +status.parallelSubmodules::
>> +	When linkgit:git-status[1] is run in a superproject with
>> +	submodules, a status subprocess is spawned for every submodule.
>> +	This option specifies the number of submodule status subprocesses
>> +	to run in parallel. If unset, it defaults to 1.
>
> Why do we default to 1, instead of e.g. grep.threads defaulting to the
> "cores available"?

I would imagine we would want to be able to say:

 - I do not trust the parallel mode yet, just use the single process
   method that we have always been using.

 - I do not know how many cores I have, just use a reasonable
   default parallelism.

 - I want to use N processes because I know better than auto-scaling
   based on num_cpus.

And the value of 1 would be a reasonable way to express the first
one.


