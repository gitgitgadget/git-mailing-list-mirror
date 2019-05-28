Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5761F462
	for <e@80x24.org>; Tue, 28 May 2019 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfE1UDa (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:03:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55971 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfE1UDa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:03:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3501414A69A;
        Tue, 28 May 2019 16:03:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K3v2mJdYiqOA
        njJb7JUS9xEIfwQ=; b=f4qsaLAHkkS2yihWC8adDGiJSX80P+/Bz16WIoZhBL/U
        yXbc8lQ9sSsl5V8mQnFEF3IQJRV+ZkUnJ0v5WwbF6uob5NtO/qD+sI7T1Luxos0O
        bTBjCPPkiwgiE8gclPu2+L+l0x4ERVJI+JblwEs9Qdl6j6vw9Z2RIU2GFJSvtDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=h5hPGf
        TRs6euwln/dOJzaAEpUBkM8kdsdg40q5Zzq4gPEx8VFxscOKpl5lpw3KwOrkofix
        tW3jBJ4SfyhB/UuAKeWonX8p9D+H/ubR1GNjKNIzOZdvfyt4kl/iAQgLsQc/N0gg
        NNYUn+LoPrcWjLHmKdeif6qzVCvXP34ZVGcPs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BB7414A699;
        Tue, 28 May 2019 16:03:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9122714A698;
        Tue, 28 May 2019 16:03:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] bundle verify: error out if called without an object database
References: <pull.226.git.gitgitgadget@gmail.com>
        <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
        <20190528015133.GA29724@sigill.intra.peff.net>
Date:   Tue, 28 May 2019 13:03:26 -0700
In-Reply-To: <20190528015133.GA29724@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 27 May 2019 21:51:33 -0400")
Message-ID: <xmqqftoy1h4h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8511858-8183-11E9-88C4-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As G=C3=A1bor noted in the earlier thread, if the bundle doesn't have a=
ny
> prerequisites, this _used_ to work before b1ef400eec (setup_git_env:
> avoid blind fall-back to ".git", 2016-10-20). I don't know if anybody
> cares about that case or not, but we could do something like:
>
>   if (p->nr)
> 	verify_prerequisites();
>
>   /* otherwise, fall through to the printing portions */
>
> and then just check for a repository in verify_prerequisites(), which i=
s
> the only part that needs to look at the repository object at all.

It depends on how important we consider the use of bundles that can
be cloned from.  If it is important enough, what you suggest is an
improvement worth doing over what Dscho did.

A bundle that can be cloned from (i.e. no prerequisite) is meant to
be used without having any repository by definition, so it is a
grave regression to require object store when verifying such a
bundle.

On the other hand, a bundle that cannot be cloned from but only
usabel for an incremental sneaker-net update needs receiving
repository anyway, so it is perfectly fine to require object store.
