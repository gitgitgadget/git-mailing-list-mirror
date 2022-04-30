Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D6CC433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 20:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbiD3Uxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiD3Uxf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 16:53:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C435FF9
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 13:50:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0360E126979;
        Sat, 30 Apr 2022 16:50:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sWlxGpsS2I8D
        Pbuq6TEzoKIPezg5r6F1XrPFqNYKfU0=; b=lE+XI8OnyWQHCTfLl60LHUzjnvXd
        zSrWbh71VoC/tXS984PxU82tiEst3Q9ejVLIfJ1S7bJQVWRooyF+9boGAcxaENT6
        fbfcBeBZYm7nyuosIJA2zndnALqnUgZaOqzhhp2wCV2U/TEkC+MMnbTsNe87JKrb
        1PYTo8yvsl6RHno=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8615126977;
        Sat, 30 Apr 2022 16:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A80CC126976;
        Sat, 30 Apr 2022 16:50:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
        Daniel Li <dan@danielyli.com>
Subject: Re: [PATCH] 2.36 fast-export regression fix
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
        <xmqqzgk388tt.fsf@gitster.g> <xmqqo80j87g0.fsf_-_@gitster.g>
        <2c988c7b-0efe-4222-4a43-8124fe1a9da6@web.de>
Date:   Sat, 30 Apr 2022 13:50:07 -0700
In-Reply-To: <2c988c7b-0efe-4222-4a43-8124fe1a9da6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 30 Apr 2022 16:31:43 +0200")
Message-ID: <xmqq35hu8feo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F13CBE2-C8C7-11EC-9EBF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> e900d494dc (diff: add an API for deferred freeing, 2021-02-11) added a
> way to allow reusing diffopts: the no_free bit.  244c27242f (diff.[ch]:
> have diff_free() call clear_pathspec(opts.pathspec), 2022-02-16) made
> that mechanism mandatory.
>
> git fast-export doesn't set no_free, so path limiting stopped working
> after the first commit.  Set the flag and add a basic test to make sure
> only changes to the specified files are exported.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---

Both format-patch fix and this one look good to me.

We have UNLEAK() in format-patch so that the fix will not result in
additional false positives from the leak checker.  But this one, we
didn't have UNLEAK() so this may start tickling the leak checker
again.  We may need to add UNLEAK() at some point.

Stopping a leak checker from complaining about a known singleton
leak that is at the top-level (i.e. does not become bigger with the
data) by spending extra cycles is pointless, compared to using
UNLEAK() to do the same, and it is doubly misguided if it breaks the
behaviour X-<.

Will queue both, thanks.
