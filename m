Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD6C433E0
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 18:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6BB20717
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 18:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dIiJ5uaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgGRSDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:03:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55897 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgGRSDB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 14:03:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8246CFD44;
        Sat, 18 Jul 2020 14:02:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aub1aDpKwPOhGGvL4Tk+eUuf1LU=; b=dIiJ5u
        aKLlUTW/QwAWnPxaJulUFBWNi7c9J7lP97LbgWzcdHBDsP1763ZU5A9soL4OTdxS
        GPBCdNqJz8E32iVkPQJUhD05WW3wPyYVjfKcl1v4xoR2LolBKNYOVuRM+3FipW5v
        JZtI13qRhe/nCGbHMkSBP+vhWIOL5imxiiXLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JKMoLNwHGsfNSvahTT3vBYYT3mV8donA
        rtGwiSBG1sO0giXYIhcp5w3cpGEvM9DwnjIhXEwNCkhsKRDoD1zOAWR2KgU13Ayx
        vezgvB2DSeXISeqQo24PEUtXx8jepNJijGWlScpLmTJrujVYdPtXXefqwE4ai7ql
        YX3v2nYupW0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1678CFD43;
        Sat, 18 Jul 2020 14:02:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14D5ACFD42;
        Sat, 18 Jul 2020 14:02:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: die if sendmail.* config is set
References: <20200718132311.27248-1-sir@cmpwn.com>
Date:   Sat, 18 Jul 2020 11:02:55 -0700
In-Reply-To: <20200718132311.27248-1-sir@cmpwn.com> (Drew DeVault's message of
        "Sat, 18 Jul 2020 09:23:11 -0400")
Message-ID: <xmqqpn8sbt0w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8DA9D8C-C920-11EA-B13E-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> I've seen several people mis-configure git send-email on their first
> attempt because they set the sendmail.* config options - not
> sendemail.*. This patch detects this mistake and bails out with a
> friendly warning.

It is not very friendly thing to do, though.

It just closes the door for anybody to add something that works
independent from "git send-email", to which "sendmail.*" variables
may be appropriate knob to use.

Demoting the "die" to "warn" is OK, and limiting the check to
variables that actually has corresponding and likely-misspelt
"sendemail.*" counterparts would be even better, but "you are not
allowed to have any 'sendmail.*' variables, ever" is way too much,
I am afraid.

> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
>  git-send-email.perl |  6 ++++++
>  perl/Git.pm         | 26 ++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 36c47bae1d..8e42ba00c1 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -478,6 +478,12 @@ sub read_config {
>      usage();
>  }
>  
> +if ((scalar Git::config_regexp("sendmail.*")) != 0) {
> +	die __("fatal: found configuration options for 'sendmail'\n" .
> +		"git-send-email is configured with the sendemail.* options - note the 'e'.\n" .
> +		"Assuming this is a mistake and bailing out.\n");
> +}

