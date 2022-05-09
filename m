Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE979C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 19:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiEITUQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 May 2022 15:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbiEITUK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 15:20:10 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082F0ABF4F
        for <git@vger.kernel.org>; Mon,  9 May 2022 12:16:14 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 249JGB2k039258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 May 2022 15:16:12 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <bagasdotme@gmail.com>,
        <phillip.wood123@gmail.com>, <Johannes.Schindelin@gmx.de>,
        "'Guy Maurel'" <guy.j@maurel.de>,
        "=?utf-8?Q?'SZEDER_G=C3=A1bor'?=" <szeder.dev@gmail.com>
References: <20220503065442.95699-1-carenas@gmail.com> <20220507163508.78459-1-carenas@gmail.com> <20220507163508.78459-3-carenas@gmail.com> <xmqqv8uhgsaz.fsf@gitster.g> <20220507185624.k5n6xihvzcuuj3vt@carlos-mbp.lan> <xmqq1qx2ejdv.fsf@gitster.g> <CAPUEspidmqiUYd3xB4QaR72YU=H8pA-3yNXxOF_MWyA_0wrKcA@mail.gmail.com>
In-Reply-To: <CAPUEspidmqiUYd3xB4QaR72YU=H8pA-3yNXxOF_MWyA_0wrKcA@mail.gmail.com>
Subject: RE: [RFC PATCH v4 2/3] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Mon, 9 May 2022 15:16:06 -0400
Organization: Nexbridge Inc.
Message-ID: <036901d863d9$3fb32df0$bf1989d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJji4tTyJI+jnaAfpyFfXflwFjlNgHMd1eNAfsGrosCcnr3jQGzvLSyAo5/+LEB/6D7Uauctsrw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 9, 2022 2:49 PM, Carlo Arenas wrote:
>On Mon, May 9, 2022 at 9:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> It is not just "not likely", but such an attack, with a potential
>> victim not futzing with SUDO_UID environment themselves, would not
>> work at all.  The value of SUDO_UID and the original uid of the
>> potential victim by definition should fit in the uid_t type.  So if
>> you, the aspiring cracker, have UID 1000, nobody else on the system
>> has UID that is congruent modulo uid_t and wrap-around attack does not
>> exist.  As long as the type we use to read SUDO_UID string into a
>> variable is not narrower than uid_t, there.
>
>correct; would adding a less elegant "static_assert" (obviously not available in C99)
>in the code an alternative?, or you are suggesting that documenting that constrain
>should be done in a comment and hope it doesn't get ignored in the future, or
>maybe gets instead made less likely to fail by some additional work, like the one I
>suggested to do later by moving this code around and using intmax_t instead?
>
>not that there are 2 different scenarios which we might seem to be flip flopping
>about :
>
>1) victim gets attacked by tricking them into using the wrong SUDO_UID
>
>unlikely to be useful as you pointed out, and totally useless if we still restrict this
>code to run only as root
>
>2) attacker using this code to elevate privileges themselves
>
>only useful if this code is not run as root.
>
>My concern again, is not with this code AS-IS but how it might be used in the
>future.
>
>> Of course you can tell any user who runs "sudo" to set SUDO_UID to
>> 1000 + 64k and cause wrap-around, but then you can tell them to set
>> SUDO_UID to 1000 without relying on wrap-around and have the same
>> effect.  So, let's stop worrying about this bogus scenario.
>
>bogus only if we are still only running this code as root, of course.
>
>> As to the "we can break compilation with -Wsign-compare on a system
>> with signed uid_t", I agree that is true if we have
>
>Apologies for not documenting it until now, but I had -Wtautological-constant-out-
>of-range-compare in mind instead, but your are correct either one would work
>and the point was that (without having to add even an "static assert") we were
>able to find them and warn them that they need to patch.
>
>>         env_id <= (uid_t) -1
>
>If that was not enough, that simple code ALSO disabled the code in that case to
>make sure they MUST patch locally if they need to make it work, or come back to
>us to figure out a portable way to accommodate them in the future, with all the
>information about their system we currently lack.
>
>> there.  But I am not sure if that is the most effective way to smoke
>> out platforms where this code has trouble working correctly.  Also, I
>> would think that a system with signed uid_t is a possibility, but a
>> user with a negative UID?
>
>It doesn't need to be a real user (specially if someone independently decides to
>remove the restriction that keeps this code available only to root).
>
>The fact that it was negative but was treated as a positive number on our code just
>makes the wraparound we decided to ignore before more likely to work without
>triggering alarms somewhere else and because we decided to ignore an unlikely to
>be useful positive wraparound, we also would fall from the negative wraparound
>here that would had protected this code from both if that humble line of code
>wouldn't had been removed.
>
>In your hypothetical system where uid_t is 16-bit (hence 15-bit for valid non-
>negative ids if uid_t is signed, since no sane system would have negative ones),
>either 65536 or -65536 would become 0, as well as at least the other 2^16
>possibilities that a larger long would provide.
>
>If the size difference is even smaller (ex: uid_t is signed int), so the type we are
>using to parse those values is only 1 bit wider it will still be a concern IMHO.

Just to be pedantic uid_t is signed int is not always smaller. It is 32-bit on NonStop. uid_t signed short or signed char would be smaller. I have wondered why uid_t was not defined as unsigned int or unsigned long (although unsigned long is 64 bits on the x86 wide model NonStop) because they cannot be negative. Making assumptions about size or sign when doing this check is not correct IMHO. It should be a direct comparison of env_id != ROOT_UID, where you know what ROOT_UID is on the specific platform. I do not like the <= concept for user id comparison because it is making assumptions. Structurally, on NonStop, (uid & 0x0000FF00) == 0x0000FF00 can be used to check whether the user is in the root group but that is coincidental and subject to change without notice. No one worth their salt does that comparison on platform, rather they compare getgid() == 255 to do that test.

>
>I know people that wrote code to check if "/" was writable as means to make sure
>they were "root", because that is what any sane system would do, and then came
>Windows and even in 2022 anyone can write to "/"
>there and create subdirectories.

On NonStop: / is often writable by non-root users in the root group. Non-root users in the root group sometimes have repositories. In cygwin, / is owned by the user who installed cygwin or the OS rather than root. It is a relatively random number, and definitely not 0. It is also possible that a dedicated VM in Linux can be spun up for sandbox testing allowing anyone to write anywhere. Even if you run git as Administrator on Windows 10+, it will not have the userId of 0 in cygwin git. I do not think the / writable assumption is portable.

