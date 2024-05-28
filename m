Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DA17332A
	for <git@vger.kernel.org>; Tue, 28 May 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916251; cv=none; b=IORcu4TaUlJBnuILBFxKh9DSJF7mCmXMRR54O2FNORWPtqA9IPpV22V43yXrWnj//Ky0ly/Y1QOLVWYr9xaqGTjyAYTBDDHiyyM7SVeFCDqWgbeiARtYqBcT7J5remsDvS1ULnJsq43UvDX9VedUlPRlNmi4Mod/zKq5ccBkjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916251; c=relaxed/simple;
	bh=uGE0GZG8qxKBzfq9uiJjlGBEWqpbROrinS1YLuT8DjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CYtlZiMwInkibokzYU2ML0cpQo6eJL3Wq9dYb6FrVyEo2zyMDh2z7BmAyDfrjNCgzrPjqmor9/DlUqNhJOM4U35srTebYTpPTn/j6QqVAz90descEf85zJLwSqvcQmVY3omWLXUyA3ZR2OrzLpfKAxCdWoYLsjq0EBeimE2lDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tNnyYUlg; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tNnyYUlg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1086A1B058;
	Tue, 28 May 2024 13:10:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uGE0GZG8qxKBzfq9uiJjlGBEWqpbROrinS1YLu
	T8DjM=; b=tNnyYUlgjyICziuD5R2AAHeoH3UzVJvBEyeDKBltn47kv5RR72ImMn
	K4ZK1/uzOElW8WSq15CS33lHnW0o3L991BYHJBk56EhJFVLz0KcnHpxJGz/5Tkg6
	ps0v/0ncHMgOlJ1t79eMp3z55Up70yJXVmzlPynY+6TspahcUs6Rk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 076B51B057;
	Tue, 28 May 2024 13:10:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60ED11B056;
	Tue, 28 May 2024 13:10:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  blanet
 <bupt_xingxin@163.com>,  Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 3/4] fetch-pack: expose fsckObjects configuration logic
In-Reply-To: <ZlXIBrs5Q91r_-qU@tanuki> (Patrick Steinhardt's message of "Tue,
	28 May 2024 14:03:18 +0200")
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
	<pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
	<67401d4fbcb3f07d31589bb8ec10060dcb77545e.1716824518.git.gitgitgadget@gmail.com>
	<ZlXIBrs5Q91r_-qU@tanuki>
Date: Tue, 28 May 2024 10:10:46 -0700
Message-ID: <xmqqikyx6ew9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 39DDFAD4-1D15-11EF-9A31-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +int fetch_pack_fsck_objects(void)
>> +{
>> +	fetch_pack_setup();
>> +
>> +	return fetch_fsck_objects >= 0
>> +	       ? fetch_fsck_objects
>> +	       : transfer_fsck_objects >= 0
>> +	       ? transfer_fsck_objects
>> +	       : 0;
>> +}
>
> ... can we maybe rewrite it to something more customary here? The
> following is way easier to read, at least for me.
>
> 	int fetch_pack_fsck_objects(void)
> 	{
> 		fetch_pack_setup();
> 		if (fetch_fsck_objects >= 0 ||
> 		    transfer_fsck_objects >= 0)
> 			return 1;
> 		return 0;
> 	}

But do they mean the same thing?  In a repository where

    [fetch] fsckobjects = no

is set, no matter what transfer.fsckobjects says (or left unspecified),
we want to return "no, we are not doing fsck".
