Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1EC2510C
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10596D56
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 14:05:47 -0800 (PST)
Received: (qmail 21657 invoked by uid 109); 13 Nov 2023 22:05:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Nov 2023 22:05:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7162 invoked by uid 111); 13 Nov 2023 22:05:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Nov 2023 17:05:49 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Nov 2023 17:05:46 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <20231113220546.GB2065691@coredump.intra.peff.net>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
 <ZU7X3N/rqCK/Y9cj@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZU7X3N/rqCK/Y9cj@nand.local>

On Fri, Nov 10, 2023 at 08:24:44PM -0500, Taylor Blau wrote:

> > This does mean that for a recursive merge, that you'll get up to 2*N
> > packfiles, where N is the depth of the recursive merge.
> 
> We definitely want to avoid that ;-). I think there are a couple of
> potential directions forward here, but the most promising one I think is
> due to Johannes who suggests that we write loose objects into a
> temporary directory with a replace_tmp_objdir() call, and then repack
> that side directory before migrating a single pack back into the main
> object store.

I posted an alternative in response to Elijah; the general idea being to
allow the usual object-lookup code to access the in-progress pack. That
would keep us limited to a single pack.

It _might_ be a terrible idea. E.g., if you write a non-bulk object that
references a bulk one, then that non-bulk one is broken from the
perspective of other processes (until the bulk checkin is flushed). But
I think we'd always be writing to one or the other here, never
interleaving?

-Peff
