Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CC66DD05
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8778 invoked by uid 109); 14 Dec 2023 21:40:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Dec 2023 21:40:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11607 invoked by uid 111); 14 Dec 2023 21:40:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Dec 2023 16:40:57 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Dec 2023 16:40:57 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH] mailinfo: fix out-of-bounds memory reads in
 unquote_quoted_pair()
Message-ID: <20231214214057.GA2297853@coredump.intra.peff.net>
References: <20231212221243.GA1656116@coredump.intra.peff.net>
 <ZXlYIZ0Hb1kN84NU@tanuki>
 <xmqqy1dynofo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1dynofo.fsf@gitster.g>

On Wed, Dec 13, 2023 at 06:54:03AM -0800, Junio C Hamano wrote:

> I actually had trouble with the proposed update, and wondered if
> 
> -	while ((c = *in++) != 0) {
> +	while ((c = *in)) {
> +		in++;
> 
> is easier to follow, but then was hit by the possibility that the
> same "we have incremented 'in' a bit too early" may exist if such
> a loop wants to use 'in' in its body.  Wouldn't it mean that
> 
> -	while ((c = *in++) != 0) {
> +	for (; c = *in; in++) {
> 
> would be even a better rewrite?

No, the "for" loop wouldn't work, because the loop body actually depends
on "in" having already been incremented. If we find the end of the
comment or quoted string, we return "in", and the caller is expecting it
to have moved past the closing quote. So that would have to become
"return in+1".

IOW, the issue is that the normal end-of-quote parsing and hitting
end-of-string are fundamentally different. So we either need to
differentiate the returns (either with "+1" on one, or "-1" on the
other). Or we need to choose to increment "in" based on which we found
(which is what my patch does).

-Peff
