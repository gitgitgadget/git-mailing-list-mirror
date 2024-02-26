Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3F1E894
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991687; cv=none; b=mXV5fLvhNm74ZqvtyF42Zpt+8BLoNwY01umJCxEQfx+RFXG/JnpadiR9K5BHjBtwJdvfVUJKig/YkL+L9xA9T756GKMGhrcyChvhuR4jz48pf2dwboICRubOQdqxhk11Q/sFyjR2TtsFIrEYYAaUVULyPVyTF3a/BzRs0n3LBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991687; c=relaxed/simple;
	bh=wAlRJj1iLIjvIwfKujwl4P/2Rig14XmVADmaPZYUA1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kEKIwmihjaLC524nlYUftlpcRPZWSliXFmPCjF0OhQevWc8qX5aPlmFjczt/VgSyKZquAhluMhrlIBTrhbswd+Siz97JSVZ614q0AUugeugCxMVjIf5HGosaazLc8WY3n0wzMW8JrUURbxO2QGEkMnZd2rLiDjpxV+a8UFHTNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LDb29Ze2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LDb29Ze2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DA8C1D59E8;
	Mon, 26 Feb 2024 18:54:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wAlRJj1iLIjvIwfKujwl4P/2Rig14XmVADmaPZ
	YUA1Y=; b=LDb29Ze2ClK8n9SAF+1EoG67FdZDQWpiIg4G1Mz74Vv+Zf1DLfGckR
	tZUIPHwW9OBbBu5dGbSZ6uimnvRzO18nNxkmhWKeahrFvxXleOUKcZNN40cuDvsd
	PoBzkLxHdu16QLZh5h/+rmeDi7IaCA9R/QbtVL0Rc7Kh9qREI9HAE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 554E51D59E7;
	Mon, 26 Feb 2024 18:54:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7BEF1D59E5;
	Mon, 26 Feb 2024 18:54:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v1 3/4] builtin/repack.c: change xwrite to write_in_full
 to allow large sizes.
In-Reply-To: <20240226220539.3494-4-randall.becker@nexbridge.ca> (Randall
	S. Becker's message of "Mon, 26 Feb 2024 17:05:37 -0500")
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
	<20240226220539.3494-4-randall.becker@nexbridge.ca>
Date: Mon, 26 Feb 2024 15:54:42 -0800
Message-ID: <xmqqwmqqixx9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 69DB5944-D502-11EE-AF3E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Randall S. Becker" <the.n.e.key@gmail.com> writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This change is required because some platforms do not support file writes of
> arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
> maximum single I/O size possible for the destination device. The result of
> write_in_full() is also passed to the caller, which was previously ignored.

This one smells more like a theoretical issue than realistic, in
that these writes are done only with .hexsz (either 40 or 64) bytes
oid string, or a single byte "\n", for either of which it is hard to
imagine that it is even remotely close to platform "maximum single
I/O size".

But we'd need to look for the error return anyway, so switching to
write_in_full() while we are doing so is also good.

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  builtin/repack.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index ede36328a3..932d24c60b 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -307,6 +307,7 @@ static int write_oid(const struct object_id *oid,
>  		     struct packed_git *pack UNUSED,
>  		     uint32_t pos UNUSED, void *data)
>  {
> +	int err;
>  	struct child_process *cmd = data;
>  
>  	if (cmd->in == -1) {
> @@ -314,8 +315,12 @@ static int write_oid(const struct object_id *oid,
>  			die(_("could not start pack-objects to repack promisor objects"));
>  	}
>  
> -	xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
> -	xwrite(cmd->in, "\n", 1);
> +	err = write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
> +	if (err <= 0)
> +		return err;
> +	err = write_in_full(cmd->in, "\n", 1);
> +	if (err <= 0)
> +		return err;
>  	return 0;
>  }
