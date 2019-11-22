Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CC8C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 02:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA1E206D7
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 02:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CB2RdOqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVCpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:45:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62405 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKVCpS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 21:45:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B3273877E;
        Thu, 21 Nov 2019 21:45:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+80Jp2KPlUJW3TWKLTD38euAlVg=; b=CB2RdO
        quhIclk/3RFClAoZvdIJZduAQVxi+Q0xgj5QprWGTvLx3v9vuJiPIqrIEDt69yJ0
        R0eXbfBLXBXS4breLH/HPt++1d/sk3vLNYRu2D0Uk3d9ndhhQyMZZaJ+xmna3OL8
        +oFqFDF2QSZMZiHM3LwwbxEFpIKhRmQMBo0JY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HJWc8y8kseB8I4GEOeka/U4fA37Ta1Ge
        YsivrlI7nJ1FA2ef9oFPKwU5d4/YmqzQmMd+WrGVxl/umMvAeQEMtza2xXpqqTNu
        GQ1klfPje2hajZuu7q/lkOtuJm5P2812qrnWbez1tTMgj2mPARtxmHSC5Yx100DX
        Vh3NQDGKkcI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 736793877D;
        Thu, 21 Nov 2019 21:45:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D61F53877C;
        Thu, 21 Nov 2019 21:45:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] gpg-interface: refactor the free-and-xmemdupz pattern
References: <20191116215850.3919-1-hji@dyntopia.com>
        <20191121234336.26300-1-hji@dyntopia.com>
        <20191121234336.26300-2-hji@dyntopia.com>
Date:   Fri, 22 Nov 2019 11:45:13 +0900
In-Reply-To: <20191121234336.26300-2-hji@dyntopia.com> (Hans Jerry
        Illikainen's message of "Thu, 21 Nov 2019 23:43:35 +0000")
Message-ID: <xmqqo8x47hom.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D174E26-0CD2-11EA-9AC0-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> This commit introduces a static replace_cstring() function.  This
> function simplifies the continuous pattern of free-and-xmemdupz() for
> GPG status line parsing.
>
> The benefit of having it in a single helper function is that it helps
> avoid the need for duplicate code that does the same thing.  It also
> helps avoid potential memleaks if parsing of new status lines are
> introduced in the future.
>
> Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
> ---
>  gpg-interface.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Looks quite cleanly done and clearly explained.  Thanks.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index d60115ca40..b4c4443287 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -105,6 +105,17 @@ static struct {
>  	{ 0, "VALIDSIG ", GPG_STATUS_FINGERPRINT },
>  };
>  
> +static void replace_cstring(const char **field, const char *line,
> +			    const char *next)
> +{
> +	free(*field);
> +
> +	if (line && next)
> +		*field = xmemdupz(line, next - line);
> +	else
> +		*field = NULL;
> +}
> +
>  static void parse_gpg_output(struct signature_check *sigc)
>  {
>  	const char *buf = sigc->gpg_status;
> @@ -136,21 +147,18 @@ static void parse_gpg_output(struct signature_check *sigc)
>  				/* Do we have key information? */
>  				if (sigcheck_gpg_status[i].flags & GPG_STATUS_KEYID) {
>  					next = strchrnul(line, ' ');
> -					free(sigc->key);
> -					sigc->key = xmemdupz(line, next - line);
> +					replace_cstring(&sigc->key, line, next);
>  					/* Do we have signer information? */
>  					if (*next && (sigcheck_gpg_status[i].flags & GPG_STATUS_UID)) {
>  						line = next + 1;
>  						next = strchrnul(line, '\n');
> -						free(sigc->signer);
> -						sigc->signer = xmemdupz(line, next - line);
> +						replace_cstring(&sigc->signer, line, next);
>  					}
>  				}
>  				/* Do we have fingerprint? */
>  				if (sigcheck_gpg_status[i].flags & GPG_STATUS_FINGERPRINT) {
>  					next = strchrnul(line, ' ');
> -					free(sigc->fingerprint);
> -					sigc->fingerprint = xmemdupz(line, next - line);
> +					replace_cstring(&sigc->fingerprint, line, next);
>  
>  					/* Skip interim fields */
>  					for (j = 9; j > 0; j--) {
> @@ -162,7 +170,8 @@ static void parse_gpg_output(struct signature_check *sigc)
>  
>  					next = strchrnul(line, '\n');
>  					free(sigc->primary_key_fingerprint);
> -					sigc->primary_key_fingerprint = xmemdupz(line, next - line);
> +					replace_cstring(&sigc->primary_key_fingerprint,
> +							line, next);
>  				}
>  
>  				break;
