Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8598C2BB1D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BAE20409
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RtVpSyS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbgCPRRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:17:34 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21642 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731507AbgCPRRe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Mar 2020 13:17:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584379053; h=To: References: Message-Id:
 Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: Subject:
 Mime-Version: Content-Type: Sender;
 bh=KNZ4RW6MGCfQCTxLVzlbTS/IC3ZVt8dKbwpivxKbKLg=; b=RtVpSyS2i0ogeP1ZKW0DwdX4aSxrQRdK+blKYj2r+xK2n2aBKBcVH9WP6j70eA4hhoYJDg7x
 5zMtt7BrRFAmrUa8TIM7baMI45KwiZSBxnnJt8hAXvq7P83uhdZMljlH+uIIgt1CC4WtIqeu
 Hrqq0Oqa3GmSY6aeyIWI3/flBaI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6fb49c.7fd5263ceb58-smtp-out-n03;
 Mon, 16 Mar 2020 17:17:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF85CC432C2; Mon, 16 Mar 2020 17:17:15 +0000 (UTC)
Received: from [192.168.86.156] (c-73-243-78-58.hsd1.co.comcast.net [73.243.78.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nasser)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BE5DC433CB;
        Mon, 16 Mar 2020 17:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BE5DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nasser@codeaurora.org
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Avoid race condition between fetch and repack/gc?
From:   Nasser Grainawi <nasser@codeaurora.org>
In-Reply-To: <759f4b3b-28a7-c002-ae51-5991bf9ad211@gmail.com>
Date:   Mon, 16 Mar 2020 11:17:12 -0600
Cc:     Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org,
        "peff@peff.net" <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <06992130-5109-4180-AB26-315AAF536788@codeaurora.org>
References: <20200316082348.GA26581@inner.h.apk.li>
 <759f4b3b-28a7-c002-ae51-5991bf9ad211@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Mar 16, 2020, at 6:10 AM, Derrick Stolee <stolee@gmail.com> wrote:
>=20
> On 3/16/2020 4:23 AM, Andreas Krey wrote:
>> Hi all,
>>=20
>> we occasionally seeing things like this:
>>=20
>> | DEBUG: 11:25:20: git -c advice.fetchShowForcedUpdates=3Dfalse fetch =
--no-show-forced-updates -q --prune
>=20
> I'm happy to see these options. I hope they are helping you!
>=20
>> | Warning: Permanently added '[socgit.$company.com]:7999' (RSA) to =
the list of known hosts.
>> | remote: fatal: packfile =
./objects/pack/pack-20256f2be3bd51b57e519a9f2a4d3df09f231952.pack cannot =
be accessed       =20
> This _could_ mean a lot of things, but....
>=20
>> | error: git upload-pack: git-pack-objects died with error.
>> | fatal: git upload-pack: aborting due to possible repository =
corruption on the remote side.
>> | remote: aborting due to possible repository corruption on the =
remote side.
>> | fatal: protocol error: bad pack header
>>=20
>> and when you look in the server repository there is a new packfile =
dated just around
>> that time. It looks like the fetch tries to access a packfile that it =
assumes to exist,
>> but the GC on the server throws it away just in that moment, and thus =
upload-pack fails.
>=20
> ...your intuition about repacking seems accurate. The important part =
of the
> race condition is likely that the server process read and holds a read =
handle
> on the .idx file, but when looking for the object contents it tries to =
open
> the .pack file which was deleted.
>=20

[snip]

>=20
>> Is there a way to avoid this?
>>=20
>> Should there be, like git repack waiting a bit before deleting old =
packfiles?
>=20
> This all depends on how you are managing your server. It is likely =
that you
> could create your own maintenance that handles this for you.
>=20
> The "git multi-pack-index (expire|repack)" cycle is built to prevent =
this sort
> of issue, but is not yet integrated well with reachability bitmaps. =
You likely
> require the bitmaps to keep your server performance, so that may not =
be a way
> forward for you.

We manage this on our servers with a repack wrapper that first creates =
hard links for all packfiles into a objects/pack/preserved dir and then =
we have patches on top of JGit [1] that actually know how to recover =
objects from that dir when the original pack is removed by repacking. =
It=E2=80=99s worked quite well for us for a couple years now and should =
be compatible with/without bitmaps (haven=E2=80=99t specifically tested) =
and any pack/repacking strategy.

[1] https://git.eclipse.org/r/122288=
