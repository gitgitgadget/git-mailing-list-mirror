Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D010EC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiEIRk1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 May 2022 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiEIRkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:40:25 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABE521553C
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:36:30 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 249HaTmd035597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 May 2022 13:36:29 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>
Cc:     <git@vger.kernel.org>, <bagasdotme@gmail.com>,
        <phillip.wood123@gmail.com>, <Johannes.Schindelin@gmx.de>,
        "'Guy Maurel'" <guy.j@maurel.de>,
        "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
References: <20220503065442.95699-1-carenas@gmail.com>  <20220507163508.78459-1-carenas@gmail.com>      <20220507163508.78459-3-carenas@gmail.com>      <xmqqv8uhgsaz.fsf@gitster.g>    <20220507185624.k5n6xihvzcuuj3vt@carlos-mbp.lan> <xmqq1qx2ejdv.fsf@gitster.g>
In-Reply-To: <xmqq1qx2ejdv.fsf@gitster.g>
Subject: RE: [RFC PATCH v4 2/3] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Mon, 9 May 2022 13:36:24 -0400
Organization: Nexbridge Inc.
Message-ID: <036501d863cb$51776640$f46632c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJji4tTyJI+jnaAfpyFfXflwFjlNgHMd1eNAfsGrosCcnr3jQGzvLSyAo5/+LGrrJ2z0A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 9, 2022 12:55 PM, Junio C Hamano wrote:
>Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
>
>>> In exchange, the only attack scenario the code prevents is this,
>>> IIUC.
>>>
>>>  * You, the aspiring cracker, are a user not allowed to run "sudo" on
>>>    the box, and you know your uid is 1000
>>>
>>>  * You look for another user, a potential victim, whose uid is 1000
>>>    modulo 65536 (if your uid_t is 16-bit) and who can run "sudo" on
>>>    the box.
>>>
>>>  * You prepare a malicious repository, invite that user there and
>>>    ask them to run "sudo something" there.
>>>
>>> I'd say such an attack vector is not likely,...
>
>Sorry, I was totally wrong here.
>
>It is not just "not likely", but such an attack, with a potential victim not futzing with
>SUDO_UID environment themselves, would not work at all.  The value of
>SUDO_UID and the original uid of the potential victim by definition should fit in the
>uid_t type.  So if you, the aspiring cracker, have UID 1000, nobody else on the
>system has UID that is congruent modulo uid_t and wrap-around attack does not
>exist.  As long as the type we use to read SUDO_UID string into a variable is not
>narrower than uid_t, there.
>
>Of course you can tell any user who runs "sudo" to set SUDO_UID to
>1000 + 64k and cause wrap-around, but then you can tell them to set SUDO_UID to
>1000 without relying on wrap-around and have the same effect.  So, let's stop
>worrying about this bogus scenario.
>
>As to the "we can break compilation with -Wsign-compare on a system with signed
>uid_t", I agree that is true if we have
>
>	env_id <= (uid_t) -1
>
>there.  But I am not sure if that is the most effective way to smoke out platforms
>where this code has trouble working correctly.  Also, I would think that a system
>with signed uid_t is a possibility, but a user with a negative UID?
>
>I do not think even nobody4 was negative ;-)

I can test the code when it's ready.

