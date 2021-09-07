Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AC7C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342EA61103
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbhIGV6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:58:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52203 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhIGV6L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:58:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DBF9160856;
        Tue,  7 Sep 2021 17:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cLJxXZ5QvwDs
        H4AhbAMj74S72iyIcLeRnyy+q5aiTq0=; b=RmI9Lk6V4FUa1ObfOYRNrdRkV71X
        PS5uSoPAl1iLvit5C1dnpt1/CvwTDZxjPKssB99bhRUBC1KPkFpykrjxBnjTEGGL
        jhTFG0SQS0WpR9nHXIJWysmrKo6vpHxMr8OsR+vdTtAzhNO1mTuJBdPuTV6BubX/
        zz8nuB+Zei/qzXg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6750D160855;
        Tue,  7 Sep 2021 17:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC0B5160852;
        Tue,  7 Sep 2021 17:57:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com, emilyshaffer@google.com
Subject: Re: [PATCH 2/2] bugreport: slightly better memory management
References: <20210903115933.622847-1-bagasdotme@gmail.com>
        <20210904021231.88534-1-carenas@gmail.com>
        <20210904021231.88534-3-carenas@gmail.com>
Date:   Tue, 07 Sep 2021 14:56:59 -0700
In-Reply-To: <20210904021231.88534-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 3 Sep 2021 19:12:31 -0700")
Message-ID: <xmqqy28882xg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 87F1B4F8-1026-11EC-B53E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 238b439d69 (bugreport: add tool to generate debugging info, 2020-04-16)
> introduces an UNLEAK for a strbuf that contains the buffer that gets
> flushed to disk earlier, instead of simply cleaning the buffer.
>
> do so, and while at it, move the free() call for another temporary stri=
ng
> closer to its creator, so it is easier to keep track of.

'do so' -> 'Do so'.

>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  builtin/bugreport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 17042381c3..a9bedde1e8 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -152,6 +152,7 @@ int cmd_bugreport(int argc, const char **argv, cons=
t char *prefix)
>  	strbuf_addstr(&report_path, "git-bugreport-");
>  	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), =
0, 0);
>  	strbuf_addstr(&report_path, ".txt");
> +	free(prefixed_filename);

Correct, but it can be raised even further.  We can free it after we
addstr to report_path.

I looked at the existing callers of prefix_filename(), hoping that
many of them might take it in a strbuf they have, in which case we
may be able to expose an alternative interface to take a caller
supplied strbuf to clean this one up.  But it seems this is the only
one, so "store in a temporary, strbuf_addstr it, and immediately
free the temporary" here would be good.

>  	switch (safe_create_leading_directories(report_path.buf)) {
>  	case SCLD_OK:
> @@ -181,6 +182,7 @@ int cmd_bugreport(int argc, const char **argv, cons=
t char *prefix)
>  		die_errno(_("unable to write to %s"), report_path.buf);
> =20
>  	close(report);
> +	strbuf_release(&buffer);

We are done with the strbuf once write_in_full() returns, but this
is close enough.

> @@ -191,8 +193,6 @@ int cmd_bugreport(int argc, const char **argv, cons=
t char *prefix)
>  	fprintf(stderr, _("Created new report at '%s'.\n"),
>  		user_relative_path);
> =20
> -	free(prefixed_filename);
> -	UNLEAK(buffer);
>  	UNLEAK(report_path);
>  	return !!launch_editor(report_path.buf, NULL, NULL);

Having reviewed all, I am not sure if my reaction is "good, now we
are cleaner" or "meh, for the same reason why report_path can be
left alive, it is fine to leave buffer alive, too".

