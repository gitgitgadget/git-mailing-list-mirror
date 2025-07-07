Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB892D8376
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897964; cv=none; b=KfFlebnex0e0owifF0t0mRVKLGet0q+us7BAKCQBg1sCxy4Ey0ih3tDhEL5Yy07/lEW8N3OhnrfwBWPXLWANE+j4j3438MZIKk0jlhsSEB6aEcK7/qh2JP4+vnLowf7deddhd+T6KUlk4zcvwGpfpaeqgNyUS3lH35y4SnOIJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897964; c=relaxed/simple;
	bh=I5/Z5qPEaTM7aoulBUOm8B1Dzom9K8i5yyfxx6pAvQY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SlZOxMPOX5VXKfYBG1tAM4j0vAkiAU5nIfn7Y3RDqQnedv3t3eyPvQRBnCw9FLDVqR673jpTXVsKW6aR9mPPymdgI+eE1GtpEn4Wr/8/fJwTrKWjE1JpwJtfmJjTe3DxWBIAnU425Thtx8VJ+T9NXfmUp6ekyzPtfJHBwMyP7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz6t1751897937tac72f3b1
X-QQ-Originating-IP: jqCPtnC6ukJEIJuX+ceJpYIwfY2NT7rtdXCBefIKd0k=
Received: from smtpclient.apple ( [202.119.43.124])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Jul 2025 22:18:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5794617093577117457
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 4/4] bloom: optimize multiple pathspec items in
 revision traversal
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <ea144a72-0975-4ac9-b2e4-ae0f7fcb6837@gmail.com>
Date: Mon, 7 Jul 2025 22:18:45 +0800
Cc: git@vger.kernel.org,
 gitster@pobox.com
Content-Transfer-Encoding: 7bit
Message-Id: <23232D29-CEFA-409D-90E3-F894EC37C1BE@smail.nju.edu.cn>
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-5-502024330056@smail.nju.edu.cn>
 <ea144a72-0975-4ac9-b2e4-ae0f7fcb6837@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N17Koc4oSm0pCa7YEgC8W032uwi3RyhAhrAtEUPTcUBbiy00iqQZXnBu
	wPjWCpE/305tnSJHb3YqVl03HXtMWh/+dhN61S2a9yC1Dfe7/f7oJwsp/S9HxG7rZFeJhYY
	NfCdd2RSYHGaItilBfZlb+aNSeFgjiW4c6RMmw5TSFqWfLBR86r9acR7YHk5C+sSnpeoVhl
	M3AubZb3p3Uj/RtCjP0Xvpz9DpEpPF2cCDnGEZqIbMsvWc9RmYCB+73hn/nyzDs/TdzudhC
	jGrTWK0l6aPi0T2+S5yADRunkFsX/gHn3wjKl5ldKaMa2gej2gysuwUAMfRcFHD7Zt/t0KS
	OvxZoRPoUV/qEtk7BheTsVaq+Pq4FCNZPEemBh22dMisVx9NlFzHUGlmTPErW8MdNo0nZ0e
	vbGwOR0CuKgxYV8HnrKa0Ao381/QO5bKyBeW+AiwQnevTrqKKaqfsRxI/WbWzVutwI2dHS6
	cnOxVRik7MRK2Ob/12+92ZLyBGKgxnjn19plQEyuKJxo1dGOIVlWNbgC0vmbd2c2Rq3V6AX
	FxOyMsNm4Pk6jrUQ0bBdcULSG2V4mjPTtezxmlveIPxqnEY1ql+qBEPECBWbtRt6oeFHyuL
	lzvbGhjjvq1L521Y+YdKttzWGPmQ9c8yORy2VVCdxhBBn5cY6Taf4ZQJSgg04Zo2g/arAu9
	yTbr8EYFN7zzq7um9B6c6YvsWGASazKnoHdQybjUfXHNM5Cgih4zh9eb5SsYQ8dqC7pojTn
	JAIEkajR+M176VvvYfsRQLR7wyqTTX7EuylkbpG7m0/R3QGXS4PzYbFuIie5xtGA71i6x8Z
	fKDOThCTJvyAHkqlIzj37iDwnYKzRppigINRhZzxP2wUObxuCCxVNz1P5+daaNPvbAgosrv
	pHZ5KfEBXXz+kEXX5L19pD1FKJPChrtdYg51X+mRuXL2ndXRP5ODG/z3JjKAGzLejNXbsgn
	MR8BNoWDgdoouHNy3DvTDcGPwlpCGmeRTTbRbRM38HLzoVxwEFYr0Osph911VaM6KFTaEy5
	8mFlbgEA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Derrick Stolee <stolee@gmail.com> wrote:
> 
> On 7/4/2025 7:14 AM, Lidong Yan wrote:
>> To enable optimize multiple pathspec items in revision traversal,
>> return 0 if all pathspec item is literal in forbid_bloom_filters().
>> Add code to initialize and check each pathspec item's bloom_keyvec.
>> 
>> Add new function release_revisions_bloom_keyvecs() to free all bloom
>> keyvec owned by rev_info.
>> 
>> Add new test cases in t/t4216-log-bloom.sh to ensure
>>  - consistent results between the optimization for multiple pathspec
>>    items using bloom filter and the case without bloom filter
>>    optimization.
>>  - does not use bloom filter if any pathspec item is not literal.
> 
> This would be a great time to add some performance statistics when
> using this feature with multiple pathspecs on some standard repos (git
> and the Linux kernel repo are two good examples).
> 
> We don't have a great performance script for this, since each test
> repo will have different paths to use for comparisons, but you can
> use 'hyperfine' to assemble your own comparisons before and after
> this change and report them here (and in your cover letter).

Got it, I will add statistics in the next version.

>> + int path_component_nr;
> 
> We can move this into the interior of the loop, right?

Yes, move this into loop looks better.

> 
> The size of this diff is unfortunate. I wonder if there could first
> be an extraction of this logic to operate on a single pathspec and
> bloom_keyvec in a way that would be an obvious code move, then this
> patch could call that method in a loop now that we have an array of
> bloom_keyvecs.

I will try to figure out a way to make diff cleaner.

Thanks,
Lidong

