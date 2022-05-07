Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD72C433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 17:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446696AbiEGRij (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 13:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390453AbiEGRig (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 13:38:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0520F54
        for <git@vger.kernel.org>; Sat,  7 May 2022 10:34:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 111AC122699;
        Sat,  7 May 2022 13:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Sxl9qkNfiFic
        hik+bj3XV0UmA3lf7251Rcyo8x1GDuA=; b=rCzB4j4zUcKRnYfFRd6tiNWChExl
        R/pi3pQFfcc0Oc0DEDc2hiqBx0rIGfeFsowV1RAIkxaIauaBWOU1mSd8SuDqFoEU
        muhA+W1hY5cc9isH76xpE0JUeeJavFnsgpNkUCTbHN+VmpVlrlaEwOHbBzPS3zAF
        JgUQe5o7JE2DSsw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07B9D122697;
        Sat,  7 May 2022 13:34:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64A33122696;
        Sat,  7 May 2022 13:34:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH v4 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
References: <20220503065442.95699-1-carenas@gmail.com>
        <20220507163508.78459-1-carenas@gmail.com>
        <20220507163508.78459-3-carenas@gmail.com>
Date:   Sat, 07 May 2022 10:34:44 -0700
In-Reply-To: <20220507163508.78459-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 7 May 2022 09:35:07 -0700")
Message-ID: <xmqqv8uhgsaz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC5A7C26-CE2B-11EC-8134-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> +		/*
> +		 * env_id could underflow/overflow in the previous call
> +		 * and if it will still fit in a long it will not report
> +		 * it as error with ERANGE, instead silently using an
> +		 * equivalent positive number that might be bogus.
> +		 * if uid_t is narrower than long, it might not fit,
> +		 * hence why we  need to check it against the maximum
> +		 * possible uid_t value before accepting it.
> +		 */
> +		if (!*endptr && !errno && env_id <=3D (uid_t)-1)
> +			*id =3D env_id;

Thanks for very clearly spelling out why you care.  It makes it much
easier to explain why I disagree with the line of reasoning ;-)

This code may be exercised by a potential attacker, but we know that
the codepath is entered only when euid=3D=3DROOT_UID.  The attacker may
or may not have used 'sudo', and we cannot trust the value of
SUDO_UID at all.  But that is OK.  If the attacker already is root
on the box, they do not have to use "git" or exercise this new code
in order to attack anybody on the box already.  This requires us to
exclude social engineering attack to tell a victim to run "sudo",
set SUDO_UID to a specific value, and run something, but at last I
have been excluding that from the beginning.  There are easier
things you can tell the potential victim to cause harm while being
root.

Now the whole point of adding this new code to _weaken_ the existing
check is to help legitimate users who are authorised to become root
via "sudo" on the box.  Making it easier for them to use "git" while
tentatively gaining root priviledge so that they can do "make
install" in a repository they own.

We know that this code is meant to be exercised after a potential
victim gained euid=3D=3DROOT_UID via 'sudo', and SUDO_UID is exported by
the command for the original user.  If uid_t is narrower than ulong
(e.g. 16-bit uid_t vs 64-bit ulong), and if it is unsigned, the only
effect the extra check is doing is to exclude the unfortunate user
with uid=3D=3D65535 from using "sudo git describe".

In exchange, the only attack scenario the code prevents is this,
IIUC.

 * You, the aspiring cracker, are a user not allowed to run "sudo" on
   the box, and you know your uid is 1000

 * You look for another user, a potential victim, whose uid is 1000
   modulo 65536 (if your uid_t is 16-bit) and who can run "sudo" on
   the box.

 * You prepare a malicious repository, invite that user there and
   ask them to run "sudo something" there.

I'd say such an attack vector is not likely, and a user with maximum
allowed uid_t value is equally not that likely, so I do not care too
deeply either way---and in such a case, I do prefer a simpler code.
