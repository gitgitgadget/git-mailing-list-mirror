Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DE91534E7
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801008; cv=none; b=TrIIPSHeSVhBPNYtQl03tI0ihhAr2lNQsbI/sPo3myJzUWmoxS/zIyBHomSLySC0czsv3lCDot4nlz3sc3okLVJ72eSJn71xjqsndOSYmE8QShRIi8SK4L0SJvOkImMdgUaTfJbOoPUqXnmsK5AiEzb6MmHFVG5R3WFg4Swwb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801008; c=relaxed/simple;
	bh=bDRJ4QhBeEyi2h4BYFrSuqMEynWhpX2NjWjwYAXPAjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XvvpsenhSeqVFG7e3ujK2pMl6jJR1qv/n28DR3vVAk8BUkn+ESw98QgcPYQsnJ5omozYm4udIZ5E6/fkrpNWBu16ADQB20tCs1QAqul5w83D8wVFeQP4Ka9pNdzCu6hXu/er+POyCN4kaY11App8uYvbC3ow+l7fHkQnSSEAyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u8MXYYd9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u8MXYYd9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 336F41E9F05;
	Mon, 22 Apr 2024 11:50:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bDRJ4QhBeEyi
	2h4BYFrSuqMEynWhpX2NjWjwYAXPAjU=; b=u8MXYYd9GrNg/OOhHRYuoE+hW/Z1
	sp3R25ITaVfQ1qu0B6iYcec+thBwYjpujXveSzmjgfaFGdOn2Ys+zmMfmqwcfa05
	tWIfwPDEvt4RxAdeyr/CD+NPKd9Jig2RjRyM3mmLHntQJoqakhHM3VVCT6di+ifa
	IMnUcS/x2ECaimo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA6F11E9F03;
	Mon, 22 Apr 2024 11:50:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8F311E9F01;
	Mon, 22 Apr 2024 11:50:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] add-interactive: plug a leak in get_untracked_files
In-Reply-To: <88b119aa-c1c2-435a-baaa-9422388bf0ec@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 21 Apr 2024 12:27:06 +0200")
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
	<88b119aa-c1c2-435a-baaa-9422388bf0ec@gmail.com>
Date: Mon, 22 Apr 2024 08:50:01 -0700
Message-ID: <xmqqwmopxuqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 FB685B58-00BF-11EF-863E-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Plug a leak we have since ab1e1cccaf (built-in add -i: re-implement
> `add-untracked` in C, 2019-11-29).
>
> This leak can be triggered with:
>
> 	$ echo a | git add -i
>
> As a curiosity, we have a somewhat similar function in builtin/stash.c,
> which correctly frees the memory.

Yup,=20

    $ git grep -W -e fill_directory -e dir_clear -e setup_standard_exclud=
es \*.c

makes an interesting read ;-)

The fix looks good.  Thanks.

> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>  add-interactive.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/add-interactive.c b/add-interactive.c
> index 6bf87e7ae7..e17602b5e4 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -865,6 +865,7 @@ static int get_untracked_files(struct repository *r=
,
>  	}
> =20
>  	strbuf_release(&buf);
> +	dir_clear(&dir);
>  	return 0;
>  }
