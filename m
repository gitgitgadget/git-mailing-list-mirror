Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23967C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352063AbiHSU7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351994AbiHSU7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 16:59:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06EA9FA8E
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:59:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7317819EA81;
        Fri, 19 Aug 2022 16:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=90Dmo+mNroyy
        hTsU1jehP95gbfuvda5hFd55BUUzVmQ=; b=vVFwp7u/a43pbABZKZXRPFhkB7Vk
        SeLxnd40bXoDxtHkXwJ7bSQ6Ua56549KUU5lMW+wgSfk/BRlvNXIlZ9OulAfoJvS
        MRpVi0mF1mGYONEO9gsI+vAouj3p7F87Zcr0avOUgOnZUvO/jggpk6fDNcFA8TDB
        1twgU3DLOXhDSh8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AE6619EA80;
        Fri, 19 Aug 2022 16:59:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2005F19EA7E;
        Fri, 19 Aug 2022 16:59:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 12/20] builtin/gc.c: let parse-options parse 'git
 maintenance's subcommands
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
        <20220819160411.1791200-1-szeder.dev@gmail.com>
        <20220819160411.1791200-13-szeder.dev@gmail.com>
Date:   Fri, 19 Aug 2022 13:59:02 -0700
In-Reply-To: <20220819160411.1791200-13-szeder.dev@gmail.com> ("SZEDER
        =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 19 Aug 2022 18:04:03 +0200")
Message-ID: <xmqq35dskl0p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C213696A-2001-11ED-9AE7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> 'git maintenanze' parses its subcommands with a couple of if

nanze?

> statements.  parse-options has just learned to parse subcommands, so
> let's use that facility instead, with the benefits of shorter code,
> handling missing or unknown subcommands, and listing subcommands for
> Bash completion.
>
> This change makes 'git maintenance' consistent with other commands in
> that the help text shown for '-h' goes to standard output, not error,
> in the exit code and error message on unknown subcommand, and the
> error message on missing subcommand.  There is a test checking these,
> which is now updated accordingly.
>
> Note that some of the functions implementing each subcommand don't
> accept any parameters, so add the (unused) 'argc', '**argv' and
> '*prefix' parameters to make them match the type expected by
> parse-options, and thus avoid casting function pointers.

OK.  When the recently posted "unused annotation" and merges down
together with this topic, we would want to add UNUSED() annotation
to them so that we can get closer to be able to compile with -Wunused
warning enabled, but we do not have to worry about it yet.

> +	struct option builtin_maintenance_options[] =3D {
> +		OPT_SUBCOMMAND("run", &fn, maintenance_run),
> +		OPT_SUBCOMMAND("start", &fn, maintenance_start),
> +		OPT_SUBCOMMAND("stop", &fn, maintenance_stop),
> +		OPT_SUBCOMMAND("register", &fn, maintenance_register),
> +		OPT_SUBCOMMAND("unregister", &fn, maintenance_unregister),
> +		OPT_END(),
> +	};
> +
> +	argc =3D parse_options(argc, argv, prefix, builtin_maintenance_option=
s,
> +			     builtin_maintenance_usage, 0);
> +	return fn(argc, argv, prefix);
