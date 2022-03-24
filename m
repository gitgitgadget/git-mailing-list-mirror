Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97411C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbiCXEeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 00:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiCXEem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 00:34:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C501C4C
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:33:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0066F1260E1;
        Thu, 24 Mar 2022 00:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=p1/Uv2pOnKHyglWObEuV73hdb
        sFGdyAm5TH7BGoyo7g=; b=FhrvQTOgcIklTwDi6yJXc1mTH6TBzC6ea23Wu834s
        EZbb3MhKquWsMzN5/ID7p9BSjl0x32fv+J6eN3Pzcx53mF0Yof6vsuHma8Qp9l87
        xenApqkOYABcjzkM4t4l+Qng1MvpBq0Mpksslj+hLGcJFZjLhbNJQQnqIAQJRKtz
        Uw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D976C1260E0;
        Thu, 24 Mar 2022 00:33:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25E021260DF;
        Thu, 24 Mar 2022 00:33:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 04/27] format-patch: don't leak "extra_headers" or
 "ref_message_ids"
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-04.27-64a76629e23-20220323T203149Z-avarab@gmail.com>
Date:   Wed, 23 Mar 2022 21:33:05 -0700
Message-ID: <xmqqfsn8m0la.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 80A2EDE8-AB2B-11EC-AE1F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix two memory leaks in "struct rev_info" by freeing that memory in
> cmd_format_patch(). These two are unusual special-cases in being in
> the "struct rev_info", but not being "owned" by the code in
> revision.c. I.e. they're members of the struct so that this code in
> "builtin/log.c" can pass information code in log-tree.c.

Hmph, if we are eventually adding a new API function to clear a
rev-info structure, shouldn't these members be released there
instead, I wonder.

This is the only user of this member, so it does not matter too much
either way, though.


> diff --git a/builtin/log.c b/builtin/log.c
> index 634dc782cce..6f9928fabfe 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1747,6 +1747,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
>  	struct commit *commit;
>  	struct commit **list =3D NULL;
>  	struct rev_info rev;
> +	char *to_free =3D NULL;
>  	struct setup_revision_opt s_r_opt;
>  	int nr =3D 0, total, i;
>  	int use_stdout =3D 0;
> @@ -1947,7 +1948,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
>  		strbuf_addch(&buf, '\n');
>  	}
> =20
> -	rev.extra_headers =3D strbuf_detach(&buf, NULL);
> +	rev.extra_headers =3D to_free =3D strbuf_detach(&buf, NULL);
> =20
>  	if (from) {
>  		if (split_ident_line(&rev.from_ident, from, strlen(from)))
> @@ -2284,6 +2285,10 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
>  	strbuf_release(&rdiff1);
>  	strbuf_release(&rdiff2);
>  	strbuf_release(&rdiff_title);
> +	free(to_free);
> +	if (rev.ref_message_ids)
> +		string_list_clear(rev.ref_message_ids, 0);
> +	free(rev.ref_message_ids);
>  	UNLEAK(rev);
>  	return 0;
>  }
