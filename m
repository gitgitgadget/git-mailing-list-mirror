Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA411C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 23:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjBBX6c convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 2 Feb 2023 18:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjBBX6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 18:58:31 -0500
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 15:58:29 PST
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553572F7B6
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 15:58:29 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 312NljX13165638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 23:47:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        "'Konstantin Ryabitsev'" <konstantin@linuxfoundation.org>,
        "'Eli Schwartz'" <eschwartz93@gmail.com>,
        "'Git List'" <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com> <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net> <20230131150555.ewiwsbczwep6ltbi@meerkat.local> <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net> <230201.86pmatr9mj.gmgdl@evledraar.gmail.com> <Y9ry5Wxck4s/X2B+@tapette.crustytoothpaste.net> <xmqqh6w5x8i8.fsf@gitster.g> <Y9xAv1reHJRj7iKA@tapette.crustytoothpaste.net>
In-Reply-To: <Y9xAv1reHJRj7iKA@tapette.crustytoothpaste.net>
Subject: RE: Stability of git-archive, breaking (?) the Github universe, and a possible solution
Date:   Thu, 2 Feb 2023 18:47:50 -0500
Organization: Nexbridge Inc.
Message-ID: <01a901d93760$c690d970$53b28c50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLiF3R71KYQrOeqrorv00GrNqikswMEgN+XA4BU8XsBkCBbTgJpxkKiAjqemSAB7GONiQHKluEVrCcOheA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 2, 2023 6:02 PM, brian m. carlson wrote:
>On 2023-02-01 at 23:37:19, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>> > I don't think a blurb is necessary, but you're basically
>> > underscoring the problem, which is that nobody is willing to promise
>> > that compression is consistent, but yet people want to rely on that
>> > fact.  I'm willing to write and implement a consistent tar spec and
>> > to guarantee compatibility with that, but the tension here is that
>> > people also want gzip to never change its byte format ever, which
>> > frankly seems unrealistic without explicit guarantees.  Maybe the
>> > authors will agree to promise that, but it seems unlikely.
>>
>> Just to step back a bit, where does the distinction between
>> guaranteeing the tar format stability and gzip compressed bitstream
>> stability come from?  At both levels, the same thing can be expressed
>> in multiple different ways, I think, but spelling out how exactly the
>> compressor compresses is more involved than spelling out how entries
>> in a tar archive is ordered and each entry is expressed, or something?
>
>Yes, at least with my understanding about how gzip and compression in general
>work.
>
>The tar format (and the pax format which builds on it) can mostly be restricted by
>explaining what data is to be included in the pax and tar headers and how it is to be
>formatted.  If we say, we will always write such and such information in the pax
>header and sort the keys, and we write such and such information in the tar header,
>then the format is completely deterministic, and we can make nice guarantees.
>
>My understanding about how Lempel-Ziv-based compression algorithms work is that
>there's a lot more freedom to decide how best to compress things and that there
>isn't always a logical obvious choice, but I will admit my understanding is relatively
>limited.  If someone thinks we can effectively succeed in supporting compression
>more than just relying on gzip, I would be delighted to be shown to be wrong.

The nice part about gzip is that it is generally available on virtually all platforms (or can be easily obtained). Other compression forms, like bz2, which sometimes produces more dense compression, are not necessarily available. Availability is something I would be worried about (clone and checkout failures).

Tar formats are also to be used carefully. Not all platform implementations of tar support all variants. "ustar" is fairly common but there are others that are not. Interoperability needs to be the biggest factor in this decision, IMHO, rather than compression rates.

The alternative is having git supply its own implementation, but that is a longer term migration problem, resembling the SHA-256 migration.

>
>> > That would probably break things, because gzip is GPLv3, and we'd
>> > need to ship a much older GPLv2 gzip, which would probably differ
>> > from the current behaviour, and might also have some security problems.
>>
>> Yup, security issues may make bit-for-bit-stability unrealistic.
>> IIRC, the last time we had discussion on this topic, we settled on
>> stability across the same version of Git (i.e. deterministic result)?

In the old days, it was export concerns. Fortunately, git never really hit those in a post-2007 timeframe. I would not bank on this issue staying off the table.

--Randall

