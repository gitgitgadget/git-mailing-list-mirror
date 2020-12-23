Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF22C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 21:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF7C207D0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 21:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgLWVPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 16:15:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61023 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgLWVPf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 16:15:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60CB8996F0;
        Wed, 23 Dec 2020 16:14:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1pQhdRlLxDjDOjGga/t3Bn3CKQQ=; b=pXowqF
        dkhItBUdjvp7Veh2XtZ/ig81aDHXOD8lPKG8c5Ty+TEgp23bb9GNmyhGuGxgEMrS
        3UQb+XXxl+3+F3DFuHko0b7/dWcoLKS7mflB4jPYGJz91y1speAtnYkI7E3yKIAZ
        dQMiJDHs+feqJ+/SK+cMpOMwvjEpbre85YQX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BD8d8LX9XyDBQIBIE/TOEjjGldMRxwDn
        Q3qP3Hzrk3DhDzHSBNdk6fY9EnM5MgXlKW3jNrqWmhBCrzmooeiwZMr44qZs6DLb
        J4LhsUFW9nBvRBC2bCYQujOZsmT6aDdkFbAm6KJT5KQEbpzAYBPWr7sfXxZ3eMM3
        S80FjVBu1A0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58ABE996EF;
        Wed, 23 Dec 2020 16:14:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF746996EE;
        Wed, 23 Dec 2020 16:14:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v5 8/8] config: allow specifying config entries via
 envvar pairs
References: <cover.1606214397.git.ps@pks.im> <cover.1608104755.git.ps@pks.im>
        <dfceffd8d4fbc3c99cfa7c5d838e4c3a2db6598a.1608104755.git.ps@pks.im>
Date:   Wed, 23 Dec 2020 13:14:52 -0800
In-Reply-To: <dfceffd8d4fbc3c99cfa7c5d838e4c3a2db6598a.1608104755.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 16 Dec 2020 08:54:48 +0100")
Message-ID: <xmqqczz06x83.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E60E198E-4563-11EB-BCB1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> While we currently have the `GIT_CONFIG_PARAMETERS` environment variable
> which can be used to pass runtime configuration data to git processes,
> it's an internal implementation detail and not supposed to be used by
> end users.
>
> Next to being for internal use only, this way of passing config entries
> has a major downside: the config keys need to be parsed as they contain
> both key and value in a single variable. As such, it is left to the user
> to escape any potentially harmful characters in the value, which is
> quite hard to do if values are controlled by a third party.
>
> This commit thus adds a new way of adding config entries via the
> environment which gets rid of this shortcoming. If the user passes the
> `GIT_CONFIG_COUNT=$n` environment variable, Git will parse environment
> variable pairs `GIT_CONFIG_KEY_$i` and `GIT_CONFIG_VALUE_$i` for each
> `i` in `[0,n)`.
>
> While the same can be achieved with `git -c <name>=<value>`, one may
> wish to not do so for potentially sensitive information. E.g. if one
> wants to set `http.extraHeader` to contain an authentication token,
> doing so via `-c` would trivially leak those credentials via e.g. ps(1),
> which typically also shows command arguments.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-config.txt |  16 +++++
>  cache.h                      |   1 +
>  config.c                     |  67 +++++++++++++++++---
>  environment.c                |   1 +
>  t/t1300-config.sh            | 115 ++++++++++++++++++++++++++++++++++-
>  5 files changed, 191 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 0e9351d3cb..72ccea4419 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -346,6 +346,22 @@ GIT_CONFIG_NOSYSTEM::
>  
>  See also <<FILES>>.
>  
> +GIT_CONFIG_COUNT::
> +GIT_CONFIG_KEY_<n>::
> +GIT_CONFIG_VALUE_<n>::
> +	If GIT_CONFIG_COUNT is set to a positive number, all environment pairs
> +	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will be
> +	added to the process's runtime configuration. The config pairs are
> +	zero-indexed. Any missing key or value is treated as an error. An empty
> +	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=0, namely no
> +	pairs are processed. These environment variables will override values
> +	in configuration files, but will be overridden by any explicit options
> +	passed via `git -c`.
> +
> +	This is useful for cases where you want to spawn multiple git commands
> +	with a common configuration but cannot depend on a configuration file,
> +	for example when writing scripts.

Dedent these three lines, and replace the blank lines before it with
a line with a single '+' on it (an example is found in the paragraph
that describes the "--get-color" option; look for "type=color" in
the same file).  Otherwise these subsequent paragraphs are treated
differently from the first paragraph.

The same problem may exist in new paragraphs in git.txt that
describes the "--config-env" stuff.

Thanks.
