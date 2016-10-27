Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FCD520193
	for <e@80x24.org>; Thu, 27 Oct 2016 14:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942601AbcJ0OY1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 10:24:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:34851 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965841AbcJ0OYX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 10:24:23 -0400
Received: (qmail 16719 invoked by uid 109); 27 Oct 2016 10:24:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 10:24:21 +0000
Received: (qmail 19016 invoked by uid 111); 27 Oct 2016 10:24:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 06:24:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2016 06:24:19 -0400
Date:   Thu, 27 Oct 2016 06:24:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
Message-ID: <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com>
 <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
 <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
 <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
 <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 02:15:33PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Oct 26, 2016 at 10:52:41AM -0700, Junio C Hamano wrote:
> >
> >> > I actually wonder if it is worth carrying around the O_NOATIME hack at
> >> > all.
> >> 
> >> Yes, I share the thought.  We no longer have too many loose objects
> >> to matter.
> >> 
> >> I do not mind flipping the order, but I'd prefer to cook the result
> >> even longer.  I am tempted to suggest we take two step route:
> >> 
> >>  - ship 2.11 with the "atime has been there and we won't regress it"
> >>    shape, while cooking the "cloexec is semantically more
> >>    important" version in 'next' during the feature freeze
> >> 
> >>  - immediately after 2.11 merge it to 'master' for 2.12 to make sure
> >>    there is no fallout.
> >
> > That sounds reasonable, though I'd consider jumping straight to "NOATIME
> > is not worth it; drop it" as the patch for post-2.11.
> 
> That endgame is fine by me too.  Thanks for a sanity-check.

So here's that endgame patch. My main concern with it was that there
might be non-Linux systems that could be affected. But when I dug into
it, I found that this code was never activated anywhere besides Linux in
the first place. So I really doubt this will have any negative impact at
all. I certainly don't mind cooking it until post-2.11, though.

+cc Linus as the original author of 144bde78e9 in case there is
something subtle I'm missing, but this really just seems like it's
an outdated optimization.

-- >8 --
Subject: [PATCH] sha1_file: stop opening files with O_NOATIME

When we open object files, we try to do so with O_NOATIME.
This dates back to 144bde78e9 (Use O_NOATIME when opening
the sha1 files., 2005-04-23), which is an optimization to
avoid creating a bunch of dirty inodes when we're accessing
many objects.  But a few things have changed since then:

  1. In June 2005, git learned about packfiles, which means
     we would do a lot fewer atime updates (rather than one
     per object access, we'd generally get one per packfile).

  2. In late 2006, Linux learned about "relatime", which is
     generally the default on modern installs. So
     performance around atimes updates is a non-issue there
     these days.

     All the world isn't Linux, but as it turns out, Linux
     is the only platform to implement O_NOATIME in the
     first place.

So it's very unlikely that this code is helping anybody
these days.

It's not a particularly large amount of code, but the
fallback-retry creates complexity. E.g., we do a similar
fallback for CLOEXEC; which one should take precedence, or
should we try all possible combinations? Dropping O_NOATIME
makes those questions go away.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 09045df1dc..6f02a57d8b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -27,14 +27,6 @@
 #include "list.h"
 #include "mergesort.h"
 
-#ifndef O_NOATIME
-#if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
-#define O_NOATIME 01000000
-#else
-#define O_NOATIME 0
-#endif
-#endif
-
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
@@ -1561,7 +1553,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 
 int git_open(const char *name)
 {
-	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
+	static int sha1_file_open_flag = O_CLOEXEC;
 
 	for (;;) {
 		int fd;
@@ -1577,11 +1569,6 @@ int git_open(const char *name)
 			continue;
 		}
 
-		/* Might the failure be due to O_NOATIME? */
-		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
-			sha1_file_open_flag &= ~O_NOATIME;
-			continue;
-		}
 		return -1;
 	}
 }
-- 
2.10.1.916.g0d2035c

