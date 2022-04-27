Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92733C433FE
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 19:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiD0TH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 15:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiD0THF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 15:07:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241E918E3B
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:54:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E2261A0C68;
        Wed, 27 Apr 2022 14:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rzgrx6h4mCrXgrB/uwoOU4RWiAeHtSWiKF7Z8f
        F8dDU=; b=rwLG2RzTO1Eu+14ZlPGopcicOpbFyWSBZZd0GHW3XdxpG97QcteY/B
        cG37xPqVC80DWI2TA6Q7Eb+W+QmcgAXjs8C60syjQ6SHu/AY5jCbAwCT4cCSQe9K
        F9VMsTkPpGR+6IHstrMTN1WhZkCAucZ9AZua880vBMT8TL/6C8+44=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 060281A0C67;
        Wed, 27 Apr 2022 14:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6636B1A0C66;
        Wed, 27 Apr 2022 14:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com, Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
References: <20220426183105.99779-1-carenas@gmail.com>
        <20220427000522.15637-1-carenas@gmail.com>
        <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
        <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
        <CAPUEspiHWTTAvNyqqLzcC854UccH=bkPLPBzPaPfzFKn_yt4aA@mail.gmail.com>
        <b0a80f47-f441-fc6e-3695-58ea83dea2b8@gmail.com>
Date:   Wed, 27 Apr 2022 11:54:17 -0700
In-Reply-To: <b0a80f47-f441-fc6e-3695-58ea83dea2b8@gmail.com> (Phillip Wood's
        message of "Wed, 27 Apr 2022 17:14:27 +0100")
Message-ID: <xmqqzgk6l5ly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7127327A-C65B-11EC-BFF8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 27/04/2022 16:58, Carlo Arenas wrote:
>> On Wed, Apr 27, 2022 at 5:30 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> You are ignoring any errors when parsing the environment variable - that
>>> is not a good idea in a security check.
>> which errors are you concerned about?, if anything in this code
>
> I was confused by the fact that the helper function returns a
> success/failure value which we ignore. However euid is not overwritten 
> if strtol fails so it is safe I think.
>
>> worries me from a security point of view is the fact that we are
>> relying in getenv not being racy (as mentioned in the original RFC),
>> but there are no errors set there AFAIK.
>> not ignoring errno in strtol is an option, but as mentioned before I
>> decided instead to reject bogus values and therefore not the clobber a
>> previous errno,
>
> strtol() will set errno if there is a range error ignoring it does not
> change that. In any case is_path_owned_by_current_uid() already
> clobbers errno if stat() fails.

IOW we are not preserving errno anyway, so ignoring errno (or
resetting before calling strtol) does not by us anything.

We probably should step back a bit, take a deep breath and think
what we are trying to protect our users against.  When I said early
in the discussion how much we trust the value in SUDO_UID, I hoped
people would do so, and I was especially hoping such a discussion to
happen when they realized that the width of uid_t is unknown and
there can be truncations in either direction.

So let's start one now.

If we didn't trust the value in SUDO_UID, what valid use case do we
help, and what avenue of attack do we open ourselves to?  This is
not a suggestion of an alternative, but is a discussion starter to
illustrate the line along which we want to think about the issues.

The original "sudo make install" (which runs "git describe" inside)
use case does not really care.  The process running with SUDO_UID is
not spelunking into random directories uncontrollably without being
aware that there may be hostile repositories.  The directories they
visit are part of legitimate journey "make install" takes.

The "sudo sh to get a shell, chdir to /var/tmp/foo to do something"
use case does care---it needs to make sure that whereever it goes is
not part of a hostile repository.  So "if SUDO_UID is there, anything
goes" is not a good protection for such a use case.

If we read SUDO_UID into an int16_t and uid_t happens to be much
wider than that type, then what happens?  Again, I am not advocating
to deliberately use shorter type to cause truncation.  This is
merely to illustrate how much truncation matters.

The "sudo make install" use case may be harmed unless the comparison
is done carefully.  If the repository owner's UID is beyond 32k then
asking if (st.st_uid == SUDO_UID) would say "no" due to truncation
and refuse access to the legitimate user.  If we compare both after
casting them to int16_t then the repository owner will be allowed in
again.  A friendly stranger who happens to share the low 16-bit of
UID will also be allowed to install from the repository, but that is
not an intended consequence.

The "sudo sh and go spelunking" use case is weakend by truncation.
It is protected only if the victim's UID does not share the lower
16-bit with the owner of hostile repository.

So what attack does this allow?  An attacker needs to learn their
own UID, find another user whose UID is the same modulo 16-bit as a
potential victim, and the victim has to be among those who can run
"sudo".  Then the victim somehow has to be talked into running stuff
in a repository the attacker prepares.

Possible?  Yes.  Practical?  I dunno.  Especially if we do not
deliberately truncate by reading into int16_t but use "int" (32-bit
almost everywhere we care about) or "long".  Now how likely is uid_t
narrower than long?  If it is not likely, then we probably are OK to
use long and not worry about the truncation at all.  Or use strtoll()
to make it even less likely.

So, in short, I think it is reasonable if we did:

 - do the extra "if SUDO_UID exists, then..." only when we are root.

 - use strtol to ensure SUDO_UID is in good shape (all digits) and
   read into long; use errno=0 trick to notice overflows.  err on
   the safe side and do not allow if the value cannot be read
   correctly.

 - do the comparison between st.st_uid and strtol() result by
   casting both to (long).  Without this, st.st_uid has a value that
   needs wider than long, we cannot allow the owner of such a
   repository in (and I somehow feel that is unlikely to happen).

 - or omit the third one --- tough luck for those whose UID is
   beyond what a long can represent (and I somehow feel that this is
   probably OK).

Another thing I'd suggest doing is to have a helper function to do
the "we do a bit more than geteuid() to come up with the allowed
owner of repositories we encounter", and call that function instead
of geteuid().

Thanks.
