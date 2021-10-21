Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF3C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAF0611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJUXkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:40:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54420 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXkc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:40:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 777C2163E91;
        Thu, 21 Oct 2021 19:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cNEWf9gBc7Gn
        n6YL/gBF6Vs5cRYh4GK/jnyWRdCBLQ4=; b=gKN2NfQgW1EU98sjJKvS+yH7GCtY
        7iqjhgbc9lfnDpzmDAHF7tfmlNy3gpqSjwcohZjqxoKkmkbqNvBk4mB5M58O6pfG
        7WYG7IRg7d8iVZ2JfLlJ+8idBcdeJdixnuDKFOcAv4jQfBj+E0LcjTWD4hymP+mP
        U3WKLg7qwNqE+rY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70950163E90;
        Thu, 21 Oct 2021 19:38:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD917163E8F;
        Thu, 21 Oct 2021 19:38:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] status: count stash entries in separate function
References: <20211021222532.463375-1-oystwa@gmail.com>
        <20211021222532.463375-2-oystwa@gmail.com>
Date:   Thu, 21 Oct 2021 16:38:11 -0700
In-Reply-To: <20211021222532.463375-2-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Fri, 22 Oct 2021 00:25:31 +0200")
Message-ID: <xmqq5ytqgd98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4CC2F9A-32C7-11EC-B133-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Make the counting of stash entries contained in one simple function as
> it will be used in the next commit.
>
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
>  wt-status.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index e4f29b2b4c..97230477b2 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -948,11 +948,17 @@ static int stash_count_refs(struct object_id *ooi=
d, struct object_id *noid,
>  	return 0;
>  }
> =20
> +static int count_stash_entries()

Probably "static int count_stash_entries(void)" was what was meant
here.

> +{
> +	int n =3D 0;

Have a blank line between the block of decls at the beginning of the
function and the first statement.

> +	for_each_reflog_ent("refs/stash", stash_count_refs, &n);
> +	return n;
> +}

I briefly wondered if this want to be size_t or some other unsigned
integral type, but this is merely refactoring the existing code, so
it is not just OK but is correct to use the same "int" as before.

>  static void wt_longstatus_print_stash_summary(struct wt_status *s)
>  {
> -	int stash_count =3D 0;
> +	int stash_count =3D count_stash_entries();
> =20
> -	for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);
>  	if (stash_count > 0)
>  		status_printf_ln(s, GIT_COLOR_NORMAL,
>  				 Q_("Your stash currently has %d entry",

OK.
