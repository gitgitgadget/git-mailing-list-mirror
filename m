Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1E1FAA
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GZEcJfGC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19FC81D8856;
	Sun, 14 Jan 2024 20:13:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mBz4QktZ2dJOFNc3Io0rktDqcol7G7TxSdWnBG
	2gzcM=; b=GZEcJfGCtPd9EDGK3k1fDLWfyI4UArMWQvof1UxuPI9lU+TXOCL2+O
	3eXHgA6wvPRPqHGw/SvLDO6YkyzPeWx0IZnirxskuv3tfQBG/TnqtSoEJyqyTMgN
	XAFtW22FAeWemv9pZmiizYjH3TwkBlzV87KyzxEWXeUJDlQ8gE+zQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 120C81D8855;
	Sun, 14 Jan 2024 20:13:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E2021D8854;
	Sun, 14 Jan 2024 20:13:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Nikolay
 Edigaryev <edigaryev@gmail.com>
Subject: Re: [PATCH] clone: support cloning of filtered bundles
In-Reply-To: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com> (Nikolay
	Edigaryev via GitGitGadget's message of "Sun, 14 Jan 2024 11:16:49
	+0000")
References: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
Date: Sun, 14 Jan 2024 17:13:42 -0800
Message-ID: <xmqqcyu35rg9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53365BD4-B343-11EE-A6B9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Nikolay Edigaryev via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index c6357af9498..4b3fedf78ed 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1227,9 +1227,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  		if (fd > 0)
>  			close(fd);
> +
> +		if (has_filter) {
> +			strbuf_addf(&key, "remote.%s.promisor", remote_name);
> +			git_config_set(key.buf, "true");
> +			strbuf_reset(&key);
> +
> +			strbuf_addf(&key, "remote.%s.partialclonefilter", remote_name);
> +			git_config_set(key.buf, expand_list_objects_filter_spec(&header.filter));
> +			strbuf_reset(&key);
> +		}
> +

> -# NEEDSWORK: 'git clone --bare' should be able to clone from a filtered
> -# bundle, but that requires a change to promisor/filter config options.

Sorry, but this "should be able to" does not make sense to me in the
first place.

I can understand how an operation to create a narrow clone of an
unfiltered bundle and then prepare the resulting repository for
future "fattening" by naming the unfiltered bundle file a
"promisor", and allow the user to lazily fetch objects that have
initially been filtered out of the bundle lazily.

But a bundle that were created with objects _omitted_ already?  It
obviously cannot "promise" to deliber any objects that ought to be
reachable from the objects contained in it, so setting the bundle
file as promisor in the configuration does not help the resulting
repository.  Those missing objects must be obtained from somewhere
other than that original "filtered" bundle, and if that source of
objects that can promise all the objects that are ought to be
reachable were specified as the promisor, it would make sense.  But
the source of this clone operation, i.e. the bundle file that is
pointed at by "remote.$remote_name.url", cannot be that promisor.
