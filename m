Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C1DC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbiFOVBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiFOVBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 17:01:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290005523D
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 14:01:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F7D91B72E7;
        Wed, 15 Jun 2022 17:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pmFN414q3oVmqVvrPluHma5nqBFvsi/TtEMxmt
        /szIw=; b=iCQCWAcWlgtoqcY5X1m2eFT3bF7C0sblwvPkgwG/5DcP7LYJyRo5o8
        eMCrFUTu93BlEm/8PSYuXcTIWj3FBKp+mN7g6fE/tmyGf6i5gmPgV2WeSFo7FMe7
        2NEhFbwntXgDTgNa4Kn+5ul7Cj+frkouM4Fyr2PWY6DPvgQtaa6II=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5782D1B72E6;
        Wed, 15 Jun 2022 17:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0AEC11B72E5;
        Wed, 15 Jun 2022 17:01:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Oliver <roliver@roku.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] mktree: learn about promised objects
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
        <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
        <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
        <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
        <YqkpRE8nykqVv8cn@nand.local>
        <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
        <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
Date:   Wed, 15 Jun 2022 14:01:33 -0700
In-Reply-To: <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com> (Richard Oliver's
        message of "Wed, 15 Jun 2022 18:40:46 +0100")
Message-ID: <xmqqa6adzln6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 572E0CE0-ECEE-11EC-A0E4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Oliver <roliver@roku.com> writes:

> Meanwhile, is it worth considering a '--promised-as-missing' option
> (or a config option) for invocations such as 'mktree --missing' that
> prevents promised objects being faulted-in? Currently, the only
> reliable way that I've found to prevent 'mktree --missing' faulting-in
> promised objects is to remove the remote. Such an option could either
> set the global variable 'fetch_if_missing' to '0' or could ensure
> 'OBJECT_INFO_SKIP_FETCH_OBJECT' is passed appropriately.

I didn't spend too much time on thinking this one through myself,
but do we really need a separte option?

As far as I remember, I wrote the original behaviour implemented in
1c64e79a (mktree --missing: allow missing objects, 2009-05-10) when
the command is run without --missing primarily to be extra paranoid
to detect broken repository with every chance we have to avoid
spreading existing breakage to new objects we create.  With the
input "mktree" gets from the end user, we have no need to learn
anything from existing objects in order to create the tree object at
all.

The original 1c64e79a even carefully made sure that with --missing
in effect, we do not ask the object store about an object:

	/* It is perfectly normal if we do not have a commit from a submodule */
	if (S_ISGITLINK(mode))
		allow_missing = 1;

	if (!allow_missing)
		type = sha1_object_info(sha1, NULL);
	else
		type = object_type(mode);

	if (type < 0)
		die("object %s unavailable", sha1_to_hex(sha1));


We by grave mistake at 31c8221a (mktree: validate entry type in
input, 2009-05-14) started insisting on inspecting objects even when
allow-mising was given.  I do not think it was sensible, given why
we had "--missing" as an option to allow users to say "you do not
have to be too paranoid".

The codebase is so distant but I think we should probably do a moral
revert/reconstruct of that commit so that the extra paranoia of the
said commit applies only when "--missing" is not in effect, or
something like that.
