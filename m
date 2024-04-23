Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8D20B3E
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908367; cv=none; b=lsVQZVUJqbJjT+45K0XTwFP0pd1+2e32jqfOhB9uavBCPVCZv/gwhEa/Yfr2hI9jnmgMxVemg/LQbi+UzX2goeo6HVLQ4E7tZ2hOce7CCWjiMki+n0QQDscmqJtjxnPqc1S64+8tBeX0aKid9Dayz4aYEX81s5HCJTDsQGOMErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908367; c=relaxed/simple;
	bh=ytBD+owfi/+m6DseT7yYq48GwcB/mquJeIejdf7iBR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bqo4zZP4Mbq1PjQ4UtLz0xTKzIiP/QDTH6X11rmfI9MFbCTGmyesgF920YEtS/ynrmjvpD79K655erVOLAvIRJEPgZGxr5N740BQavLasJeEntRtEvcjF09q9wES/WoZbXRs0gRvyvCdmyhI5y5nFCoMRZTYg2edNNt+4SzufGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7854 invoked by uid 109); 23 Apr 2024 21:39:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Apr 2024 21:39:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4873 invoked by uid 111); 23 Apr 2024 21:39:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Apr 2024 17:39:18 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Apr 2024 17:39:15 -0400
From: Jeff King <peff@peff.net>
To: Calvin Wan <calvinwan@google.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] osxkeychain: restrict queries to requests with a valid
 host
Message-ID: <20240423213915.GA1172807@coredump.intra.peff.net>
References: <20200420224310.9989-1-carenas@gmail.com>
 <20240422194824.340464-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422194824.340464-1-calvinwan@google.com>

On Mon, Apr 22, 2024 at 07:48:12PM +0000, Calvin Wan wrote:

> > diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> > index bcd3f575a3..2264a88c41 100644
> > --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> > +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> > @@ -69,6 +69,12 @@ static void find_internet_password(void)
> >  	UInt32 len;
> >  	SecKeychainItemRef item;
> >  
> > +	/*
> > +	 * Require at valid host to fix CVE-2020-11008
> > +	 */
> > +	if (!host || !*host)
> > +		return;
> > +
> >  	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item))
> >  		return;
> >  
> > -- 
> > 2.26.2.111.gbff22aa583
> > 
> 
> We're currently using this patch downstream (removed the check for
> !*host after updates to this file), but I was wondering whether this
> change should also be in main. It seems like the discussion around this
> stalled and there was no definitive conclusion, but the change also at
> worst does nothing and could possibly be useful -- I see other functions
> where we're checking for the existence of "host". I wasn't around when
> all the changes around this CVE were happening so I'm not exactly sure
> how useful this patch this and whether we can get rid of it or not.

I think this is mostly redundant with the protection on the sending side
from 8ba8ed568e (credential: refuse to operate when missing host or
protocol, 2020-04-18).

Locking down the individual helpers more might be useful if they are run
as independent programs (e.g., you could run "osxkeychain" manually and
feed it input with a host, which would make its matching quite liberal).
But since there isn't a way to trigger it in a normal workflow with
untrusted input, I don't think there's much of a security implication.

Looking at the patch above, I think it may cause issues with protocols
that do not have a host (like "cert" ones we use for storing client-side
certificate passphrases). But I'm not sure that osxkeychain can handle
those anyway. I'm also not sure we didn't break that in 8ba8ed568e. That
patch allows an empty string for the host, and the code in http.c to set
up the credential struct for the cert uses an empty string. But doing a
trivial test seems broken:

  $ touch foo.cert
  $ git -c http.sslcert=foo.cert ls-remote ...
  fatal: refusing to work with credential missing host field

Curiously if you feed it a real cert and matching key, then curl itself
prompts for the passphrase! And if you provide the correct one, then it
does not need to check credential config/helpers, and it works. If you
provide a bad one, we hit that same message trying to "reject" it (and I
think that is what happens with the fake cert; curl likewise complains
and we try to erase the passphrase before trying again).

But that also means we have no opportunity to prompt/store ourselves, if
curl is handling it. If you set GIT_SSL_CERT_PASSWORD_PROTECTED, then we
do our own prompt ahead of time (and this correctly sets the hostname to
the empty string).

So the whole cert auth handling is kind of wonky, and it's not clear to
me that anybody actually uses it, or what's supposed to work and what
isn't.

That's all sort of a tangent to your question, of course. ;)

It is interesting that the fix we did in 8ba8ed568e still allows empty
string hostnames, as I think such a hostname would cause osxkeychain to
still liberally match its contents. So in that case maybe the patch
above is doing something? I dunno. I think the real protection is
avoiding either a NULL or empty-string hostname based on untrusted input
in the first place.

-Peff
