Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981215EFC4
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879729; cv=none; b=nMuFGoeH0qSfX7TV53Q+Ov5HQ/Tfgwv2Uo74IPuvxDItt2q3pAPOmCuitKlRTslhZFpur1RNUGurvTtu7TCKxo/9RIPGukVLj6YYVUGF9jd7Ibgiax3R+eZdwB6Tlh5kblZGiBjCDR2t5NV+dlglASU5shLjs67QFueQ2so5Cf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879729; c=relaxed/simple;
	bh=FiZM1cau3a3ZnVt1HLAkpPV1fhIJ+mYSxnlE/vHqqZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MO81Fy29CdWi8dq0GPd33WL3JD5EZFzKmOrwuh+ZdLhz7Rs3wVqn82ksuytAbJAyopx98U2znkT15h0OUCp0qC6b3b+oLp9lr7J7cfOQgPKhtMMsw2WRY2nULjW64ne/Yh1wI0CmijntmqPvAfRoU4uOg2Phlb+RBJ5Rw33/9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pVsvMvwQ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pVsvMvwQ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E59912F0CD;
	Mon,  5 Aug 2024 13:42:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FiZM1cau3a3ZnVt1HLAkpPV1fhIJ+mYSxnlE/v
	HqqZg=; b=pVsvMvwQL+tn1QtITME5R7puEHzxjgRjZpHft3IDnFQEMGAw1f0IVJ
	ughRuKfgCOeW2QrYUxpVI2tN/onAIRhYM6b639LaPAQZYz65IaqgbungGc6C7P2i
	ezFyl5DXB0gBK68/6ukwau1Oe/X+oOF/lSZ4bP/OWZx1kBysTaS20=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DDE4C2F0CC;
	Mon,  5 Aug 2024 13:42:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ECD3D2F0CA;
	Mon,  5 Aug 2024 13:42:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <email@cs-ware.de>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Sven Strickroth
 via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] repository: prevent memory leak when releasing ref stores
In-Reply-To: <8594c7bb-07ed-4c54-8712-5b0d4299b8eb@cs-ware.de> (Sven
	Strickroth's message of "Mon, 5 Aug 2024 17:50:04 +0200")
References: <pull.1758.git.git.1722855364436.gitgitgadget@gmail.com>
	<8594c7bb-07ed-4c54-8712-5b0d4299b8eb@cs-ware.de>
Date: Mon, 05 Aug 2024 10:42:01 -0700
Message-ID: <xmqqa5hq3lzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 06E459DE-5352-11EF-A8A3-BF444491E1BC-77302942!pb-smtp20.pobox.com

Sven Strickroth <email@cs-ware.de> writes:

> Am 05.08.2024 um 12:56 schrieb Sven Strickroth via GitGitGadget:
>> -	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e)
>> +	strmap_for_each_entry(&repo->submodule_ref_stores, &iter, e) {
>>   		ref_store_release(e->value);
>> +		free(e->value);
>> +	}
>>   	strmap_clear(&repo->submodule_ref_stores, 1);
>
> After further checking this does not seem to be necessary. The ref
> stores are already free'd in strmap_clear.

Is it "not necessary" or "actively harmful"?  It sounds like the
latter?
