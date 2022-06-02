Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97135CCA47E
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 20:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiFBUFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbiFBUFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 16:05:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841A313EB2
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 13:05:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9345124AB1;
        Thu,  2 Jun 2022 16:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1mBzHXI4Icfr
        CxP0xMcxniP9Q9IImfuDhwP0uy9iwdI=; b=LUiVFwBVAqTzjgWkfnSqiafKBjlI
        SJlgLeAeW4dngRfdtiL0GlfMymNZanJsno+4cdHXrEoDSw75zYLy+KcQwHdxVLNC
        vnaSUSTT9CDONaTEakLTUwiK7TcvZ6N7qNRrps7W3s7Xy6pUqrttCDLG44l0zSrZ
        aMX2cmPfUHxNdx8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1673124AB0;
        Thu,  2 Jun 2022 16:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17B97124AAF;
        Thu,  2 Jun 2022 16:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/2] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
References: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
        <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
Date:   Thu, 02 Jun 2022 13:05:16 -0700
In-Reply-To: <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Jun
 2022 16:07:55
        +0200")
Message-ID: <xmqq7d5yn85f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 52FD39DC-E2AF-11EC-A6B7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series fixes a v2.36.0 regression[1]. See [2] for the v4. The
> reasons for why a regression needs this relatively large change to
> move forward is discussed in past rounds, e.g. around [3]. CI at
> https://github.com/avar/git/actions/runs/2428475773
>
> Changes since v4, mainly to address comments by Johannes (thanks for
> the review!):

This version looks good to me.

>     @@ run-command.c: static void pp_init(struct parallel_processes *pp=
,
>       	for (i =3D 0; i < n; i++) {
>       		strbuf_init(&pp->children[i].err, 0);
>       		child_process_init(&pp->children[i].process);
>     -+		if (!pp->pfd)
>     -+			continue;
>     - 		pp->pfd[i].events =3D POLLIN | POLLHUP;
>     - 		pp->pfd[i].fd =3D -1;
>     +-		pp->pfd[i].events =3D POLLIN | POLLHUP;
>     +-		pp->pfd[i].fd =3D -1;
>     ++		if (pp->pfd) {
>     ++			pp->pfd[i].events =3D POLLIN | POLLHUP;
>     ++			pp->pfd[i].fd =3D -1;
>     ++		}
>       	}

This change is merely a personal taste---it does not match mine but
that is Meh ;-)

>     -@@ run-command.c: static void pp_cleanup(struct parallel_processes=
 *pp)
>     -  */
>     - static int pp_start_one(struct parallel_processes *pp)
>     - {
>     -+	const int ungroup =3D pp->ungroup;

It may have made the resulting code easier to read if the local
variable was kept as a synonym as "pp->" is short enough but is
repeated often, but what is written is good enough and I do not see
a need to flip-flop.

>     -+static void pp_mark_ungrouped_for_cleanup(struct parallel_process=
es *pp)
>     -+{
>     -+	int i;
>     -+
>     -+	if (!pp->ungroup)
>     -+		BUG("only reachable if 'ungrouped'");
>     -+
>     -+	for (i =3D 0; i < pp->max_processes; i++)
>     -+		pp->children[i].state =3D GIT_CP_WAIT_CLEANUP;
>     -+}

Good to see this inlined.  I find the caller easier to follow
without it.

Thanks for a quick succession of rerolling.  Will queue.
