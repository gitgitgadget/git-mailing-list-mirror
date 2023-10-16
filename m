Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7130FA2
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VJFrXFbX"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F645AC
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 15:55:52 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F309B1AF282;
	Mon, 16 Oct 2023 18:55:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8FWQk6IVYs6cwed+yLNcwpR7xlRCTDlfY+EnhM
	oa8Ks=; b=VJFrXFbX5aXROiK9OnZUYxcv82xqxP33HBdFHDKjJNdkSwHLip7Ktf
	4gxX2XD6NWKeEwufDp5hNjQfAdSfPwKUYHPagjXadmIJRmg4Xni0ywQTeQjU3T9i
	T80q/Pnyo93FO7YRKk/5gPCokdi60XNsUYbapAOMWFPOP5bIrDqZI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E6B861AF281;
	Mon, 16 Oct 2023 18:55:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 562D91AF280;
	Mon, 16 Oct 2023 18:55:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bugreport: include +i in outfile suffix as needed
In-Reply-To: <20231016214045.146862-2-jacob@initialcommit.io> (Jacob Stopak's
	message of "Mon, 16 Oct 2023 14:40:45 -0700")
References: <20231015034238.100675-2-jacob@initialcommit.io>
	<20231016214045.146862-1-jacob@initialcommit.io>
	<20231016214045.146862-2-jacob@initialcommit.io>
Date: Mon, 16 Oct 2023 15:55:50 -0700
Message-ID: <xmqq4jiqkwi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2770C09C-6C77-11EE-B934-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jacob Stopak <jacob@initialcommit.io> writes:

>  builtin/bugreport.c | 83 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 26 deletions(-)

Looking good.  It is not easy to do an automated and reliable test
for this one for obvious reasons ;-), so let's queue it as-is.

Thanks.

> -	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
> -	report = xopen(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> +	again:
> +		/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
> +		report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> +		if (report < 0 && errno == EEXIST && !option_suffix_is_from_user) {
> +			build_path(&report_path, prefixed_filename,
> +				   "git-bugreport-", option_suffix, now, &i,
> +				   ".txt");
> +			goto again;
> +		} else if (report < 0) {
> +			die_errno(_("unable to open '%s'"), report_path.buf);
> +		}

I didn't expect a rewrite to add an extra level of indentation like
this, though ;-).
