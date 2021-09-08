Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259AFC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 14:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5DD60C3E
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 14:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351434AbhIHOFl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 8 Sep 2021 10:05:41 -0400
Received: from elephants.elehost.com ([216.66.27.132]:10446 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348320AbhIHOFl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 10:05:41 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 188E4VD0001962
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Sep 2021 10:04:31 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Neeraj Singh'" <nksingh85@gmail.com>
Cc:     "'Neeraj K. Singh via GitGitGadget'" <gitgitgadget@gmail.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>,
        "'Christoph Hellwig'" <hch@lst.de>,
        "'Neeraj K. Singh'" <neerajsi@microsoft.com>
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com> <003701d7a422$21c32740$654975c0$@nexbridge.com> <CANQDOdcKsUqrQ6K6MEBoXS1BW8_tO8mx4tcq6nvqyiuM4e2CmA@mail.gmail.com> <87h7evkghf.fsf@evledraar.gmail.com>
In-Reply-To: <87h7evkghf.fsf@evledraar.gmail.com>
Subject: RE: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
Date:   Wed, 8 Sep 2021 10:04:26 -0400
Message-ID: <006e01d7a4ba$72191e00$564b5a00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEuszLZPnOzWuI9JhEj5nYbH7e2rgGns2uvAVb0vKQBgiqs2wJhm+WHAd7xXF6spgHwgA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 7, 2021 9:23 PM, Ævar Arnfjörð Bjarmason wrote:
>Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
>
>
>On Tue, Sep 07 2021, Neeraj Singh wrote:
>
>> On Tue, Sep 7, 2021 at 12:54 PM Randall S. Becker
>> <rsbecker@nexbridge.com> wrote:
>>>
>>> On September 7, 2021 3:44 PM, Neeraj Singh wrote:
>>> >On Fri, Aug 27, 2021 at 4:49 PM Neeraj K. Singh via GitGitGadget <gitgitgadget@gmail.com> wrote:
>>> >>
>>> >> Thanks to everyone for review so far! I've responded to the
>>> >> previous feedback and changed the patch series a bit.
>>> >>
>>> >> Changes since v1:
>>> >>
>>> >>  * Switch from futimes(2) to futimens(2), which is in POSIX.1-2008. Contrary
>>> >>    to dscho's suggestion, I'm still implementing the Windows version in the
>>> >>    same patch and I'm not doing autoconf detection since this is a POSIX
>>> >>    function.
>>>
>>> While POSIX.1-2008, this function is not available on every single
>>> POSIX-compliant platform. Please make sure that the code will not
>>> cause a breakage on some platforms - the ones I maintain, in
>>> particular. Neither futimes nor futimens is available on either
>>> NonStop ia64 or x86. The platform only has utime, so this needs to be
>>> wrapped with an option in config.mak.uname.
>>>
>>> Thanks,
>>> Randall
>>
>> Ugh. Fair enough.  How do other contributors feel about me moving back
>> to utime, but instead just doing the utime over in
>> builtins/pack-objects.c?  The idea would be to eliminate the mtime
>> logic entirely from write_loose_object and just do it at the top-level
>> in loosen_unused_packed_objects.
>
>Aside from where it lives, can't we just have a wrapper that takes both the filename & fd, and then on some platforms will need to
>dispatch to a slower filename-only version, but can hopefully use the new fd-accepting function?

I'm not really enamoured with this direction at all. It means that any platform would have to potentially skip a version of git (resulting from the broken build from a wrapper that is not compilable) after the patches were applied, unless the patches for all of those platforms are included. Even adding a Makefile option would be similar. This should be an "Enable if supported" feature, not a default-or-broken, feature. At best, I'd have to monitor for the time where the patch is applied and hope I can figure out the wrapper changes (around my $DAYJOB) in time to make the same release. This seems a bit counter to a "keeping things compatible" philosophy. Maybe there's something I'm missing here.
-Randall

