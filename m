Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03819D093
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543497; cv=none; b=UfYNQGspsGK35aHq7hS5FXaIeyZMCpOB215YMSvJP/ZlM7EgOz2JC69l5h1RPKZt0idQiJ3Fi10oQxxrLt7nH/obh51zafrG11lQF7pKpj1wHzJD+DKJVNJ4AO+qnvweLEK4VB6wtevcDahTrpkbFJG0D9BBd8mJxubnSv9k+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543497; c=relaxed/simple;
	bh=AOb5/pKIEAee7xHJVbwF5YO/aSrFZyBuBCEtM6E4T1o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ewba8UBonDx0Y0zOPOu6qn8aA3jVbTTowbGSErNHXq+OouonAney6HGBtL3iL1cG4XBLEeyfrU0kKRCD1bsWLi50kFaH0dB4rpdLwpVASjARRN9XNaxRLxbz77xHDOrNpBGubQy51wlfQvRcBhSiPlMdV0XZRYrYQjL4vnRSB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz19t1752543462tc10c163f
X-QQ-Originating-IP: Y/oDzPHrNZzeB19MiZOwz9JUPpdJnQikjpL3eqyTzPY=
Received: from smtpclient.apple ( [171.116.160.7])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 09:37:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12221648550897008801
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 5/5] bloom: optimize multiple pathspec items in
 revision
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqbjpmu2oz.fsf@gitster.g>
Date: Tue, 15 Jul 2025 09:37:30 +0800
Cc: Derrick Stolee <stolee@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <55BF9B3C-F9B1-4ADB-9CBC-0D8EA45BA264@smail.nju.edu.cn>
References: <A25E64EE-CABB-498D-8B34-27588B349FAC@gmail.com>
 <20250712095129.24642-1-yldhome2d2@gmail.com>
 <30afce8c-c932-4c51-9a27-e63385608514@gmail.com> <xmqqbjpmu2oz.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MPI5HzS7e4/KPUETSAYWDh+I2G2Wi8+C/oD1ME9nQKgTNlDNsXexOlkt
	L926nQioMFbs4B6LIbTIXBZbzm8PuhPwgQiW/3WU7czeAxZamOUo6GSkDE0wH4Bm4rFtkpx
	qS4+BGjgG1fKkqYKiBoVI75OzcEcCYnmHomGmwEfoDZzXdRRh3wXCeqSYO9aC+Rvnuzig68
	4sVbc5Y860fj9OcktPM1GZxeGsm77O4G+YL3Ghv2cDyXvypFEapJlNY/TwqP3Qdpg6Y2P48
	3XMpcBUrYZMydVSUbh6pbPfZWwqq41/6OBYDGGw0f/WNI/M+XayU4GtH19c5RfttWISHbW+
	NZ742197xk/NIRjSJNI4D/iHA+gqKCxlo6bQB3MSq9pTno2NbwprhgN0zRX4iRz++IGTCRp
	SRCMrBkmpDyLW7cWBwjXhD4esR0N5tGRJg2gGqnSF4OXZXo4PSKsGzfMc6H1DGtH8RMWCMe
	mp9XsmY9Iy3Kb5jvTcZftaoX4Ac+YQg8d7iSEajkk3BjJKWkrdXI/aYXTQPukbzxtVmXbX/
	fK+42lAwFO+o5K9N/UOljyAmkYX+hYI/W3dOLQrOOyMi9CrpZdyZVvMtD8adnAy7fP9AgbP
	tCXG9zlJUV8iwe2/K/nHnvMg0UgtyrudRiD+wBcfxRnE/FoUuO+RoVvwFdknn/GwrRntWUl
	uX8DRm1JJLIa13DwR4h1gbK2nUhMPWl74vLrGAOVO1/jbzSj6hVL5bThfPo3GUDbaXwJUfK
	cpRTh0454fdLODv7DsQCVQHS068NR/+TairybLRGCTre7VwvWKb72vZiJg4juGfjwjPf+Mz
	k1GjB2iKYOPDgi8F18fzX7UyZUoSXbRyT6XOl81TNZ+/V/yb7PrVXYk1tLVmrKkV5ljHPlN
	cuQnTfHvTgufAdKss9I09zj0GARA30527H45ri2FsxBDR4/TGQEX9um9ofxU48BQcb3dGcK
	9czwkczq7KR19IucWE+4tDOqADUfFkLMQm0bdErXPGmfu18LTXCQNRiRxCLMpQ2SdM8jHff
	F9ajPdUg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes:
> 
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 7/12/2025 5:51 AM, Lidong Yan wrote:
>>> To enable optimize multiple pathspec items in revision traversal,
>>> return 0 if all pathspec item is literal in forbid_bloom_filters().
>>> Add for loops to initialize and check each pathspec item's bloom_keyvec
>>> when optimization is possible.
>> 
>> The patch itself is good.
>> 
>>> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
>>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> 
>> Here, I'll just point out that your sign-off should follow mine
>> because you were the last to touch the patch. In this way, the
>> sign-off gives a kind of timestamp to who made the most-recent
>> changes (and that those changes have that person's sign-off,
>> and may not have been vetted by previous signers).
> 
> Thanks for pointing it out.  Also perhaps a single-liner attribution
> to clarify who did what, e.g.
> 
> Signed-off-by: Derrick
> [ly: did this and that to derrick's code to adjust]
> Signed-off-by: Lidong

I will fix the order of the sign-offs, add the attributes, and resend
PATCH v6 5/5.

Thanks,
Lidong
