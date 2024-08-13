Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409484C8C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554127; cv=none; b=HV7JP4qbBc1jBP01A89nL5rDSVHlqk/uFDZ90UzAAYYey3fh9roKEFENYqQAZg4SGOMqqtHLqETgT49AfiOnM2/5JSq9u6AeMKF1DQjy34G/W/MS7/swcuY4gYZDieiwrbnKgOhZsAg1B7RexMJghC4d/s7doxh+qlHvG3mzdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554127; c=relaxed/simple;
	bh=61RbGSGGusriyJoM9nr8fHnFa2huaFQWKm4UXZWVCEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRRU3v0Gk2bE3C4dL1W4amOLOGmG7c/bZMsAcmkoTwjUgOI344qUm160v+2CVNnn9G0JP6FFhXmEK8WzIQYkPesfSIsNbU/RLqNlXzwXYQNUB8UAYe6+KalWJ+N7ww6821BoEQoFn+093+I/ehDSV/xl0VDzykdtbSdiKVy5A5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4700 invoked by uid 109); 13 Aug 2024 13:02:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Aug 2024 13:02:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6706 invoked by uid 111); 13 Aug 2024 13:02:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2024 09:02:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Aug 2024 09:02:03 -0400
From: Jeff King <peff@peff.net>
To: Matt Thompson <fortran@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] get_oid(): enforce minimum length for "-g<hex>" names
Message-ID: <20240813130203.GE968816@coredump.intra.peff.net>
References: <CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com>
 <xmqqy15b2aiz.fsf@gitster.g>
 <CAFb48S8+X0=Zqi8oisB0fAgx7HoyQrahF-RGQdagXTX3RdfSNQ@mail.gmail.com>
 <20240813115358.GB968816@coredump.intra.peff.net>
 <20240813124550.GC968816@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813124550.GC968816@coredump.intra.peff.net>

On Tue, Aug 13, 2024 at 08:45:50AM -0400, Jeff King wrote:

>   3. Looking at the loop in get_describe_name(), we read from the back
>      end and check for "-g" when we see a non-hex digit. But if it's not
>      "-g", we keep looking! So for a name like "foo-g1234abc-bar", we'll
>      still pass "1234abc-bar" to get_short_oid()! This is OK in
>      practice, since it will barf when seeing the non-hex digits. But
>      let's confirm that it does so. This is particularly important
>      with our length checks, since "foo-gcc14-bar" would yield a length
>      of 8, which is plausibly long (so we are likewise depending on
>      get_short_oid() to reject it).

So I think the current code is working as we'd want, and there's no
correctness issue. I do think breaking out of the loop early would be
more clear (and would provide a tiny speedup). Like:

diff --git a/object-name.c b/object-name.c
index 6507a30ace..89de9db8e9 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1263,35 +1263,36 @@ static int peel_onion(struct repository *r, const char *name, int len,
 static int get_describe_name(struct repository *r,
 			     const char *name, int len,
 			     struct object_id *oid)
 {
 	const char *cp;
 	unsigned flags = GET_OID_QUIETLY | GET_OID_COMMIT;
 
 	for (cp = name + len - 1; name + 2 <= cp; cp--) {
 		char ch = *cp;
 		if (!isxdigit(ch)) {
 			/* We must be looking at g in "SOMETHING-g"
 			 * for it to be describe output.
 			 */
 			if (ch == 'g' && cp[-1] == '-') {
 				/*
 				 * To reduce the chance of false positives,
 				 * assume that any "-g<hex>" must have some
 				 * minimum number of <hex> that matches what
 				 * we'd produce when abbreviating.
 				 */
 				int min_len = default_abbrev;
 				if (min_len < 0)
 					min_len = FALLBACK_DEFAULT_ABBREV;
 
 				cp++;
 				len -= cp - name;
 				if (len < min_len)
 					return -1;
 				return get_short_oid(r,
 						     cp, len, oid, flags);
 			}
+			break;
 		}
 	}
 	return -1;
 }


But I don't know that it matters much in practice.

-Peff
