Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F378C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 06:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJRGb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 02:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJRGb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 02:31:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12872A59A5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 23:31:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83CF21D05FA;
        Tue, 18 Oct 2022 02:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=nJdOocivCFa4HzvSJamOSp+L/3kYy4Co481L09SQNOs=; b=iAsz
        a7ejArgeYKxV+Eood9YEWwi/EfLfnBqXTs+2avH9mdgIF/PBpGgB594nsLVBAeu8
        uZrLjnbBTTd2aK+2naR4Uzdk+swdyKUEXVAH4VdTW8UKG0VsfbP+uHt3CElkiigD
        66z9cgkoSgGlSvL2XFvMtJoraif+rNXwjQaFImU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 669BD1D05F9;
        Tue, 18 Oct 2022 02:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6E6611D05F8;
        Tue, 18 Oct 2022 02:31:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric DeCosta <edecosta@mathworks.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 07/12] fsmonitor: prepare to share code between Mac
 OS and Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <295beb89ab10f001724fb64fa55944d05ee29fc7.1665783945.git.gitgitgadget@gmail.com>
        <xmqqmt9y55py.fsf@gitster.g>
        <BL0PR05MB557147E13EFF24F664A14832D9299@BL0PR05MB5571.namprd05.prod.outlook.com>
Date:   Mon, 17 Oct 2022 23:31:16 -0700
Message-ID: <xmqqa65twsln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78B3A894-4EAE-11ED-A33B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric DeCosta <edecosta@mathworks.com> writes:

>> Ugly.
>> 
>> One overrides backend with common, while the other one doesn't.
>> That asymmetry alone should stop us and wonder if there is something fishy
>> in the approach that can be improved.  It makes it look like the word
>> "common" means something quite different between the -ipc and the -
>> settings world.
>> 
>> I suspect that in both, you should not expose "unix" to this part of the
>> Makefile.  Linux and macOS occasionally being similar in some places does
>> not have to be exposed here.  INstead you can use backend "linux" and
>> "macos", whose C sources may include from a separate C source file whose
>> name may contain "unix".  That would allow you to get rid of
>> FSMONITOR_DAEMON_COMMON in a cleaner way.
>
> Let me see if I am understanding you correctly. Are you suggesting something like:

Not really.

What I had in mind was an arrangement more like

    $ for variant in linux macos; do grep include fsm-ipc-$variant.c; done
    #include "fsm-ipc-common-unix.cinclude"
    #include "fsm-ipc-common-unix.cinclude"

and COMPAT_OBJS knowning only about fsm-ipc-linux.o or
fsm-ipc-macos.o, depending on which platform you are building.

