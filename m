Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D417201266
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955285; cv=none; b=Qbtii5ri3QMqEmoilZHcPFYv/23CWgfwHv8b4hPxSCMHM8pUr4u/gOziDsNz1owBJEd7RmfDEpjPWNqdee2Ww2iUF2SM69aLZjCbakyxrQrRbjyUv9H/6qwGrv0xjH+yMDESVJDK6OxCILjSR7OQNcOihSM4usPxJdVn45hIdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955285; c=relaxed/simple;
	bh=QsNcGaUxqLBDU8xRUDWIEOzZg/3i+s/ZxAdTaOqZiVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qknX2iO+HsW74mkyQcAiXmvqKEoefcm2GIgwiB1euA/yDqVuTQBkzeTuV+kB2+yqANNe/V77L9+is6Q0J6U5GY9hZ3ddb9rwv5RALpGjVjfOh9XyKUvs7VRNo6lgHqmxV9tIyAOm+ooQ8vNpHSPUxGEEdBFvmuLearMye90M6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8698 invoked by uid 109); 2 Jul 2024 21:21:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Jul 2024 21:21:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28987 invoked by uid 111); 2 Jul 2024 21:21:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Jul 2024 17:21:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Jul 2024 17:21:21 -0400
From: Jeff King <peff@peff.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	limin <1159309551xcz@gmail.com>, git@vger.kernel.org
Subject: Re: Git remote origin leaks user access token
Message-ID: <20240702212121.GC120950@coredump.intra.peff.net>
References: <CALFtjBBvk+JPmU_GzrnM=ANwaQDdiLtzh4YkZFbcVENyCu9fxA@mail.gmail.com>
 <ZoKW-yDJMsz9JPSI@google.com>
 <ZoLY_yxpQBjmp8O3@tapette.crustytoothpaste.net>
 <20240701183515.GF3199@coredump.intra.peff.net>
 <ada57994-b7cc-4a21-b41d-400d63b243d5@zytor.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ada57994-b7cc-4a21-b41d-400d63b243d5@zytor.com>

On Tue, Jul 02, 2024 at 02:13:47PM -0700, H. Peter Anvin wrote:

> > One thing we could do is refuse to store credentials in plaintext
> > config. That helps people who aren't aware of the recommendations you
> > mentioned end up more secure (though at the expense of convenience, as
> > subsequent fetches won't work if you don't have a credential helper set
> > up).
> > 
> > Some old discussion and possible patches here if anybody wants to pick
> > up the topic:
> > 
> >    https://lore.kernel.org/git/nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet/
> > 
> 
> That could be a default, but please in that case add an override option. I
> can't even begin to list the number of fail whales that have been committed
> in the name of "security" without some kind of No Dammit I Really Mean It™
> override. Everything from MTAs refusing to deliver to shared mailboxes for
> role accounts (due to giving group access) to being unable to connect to old
> embedded devices because "SSL 3 is dangerous and deprecated" -- which, of
> course, is true, but when you are on an isolated network and can't downgrade
> the existing device to unencrypted and can't upgrade it to TLS, it is an
> amazing headache.

The patches there would actually work out of the box, because they
replace the config storage with the janky plaintext git-credential-store
mechanism. But it was that final compatibility step that I think made me
question whether it was really accomplishing much at all.

I do agree there should be an option to override, though (you can always
run "git config remote.origin.url" yourself, but I think it should be as
simple as a config or command line option to get the old behavior).

-Peff
