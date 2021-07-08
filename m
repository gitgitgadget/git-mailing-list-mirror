Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937B7C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 04:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC5A61C40
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 04:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhGHFAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 01:00:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57809 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhGHFAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 01:00:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46ABC138EA6;
        Thu,  8 Jul 2021 00:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=isFRuaphtuGjnqx5CZgUKsmPW1cZtOcGs88ExX
        lfXRM=; b=IjV0U0P2o4BNXDuqdL+5buC6thnsGf7R+m/zzA7DArho7Ju8rdvOGl
        P9eHt+4wp0eMMQBcuiwfpu16ks9+4oT6FO9I7ATb0pgEEDUJ6zsZhLjSNT4PcvLm
        aCAmEwtGh9LcaTaKqEDz+FRaUXhyBy+XecEjWddIvuNLPrfKy4baw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32F46138EA4;
        Thu,  8 Jul 2021 00:58:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 71BE0138EA2;
        Thu,  8 Jul 2021 00:57:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 2/5] avoid strlen via strbuf_addstr in
 link_alt_odb_entry
References: <20210629205305.7100-1-e@80x24.org>
        <20210707231019.14738-3-e@80x24.org>
Date:   Wed, 07 Jul 2021 21:57:57 -0700
In-Reply-To: <20210707231019.14738-3-e@80x24.org> (Eric Wong's message of
        "Wed, 7 Jul 2021 23:10:16 +0000")
Message-ID: <xmqqwnq1bdwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 112186C6-DFA9-11EB-BC77-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> We can save a few milliseconds (across 100K odbs) by using
> strbuf_addbuf() instead of strbuf_addstr() by passing `entry' as
> a strbuf pointer rather than a "const char *".

OK; trivially corect ;-)

>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  object-file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index a13f49b192..2dd70ddf3a 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -567,18 +567,18 @@ static int alt_odb_usable(struct raw_object_store *o,
>  static void read_info_alternates(struct repository *r,
>  				 const char *relative_base,
>  				 int depth);
> -static int link_alt_odb_entry(struct repository *r, const char *entry,
> +static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
>  	const char *relative_base, int depth, const char *normalized_objdir)
>  {
>  	struct object_directory *ent;
>  	struct strbuf pathbuf = STRBUF_INIT;
>  	khiter_t pos;
>  
> -	if (!is_absolute_path(entry) && relative_base) {
> +	if (!is_absolute_path(entry->buf) && relative_base) {
>  		strbuf_realpath(&pathbuf, relative_base, 1);
>  		strbuf_addch(&pathbuf, '/');
>  	}
> -	strbuf_addstr(&pathbuf, entry);
> +	strbuf_addbuf(&pathbuf, entry);
>  
>  	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
>  		error(_("unable to normalize alternate object path: %s"),
> @@ -669,7 +669,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
>  		alt = parse_alt_odb_entry(alt, sep, &entry);
>  		if (!entry.len)
>  			continue;
> -		link_alt_odb_entry(r, entry.buf,
> +		link_alt_odb_entry(r, &entry,
>  				   relative_base, depth, objdirbuf.buf);
>  	}
>  	strbuf_release(&entry);
