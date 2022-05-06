Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C1C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444274AbiEFVLX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 6 May 2022 17:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444243AbiEFVLW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:11:22 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916FC6F481
        for <git@vger.kernel.org>; Fri,  6 May 2022 14:07:37 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 246L7aif037118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 May 2022 17:07:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <phillip.wood@dunelm.org.uk>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>, <bagasdotme@gmail.com>,
        "'Guy Maurel'" <guy.j@maurel.de>,
        "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com> <20220503065442.95699-1-carenas@gmail.com> <20220503065442.95699-3-carenas@gmail.com> <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet> <c9fc0fc6-c688-022d-9476-aaa87c66d295@gmail.com> <CAPUEspiMsvNhQF-RjW5eu3Xco9gU7TFt4w9dOOcF1PGM4Z+ceQ@mail.gmail.com> <xmqq35hml9cs.fsf@gitster.g> <CAPUEspj98i9oTECSvSp4c-sDQ=hrxJHCY3Nn6QwqdAf9Ntnahw@mail.gmail.com>
In-Reply-To: <CAPUEspj98i9oTECSvSp4c-sDQ=hrxJHCY3Nn6QwqdAf9Ntnahw@mail.gmail.com>
Subject: RE: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Fri, 6 May 2022 17:07:31 -0400
Organization: Nexbridge Inc.
Message-ID: <025801d8618d$50890670$f19b1350$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNSFEhJznDvJ14R8+XRCaXNQPEYwgJji4tTAaRUgXgC8JKQpgJnCPsPAecZ8RsBv0jBiAEicecVqa2vINA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 6, 2022 4:23 PM, Carlo Arenas wrote:
>On Fri, May 6, 2022 at 1:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Carlo Arenas <carenas@gmail.com> writes:
>>
>> > which is also why we can't use it, any possibly bogus or suspicious
>> > value we get from SUDO_UID MUST be ignored.
>>
>> I do not think I agree.  If we have a strange value in SUDO_UID, it
>> would be much better and safer to err on the safe side.
>
>ignoring it is the safe side; for example if we replace the current function with the
>proposed one then some user lucky enough to have access to the latest linux
>supercomputer that has been patched to have a 64-bit uid_t (because who makes
>32-bit supercomputers nowadays) would get root[1] access by simply faking his
>SUDO_UID to be UINT_MAX
>+ 1.
>
>We will also honour probably SUDO_UID=0M as root instead of the current action
>which is to ignore that nonsense and most likely die by telling the pranker that he
>still can't run `git status` on that root owned repository he got access to even after
>he managed to get sudo to generate that as a SUDO_UID.
>
>> Instead of ignoring, in the situation where we care about the value we
>> read from SUDO_UID (i.e. when euid==0), we should die loudly when it
>> has a strange value.
>
>that is fair, but then it would then make this feature into a denial of service attack
>target ;)
>
>The current implementation instead keeps git running under the UID it was
>started as, which should be root if it gets to use this code under the current
>implementation.
>
>I am still open to changing it if you would rather let git be the last line of defense, I
>just think that the current implementation of ignoring it is more user friendly and
>better at punking would be attackers.

Please keep in mind the uid_t == 65535 on __TANDEM. uid_t == 0 actually means "not logged in".

Thanks,
Randall

