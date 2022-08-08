Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7A6C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 17:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiHHRbE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiHHRbD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 13:31:03 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8FFC78
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 10:31:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 263EC134ECD;
        Mon,  8 Aug 2022 13:30:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/ARCkyCpTZP7
        jA+P8Q0RNR8GdPZp8vjCb+xE3ASJWcc=; b=KX9Td0CEmng1oeaIWN46jwOiJYud
        rRT3rg0OgSblj8hkr61t81bxt6XIQpIGhfdkZuPuUZImDXpgbIykCrEb1Yco+5uI
        IPYiVFLGLWJchJ/JRzrCrAg2aaqynHTMXjvsVymGNntG9ThfiDYyIavKLJka88w3
        OljvhxpURd89mSA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C83A134ECC;
        Mon,  8 Aug 2022 13:30:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 781AA134ECB;
        Mon,  8 Aug 2022 13:30:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     git@vger.kernel.org, Jakub Wilk <jwilk@debian.org>
Subject: Re: git add -N vs. git stash
References: <20220808163954.tnozlrv7nyx63imu@pengutronix.de>
Date:   Mon, 08 Aug 2022 10:30:57 -0700
In-Reply-To: <20220808163954.tnozlrv7nyx63imu@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 8 Aug 2022 18:39:54
 +0200")
Message-ID: <xmqqh72mskvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD8335EC-173F-11ED-A9CA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org> writes:

> I'd say that's not a feature, is it?

I think that is a sign that "add -N" came much later than "stash",
and whoever added the former was not a heavy user of "stash" ;-)

As the state of the "tracked files in the working tree" and "staged
contents in the index" are both stored as tree objects, I think the
necessary fix would involve

 - record the contents of the "intent-to-add" paths to the tree
   object for the working tree.

 - record the fact that the "intent-to-add" paths are "not in the
   index yet" by removing them from the tree object for the index.

on the recording side (i.e. "stash create"), and then teach the
replay side (i.e. "stash apply") to pay attention to such strange
"exists in the tree for the working tree, but missing from the tree
for the index" paths and mark them with the "intent-to-add" bit.


