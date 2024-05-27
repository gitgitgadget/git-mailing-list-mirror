Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3913A3EE
	for <git@vger.kernel.org>; Mon, 27 May 2024 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831550; cv=none; b=bYA3xIHwFSCwF4JxIooxrcSnRfdUwEYXw6IiHoAuOw3dcn5F0hptbRkyBxbraWt2IUq0CHq6Fw40k4HqHlv4TpdmnJkb0l9mMC7zNJeYbIiPsQTxKP7wTGJ+/0vKB2YwDaQJ1aGwX487JTSArrl3ulrnC3jBGStPxHaIygqvTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831550; c=relaxed/simple;
	bh=UT4xlBJZEK4uVStgk1bo3yJ/Hg6ocL+MFi3FTSNC2IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7pTmosjRrV8A/fnDMAnvLyinGKL/8l7fzIFsSwH8cDNJMaGwhfmuhS3+bPM7iYsmrvdNoChp2Re6XmrlCL4fK5xiKkH+kWHIwxcZGsi2o52MImuHdeYmuUBX8h4nnvgSAKkkE3szKGKw/KWMJ8JsRtLGDNrF+jjO07V9yClk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xuPVi6SN; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xuPVi6SN"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFD1E22398;
	Mon, 27 May 2024 13:39:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UT4xlBJZEK4uVStgk1bo3yJ/Hg6ocL+MFi3FTS
	NC2IE=; b=xuPVi6SN+sXSd50TyjniDSOBFu0z2gA6WjUVhXOE3HrK4OQAFBkoH5
	COVAD59uWYInEq6gpmKsXg/l4hl6iqUHlqMK0xBFJgyNooUZ/fPpmDAvsVOKvl8X
	hlTJ19xl/BH+nOSBoGbAiPDkWoLAw0EOgX/9+jeAWp2KLyDx5FF10=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E749222397;
	Mon, 27 May 2024 13:39:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A7CD22396;
	Mon, 27 May 2024 13:39:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/21] Various memory leak fixes
In-Reply-To: <ZlQr11P_C-KyO2DF@tanuki> (Patrick Steinhardt's message of "Mon,
	27 May 2024 08:44:39 +0200")
References: <cover.1716465556.git.ps@pks.im> <cover.1716541556.git.ps@pks.im>
	<xmqqwmniiqv2.fsf@gitster.g> <ZlQr11P_C-KyO2DF@tanuki>
Date: Mon, 27 May 2024 10:38:59 -0700
Message-ID: <xmqqwmnf9mto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 011AE236-1C50-11EF-A611-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Indeed. The following diff fixes the leak:
>
>     diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>     index 7d2a419230..e54be9c429 100644
>     --- a/builtin/update-ref.c
>     +++ b/builtin/update-ref.c
>     @@ -130,6 +130,8 @@ static char *parse_next_arg(const char **next)
>      
>         if (arg.len)
>             return strbuf_detach(&arg, NULL);
>     +
>     +	strbuf_release(&arg);
>         return NULL;
>      }
>      
>
> Karthik is out of office this week, so you may want to add this as a
> "SQUASH???" commit on top of his topic branch to make "seen" pass.

Alright.  Thanks.

>> Also
>> 
>>  https://github.com/git/git/actions/runs/9231313414/job/25401102951
>> 
>> shows that t1460-refs-migrate fails on Windows.
>
> Hm, this one is curious. There are no leak logs at all, and the exit
> code is 139. Might be SIGSEGV, indicating that something else is going
> on here than a memory leak.

Sorry, I wasn't clear enough.  I do not suspect this is about leaks
(and the failing job on Windows is not about leaks).
