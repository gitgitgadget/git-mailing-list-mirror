Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84C2698AF
	for <git@vger.kernel.org>; Thu, 15 May 2025 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273114; cv=none; b=R8ZRpwGp1SArRKO1ApNq9LNPhi+lFrwxEPzpHH8Y73FbVgkTTGtusH2mWqaMbi+wOhr4tar8SJ4/G7U657HD9fI5tdZXpxxevTuQFI/AbKGNQQEucidhBAHKNoQ82KQtNtI06p4jRmtngi7jVTzJpWWPpBrN9mdAq+Z6XnuZuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273114; c=relaxed/simple;
	bh=YbdtcQzNmm4CtOtmeI0BeG69/FrJyCQHRsu9tzPkWhY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pkouHVxQ1R+8ZUPLye8t8clyyMrfAUDcaqwAKwAlwHOKDnqdIfFuNLkleWklW8WuLowRHpadZM+5jK+knfVuTntRb/VoFmCyFqAZeCvU6shNyrR+KVaWftzoIaciw3sMGjO5Kd98Hjkrs2B78RV3hYOZds1Pgi5RKJtrmxHrs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz7t1747273071tf83a67e3
X-QQ-Originating-IP: D0CtAzJetilNSaNZYwPvRw+LzIhJT5laRq8HgL00lrA=
Received: from smtpclient.apple ( [36.152.24.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 15 May 2025 09:37:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8009572556527623847
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] pack-bitmap: fix memory leak if `load_bitmap_entries_v1`
 failed
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <20250514180325.GB2196784@coredump.intra.peff.net>
Date: Thu, 15 May 2025 09:37:39 +0800
Cc: Taylor Blau <me@ttaylorr.com>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <99DD81A9-DDF2-4D13-BDEC-9DD83C8E8423@smail.nju.edu.cn>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <20250512131315.GD1191360@coredump.intra.peff.net>
 <aCOFqYdnPp1Lne4Y@nand.local>
 <20250514180325.GB2196784@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M8P8Ot9e/QAQQZUNKMQDTskbfv1ewD4IPspWGLZUuCyCCGFNMd/NCSDr
	qBUc+vbsk6yLjAGj7azcJaeNSoBmFkm6rblmhPH5abmyNr4cTKhNsvJ5qIVmCcjloU/tRSw
	8h4A4VSPrHo/Fo85nc1ZZ64PMW73p4VYUAHOok8INHtj8AJxlnpSghLIs+gv735mqkRkQgg
	+VdNxV4Kak6z2tc1Un4u6UwY6Gw37BA7U5S/uH6x3pLwwddx0mIeH8iqxPOS2lDTM9biFrm
	fgI6MxUT4mUTRlsJ1ttQUZk8oehKehMraimxIzILFBC2pqy3xXw0ySX66ubTMBKnUHmp6YE
	P8KGSzQT0xfLQk9il4L7bntJ7Vn8qOljpMSU1b0MZ05M/Fv3hCTknNEnt2NlH9D2JiAX2+V
	oTZjSW/tXFT2xl3QnteeoWbcH3Vo3pfPQaRCUUKNhQBXBbwGJu+kOMwQ2k0FO7k7mI9Iotl
	7F1Ipz4w2YaHORTSZdKZHHB2m1mVX87smR9h9/VYRmPO4VooF9zY2AVe3XTPCpWC9lNskA4
	acPYrJfIZq71hzzbVR4vDiBlQhehGRhgUfaMUVm5p8gDTKqP1BPYHGtpbX7IYkB2cYOcouU
	CsGTWsiEmZRxtfjlvAukxG0/ZhyEj7fFhQEcBc48NlRVXl1Df+01H5S1G8pBBKDCP/3mH9F
	pUZ90PVim4bd6V4T+YdDhcEiFYdJ229fqt+8F2i/8Vu35GjVeX7rTF8tgNIL0U7W1YGPQeQ
	3uzwXibImk2ffse+FGsXRSXSYArdDO6Y8rNplSUdoinuoVKN4Rk83N1g5n0Ny0Mo1bGitGa
	Ot66nglj8sA5P5dsE7q5mlknjOirfFeAExjhPFtN0jT+e8Gt514exfdBdxruiGz3NvT4k8r
	3plvyDQ3c9wB1s3oqZ7a0HOEb+aDFtHqY52IwI/n9snz+zm2sR2hYxb13XF0v1arWFTuNiF
	hBM+1jdD9N3gcMx2gEWakupdN94XV2BsTajg5PHMumV7TYQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

On 15/5/2025 at 02:03=EF=BC=8CJeff King <peff@peff.net> =E5=86=99=E9=81=93=
=EF=BC=9A

> It would be nice if we triggered these cases in the test suite so that
> LSan could confirm that all leaks are covered. But I suspect it may =
not
> be worth the effort to craft a bitmap file that is broken in such
> particular ways.

I'd like to try coming up with some test cases for this.=
