Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7384F8A6
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BgvA+/93"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 591B118CF6;
	Tue, 26 Dec 2023 12:35:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tJcItxSbnbg4xXDxewhU5m8bX5t+CJMwX81UGi
	SoYbs=; b=BgvA+/936nRTMr5IdO1Iy7k2vYJ5jkQjYTmlJP9YG1aYit/mC+OrEv
	N7EAcvEYkKUvNkRI09Gvok4ZhenxsG9uvYWDgpmC9gN0UDOzQMcdxOdQ33eTSSYo
	EgnAeAGac2FXZMYrnjxdViVKMJ3rl5XKqXjD2nTWLL5KJDlN5QIXY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 52C6018CF5;
	Tue, 26 Dec 2023 12:35:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EEDD718CF3;
	Tue, 26 Dec 2023 12:35:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Chandra
 Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] Teach git apply to respect core.fileMode settings
In-Reply-To: <82dadb69-5016-dec6-3699-4d994ea7929d@gmx.de> (Johannes
	Schindelin's message of "Sun, 24 Dec 2023 14:42:48 +0100 (CET)")
References: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
	<pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
	<82dadb69-5016-dec6-3699-4d994ea7929d@gmx.de>
Date: Tue, 26 Dec 2023 09:35:24 -0800
Message-ID: <xmqq4jg4j28z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 278E051E-A415-11EE-83A2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I noticed a CI breakage in t2106.3 in `seen` that seems to be caused by
> this, and I can make it go away with this patch:
>
> -- snip --
> From 5c2a709b629d396528dabe2f92bf3d4deb5bbdb2 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Sun, 24 Dec 2023 14:01:49 +0100
> Subject: [PATCH] fixup! Teach git apply to respect core.fileMode settings
>
> As pointed out e.g. by t2016.3(git checkout -p), if the patch is to be
> applied in reverse (`git apply -R`), then the `old_mode` is actually 0,
> and we must use `new_mode` instead.

Good finding.


> While at it, add some defensive code to ignore `ce_mode` should it be 0.

Is it defensive or is it hiding a problematic index under the rug?

If there is an index entry whose ce_mode is 0, I suspect we would
want to error out with a BUG(), unless it is an intent-to-add entry.

Shouldn't it cause an error to apply a patch that mucks with
"newfile" after you did

	$ git add -N newfile

If we allow ce_mode==0 to be propagated to st_mode, I suspect we
will catch such a case with the "mode is different" warning code, at
least.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  apply.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index 58f26c404136..5ad06ef2f843 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3780,7 +3780,9 @@ static int check_preimage(struct apply_state *state,
>
>  	if (!state->cached && !previous) {
>  		if (!trust_executable_bit)
> -			st_mode = *ce ? (*ce)->ce_mode : patch->old_mode;
> +			st_mode = *ce && (*ce)->ce_mode ? (*ce)->ce_mode :
> +				(state->apply_in_reverse ?
> +				 patch->new_mode : patch->old_mode);
>  		else
>  			st_mode = ce_mode_from_stat(*ce, st->st_mode);
>  	}
> -- snap --
>
> I guess you can slap on that `Reviewed-by:` footer again, after all... ;-)

Yup, Reviewed-by: is what the reviewer says "this version was
reviewed by me and I found it satisfactory", so once you said the
above, I can certainly do so.

