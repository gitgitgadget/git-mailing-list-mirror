Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942D19B3FF
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778041; cv=none; b=MLJYWjjySoJExO/qsHV2XSjVW7dfoeNj0++zEB2v44gJqq9mUwHJbQZISufs0QSS73a+9ZsFTIg0LABK8CSu99WOgRe4Ke3gsmzNqKsfQjdOKYvWG1LgXgRji0pzrWXh94q/Ow9TTpDxJp1ZiYuSb59Qlwt9sRp7Y2LDO3vkyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778041; c=relaxed/simple;
	bh=DgMxj0+ubNwut3mgnDyqd7nJRKC73+25yfoBI+nJFIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNLjCtz9VdtJ3yO/o6urZLKRBTNTgu8BemTviCvbxnMdmn2G0aKTPnG8V/JYMwbNDlOrxKt55YeJb7QwQ/H6Vz9fM2WI97bTKpjIB64l7JQSj5Cnc7LJyA0+0/rQXZi0CWKqkCh6PH6EF+TnN9HQiiB+unmgDPCzFgkV8+FpBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mYOgISq1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mYOgISq1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 72D8E37689;
	Fri,  7 Jun 2024 12:33:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DgMxj0+ubNwut3mgnDyqd7nJRKC73+25yfoBI+
	nJFIU=; b=mYOgISq1Jsea1A049mDZCHs27Ecr+L15nyBWRyAnS+zWwL0PIwcgIX
	NybrrLvcMNVDGE7YzeoHwxxELyw28OLeMgtuHxle/y2m7l9173NAdimLBuwWPJSQ
	m+0csiakdgC7atq+wbyPYGy9mHwimDbLsRifMk7xFqc/Bdw9RlhV4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A78637688;
	Fri,  7 Jun 2024 12:33:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D004437687;
	Fri,  7 Jun 2024 12:33:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 1/2] commit-graph.c: remove temporary graph layers on exit
In-Reply-To: <25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 6 Jun 2024 18:19:25 -0400")
References: <cover.1717712358.git.me@ttaylorr.com>
	<25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>
Date: Fri, 07 Jun 2024 09:33:56 -0700
Message-ID: <xmqqa5jwg1aj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD01CB9C-24EB-11EF-A9B1-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> @@ -2133,8 +2132,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  		char *final_graph_name;
>  		int result;
>  
> -		close(fd);
> -
>  		if (!chainf) {
>  			error(_("unable to open commit-graph chain file"));
>  			return -1;
> @@ -2169,7 +2166,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
>  		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
>  
> -		result = rename(ctx->graph_name, final_graph_name);
> +		result = rename_tempfile(&graph_layer, final_graph_name);

Before this rename, after the close(fd) we saw in the previous hunk,
there is one early error return when we fail to rename the base
graph file.  Do we need to do anything there, or an unfinished
tempfile getting removed at the process termination is sufficient
for cleaning up the mess?

Other than that, this looked quite straight-forward.

Thanks.

