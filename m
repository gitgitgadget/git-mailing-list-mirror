Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C9130E4E
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200726; cv=none; b=DpNsEGrj/f36y+BcGM3F4vYayao+rf0QyyV26aygg9v6sUW5YxLmPnfVlqiLiTGo5NHC0ruRf5qE9GbGa7WddUgIOZvZIyi6j7JxmVX5ovDLMerNeWJGTVX+ZXVdxeZVNRDtHsKgsORVwp/I51NLJbtlNyLp6qGLA0hl8Tb3T1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200726; c=relaxed/simple;
	bh=6mbREU98Hxs4ta29gAcRMyi7m5jSYsVo13pVbCwqpkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I4bF+Xw+c25zl2Iv6KUx7l8Ag2yB6i+KF4gzrVMGHKAmpugCwTKZv1NrXstFJDcAm3iLTqswBJREV+DgCBBanR+24ziLbfjGpxeNbLt9Z4zbTtX3yhosrUE0GXv0Nt+ZRIgeDh+1A+ymiJ7ziQ2ZCcu0Fx1UeEIFcHEgEnk9GMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k9weXiuv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k9weXiuv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D8E851C303A;
	Thu, 25 Jan 2024 11:38:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6mbREU98Hxs4ta29gAcRMyi7m5jSYsVo13pVbC
	wqpkY=; b=k9weXiuvlzdqul2o4QbXGrZkZlL97Z7LtaD/CU+cZ6E2LRMqCgenaD
	XafBE/yD1fHQiKwOmBTLKDQq2ckE51hXCFy/fk3IoTQWZBQ/Y2Pq6JbbkdJWL/wV
	Qt6c9izmYH31BpD+GhFwwwR0zyFrbZC2qogYho46eHwg9iem2nrgg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D024D1C3039;
	Thu, 25 Jan 2024 11:38:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 316341C3036;
	Thu, 25 Jan 2024 11:38:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,  Zach FettersMoore
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees
 present
In-Reply-To: <CAP8UFD0M_KeUTHthQ6n_a1KbEvuA1gAsE2jKkAqd-4twjbpNWw@mail.gmail.com>
	(Christian Couder's message of "Thu, 25 Jan 2024 11:09:41 +0100")
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
	<pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>
	<CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
	<CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
	<CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
	<CAP8UFD3b2y+55j3NMDm89hpVRNxX2TA-AdQS=zsboD30pZ1c4Q@mail.gmail.com>
	<CAP8UFD0M_KeUTHthQ6n_a1KbEvuA1gAsE2jKkAqd-4twjbpNWw@mail.gmail.com>
Date: Thu, 25 Jan 2024 08:38:28 -0800
Message-ID: <xmqq5xzhxta3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2B643EA4-BBA0-11EE-B39A-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> It seems that this topic has fallen into the cracks or something,
> while the associated pch looks good to me.

Yeah, it wasn't clear to me that your message you are responding to
was your Reviewed-by:.  If I recall my impression correctly from the
time I skimmed its proposed log message the last time, it focused on
describing a single failure case the author encountered in the real
world and said that the patch changed the behaviour to correct that
single case, and was not very clear if it was meant as a general
fix.  Is the patch text, including its proposed patch description,
satisfactory to you?  In other words, is the above your Reviewed-by:?

Thanks for pinging the thread.
