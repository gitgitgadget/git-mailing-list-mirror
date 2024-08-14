Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292DC1BBBF2
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672393; cv=none; b=QPl6oSKoUif+whm1AJik6OF49kms8qPsSCHrwRwmXeVIvRf3zYnYlDHBbQs8ui2x4A3I4MOjAaBNKMvV76t/zAYj6cItQR1AYMijtCtDB1aSo2ieMHrt8Dqiw/iG3XGZSm6q1HTOlj4ltQrrnKMtm//DB2O3U1T3VNnll/gEBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672393; c=relaxed/simple;
	bh=c1BUVKMb7aZcdqeTLq5bS1gkA8J4Ojr3v+MiIaGnNe8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FA0hr658+Rn5iZrEoXlxlnvD3mMc34HrFQhH0CfAJAeBUSjo0Bgllv8uJLgGK61LOQ5gp5OAI5jPEzIOAzIsFrlVn/1JLV1UPbeaO3e8IAA+abLn6e7uO0BSHXpOMKIJgm1xFB0B8PGPUwUcst6VwOzxdHkzMNXxKAE3jv3nigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FutghiZc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FutghiZc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 985042B9CA;
	Wed, 14 Aug 2024 17:53:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c1BUVKMb7aZcdqeTLq5bS1gkA8J4Ojr3v+MiIa
	GnNe8=; b=FutghiZc3LAazCd276xQsJcRvQS4Dp6qvMRd4T79dPYv//tFB3nPGG
	0hE/mjTSMEy1CW8K8w2m4M4eNUz1ZjVyj0IZb+aL/TBtML6ZGpUlmkT0sB/1StMa
	KlK9hqaVlzkrnNNdMJo7VX6hUcBBP5pdnUefuARNKiQamjdMaoyEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 91A9A2B9C9;
	Wed, 14 Aug 2024 17:53:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B6B62B9C8;
	Wed, 14 Aug 2024 17:53:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Anthony
 Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH] format-patch: add support for mailmap file
In-Reply-To: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>
	(Jacob Keller's message of "Tue, 13 Aug 2024 14:45:22 -0700")
References: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>
Date: Wed, 14 Aug 2024 14:53:04 -0700
Message-ID: <xmqq4j7mydof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 964F0FE2-5A87-11EF-8B85-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Jacob Keller <jacob.e.keller@intel.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 4d4b60caa76a..94560add6fbc 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -975,6 +975,7 @@ struct format_config {
>  	struct log_config log;
>  	enum thread_level thread;
>  	int do_signoff;
> +	int use_mailmap;

As we share the "--[no-]mailmap" option from the command line with
"git log", shouldn't we be able to reuse log.use_mailmap_config as
well without adding yet another member to the struct?  "git log"
defaults use_mailmap_config to true, but this command would want to
default it to false to avoid disrupting existing users, or
something, perhaps?

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 8708b3159309..f3de349990bf 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -30,6 +30,7 @@ SYNOPSIS
>  		   [--range-diff=<previous> [--creation-factor=<percent>]]
>  		   [--filename-max-length=<n>]
>  		   [--progress]
> +		   [(--mailmap|--no-mailmap|--use-mailmap|--no-use-mailmap)]

We seem to say "[--[no-]cover-letter]" to abbreviate, and because
"--[no-]use-mailmap" is merely a synonym, shouldn't it be sufficient
to say

		   [--[no-]mailmap]

without any other frills?  I find the use of the (al|terna|tive)
here especially annoying, as it is not like it is an error if you
give "--mailmap" and then say "--no-mailmap" later on the same
command line---it's just the usual "last one wins".

I haven't decided what my response to Peff's concern on the fallout
to "rebase --apply".  On one hand, those who conciously choose to
rebase by creating patches and applying them would find it puzzling
if it did not honor format.mailmap setting.  But I would not be
strongly opposed if we hardcoded to pass "--no-mailmap" to the
internal invocation of "format-patch", just like we hardcode "-k"
and other options and justified it with "the use of format-patch is
a mere implementation detail".

Thanks.
