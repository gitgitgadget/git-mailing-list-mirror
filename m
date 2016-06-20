Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BBA21FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbcFTTbP (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:31:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753019AbcFTTbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:31:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0246E269C0;
	Mon, 20 Jun 2016 14:57:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sZZefqjjKOloiims6FX6Ev69gTs=; b=jeDsTc
	46i31d3jKW1jgQXtMm1fX/Wli0UytoIP0+YbxvSsmTwPKWUMSPu4heMu4FLMQEa2
	lK3TWQdVFYPoFEDaDS6KFt/LX3NNse+BLgS4afEvZEhGvLbYaLP8UDFZzFpC0+eC
	mCdj3d2xZXsGdHpZNiaWAT5ea+OuJdc25Vjms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NnFryhy1fdJY904T9zlgnp1HxfsGUgvE
	CDNF1VlTY6X2g399TUw/9q4XwqRFioCD2XBrU8AyjHFWdXX3dlOs0iAHBUKlkYej
	LDvAH3obmZR+ip/mqrgaWuVPVaxeeScoBv0Kdtz5/vPkGlBy10/O+BT/IC53LB5P
	Kh4qKPHNMJU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF0D7269BF;
	Mon, 20 Jun 2016 14:57:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 74AFD269BE;
	Mon, 20 Jun 2016 14:57:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 7/7] format-patch: use stdout directly
References: <cover.1466244194.git.johannes.schindelin@gmx.de>
	<cover.1466420060.git.johannes.schindelin@gmx.de>
	<d486373d9eb2bd248a80b6be7061b56db2f148aa.1466420060.git.johannes.schindelin@gmx.de>
Date:	Mon, 20 Jun 2016 11:57:01 -0700
In-Reply-To: <d486373d9eb2bd248a80b6be7061b56db2f148aa.1466420060.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 20 Jun 2016 12:56:01 +0200
	(CEST)")
Message-ID: <xmqqshw7u1s2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6C4641A-3718-11E6-84C7-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Earlier, we freopen()ed stdout in order to write patches to files.
> That forced us to duplicate stdout (naming it "realstdout") because we
> *still* wanted to be able to report the file names.
>
> As we do not abuse stdout that way anymore, we no longer need to
> duplicate stdout, either.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/log.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Overall, it was a pleasant read, modulo some details that I
mentioned separately elsewhere, i.e.

 - we do not need to lose flush-or-die
 - we do not need to lose --color=always
 - we do not need to lose macro-ness of putchar()

Thanks.

>
> diff --git a/builtin/log.c b/builtin/log.c
> index db034a8..5a889d5 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -796,7 +796,6 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  	return git_log_config(var, value, cb);
>  }
>  
> -static FILE *realstdout = NULL;
>  static const char *output_directory = NULL;
>  static int outdir_offset;
>  
> @@ -822,7 +821,7 @@ static int open_next_file(struct commit *commit, const char *subject,
>  		fmt_output_subject(&filename, subject, rev);
>  
>  	if (!quiet)
> -		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
> +		printf("%s\n", filename.buf + outdir_offset);
>  
>  	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
>  		return error(_("Cannot open patch file %s"), filename.buf);
> @@ -1629,9 +1628,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		get_patch_ids(&rev, &ids);
>  	}
>  
> -	if (!use_stdout)
> -		realstdout = xfdopen(xdup(1), "w");
> -
>  	if (prepare_revision_walk(&rev))
>  		die(_("revision walk setup failed"));
>  	rev.boundary = 1;
