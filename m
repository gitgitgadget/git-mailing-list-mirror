Received: from mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07703493658
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787431652; cv=none; b=eTD9ha0ZrsOn9kXGcmgiwufUvuewIhBziKi40JXDE4VNSLvlI5RkM89IRJ5FRfHq8cWpwdVc6V02sY1I/xh3WyRCK1CBgSek6p+pN3QqMgdof1HrwfBdT5fPaFG6MEYK7yiADRksoMfQFu0qTZCO1+OIqofmPjOd94UVSYyklfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787431652; c=relaxed/simple;
	bh=bJOf1rlgcyVaLGtO+uRKgrN49a3X/aA44p6nfVznqcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC3NwjHPWftUjis3JsoDz70s+D8Qo0pqWOW6e4M88GuRN82WQs/clhHIMFcyTds/RZgTqqPqKdlthjBgb0y5tMPTTWnAw4x3XSgNO5KazIvIbdLxwZIeI5m6MhMc2MYSR8Sl6wOMFvMgk6PQMG3B3QPvsXsaW6X06FtSMYvflfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc; spf=pass smtp.mailfrom=mvdan.cc; dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b=AFCVa1Ii; arc=none smtp.client-ip=95.215.58.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b="AFCVa1Ii"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bJOf1rlgcyVaLGtO+uRKgrN49a3X/aA44p6nfVznqcs=;
 c=simple/simple; d=mvdan.cc;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787431646; v=1; x=1788036446;
 b=AFCVa1IioY0hFWqalCEXRzb0MZfPPkF5L+dcSroDCYicgu1IAgBNk+uCYafh0gQUk/9JSHiQ
 HXtVm6QC0MspnQ8mV2KWldBZHa+rL2kNjDlJ4yNG/U2GYDnSKKcMOCfcZfz/MIUyGnhC6e/qn+2
 E+UVB1AmzfcC1bK4ncAkvY5s=
X-Envelope-To: git@vger.kernel.org
Received: from [IPV6:2a02:6b6f:ea56:2100:e59a:61c0:de61:63be] (2a02:6b6f:ea56:2100:e59a:61c0:de61:63be)
	by smtp.migadu.com with ESMTPS id 0b21dfa7a8a8a8b6;
	Sat, 22 Aug 2026 20:47:16 +0000
X-Mizu-Trace-ID: 0b21dfa7a8a8a8b6
X-Migadu-Flow: FLOW_OUT
Message-ID: <a60afe54-7059-4827-8c3b-dfe01a0cde9c@mvdan.cc>
Date: Sat, 22 Aug 2026 21:47:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] credential/libsecret: load secrets explicitly
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Daniel_Mart=C3=AD_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
 <331e94ec-c07a-4d56-938d-d12c9a0cc5c9@mvdan.cc> <xmqq33w8sjcg.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>
In-Reply-To: <xmqq33w8sjcg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio, thanks very much for your review. I also do not program Gnome,
so this is just based on my best effort research :)

Junio C Hamano <gitster@pobox.com> writes:
 > The above makes it sound like we can just request with
 > secret_service_search_sync() exactly the same way as before (i.e.,
 > with LOAD_SECRETS), and then check with secret_item_get_secret()
 > to see if it has secret value in it.  The problem with the current
 > code is that we do not validate what that secrete value is (iow, we
 > do not say "ah, NULL, we should not assume we do have secret already
 > obtained here").
 >
 > So does the first hunk to drop _LOAD_SECRETS really needed?

Not strictly; your version would avoid the assertion failures too.

I dropped the flag because it isn't the single call it appears to be:
libsecret implements SECRET_SEARCH_LOAD_SECRETS as the SearchItems
D-Bus call followed by a separate GetSecrets call covering the matched
items, with any error from that second step discarded. It also skips
locked items on the client side without even asking the daemon, so
SECRET_SEARCH_UNLOCK having silently failed is one way to end up with
a NULL secret. The patch does SearchItems plus one GetSecret for the
one item we use, so the common case is the same two round trips either
way; it is your fallback version that would add a third in the rare
case. That is what the "cost is unchanged" paragraph in the commit
message is trying to say.

Keeping the flag with a fallback load would also mean the explicit
load only runs during the rare race, so that path would go essentially
unexercised, and load errors on the common path would still be
silently discarded. With the unconditional load there is one code
path, taken on every run, and any failure produces a real error
message.

 > I am also assuming that this is a race condition that is not very
 > easy to reliably reproduce in the test, so I wouldn't expect it to
 > come with a test to ensure that the fix will not regress in the
 > future (in other words, lack of patch to t/ directory is fine).

Right, it needs a concurrently-racing process (or a locked keyring)
to trigger, so I don't see a way to test it reliably.

Thanks!

