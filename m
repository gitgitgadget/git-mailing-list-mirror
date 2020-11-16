Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305FAC388F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3DF2225B
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 22:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="peqM9leM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgKPV77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 16:59:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62213 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgKPV77 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 16:59:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AAFC96E7A;
        Mon, 16 Nov 2020 16:59:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JF84IlqaBl+s
        XjpbDeOKplevteo=; b=peqM9leMXURxgNE/fMCgJdyipWqEfNyQR3vCWhwBkDAB
        qmtxZvrsT8mpRKHDgiBxWi4smGf65JJtB46WjtHg0uoJWhzxpbwX6yq5sqn4Zm6S
        pxUbOb51y81BCA59lw5gY9SC0jywsTTPVAmhMwI+eB93Okv1cP3Pgv1aIQTyKf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wKcmwe
        g9tNMSEZazTh9DH8+Jsgl2/y6SqMT2z55Z+pBttqcLkRNkDvVsITMoBz0NQd6oJz
        V3qruQ/sj+F6W88RyKjM7QdxVk1hazKsfqnJS5tTgNAd/EyphRMlMmZgU4K9dBBz
        MM6cWzRZHb4I9WqgzFsXknQydsJDqNhknPxVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 831FA96E79;
        Mon, 16 Nov 2020 16:59:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E05A96E76;
        Mon, 16 Nov 2020 16:59:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] chdir-notify: UNLEAK registrated callback entries
References: <8a9cf9ba-f615-3ff5-8d35-c24c22d5d859@web.de>
        <58f36a04-afa7-3cf3-ce0a-ad53004dd774@web.de>
Date:   Mon, 16 Nov 2020 13:59:54 -0800
In-Reply-To: <58f36a04-afa7-3cf3-ce0a-ad53004dd774@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 14 Nov 2020 22:53:04 +0100")
Message-ID: <xmqqzh3h6jz9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F68DAC8-2857-11EB-9E40-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Right, avoiding list.h like below lets Valgrind classify the memory as
> "still reachable", without UNLEAK.  Not sure if it's worth it, though.
>
> Note my somewhat concerning knee-jerk reaction to write some macros. ;)

We have used such 3-tuple of <vector, alloc, nr> in many places from
very early time, and these macros might be worth using if we were to
rewrite all of them.

As to this particular instance, given that the entries is either a
list or a vector of at most one element in practice, I do not think
it matters very much either way.  Just a single UNLEAK is certainly
simpler ;-)

Thanks.




>  struct chdir_notify_entry {
>  	const char *name;
>  	chdir_notify_callback cb;
>  	void *data;
> -	struct list_head list;
>  };
> -static LIST_HEAD(chdir_notify_entries);
> +
> +#define VECTOR_TYPE(elemtype) struct { elemtype *v; size_t alloc, nr; =
}
> +#define VECTOR_FOR_EACH(x, p) for (p =3D (x)->v; p < (x)->v + (x)->nr;=
 p++)
> +#define VECTOR_NEW_ENTRY(x, p) do {			\
> +	ALLOC_GROW_BY((x)->v, (x)->nr, 1, (x)->alloc);	\
> +	p =3D (x)->v + (x)->nr - 1;			\
> +} while (0)
> +
> +static VECTOR_TYPE(struct chdir_notify_entry) chdir_notify_entries;
>
>  void chdir_notify_register(const char *name,
>  			   chdir_notify_callback cb,
>  			   void *data)
>  {
> -	struct chdir_notify_entry *e =3D xmalloc(sizeof(*e));
> -	UNLEAK(e);
> +	struct chdir_notify_entry *e;
> +
> +	VECTOR_NEW_ENTRY(&chdir_notify_entries, e);
>  	e->name =3D name;
>  	e->cb =3D cb;
>  	e->data =3D data;
> -	list_add_tail(&e->list, &chdir_notify_entries);
>  }
>
>  static void reparent_cb(const char *name,
> @@ -52,7 +58,7 @@ void chdir_notify_reparent(const char *name, char **p=
ath)
>  int chdir_notify(const char *new_cwd)
>  {
>  	struct strbuf old_cwd =3D STRBUF_INIT;
> -	struct list_head *pos;
> +	struct chdir_notify_entry *e;
>
>  	if (strbuf_getcwd(&old_cwd) < 0)
>  		return -1;
> @@ -67,11 +73,8 @@ int chdir_notify(const char *new_cwd)
>  			 "setup: chdir from '%s' to '%s'",
>  			 old_cwd.buf, new_cwd);
>
> -	list_for_each(pos, &chdir_notify_entries) {
> -		struct chdir_notify_entry *e =3D
> -			list_entry(pos, struct chdir_notify_entry, list);
> +	VECTOR_FOR_EACH(&chdir_notify_entries, e)
>  		e->cb(e->name, old_cwd.buf, new_cwd, e->data);
> -	}
>
>  	strbuf_release(&old_cwd);
>  	return 0;
> --
> 2.29.2
