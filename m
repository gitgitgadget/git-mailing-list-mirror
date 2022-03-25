Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93643C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 01:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357100AbiCYBFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 21:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbiCYBFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 21:05:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4AB6E40
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 18:03:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CABE8110178;
        Thu, 24 Mar 2022 21:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cUpGdwbsz936
        6ol+tDX1QeKiIxo6kz1ZNbDrJH1NCUU=; b=WJshoUol80r+Me32mb8Icvx5jqnd
        lxfRCjckYET+YKCKGQs6WLZCqldiV80+YqcdKf/ZZkz8HiG5rFEHe++JIZJyGrXR
        4kRq83tRscY9qXf9318FjikDq3YrMtfOVbQgApPCZgzFjLChXN3B373bfO5zxb2w
        aq9fovJl2DSvRqk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C26F3110177;
        Thu, 24 Mar 2022 21:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 169F9110176;
        Thu, 24 Mar 2022 21:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 12/27] revisions API users: use release_revisions()
 in builtin/log.c
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-12.27-74818bc372f-20220323T203149Z-avarab@gmail.com>
Date:   Thu, 24 Mar 2022 18:03:33 -0700
In-Reply-To: <patch-v2-12.27-74818bc372f-20220323T203149Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 23 Mar
 2022 21:32:02
        +0100")
Message-ID: <xmqq5yo2etcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 658471D8-ABD7-11EC-8F30-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In preparation for having the "log" family of functions make wider use
> of release_revisions() let's have them call it just before
> exiting. This changes the "log", "whatchanged", "show",
> "format-patch", etc. commands, all of which live in this file.
>
> The release_revisions() API still only frees the "pending" member, but
> will learn to more members of "struct rev_info" in subsequent commits.

Learn to do what to more members?

> In the case of "format-patch" revert the addition of UNLEAK() in
> dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16), and
> which will cause several tests that previously passed under
> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" to start failing.

", and which" -> ", which".

> diff --git a/builtin/log.c b/builtin/log.c
> index 6f9928fabfe..c40ebe1c3f4 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -295,6 +295,12 @@ static void cmd_log_init(int argc, const char **ar=
gv, const char *prefix,
>  	cmd_log_init_finish(argc, argv, prefix, rev, opt);
>  }
> =20
> +static int cmd_log_deinit(int ret, struct rev_info *rev)
> +{
> +	release_revisions(rev);
> +	return ret;
> +}

Ugly but cute.

> @@ -732,8 +738,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
>  			ret =3D error(_("unknown type: %d"), o->type);
>  		}
>  	}
> -	free(objects);
> -	return ret;
> +	return cmd_log_deinit(ret, &rev);
>  }

This probably makes things worse tentatively for OBJ_COMMIT case,
where we reuse the rev structure to "(un)walk" the given commit
after clearing rev.pending, but hopefully you'll fix it up in a
later step or two?
