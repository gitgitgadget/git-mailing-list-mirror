Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6933070
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4FD5
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:55:26 -0800 (PST)
Received: (qmail 3659 invoked by uid 109); 14 Nov 2023 21:55:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Nov 2023 21:55:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20917 invoked by uid 111); 14 Nov 2023 21:55:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Nov 2023 16:55:27 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Nov 2023 16:55:24 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org, "Eric W. Biederman" <ebiederm@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <20231114215524.GB12791@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <ZU7X3N/rqCK/Y9cj@nand.local>
 <20231113220546.GB2065691@coredump.intra.peff.net>
 <xmqqpm0d1591.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm0d1591.fsf@gitster.g>

On Tue, Nov 14, 2023 at 10:40:58AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I posted an alternative in response to Elijah; the general idea being to
> > allow the usual object-lookup code to access the in-progress pack. That
> > would keep us limited to a single pack.
> 
> If such a mechanism is done in a generic way, would we be able to
> simplify fast-import a lot, I wonder?  IIRC, it had quite a lot of
> code to remember what it has written to its output to work around
> the exact issue your alternative tries to solve.  In fact, maybe we
> could make fast-import a thin wrapper around the bulk checkin
> infrastructure?

I suspect that the implementation could be shared with fast-import. I'm
not sure it would save all that much code, though. There's a lot going
on in fast-import besides keeping track of which objects we wrote into a
pack. ;)

The bigger issue, though, is that fast-import does generate some deltas
and the bulk checkin code does not. And I'm not sure how the bulk
checkin interface would expose that API (you need the caller to say
"...and I suspect this object might be a good delta base").

-Peff
