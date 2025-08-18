Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6B222173A
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550695; cv=none; b=rz6xne/aBnTppCrRuFT2ZQWSAe8hHrwFKS5X45VOEjWcvaAKU1R+tb1qxD5+1U76KgcKxDmlAMqOF6tGWjnAnQvLD/qEuIKO11VOlk6QfBmsOvTpJXDm+Q1sDwdb+58uikwaSRaBZ4Pb4RmWm5Jv1j+cfknwI1pq1h2KbblAPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550695; c=relaxed/simple;
	bh=P4tCR4orzzxiR/k3DshM7mG/cNm1jmBJb9maR6hQ42w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhPQmZA3Ocl3CBQahbu5QIMPzjD4J1ADOqiIfWwUWsYexxof+uBV+YeDtV29mY8r3FG8xggcgBVSXRnrKrCVeWzw8/DwlA2Rfh+WGqb+cI9Uqb651SYHnDQqH6b54au0M1qDlmEFvus0b3nEvDq7Jt+JXFvgsMje/epQza0HBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MVHDGe7y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MVHDGe7y"
Received: (qmail 23247 invoked by uid 109); 18 Aug 2025 20:58:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=P4tCR4orzzxiR/k3DshM7mG/cNm1jmBJb9maR6hQ42w=; b=MVHDGe7y/9+agpUqAHsXRvpwoifvJcoyRhyTLP7r/DlmEOuTqFPv8+5PhhMtSvuRRFTaNLb6Z6aYpZLA3q3LTvE6tmF6uK15uQOuTJFudShmxY+dRC+YeIRxOih5/zs1TaloIoX84DFnfGkm22mytX5q70dwVQflkM5INy/wrVTYI/1PLw4/D5EgXt7hpoZJDyUGNJANQtL6x01ucdIEZ5ey46yMb89HjhILxsh/m/WDM6REjV6XB3/kZhW8TWp4eDwI8+5HQR3rQIFjqzp3uuIEoOOtUsD7IKMw5i3Sw9b0u4ABEHquL+ZSzV4sj/mBZ9KqFxn8JUCh77gQWJ7xLA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 20:58:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30242 invoked by uid 111); 18 Aug 2025 20:58:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 16:58:12 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 16:58:12 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: [PATCH 0/5] fix segfault and other oddities describing blobs
Message-ID: <20250818205812.GA1018043@coredump.intra.peff.net>
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
 <20250814232644.GC2937@coredump.intra.peff.net>
 <7f289d4f-0a9d-480d-a5a9-7f4d4d24626b@web.de>
 <20250818044807.GA51803@coredump.intra.peff.net>
 <20250818050545.GA62231@coredump.intra.peff.net>
 <194415e5-2adc-4b3f-98d3-0fde4a288b5c@web.de>
 <20250818202140.GA1014353@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818202140.GA1014353@coredump.intra.peff.net>

On Mon, Aug 18, 2025 at 04:21:40PM -0400, Jeff King wrote:

> I'll send out a few patches in a moment (I guess I summoned some
> willpower in the interim).

Here's what I came up with.

  [1/5]: describe: pass oid struct by const pointer
  [2/5]: describe: error if blob not found
  [3/5]: describe: catch unborn branch in describe_blob()
  [4/5]: describe: handle blob traversal with no commits
  [5/5]: describe: pass commit to describe_commit()

 builtin/describe.c  | 41 +++++++++++++++++++++++++----------------
 t/t6120-describe.sh | 14 ++++++++++++++
 2 files changed, 39 insertions(+), 16 deletions(-)

-Peff
