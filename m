Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB56C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 18:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiA0SGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:06:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61564 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbiA0SF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 13:05:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A921C1746DB;
        Thu, 27 Jan 2022 13:05:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sgiviqb9gSVD
        KD5s1wj2I+QV//cnQM0tpGoEEwSiwgU=; b=lvv2EZMDa4/Kxx+mt2Zb09W4dZ+S
        dD/McPHwrFqoqLHac10vErHBgFy5aSfzCftNyalLAk6M62HU7QCMIIoVU3+g/TZs
        pCciSmIoTKei9VUYGmibRAkr62bTkyG/lEYmiCASaLLb15j6/cq1zJ/792mpb61E
        cEk9q47WDVd0EWE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1DF51746DA;
        Thu, 27 Jan 2022 13:05:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1DF871746D4;
        Thu, 27 Jan 2022 13:05:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git stash push' isn't atomic when Ctrl-C is pressed
References: <4493bcea-c7dd-da0a-e811-83044b3a1cac@tsoft.com>
        <220126.86bkzyfw3q.gmgdl@evledraar.gmail.com>
        <xmqqlez2qnfi.fsf@gitster.g>
        <220126.864k5qdx66.gmgdl@evledraar.gmail.com>
        <xmqqczkeozpx.fsf@gitster.g>
        <220127.86zgnhdhft.gmgdl@evledraar.gmail.com>
Date:   Thu, 27 Jan 2022 10:05:54 -0800
In-Reply-To: <220127.86zgnhdhft.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 27 Jan 2022 03:36:21 +0100")
Message-ID: <xmqq4k5p3vgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C611A3D0-7F9B-11EC-9C23-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Of course it's possible that I'm just missing something, do you see a
> reason for why having a signal handler be responsible for rolling back =
a
> reference transaction wouldn't work?

It is not an issue between would and would not work.  It is what is
practical and reasonable to support, and end-user expectation
management.

Besides, if you did

	open the reference transaction
	create a new commit to represent a stash entry
	revert local modifications from working tree files
	update the stash ref with the new commit
	commit the reference transaction

with the auto-rollback of the ref transaction as an atexit handler,
it would help rolling back the reference update (i.e. update to
refs/stash to append a reflog entry), but it would not help at all
rolling back updates to working tree files.

In fact, if you instead did them in this order instead:

	open the reference transaction
	create a new commit to represent a stash entry
	update the stash ref with the new commit
	commit the reference transaction
	revert local modifications from working tree files

it will safely record the local modifications in the stash *and* in
the refstore _before_ it starts to modify the working tree files, so

 (1) killing the process before the ref change is committed will
     truly be a no-op at the end-user level.  There may have been
     unreferenced objects added to the object store, but that won't
     hurt anything.

 (2) killing the process after the ref change is committed, before
     we completely revert all local modifications from the working
     tree files, will still leave crufts in the working tree.  But

     (2-a) you can "git reset --hard" to go to a known good state,
           i.e. the state you would have been in if "git stash push"
           were allowed to finish without interruption.

     (2-b) you can do (2-a) followed by "git stash pop" to go to
           another known good state, namely, the state before you
           ran "git stash push".

If you do not commit the ref transaction before starting to muck
with working tree files, such a recovery, which is transparent and
easy to understand what is going on, would not be possible.  You'd
lose the local changes and be left with a working tree with local
changes partially reverted.



