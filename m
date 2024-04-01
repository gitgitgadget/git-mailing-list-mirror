Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D0DF59
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962400; cv=none; b=avfo1k8nQ55vV1FFHn8cLwXmXMCN//1/BvSfpz44eWcUW+3hK3JiTqi/3WoeRw8SuWMHubuUdmqs7CZTYG88vmmlbejEhmgVzKqmCUL5pMjdaNK8/RIO+xoRzZHVP3Y77zkF4zL8mPg+p7GzJ6D+hTz1SapYgaW3y0oaBQ2vwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962400; c=relaxed/simple;
	bh=+lYI7qDkZSkkojo/5mAt139WhFAQAAjiX6Nvnm2kCtg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJUb7WOnZ94p2PARdAfu6lvJ+WKkAJlAVtkGBgoNatzYsPVNxfWDVjrEiLHDEhtiN4Xtr7+Q8ASer4+zdkDCPW28UHcgCkkJ1fywlGqUFFG5GxhstMOMgrWIEtFqjIg1pIzoPgLDHc8mzPD6T9T12tCO8Y5GQ4NmwZXyfZ5kCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=tTEq90MP; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="tTEq90MP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962391; x=1712221591;
	bh=+lYI7qDkZSkkojo/5mAt139WhFAQAAjiX6Nvnm2kCtg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tTEq90MPUFlcS7JNBKPNf7jYx8Qcj1wGYPl2PrY+F5m1PCuv1e3On2VNrM0CrhkqU
	 dOn7ffTkrfvy7g/CdG4RGFw/yaaCyi737HV0CTPt7Mr2uxFTD8GvRbSgN6L30n0Ieb
	 a65Z4ViY8fuGvhfRtG62Hu0vaA80LmGzYuWuz4m3O9ROl8XmDIYlHoyPrJjYEri4Ov
	 enp9auyk2mDPfQIx4SYRAFPMywEEajfh61g1M2Cn/i6CeUmIiy//4/r0pMLhkxBSK7
	 ElGxoLa6AZ45zW3/CB3mTvOOT8uOd/km36PZiu955f15KeNkreT/YNsEO3Z5qIds5w
	 M0yYMogwdnP2Q==
Date: Mon, 01 Apr 2024 09:06:24 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/6] fast-import: release unfreed strbufs
Message-ID: <9DF24328-0128-4386-82E7-662D10267242@archibald.dev>
In-Reply-To: <ZgUod3QKptINaPBF@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev> <20240322000304.76810-4-thalia@archibald.dev> <ZgUod3QKptINaPBF@tanuki>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Resending as plain text)

On Mar 28, 2024, at 01:21, Patrick Steinhardt <ps@pks.im> wrote:
> I was about to propose that we should likely also change all of these
> static variables to be local instead. I don't think that we use the
> variables after the function calls. But now that I see that we do it
> like this in all of these helpers I think what's going on is that this
> is a memory optimization to avoid reallocating buffers all the time.
>=20
> Ugly, but so be it. We could refactor the code to pass in scratch
> buffers from the outside to remove those static variables. But that
> certainly would be a bigger change and thus likely outside of the scope
> of this patch series.


> Oh, now you get to my comment in the preceding patch. With this patch
> we're now in a somewhat weird in-between state where the buffers are
> still static, but we release their memory after each call. So we kind of
> get the worst of both worlds: static variables without being able to
> reuse the buffer's memory.
>=20
> If we were to change this then we should definitely mark the buffers as
> non-static. If so, it would be great to demonstrate that this does not
> significantly impact performance.
>=20
> The same is true for all the other instances.

I had glossed that they're `static`, since I've grown accustomed to Rust, w=
here
this sort of non-reentrant code is discouraged. However, this pattern is gr=
eat
for fast-import, because all of its data is simply freed when it exits at t=
he
end of the stream. I dropped this patch in v2.

I don't think it's worth hoisting these `strbuf`s out. It would only reduce=
 it
from 5 to 2 total static `strbuf`s for paths, but would make ownership less
clear.

Thalia


