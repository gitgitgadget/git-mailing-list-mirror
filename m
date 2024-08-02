Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3DD1EB4B8
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722569961; cv=none; b=pa4/KbVRtJm+ZLWyFwgxnlb3sENVy19Nyp9qkKKFQ+/yFmJzfn7o5V9h95L/fJn3A4m6XWQuyPl1fFmL80VP7mHUOJ7L87oqx15xG16ag2HPdSrK8JJhgs29h0J6J+uMws/oZo5VOxSH0qq6mcDnLbc9g01k88Irh1Ans9055hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722569961; c=relaxed/simple;
	bh=tyPZCKCJ5Jxo/6j0U3iHcEbMHN+MUJh8ZP8PDdRpe88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT3qbJHt4Uudl4B7LoZ/mF9pe4VUVRlma+LOJiwEAxsJzfCZ+Qfme64NU7a/WKgmN2UJv9eFm94+/fl7aqJV+W3J/qeG8z9ozMMuKCp8sZK5S8Kq+a+sVy42w38vgJvjpoUf3+eNpIyMPJcEf6jR1antTGDySJ1GI0td8Ij3YGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26813 invoked by uid 109); 2 Aug 2024 03:39:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Aug 2024 03:39:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7005 invoked by uid 111); 2 Aug 2024 03:39:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 23:39:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 23:39:16 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Bug] Temp file use in t0018.6
Message-ID: <20240802033829.GA1246312@coredump.intra.peff.net>
References: <02d401dae43e$c076b000$41641000$@nexbridge.com>
 <xmqqbk2cum5o.fsf@gitster.g>
 <02e101dae443$d01575a0$704060e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02e101dae443$d01575a0$704060e0$@nexbridge.com>

On Thu, Aug 01, 2024 at 02:51:17PM -0400, rsbecker@nexbridge.com wrote:

> >Thanks for noticing.  Are there other reference to /tmp in our test
> >suite I have to wonder...
> 
> Other than t0018...
> * t0060 references /tmp but only for a synthetic repo path

This is OK; we're just doing string manipulation on the path.

> * t1300 extensively uses /tmp with hard-coded file names for cookies.

Likewise, this test is just covering the config code. The actual
contents of the variables are not used.

> * t7400 appears to work with submodules in /tmp but that may only be a
> reference

This does do a "submodule init" with that path. But since we only care
about the string handling of the relative URL, we never actually do a
"submodule update", so we never look at the path.

> * t9902 hard-codes a reference to the user home directory ~/tmp, which might
> be fine
>    but prevents parallel tests

Remember that in the test environment, $HOME is the trash directory. So
this "~/tmp" is inside there, and parallel tests each get their own.

I tried doing a "sudo chmod 755 /tmp" and running the test suite, to see
if there were other cases. Lots of stuff fails, because processes want
to make temporary files behind the scenes (git itself, but also
sub-programs like gpg). Those cases are all OK; they do touch /tmp, but
they should be getting their own randomized files.

Setting TMPDIR=/some/actual/path on top of that yields only two
failures:

  - t5541 fails on push certificate inspection over http. I suspect this
    is because we are running gpg on the server side, and apache does
    not pass our custom TMPDIR through the CGI environmentT.

  - t7528 seems to fail to invoke ssh-agent. Probably ssh-agent is
    unhappy with the unwritable /tmp.

So I don't think there's anything else we need to fix on our end, though
possibly some of the cosmetic uses of /tmp could make it more clear we
do not expect the path to exist by using file:///some/repo.git, etc.

-Peff
