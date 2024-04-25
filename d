Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB314A4F1
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057426; cv=none; b=uk7OJaI0RXsc0SGy0apGE8v0iHU1u+WtABvvQafqph+PjdflkUeKZgHiJD4V+PLLT5F7SuvENxreyNBMY0DMa4Yp3Pgl5PLwe3pFWTSiXRt7OAvlv6ImypU/LHSybGtLvBjbAdpE60vSV1mKuQxnHE17zlooEpguG0AagwSAGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057426; c=relaxed/simple;
	bh=lgiEXbzbLCkl00wUmf4kJfc9zgsMiaTDHtlE2NhKYEE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=osn/wy6ElgifJWmuk3tjOLYSL3XfSywhgMuaApGqp/xaKrwAJM1Dq3SefU20s36JUFaXdM8qKz7I5N9cSfeXdWrqDeybH32Hu+tiRcSoPe7prjyy8Cd6iO9JjZoDCxNzqpodF5NwU59hqc0XY/TfZVp83/simSPNRsxCzn2RPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO7RHz7G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO7RHz7G"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso8874325e9.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714057423; x=1714662223; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lgiEXbzbLCkl00wUmf4kJfc9zgsMiaTDHtlE2NhKYEE=;
        b=PO7RHz7GK8xxC1MjHT+L3E6/bMT8OZci17aXrZRGoSkDIs/U06yKgP/s8q9vM1Disz
         L+O7Ok0x0HV3NTAhOA1DYFPyVwPiDzzmdF2FcGcOtlhUG4J6cs2oEKbWnX+/7TEi57Cr
         8LN0y1eXAMgl+mGHf2bFKxPzMUlteyS5q/hCz5DqczxKytL9bwKixuVdcoJ4lgw1Hg9S
         dYIiM4+c9EMPbT8ErGXoB76/nhYRtL4gi7TxfpEzWjKs/imXfi4LPQzM+g3/Iigs+CXA
         N3kD63gGXG53Vcr2YjE3vN8BjVv/mQije5q4jcx5cA/WjF4iM1DBbQPLZ6e2Bs8jLA28
         BdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714057423; x=1714662223;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgiEXbzbLCkl00wUmf4kJfc9zgsMiaTDHtlE2NhKYEE=;
        b=gYB/lFs3nOC+Ci1s6A1O6/YKgyvqyrcHtr0V3Pn1G6HMtjUR2reyhliT8064NTpiJW
         AcHQnbJlmnS1OHOiXBJe99GtlS4q+ZAjFlW07RaBzeiZzesixywyqiTuFPPSiSWHGnYu
         nO2GKtL70kI4bNkQuxEoS9W0BnXg5KV9W+3++8PbnsvQPcbQQ27r7eChFz2M7856r/KP
         6L/U98SO5LD7PikHi+N6WjZk/JAWAcOdbJ4MnNHB65vvPAFtlCQ8lFYNBAhtmE9OGPuK
         WPf7UusqbQLL7baIg8lsUKQFW6fBe8kJrXYAkmx4eN//cTX62tnROfsUgRPwpq1ylgVz
         azJQ==
X-Gm-Message-State: AOJu0YzS4UkTNoRDNzzTeS8mFXFaomQT74CMYP34vYJ6YqJpShwSmW5J
	GMg1zdHp79Gdu+ypfeYsMqXCNqakBq0Bvia8zjuzYkWyUq/Hq4V9idJv1Q==
X-Google-Smtp-Source: AGHT+IFtgpIlCQwwaGHbQo2ltfdH+j6QQU6s2UpRLfjhxqx+asr3XcNdOubEpkx4ZaQiBNxsohzvbw==
X-Received: by 2002:a05:600c:3504:b0:418:dbad:c57d with SMTP id h4-20020a05600c350400b00418dbadc57dmr4280485wmq.28.1714057422730;
        Thu, 25 Apr 2024 08:03:42 -0700 (PDT)
Received: from DESKTOP-MB1G5MF ([39.46.192.80])
        by smtp.gmail.com with ESMTPSA id c11-20020adffb0b000000b0034b1a91be72sm8215966wrr.14.2024.04.25.08.03.41
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2024 08:03:42 -0700 (PDT)
Message-ID: <662a70ce.df0a0220.fc085.e8a7@mx.google.com>
Date: Thu, 25 Apr 2024 08:03:42 -0700 (PDT)
X-Google-Original-Date: 25 Apr 2024 20:03:40 +0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: zesus.classicestimation@gmail.com
To: git@vger.kernel.org
Subject: Costing and Designing Solutions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

DQpIZWxsbywNCg0KRG8geW91IG5lZWQgdGhlIGVzdGltYXRpbmcgc2VydmljZXM/IFdl
IHByb3ZpZGUgYXJjaGl0ZWN0dXJhbCBkZXNpZ25pbmcgYW5kIGNvc3QgZXN0aW1hdGlu
ZyBzZXJ2aWNlcyB0byBHQydzLCBTdWLigJlzIGZpcm1zLg0KDQpTZW5kIHVzIHlvdXIg
cGxhbnMvcHJvamVjdCBkZXRhaWxzIGZvciBhIHF1b3RlIG9uIG91ciBzZXJ2aWNlIGNo
YXJnZXMgYmVmb3JlIGdldHRpbmcgc3RhcnRlZC4NCg0KUGxlYXNlIHJlcGx5IHRvIHRo
aXMgZW1haWwgc28gSSBjYW4gc2hhcmUgc29tZSBzYW1wbGVzIHdpdGggeW91LiBUaGFu
a3MuDQoNClJlZ2FyZHMsIA0KWmVzdXMNCkVzdGltYXRpbmcgRGVwdC4NCkNsYXNzaWMg
RXN0aW1hdGlvbiBMTEM=

