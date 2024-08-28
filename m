Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2117C223
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859066; cv=none; b=RHj7QG6OhRWMv9JcsggB7oMw2qGafr0mSOhDe64jhTB1It1Uqkl8EeHJiFHP+IdAV15TelT8nKEYf7sMWm8GmIoHP6or+JQfUdPVZrSzeZNMI7z2gDBvmnZk8tGvpyO2d+gRRpwGCrfTI9A3UCArrlNn8RrzlpYDJ/GPmgDmSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859066; c=relaxed/simple;
	bh=8Src05zw1O5Dr0aQLKw12fZQS4GRXlWMpKsa8EQDMDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KswXhK/YRZVgmDj7moq5sdkgmTZ7mGvZpXVE2u0fU5XxXvWEMZIMpApwe921sOB8hz5ep7wyZrgSdOW3iFma7rxt5l9M7TRhdDCL4O/A0WVB7wLU9NPxPdDm/8vyAG515nMrAbY9RGXFv8I1s4sui0qBZ7wo+doHhuV8JviS5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mPz87SE/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mPz87SE/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C56330B1E;
	Wed, 28 Aug 2024 11:30:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8Src05zw1O5Dr0aQLKw12fZQS4GRXlWMpKsa8E
	QDMDs=; b=mPz87SE/hEpM7kIBtlfuBgA0f0rW81CplfL0JTinyMWoSd0neu44Xe
	5Wh6JsaOWlFXf0ItpIm8q1eR8Fi3ldX3hfIXaqfW6o3LpwkPi2t12hMLRU/bVBXn
	voYoSum5wTeYbc4uJCyA9kxuOmph8H1DH/OpphZRq311SOp+8La2Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 085C830B1D;
	Wed, 28 Aug 2024 11:30:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8241230B1C;
	Wed, 28 Aug 2024 11:30:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/4] ref: add regular ref content check for files
 backend
In-Reply-To: <Zs8c81Z-zb4uQpp6@tanuki> (Patrick Steinhardt's message of "Wed,
	28 Aug 2024 14:50:01 +0200")
References: <Zs348uXMBdCuwF-2@ArchLinux> <Zs353oLDaw2SbNQs@ArchLinux>
	<Zs8c81Z-zb4uQpp6@tanuki>
Date: Wed, 28 Aug 2024 08:30:50 -0700
Message-ID: <xmqqy14g3brp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 82A6EA98-6552-11EF-A425-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 28, 2024 at 12:07:58AM +0800, shejialuo wrote:
>> @@ -170,6 +173,12 @@
>>  `nullSha1`::
>>  	(WARN) Tree contains entries pointing to a null sha1.
>>  
>> +`refMissingNewline`::
>> +	(INFO) A valid ref does not end with newline.
>
> This reads a bit funny to me. If the ref is valid, why do we complain?

I think you understood after reading the series through and
responded to my "curiously formatted" comment.  I understand that
these marked as INFO are not about "to complain" but are for us to
ask the user to report so that we can learn of any third-party tools
that may get in our way to later tighten the parsing rules
retroactively.  

> Maybe this would read better if you said "An otherwise valid ref does
> not end with a newline".

So I do agree that the text above is less than optimal.  It is "this
is valid, but something we wouldn't have written.  Who creates such
a ref?"
