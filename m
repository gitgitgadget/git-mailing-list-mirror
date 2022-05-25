Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90825C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 00:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbiEYAUu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 24 May 2022 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiEYAUt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 20:20:49 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C4C70901
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:20:48 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24P0KlJB007997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 May 2022 20:20:47 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>
Cc:     "'Jonathan Nieder'" <jrnieder@gmail.com>, <git@vger.kernel.org>,
        <avarab@gmail.com>, <derrickstolee@github.com>,
        <gitster@pobox.com>, <larsxschneider@gmail.com>, <tytso@mit.edu>
References: <cover.1638224692.git.me@ttaylorr.com> <cover.1653088640.git.me@ttaylorr.com> <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com> <Yo0ysWZKFJoiCSqv@google.com> <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com> <Yo1bUbys+Fz7g+6h@nand.local> <016e01d86fc5$64ecf180$2ec6d480$@nexbridge.com> <Yo1zW7ntTuNakpOD@nand.local>
In-Reply-To: <Yo1zW7ntTuNakpOD@nand.local>
Subject: RE: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Date:   Tue, 24 May 2022 20:20:42 -0400
Organization: Nexbridge Inc.
Message-ID: <017201d86fcd$485839f0$d908add0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHb/488bX7VmyGm7lOI8s5Sc6VeLQKg6TD0AnqYOkcA3OyauQHJFXHbAse5aIkBv8k3GgHgkk2BrLZNmTA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 24, 2022 8:08 PM, Taylor Blau wrote:
>On Tue, May 24, 2022 at 07:24:14PM -0400, rsbecker@nexbridge.com wrote:
>> On May 24, 2022 6:25 PM ,Taylor Blau write:
>> >On Tue, May 24, 2022 at 03:44:00PM -0400, rsbecker@nexbridge.com wrote:
>> >> I am again concerned about 32-bit time_t assumptions. time_t is
>> >> 32-bit on some platforms, signed/unsigned, and sometimes 64-bit. We
>> >> are talking about potentially long-persistent files, as I
>> >> understand this series, so we should not be limiting times to end
>> >> at 2038. That's only
>> >> 16 years off and I would wager that many clones that exist today will exist
>then.
>> >
>> >Note that we're using unsigned fields here, so we have until 2106
>> >(see my earlier response on this in
>https://lore.kernel.org/git/YdiXecK6fAKl8++G@nand.local/).
>>
>> I appreciate that, but 32-bit time_t is still signed on many
>> platforms, so when cast, it still might, at some point in another
>> series, cause issues. Please be cautious. I expect that this is the
>> particular hill on which I will die. 😉
>> --Randall
>
>Yes, definitely. There is only one spot that we turn the result of
>nth_packed_mtime() into a time_t, and that's in
>add_object_in_unpacked_pack(). The code there is something like:
>
>    time_t mtime;
>    if (pack->is_cruft)
>      mtime = nth_packed_mtime(pack, object_pos);
>    else
>      mtime = pack->mtime;
>
>    ...
>
>    add_cruft_object_entry(oid, ..., mtime);
>
>...and the reason mtime is a time_t is because that's the type of
>pack->mtime.
>
>And we quickly convert that back to a uint32_t in add_cruft_object_entry(). If
>time_t is signed, then we'll truncate any values beyond 2106, and pre-epoch
>values will become large positive values. That means our error is one-sided in the
>favorable direction, i.e., that we'll keep objects around for longer instead of
>pruning something that we shouldn't have.

I can only hope. I am working with the platform compiler team on time_t issues. Hoping we can get to 64-bit builds within two years, but out of my control. That would make time_t an int64_t, which puts failure well outside my own lifespan and anyone else in my company. Provisioning for signed 64-bit time values would be prudent even if unsupported in a specific build. We are almost 1/4 through 20xx.
--Randall

