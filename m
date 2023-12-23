Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F128F68
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18957 invoked by uid 109); 23 Dec 2023 10:18:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Dec 2023 10:18:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11519 invoked by uid 111); 23 Dec 2023 10:18:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Dec 2023 05:18:53 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 23 Dec 2023 05:18:53 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1006: add tests for %(objectsize:disk)
Message-ID: <20231223101853.GC2016274@coredump.intra.peff.net>
References: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
 <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
 <20231221094722.GA570888@coredump.intra.peff.net>
 <d44cb8e7-ffce-4184-b9b5-6bb56705dcd1@web.de>
 <20231221213034.GB1446091@coredump.intra.peff.net>
 <120b3194-5eee-47ed-b2d8-bc6731b71a6b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120b3194-5eee-47ed-b2d8-bc6731b71a6b@web.de>

On Fri, Dec 22, 2023 at 12:13:10AM +0100, René Scharfe wrote:

> >> Should we deduplicate here, like cat-file does (i.e. use "sort -u")?
> >> Having the same object in multiple places for whatever reason would not
> >> be a cause for reporting an error in this test, I would think.
> >
> > No, for the reasons I said in the commit message: if an object exists in
> > multiple places the test is already potentially invalid, as Git does not
> > promise which version it will use. So it might work racily, or it might
> > work for now but be fragile. By not de-duplicating, we make sure the
> > test's assumption holds.
> 
> Oh, skipped that paragraph.  Still I don't see how a duplicate object
> would necessarily invalidate t1006.  The comment for the test "cat-file
> --batch-all-objects shows all objects" a few lines above indicates that
> it's picky about the provenance of objects, but it uses a separate
> repository.  I can't infer the same requirement for the root repo, but
> we already established that I can't read.

The cat-file documentation explicitly calls this situation out:

  Note also that multiple copies of an object may be present in the
  object database; in this case, it is undefined which copy’s size or
  delta base will be reported.

So if t1006 were to grow such a duplicate object, what will happen? If
we de-dup in the new test, then we might end up mentioning the same copy
(and the test passes), or we might not (and the test fails). But much
worse, the results might be racy (depending on how cat-file happens to
decide which one to use). By no de-duping, then the test will reliably
fail and the author can decide how to handle it then.

IOW it is about failing immediately and predictably rather than letting
a future change to sneak a race or other accident-waiting-to-happen into
t1006.

> Anyway, if someone finds a use for git repack without -d or
> git unpack-objects or whatever else causes duplicates in the root
> repository of t1006 then they can try to reverse your ban with concrete
> arguments.

In the real world, the most common way to get a duplicate is to fetch or
push into a repository, such that:

  1. There are enough objects to retain the pack (100 by default)

  2. There's a thin delta in the on-the-wire pack (i.e., a delta against
     a base that the sender knows the receiver has, but which isn't
     itself sent).

Then "index-pack --fix-thin" will complete the on-disk pack by storing a
copy of the base object in it. And now we have it in two packs (and if
it's a delta or loose in the original, the size will be different).

-Peff
