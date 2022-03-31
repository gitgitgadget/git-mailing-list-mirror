Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF03C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiCaQkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiCaQkW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:40:22 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9713FBB
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1648744702;
        bh=NAcU03XiY9IhpBKD1Fv3igxPHo3tX1I/9396jBAQE/c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VWekY5D+GBZNjUk0zi/Kp1vLnasDe+IqcMXI1YRNkFpVcv2zoFJMUyvhd+hFeG9P6
         jpX3qKE9dTxAJWWjxFEZ4X61QKCKWoCojoSI9lfEt4dh6kI2I5q/EKccaFMtYaZmII
         vjaW8ZocOWk7uJ0zEL8Qq5iqKWZZ3bH6cJn3Gz7E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjIE-1njtQY0A4C-00C8MF; Thu, 31
 Mar 2022 18:38:22 +0200
Message-ID: <b6f9518d-0b41-d607-ba77-46a83edb1d40@web.de>
Date:   Thu, 31 Mar 2022 18:38:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v12 7/8] unpack-objects: refactor away
 unpack_non_delta_entry()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
 <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <patch-v12-7.8-11f7aa026b4-20220329T135446Z-avarab@gmail.com>
 <2f98c63d-f2c9-26fe-cfd3-9eed6b79047a@web.de>
 <220331.86wngap9vo.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220331.86wngap9vo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WdgbCKY2H5TFsLOiPriaq6a8bARo4UmjS7P+C9/xmHOizlO7tSF
 OZkSViyv2dxy4qGFh7GiXwFD3QC3wx5rzn8M4y2IgE8mdAYJUDyFM9fh4Aggs836PJdUm/Z
 cp13daXHD+KY8BjS0Ijkv7dmD3sLP8lNjnstG3PjyM3DNW/+wNktv85YirUz103GkoxHrtg
 3hHlrNk5Ydg4d5/URAilQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LBU+Uv1MKZc=:ZL1gbC7j1T6+qcoGw2XW4B
 QIrH41YLqQxd8h4l0hB9+a+LT13TwEwhGdZCj73rwl6fp+/+FRlJ6Qzt0v4ujZTHeLdOhzvR+
 WgmryB3Y+HqiqhhB/1L/HwTUjjqRgZBAyjTOiA0kR9xr2fw+mVrZ4Lv50r1StGZskyQMFbmje
 a6LO16lezIFb9yfH+SrbS0Px3OiG1naHvOEYfNW5IpW6XAo4bhA66LjyY1O/KOqw1yn8qn6c0
 MsHTKQeUDnPbuUTb8Fux5GJZYtCoxUnAfX1FfR2xOVqFuZvEWl9qsCUPJfIsY4c0f+V6VqqaL
 jgTgYpSDYlVQvcT8mPiFOWxMjYDpv2cdOP1VDGuWKVval8w0RKfNSUQRg+9PMCBMYcDU3pAxp
 25vSOsiAC35C6ieZB1MyqPL74CEvy4S7fWvjzA4Mce4xG3SefXaX3i/SFEpdNXwVzr6aWv4hT
 r58eKY8YrDqtBXes1I9801Y6h0w4PyHKHv8c9NXPsF0Iiw3TuYcouWu+Og4O3jFYeaGzFmKDT
 DZv7cKxT7gUKd6ENfsWZZREa+8JGQ94X09cgEtxxWqBiaZLfVYiWT98gU3GSh1OZsujVs1sS2
 SDn9yxtsDFva3SJIlas/wwbCCtcIj7sLLcn+a6qkpfDwlV18f1yM3d/EpTXBJwmP9hgO3rmz2
 oulRSBg+IH+10fNdYVV5JTSZmKY6ycAMGT7/KfAXhQv4qo3cc0XoSvt0Y+ZKFzRtViNWdyTxA
 kuOfnYNVIByL9wDc2W21OG4bTZutkBiA1zksO7pgB10wlma/feYA1QJ7KXDeoUkNDmE4A3/4o
 zcGbwcDWREJarZ9H/5wIvTPiuyxBQuvWOBQ5wp2WILD9IurPY6DxjlwrKwokkmreoY4POsRbC
 J2twgdpx61B2plm9mG+NcnQbmnBfetQQoatd9NwkPeIH3wYqki5Jpr7lJpx8Al6WA/8xrEh4h
 dkVsZJJ9+PUoYQhXdtOE8nDZPd4DRvMkLTBAYskdVdat4Yl+Lg7fZ2WS+bbq/vgNWp1jIOdse
 Lyq8TmqNiXAPPJoHDI+OyxHhSONyCesNc+8gkG532FHOaZvZGbQ13Ku7znaxoIViow==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.03.22 um 14:42 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Wed, Mar 30 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 29.03.22 um 15:56 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> The unpack_one() function will call either a non-trivial
>>> unpack_delta_entry() or a trivial unpack_non_delta_entry(). Let's
>>> inline the latter in the only caller.
>>>
>>> Since 21666f1aae4 (convert object type handling from a string to a
>>> number, 2007-02-26) the unpack_non_delta_entry() function has been
>>> rather trivial, and in a preceding commit the "dry_run" condition it
>>> was handling went away.
>>>
>>> This is not done as an optimization, as the compiler will easily
>>> discover that it can do the same, rather this makes a subsequent
>>> commit easier to reason about.
>>
>> How exactly does inlining the function make the next patch easier to
>> understand or discuss?  Plugging in the stream_blob() call to handle th=
e
>> big blobs looks the same with or without the unpack_non_delta_entry()
>> call to me.
>
> The earlier version of it without this prep cleanup can be seen at
> https://lore.kernel.org/git/patch-v10-6.6-6a70e49a346-20220204T135538Z-a=
varab@gmail.com/

This plugged the special case into unpack_non_delta_entry().  The
alternative I had in mind was to plug it into the switch statement as
the current patch does, just without inlining unpack_non_delta_entry().

> So yes, this could be skipped, but I tought with this step it was easier
> to understand.
>
> We previously had to change "void *buf =3D get_data(size);" in the
> function to just "void *buf", and do the assignment after the condition
> that's being checked here.
>
> I think it's also more obvious in terms of control flow if we're
> checking OBJ_BLOB here to not call a function which has a special-case
> just for OBJ_BLOB, we can just do that here instead.
>
>>> As it'll be handling "OBJ_BLOB" in a
>>> special manner let's re-arrange that "case" in preparation for that
>>> change.
>>>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>>> ---
>>>  builtin/unpack-objects.c | 18 +++++++-----------
>>>  1 file changed, 7 insertions(+), 11 deletions(-)
>>
>> Reducing the number of lines can be an advantage. *shrug*
>
> There was also the (admittedly rather small) knock-on-effect on
> 8/8. Before this it was 8 lines added / 1 removed when it came to the
> code impacted by this change, now it's a 5 added/0 removed in the below
> "switch".
>
> So I think it's worth keeping.
