Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0483C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiGACBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGACBK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:01:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1590725EA8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:01:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 680211AA4FB;
        Thu, 30 Jun 2022 22:01:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JyBCKqgh5YMq
        hOInGxoREkgfFgZ4cmmIsdZhHHOnqKI=; b=CSbZjZbSvaGRLqVUg6JEqnGbFIkq
        Fzp9fuF5eMdh/7eDPWfx4vF9SmlekRpnmhk78dEwOs6q3GbHFgzqxymfPMXDNzgz
        EUtRGJ7kYkAdmSZcMrMxbI15L6fl2BZM0Ct4dt5JDvokaTdVoQBYgbS+Ot8D2/ni
        QA4ACIWTxhoaBwI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FD701AA4F9;
        Thu, 30 Jun 2022 22:01:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B5881AA4EC;
        Thu, 30 Jun 2022 22:01:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     avarab@gmail.com, Han Xin <hanxin.hx@alibaba-inc.com>,
        git@vger.kernel.org, l.s.r@web.de, neerajsi@microsoft.com,
        newren@gmail.com, philipoakley@iee.email, stolee@gmail.com,
        worldhello.net@gmail.com, Neeraj Singh <nksingh85@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v15 6/6] unpack-objects: use stream_loose_object() to
 unpack large objects
References: <cover.1654871915.git.chiyutianyi@gmail.com>
        <cover.1654914555.git.chiyutianyi@gmail.com>
        <5a4782d746a496e8edd1654296bac390d8e1c9d3.1654914555.git.chiyutianyi@gmail.com>
Date:   Thu, 30 Jun 2022 19:01:03 -0700
In-Reply-To: <5a4782d746a496e8edd1654296bac390d8e1c9d3.1654914555.git.chiyutianyi@gmail.com>
        (Han Xin's message of "Sat, 11 Jun 2022 10:44:21 +0800")
Message-ID: <xmqqk08xa8ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA5517DE-F8E1-11EC-8300-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

> +BATCH_CONFIGURATION=3D'-c core.fsync=3Dloose-object -c core.fsyncmetho=
d=3Dbatch'
> +
> +test_expect_success 'unpack big object in stream (core.fsyncmethod=3Db=
atch)' '
> +	prepare_dest 1m &&
> +	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
> +		git -C dest.git $BATCH_CONFIGURATION unpack-objects <pack-$PACK.pack=
 &&
> +	grep fsync/hardware-flush trace2.txt &&
> +	test_dir_is_empty dest.git/objects/pack &&
> +	git -C dest.git cat-file --batch-check=3D"%(objectname)" <obj-list >c=
urrent &&
> +	cmp obj-list current
> +'

This test without any prerequisite expects that "hardware-flush"
will always appear in the trace, but is that reasonable?  Don't
we need either=20

 (1) some sort of prerequisite to make sure this test piece runs
     only on platforms that will use hardware-flush, or

 (2) loosen grep pattern to look for just "fsync/", or

 (3) something else?

It will become even worse when we queue =C3=86var's "trace2 squelch"
patch on top, as we will stop emitting trace entries for that did
not trigger.
