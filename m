Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A49C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 22:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD65460F90
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 22:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhG0Wk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:40:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60488 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhG0Wk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 18:40:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFC8BD17CA;
        Tue, 27 Jul 2021 18:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mDfu+MkIE3cJ
        yviih+PvjR6AoCza1ijBz/+s7vjLV7Q=; b=cfl9O0euGURhmgcRDmMewKTERwU8
        D3wDeW/m+BeKLkn4hRCeMKEBnYaeX5Ke6hvUfv7UmzCsBNkhJ7HP0HOYQAX0tnrE
        hAS3aUqGwfg4vRieoDhBBjg/vKkIwhSxaHUTHz+C/886D2VCo9NnPV2mojzTxawc
        aVCk3QJOYO3CeWM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C70AFD17C9;
        Tue, 27 Jul 2021 18:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A269D17C8;
        Tue, 27 Jul 2021 18:40:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     emilyshaffer@google.com, avarab@gmail.com, git@vger.kernel.org,
        iankaz@google.com, sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
References: <xmqqczr4fsso.fsf@gitster.g>
        <20210727213942.2574308-1-jonathantanmy@google.com>
Date:   Tue, 27 Jul 2021 15:40:24 -0700
In-Reply-To: <20210727213942.2574308-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 27 Jul 2021 14:39:42 -0700")
Message-ID: <xmqqmtq7crdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A276AE12-EF2B-11EB-9385-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I think both "I want to vet" and "good enough for project X is good
> enough for me" are both reasonable points of view, and this
> remote-suggested hook scheme supports both.

Sure. =20

I was just pointing out that the design is opinionated and not
giving two points of view fair chance to compete.  It will strongly
encourage users to the latter choice by prodding them when they want
to do a hook-invoking operation (like "git commit").

Not that opinionated design is necessarily a bad thing.

> I don't think we should compare the installed .git/hooks/pre-commit wit=
h
> remotes/origin/suggested-hooks (since the user may have locally modifie=
d
> that hook), so a solution involving storing the OID of the installed
> hook somewhere (I haven't figured out where, though) and comparing that
> OID against remotes/origin/suggested-hooks would be reasonable and woul=
d
> be compatible with the current approach (as opposed to the one which
> =C3=86var describes which, if I understand it correctly, would require
> "commit" to access the network to figure out if the hook the client has
> is the latest one).

Coping with local modification would not be rocket science.

If I were to do this, when the end-user approves installation of
and/or updates from remotes/origin/suggested-hooks/, the following
would happen:

 (1) If .git/hooks/* does not have the hook installed, copy it from
     the suggested hooks, and append two line trailer:

	# do not edit below
	# hook taken from <suggested hooks blob object name>

 (2) If .git/hooks/* does hold the hook, look for the "hook taken
     from" trailer

   (a) if "hook taken from" trailer is missing (i.e. it came from
       somewhere other than "remote suggested" workflow) or it does
       not point at a valid blob object, jump to "conflict exists"
       below.

   (b) using that (old) blob object name, perform (1) to recreate
       the hook the user would have seen when on-disk version of
       hook was created.  Difference between that and what is
       on-disk is the end-user customization.

       extract the current blob object from the suggested hooks tree
       object, do the same as (1), and then replay the end-user
       customization we figured out above.

       If the replaying succeeds cleanly, we are done.  Otherwise we
       have conflicts that cannot be resolved automatically.

   (c) "conflict exists".  The usual three-way merge resolution is
       needed.  I'd suggest to give users two (or three) files:

       - Rename the current version the user has to *.bak;
       - The new version from the project in the final file;
       - The patch obtained in (b) above, if exists in a separate file.

       and ask them to carry their customization forward to the
       second one (this is in line with the "we encourage them to
       adopt the project preferences" philosophy this proposal is
       taking us, I think).

I think configuration files under /etc/ on Debian-based distros have
been managed in a similar way for at least the past 10 years if not
longer, and since we are version control software ourselves, the
conflict resolution users are asked to perform in (2)-(c) shouldn't
be too much of a burden to our users anyway.
