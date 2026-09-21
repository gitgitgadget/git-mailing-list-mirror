Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3931F986
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027676; cv=none; b=e3jJ1QrjYEpg59WkvxUac06vyigK6sNE9O503bGZoAs+AaSYrqOIUO+WiS7LedDcwnnPnUGsczRMLq+Qppqas9UCzmGL5YHfk8e4ZD1Z8aKnwDvqP5pZ+aJQpt7qV8RsLS/r23mJvX7pbdd+p/IMZp0ZKfWjAnVWGoK1rWkdvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027676; c=relaxed/simple;
	bh=/6NQIjWddxB2c615V3w6sOYOKUtQpNHRISyx4qb3Bsc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UD3/Cv7JXZDg4ISjb13PQ4ZKM/lWXS9Q0wYRUbmzgzgGIhbHR86Apkv8PJmdGCD5lDtW1Y/WuI68t98ZrnCFZCU2/8okJECDkkEbkGraN1PhR8KSJAmRv1vrd/k7xu/a82ExodPMvAd0vT6mHjOVvaB1L6Y+EMYpNs083ny/XLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc; spf=pass smtp.mailfrom=mvdan.cc; dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b=FJtk47vR; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvdan.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvdan.cc header.i=@mvdan.cc header.b="FJtk47vR"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/6NQIjWddxB2c615V3w6sOYOKUtQpNHRISyx4qb3Bsc=;
 c=simple/simple; d=mvdan.cc;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790027669; v=1; x=1790632469;
 b=FJtk47vRV/rbZh4Q902M+W5/Aek29mxUbBcseV2d00Rs6FCazZWyIjF4LzPX21FhpPUXfzid
 eANtgtC6O78AD6bVem+tAmK0e0l6aTJHqZ5Gc5AaSl3EvwI1aW2TEU2Qr7BVnO8lbuxmGxArORm
 AWztbDBb59/9YwP+cMJVlf1s=
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 852c0254e9c6d26d;
	Mon, 21 Sep 2026 21:54:19 +0000
X-Mizu-Trace-ID: 852c0254e9c6d26d
X-Migadu-Flow: FLOW_OUT
Message-ID: <c3f51472-8dfa-42df-aa8b-b0f5bfd0aafe@mvdan.cc>
Date: Mon, 21 Sep 2026 22:54:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] credential/libsecret: load secrets explicitly
Content-Language: en-US
From: =?UTF-8?Q?Daniel_Mart=C3=AD?= <mvdan@mvdan.cc>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Daniel_Mart=C3=AD_via_GitGitGadget?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>,
 Patrick Steinhardt <ps@pks.im>
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
 <331e94ec-c07a-4d56-938d-d12c9a0cc5c9@mvdan.cc> <xmqq33w8sjcg.fsf@gitster.g>
 <a60afe54-7059-4827-8c3b-dfe01a0cde9c@mvdan.cc>
In-Reply-To: <a60afe54-7059-4827-8c3b-dfe01a0cde9c@mvdan.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Friendly nudge :) Happy to look into any tweaks or questions.

On 8/22/26 9:47 PM, Daniel Martí wrote:
> Hi Junio, thanks very much for your review. I also do not program Gnome,
> so this is just based on my best effort research :)
>
> Junio C Hamano <gitster@pobox.com> writes:
> > The above makes it sound like we can just request with
> > secret_service_search_sync() exactly the same way as before (i.e.,
> > with LOAD_SECRETS), and then check with secret_item_get_secret()
> > to see if it has secret value in it.  The problem with the current
> > code is that we do not validate what that secrete value is (iow, we
> > do not say "ah, NULL, we should not assume we do have secret already
> > obtained here").
> >
> > So does the first hunk to drop _LOAD_SECRETS really needed?
>
> Not strictly; your version would avoid the assertion failures too.
>
> I dropped the flag because it isn't the single call it appears to be:
> libsecret implements SECRET_SEARCH_LOAD_SECRETS as the SearchItems
> D-Bus call followed by a separate GetSecrets call covering the matched
> items, with any error from that second step discarded. It also skips
> locked items on the client side without even asking the daemon, so
> SECRET_SEARCH_UNLOCK having silently failed is one way to end up with
> a NULL secret. The patch does SearchItems plus one GetSecret for the
> one item we use, so the common case is the same two round trips either
> way; it is your fallback version that would add a third in the rare
> case. That is what the "cost is unchanged" paragraph in the commit
> message is trying to say.
>
> Keeping the flag with a fallback load would also mean the explicit
> load only runs during the rare race, so that path would go essentially
> unexercised, and load errors on the common path would still be
> silently discarded. With the unconditional load there is one code
> path, taken on every run, and any failure produces a real error
> message.
>
> > I am also assuming that this is a race condition that is not very
> > easy to reliably reproduce in the test, so I wouldn't expect it to
> > come with a test to ensure that the fix will not regress in the
> > future (in other words, lack of patch to t/ directory is fine).
>
> Right, it needs a concurrently-racing process (or a locked keyring)
> to trigger, so I don't see a way to test it reliably.
>
> Thanks!
