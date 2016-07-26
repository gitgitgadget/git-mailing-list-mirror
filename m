Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23445203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbcGZT2l (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 15:28:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756768AbcGZT2j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 15:28:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 840102F802;
	Tue, 26 Jul 2016 15:28:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7pfgoUosWUaV4Y0W0AUSpsMyiuA=; b=yPPfYN
	waKta4BrlyIyb7e88pU+qZnVqbsUJvcmXVPxX4fJJouE4PdbYxAHwrZH5BD+U9aJ
	Jx23ySkSEA2wMBeDJbVGDe1T+P/ZlPuDgyTH5oz+KYImEwshoF8q94h1a7hBaLEb
	f40vN0GSTwTT5f+0O6vdME+/S1241ho+Q8ZQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oErS6IvV72xJQD+ahGEV8O050tW4p7NP
	sxSglMLXPlmLxNViaioSY9YOGxJtpyvIQv3YvBsv9EZsotKazut+naDVkmackT5P
	c2ye2tYixCSYtYfS09FauupM6JVDB9XFUPZp+D2d8r3VnWkRXYQ56du116Nyt/uf
	uhxfkZSyyBU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B58D2F801;
	Tue, 26 Jul 2016 15:28:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0054C2F800;
	Tue, 26 Jul 2016 15:28:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 32/41] environment: add set_index_file()
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
	<20160627182429.31550-33-chriscool@tuxfamily.org>
Date:	Tue, 26 Jul 2016 12:28:35 -0700
In-Reply-To: <20160627182429.31550-33-chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 27 Jun 2016 20:24:20 +0200")
Message-ID: <xmqqinvs19ng.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26E730BA-5367-11E6-8F91-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Introduce set_index_file() to be able to temporarily change the index file.
>
> It should be used like this:
>
>     /* Save current index file */
>     old_index_file = get_index_file();
>     set_index_file((char *)tmp_index_file);
>
>     /* Do stuff that will use tmp_index_file as the index file */
>     ...
>
>     /* When finished reset the index file */
>     set_index_file(old_index_file);

WHY is glaringly missing.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Doesn't calling this have a global effect that is flowned upon when
used by a library-ish function?  Who is the expected caller in this
series that wants to "libify" a part of the system?

>  cache.h       |  1 +
>  environment.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index c73becb..8854365 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -461,6 +461,7 @@ extern int is_inside_work_tree(void);
>  extern const char *get_git_dir(void);
>  extern const char *get_git_common_dir(void);
>  extern char *get_object_directory(void);
> +extern void set_index_file(char *index_file);
>  extern char *get_index_file(void);
>  extern char *get_graft_file(void);
>  extern int set_git_dir(const char *path);
> diff --git a/environment.c b/environment.c
> index ca72464..7a53799 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -292,6 +292,16 @@ int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
>  	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
>  }
>  
> +/*
> + * Temporarily change the index file.
> + * Please save the current index file using get_index_file() before changing
> + * the index file. And when finished, reset it to the saved value.
> + */
> +void set_index_file(char *index_file)
> +{
> +	git_index_file = index_file;
> +}
> +
>  char *get_index_file(void)
>  {
>  	if (!git_index_file)
