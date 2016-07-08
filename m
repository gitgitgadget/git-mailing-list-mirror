Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7ED42070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666AbcGHRC7 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:02:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755307AbcGHRC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 13:02:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5005B27C2B;
	Fri,  8 Jul 2016 13:02:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/W1STYmGv2Cj0FR5NkkeZCM46Q=; b=rejqXe
	Ap6mshhA5eQsYL2sX6tBHCrFDejUYcsEWyD62XIdm+fLcb1HJG6T1gMiBP2JpHEW
	np6EHVR80LASRl+A3dgC3K5bNENsuqzct8Py6GdvQ1hZ6aw0sG+s6uWAXY6QzUP9
	PFFVBuh1I+3h3iUnE/UnnxQsiMeDBB3u9/nGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E6Uc1enLvfFinUD0TFedIVNQym6CpwgB
	3uU04uSeHWjBRUOgSeizdKDVUnabT59K1o3d+Bl/M/GarApMJSVRNCRajSb6OO3k
	gWGH17kZ8LRdE+tZF8QfFg5gsgQ6VPgrK/D6TlBYCKrOaDszrlptnsQH/H2BII+X
	3Wpmvd6Ca/g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 485B327C26;
	Fri,  8 Jul 2016 13:02:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8ADB27C24;
	Fri,  8 Jul 2016 13:02:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] avoid using sha1_to_hex output as printf format
References: <20160708092510.GB17072@sigill.intra.peff.net>
	<20160708092526.GB18263@sigill.intra.peff.net>
	<20160708103515.GA19705@sigill.intra.peff.net>
Date:	Fri, 08 Jul 2016 10:02:53 -0700
In-Reply-To: <20160708103515.GA19705@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 8 Jul 2016 06:35:15 -0400")
Message-ID: <xmqqinwgm5aa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0AF02A0-452D-11E6-8D41-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jul 08, 2016 at 05:25:26AM -0400, Jeff King wrote:
>
>> diff --git a/commit.c b/commit.c
>> index 3f4f371..9603379 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -1623,7 +1623,7 @@ void print_commit_list(struct commit_list *list,
>>  {
>>  	for ( ; list; list = list->next) {
>>  		const char *format = list->next ? format_cur : format_last;
>> -		printf(format, oid_to_hex(&list->item->object.oid));
>> +		printf(format, "%s", oid_to_hex(&list->item->object.oid));
>
> Urgh, this second hunk is clearly bogus. This is a -Wformat-nonliteral
> problem, but not because of oid_to_hex(), but rather because of
> "format". :-/
>
> Here's a corrected patch. But as this has demonstrated the dangers of
> churn, and as it doesn't really get us meaningfully closer to being able
> to use -Wformat-nonliteral, perhaps the best course of action is to just
> drop it (I do think the "walker_say" patch has more inherent value as a
> cleanup, though).

Hmm.  While both do look correct, and it is a no-brainer to take
this (corrected) patch, I am not sure how much we care about walkers
these days.

As to the hunk to commit.c that was dropped in this round, the only
caller of print_commit_list() is bisect.c, and it passes "%s\n" to
format_cur and format_last, it seems, so that suggests a more
obvious direction for cleaning things up, I would say.

> -- >8 --
> Subject: [PATCH] avoid using sha1_to_hex output as printf format
>
> We know that it should not contain any percent-signs, but
> it's a good habit not to feed non-literals to printf
> formatters.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index e866844..cce555c 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -262,7 +262,7 @@ static int add_worktree(const char *path, const char *refname,
>  	 */
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
> -	write_file(sb.buf, sha1_to_hex(null_sha1));
> +	write_file(sb.buf, "%s", sha1_to_hex(null_sha1));
>  	strbuf_reset(&sb);
>  	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>  	write_file(sb.buf, "../..");
