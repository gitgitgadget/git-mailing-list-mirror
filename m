Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113EF23A8
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nJG9NkQy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 893FA1D7381;
	Tue, 26 Dec 2023 15:10:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MKaYa9MozqVieTcarKuWKSFkkvrOuM3zNIE5ON
	16d+I=; b=nJG9NkQylCEbq16EWIBksrJcRp2EL//0eN06bLgDN6542m5bhdIXpe
	8m1wUjv8N9hBqmpMXTILlyDB80FyT/VcT0xim8kF4V72qGEiNspfu/ZCvB12/EVx
	f5Lrej3TvcWn4s/9/7knp2XWytFPAUk+ZHlmB/qLBPGRFEFRGHJvQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 71CFA1D737F;
	Tue, 26 Dec 2023 15:10:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A4881D737D;
	Tue, 26 Dec 2023 15:10:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Chandra
 Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] Teach git apply to respect core.fileMode settings
In-Reply-To: <fb022e3c-adb5-e341-9fd0-9c5311abe908@gmx.de> (Johannes
	Schindelin's message of "Tue, 26 Dec 2023 20:18:58 +0100 (CET)")
References: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
	<pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
	<82dadb69-5016-dec6-3699-4d994ea7929d@gmx.de>
	<xmqq4jg4j28z.fsf@gitster.g>
	<fb022e3c-adb5-e341-9fd0-9c5311abe908@gmx.de>
Date: Tue, 26 Dec 2023 12:10:08 -0800
Message-ID: <xmqqo7echgin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C6012022-A42A-11EE-B98C-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Is it defensive or is it hiding a problematic index under the rug?
>
> I wrote this defensive code only out of habit, not because I saw a
> `ce_mode` that was 0.
>
>> If there is an index entry whose ce_mode is 0, I suspect we would
>> want to error out with a BUG(), unless it is an intent-to-add entry.
>>
>> Shouldn't it cause an error to apply a patch that mucks with
>> "newfile" after you did
>>
>> 	$ git add -N newfile
>>
>> If we allow ce_mode==0 to be propagated to st_mode, I suspect we
>> will catch such a case with the "mode is different" warning code, at
>> least.
>
> Is `ce_mode == 0` an indicator of a new file? In my tests, `git add -N`
> will add the file with a non-zero mode...

Oh, if we know nobody would assign 0 to ce_mode in a valid in-index
entry, then we should (1) check and BUG() if we care there may be
such a case due to a bug, or (2) assume that it never happens and
omit the extra check.  The third way in the patch is neither and is
sweeping a potential bug ("potential" because the code apparently
assumes it can happen) under the rug ("sweeping" because the code
silently ignores such an abnormal case), I am afraid.
