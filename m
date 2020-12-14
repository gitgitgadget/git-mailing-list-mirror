Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D40C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E7E20798
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 08:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439128AbgLNINt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 03:13:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53872 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406789AbgLNINf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 03:13:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E4D18F00C;
        Mon, 14 Dec 2020 03:12:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=pzGH3UF+bc05gRhwREvvCZyPIJo=; b=FeJTg7xkKEV0BTl0aO9l
        GSab+ypsX0mEjZ84dC2eVfusGjbu4LhwPiv71xRKVgJjDmeAE8LrDThX8qqlSfaR
        iZRgSDWbMMnk3BypRAtkcMuVYLFE/Ti8ff7kPIe+yKmV8SVHMwGCGB5afOQGMIWB
        whe7HfkYRMqrN1uCx/hVngo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=PmW/kZKLvEVdy0cuhbnjfaOQH0yWdWtTOEoI3PnQXE6BZu
        QRzdFMhkY9Ua0eJxdeqnMxYLNFE9v6I6CCzimXKYAzFWab3adUjSJTkH4n5ebrMj
        DiRJRdqAZegg3Gb8gxQqbotTtk0tRFOTjGaz8m4So4aEDI5U4v7nPIezahdNA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96DB48F00A;
        Mon, 14 Dec 2020 03:12:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B3178F008;
        Mon, 14 Dec 2020 03:12:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] mailmap: support hashed entries in mailmaps
Date:   Sun, 13 Dec 2020 16:09:19 -0800
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
        <20201213010539.544101-2-sandals@crustytoothpaste.net>
Message-ID: <xmqqv9d4ergd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28D71AF4-3DE4-11EB-976E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Come to think of it, this probably needs documentation as well, so I'll
> wait for any other feedback and then reroll with that in there.
> Hopefully that will clear up any potential confusion.

Not just "where does the hashed entry can appear in the file", but
"how exactly does it gets computed" needs to be described.  If it is
sufficient to do something like

	set x $(echo doe@example.com | sha256sum) &&
	echo "@sha256sum:$2"

that exact procedure must be described to the users in the
documentation (note: I know the above is not correct as I looked at
the tests---it is a demonstration of the need for a procedure using
commonly available tools).

I wonder if somebody may want to do a dedicated tool that lets you

 (1) given an e-mail and/or a name, look-up existing entries and
     show what <name, e-mail> pair it maps to;

 (2) take a new <name, e-mail> pair and add mapping from it to some
     other <name, e-mail> pair.

 (3) take an existing mailmap file, and obfuscate all the existing
     entries.

The first one is covered by "check-mailmap", so the other two could
be new features added to the command to be triggered with a command
line option.

> +	cat >hashed <<-EOF &&
> +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$GIT_AUTHOR_EMAIL>
> +	EOF
> +	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&

The two spaces after "check-mailmap" is not significant but drew my
attention.  Let's not do so.
