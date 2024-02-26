Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EA125DB
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708922138; cv=none; b=RKGW4apJWKUwqMQrJWoBzlaQr4Qhac5YOb0BkwcayHuTBsf32q5hwqqaqyZHLW1n3LhZrcvM6+2M36H/GwqwF0kEU6w3/EkftidOm6brYGJcc63I4uu1MmM9415bXDX/fropyKlcRq5yALm2a6SP1PQN781i8ZlEXMqolKwbGRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708922138; c=relaxed/simple;
	bh=xzsh0IE3oIBdwxqdvMwPY+9RgG92ZEpJWQf8vjwxYlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=shc1BJD58X6/z9BnU3zGjikMExWEBqal9UiqBkK3apfDNz0FLbMv8kfNG1giVHgssF4X/FwmbE7A419zFzMWSMdHkUUkfCmTwBXNOmSi8ZY4BE5psAgUcTtzt14cO4vIV8ERtQL3XorT+502ERrC//73D1ocr1D56Spy8yd29Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=imgJsl3o; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="imgJsl3o"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 10A6A1F2EE8;
	Sun, 25 Feb 2024 23:35:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xzsh0IE3oIBdwxqdvMwPY+9RgG92ZEpJWQf8vj
	wxYlE=; b=imgJsl3ojKOIKoTTu3nQ1LMYrsF5lbWadLv+iPe0IOWTMECXAUJLbD
	1xYqwb1b0mUY94RvUtCdtRZFXGIcCP9o2TRltXfZdIFXE6nKe9a49lGVkTq7DOTb
	jCBDCIgTXyKnwbhrENs9OmGsdszIKhHAgYOyfnzBlMg+NBarowjHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 08BBA1F2EE7;
	Sun, 25 Feb 2024 23:35:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 774D81F2EE6;
	Sun, 25 Feb 2024 23:35:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Elijah Newren
 <newren@gmail.com>,  Michael Lohmann <mial.lohmann@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>,
  Michael Lohmann <mi.al.lohmann@gmail.com>
Subject: Re: [PATCH v5 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
In-Reply-To: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-2-af1ef2d9e44d@gmail.com>
	(Philippe Blain's message of "Sun, 25 Feb 2024 16:56:17 -0500")
References: <20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-0-af1ef2d9e44d@gmail.com>
	<20240225-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v5-2-af1ef2d9e44d@gmail.com>
Date: Sun, 25 Feb 2024 20:35:28 -0800
Message-ID: <xmqqa5nnj10v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 78496356-D460-11EE-A387-25B3960A682E-77302942!pb-smtp2.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> +	for (i = 0; i < ARRAY_SIZE(other_head); i++)
> +		if (!read_ref_full(other_head[i],
> +				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +				oid, NULL)) {
> +			if (is_null_oid(oid))
> +				die(_("%s is a symbolic ref?"), other_head[i]);
> +			return other_head[i];
> +		}
> +
> +	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
> +}

Just a minor nit, but reacting to recent "passive-aggressive"
message change in another thread, perhaps we should stop asking a
rhetorical question like the new message and instead state what we
detected and what we consider is an error condition as a fact in
them.

The last die() in the above helper function used to be such a
rhetorical question "--merge without HEAD?" but now it reads much
better.  The one about symbolic ref is new in this series, and we
can avoid making it rhetorical from the get go.  Perhaps "%s exists
but it is a symbolic ref" or something?
