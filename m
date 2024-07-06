Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEB17753
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290643; cv=none; b=Ke7XeCwGGsOEKI/PsBOxp7nZ49ezuqwtZxvbKKM9B5CKlyA6d3QiFkAyyJTf1R5HBryA/uMFsNHIUhKM1pal7F72fMfQAH0IbcR/aTYyYLgw7lE2JmlF9nn4MML5fDtu+8ssXu1VeoIru90wr/QbOXrPKpFr02Orqv3qQnuowuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290643; c=relaxed/simple;
	bh=P09/JUQX/GjuDFTbQMPWbVI2mJNMkFlR5mwBZVxHfI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VfSvHQ5CJP+Uym4gq2Mg2Ujyue3kEo1gk7wWZUFzDlbdZpYlzMLs7gBQFPzjyNxHWdp9JUN7Aare1NnKLX5g0KgQoJZ0OxgmE5YSB9cVjKjk2aPX+rhb82F1PWO+KMcUx+GkESVWircMcuH3yKfvv023T87p+X52Q8EgcBJTmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ICQ6wisH; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ICQ6wisH"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3D2132840;
	Sat,  6 Jul 2024 14:30:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P09/JUQX/GjuDFTbQMPWbVI2mJNMkFlR5mwBZV
	xHfI4=; b=ICQ6wisHK10JA4EPpwCMglBmz8KeTx/uYy4ypHim7vfpoIIaG2PxP8
	F7jJFciceQBTvNpb+PzAmI6Ky3xFDlK92rxTqpusPac4U7nwnYdyMMUfj72BmS2x
	/GoNIxjjxdqWvRQf8nIvQ4onLaLPF9pupvPBuXPvgu6QUDHluduJg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BD133283D;
	Sat,  6 Jul 2024 14:30:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D2EE3283C;
	Sat,  6 Jul 2024 14:30:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: fix missing early return
In-Reply-To: <pull.1758.git.1720123341342.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Thu, 04 Jul 2024 20:02:21
	+0000")
References: <pull.1758.git.1720123341342.gitgitgadget@gmail.com>
Date: Sat, 06 Jul 2024 11:30:38 -0700
Message-ID: <xmqqr0c6nzjl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D89FD92A-3BC5-11EF-AACE-965B910A682E-77302942!pb-smtp2.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> One of the conversions in 500433edf49 ("merge-ort: convert more error()
> cases to path_msg()", 2024-06-10) accidentally lost the early return.

f19b9165 (merge-ort: convert more error() cases to path_msg(),
2024-06-19) is what I have, date is different (and object name is,
too, obviously).

And funny thing is that your base-commit points at the latter.  I
briefly wondered if we can somehow automate the generation of
reference in the log message, but the base is likely to be the tip
of the topic branch that has been accepted upstream, and the commit
being fixed up can be something below, not at, that tip, so it
wouldn't be like a simple and silly "compare base-commit and the
commit we talk about in the proposed log message".

A commit-msg hook that scans for names that look like commit object names in the
message, and

 - makes sure that these commits are reachable from HEAD (the goal
   is to make sure they are reachable from the resulting commit),
   and possibly

 - makes sure that these commits are reachable from @{u} (the goal
   is to catch references of unpublished commits)

might be a possibility, but such criteria are probably highly
workflow specific, so needs to be highly customizable if we wanted
to make such a feature as a part of what we ship.

> Restore it.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Thanks.  I saw Peff's earlier message and the change exactly matches
my expectation.  Will queue (with adjustments to the log message).

>     merge-ort: fix missing early return
>     
>     This is a patch on top of en/ort-inner-merge-error-fix which is in next.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1758%2Fnewren%2Ffix-fix-error-cases-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1758/newren/fix-fix-error-cases-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1758
>
>  merge-ort.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 8dfe80f1009..d9ba6e3e523 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3618,6 +3618,7 @@ static int read_oid_strbuf(struct merge_options *opt,
>  		path_msg(opt, ERROR_OBJECT_NOT_A_BLOB, 0,
>  			 path, NULL, NULL, NULL,
>  			 _("error: object %s is not a blob"), oid_to_hex(oid));
> +		return -1;
>  	}
>  	strbuf_attach(dst, buf, size, size + 1);
>  	return 0;
>
> base-commit: f19b9165351a4058832bb43560178474c7501925
