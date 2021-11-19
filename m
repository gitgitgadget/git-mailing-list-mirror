Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB6C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 21:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhKSVbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:31:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:35336 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhKSVbe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 16:31:34 -0500
Received: (qmail 9239 invoked by uid 109); 19 Nov 2021 21:28:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 21:28:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19262 invoked by uid 111); 19 Nov 2021 21:28:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 16:28:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 16:28:30 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] refs: work around gcc-11 warning with REF_HAVE_NEW
Message-ID: <YZgW/pz6CbpaywDa@coredump.intra.peff.net>
References: <211115.86a6i5s4bn.gmgdl@evledraar.gmail.com>
 <YZLhrSoTzrC7wcQo@coredump.intra.peff.net>
 <YZQUxkYI3TES3vDo@nand.local>
 <YZQhLh2BU5Hquhpo@coredump.intra.peff.net>
 <xmqqwnl5ujxw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwnl5ujxw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 03:23:55PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	/*
> > +	 * Should be a noop per the ALLOWED_FLAGS check above, but this
> > +	 * is necessary to work around a problem with some versions of
> > +	 * "gcc -O3 -Wnonnull", which otherwise thinks that you can have the
> > +	 * flag set with a NULL new_oid.
> > +	 */
> > +	flags &= ~REF_HAVE_OLD | REF_HAVE_NEW;
> 
> Are you missing parentheses around ~(OLD|NEW)?

Whoops, yes. Interesting that the compiler is still happy enough with it
to prevent the warning (it does clear OLD, but not NEW). I also expected
it to be a bug the tests would catch, but because of the OR it clears
nothing except REF_HAVE_OLD.

It probably should just be spelled using the ALLOWED_FLAGS constant,
though. See the patch below.

> > Reading over the code, it all looks OK. And that size is...weirdly huge.
> 
> The original bug is really annoying and this looks even worse.
> Hopefully it won't come down from experimental to more stable tracks
> before they are corrected.

Yeah, I'm willing to ignore that one for now. But we probably should
deal with the gcc-11 one. Here's a cleaned-up version with a commit
message.

-- >8 --
Subject: [PATCH] refs: work around gcc-11 warning with REF_HAVE_NEW

Using gcc-11 (or 12) to compile refs.o with -O3 results in:

  In file included from hashmap.h:4,
                   from cache.h:6,
                   from refs.c:5:
  In function ‘oidcpy’,
      inlined from ‘ref_transaction_add_update’ at refs.c:1065:3,
      inlined from ‘ref_transaction_update’ at refs.c:1094:2,
      inlined from ‘ref_transaction_verify’ at refs.c:1132:9:
  hash.h:262:9: warning: argument 2 null where non-null expected [-Wnonnull]
    262 |         memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In file included from git-compat-util.h:177,
                   from cache.h:4,
                   from refs.c:5:
  refs.c: In function ‘ref_transaction_verify’:
  /usr/include/string.h:43:14: note: in a call to function ‘memcpy’ declared ‘nonnull’
     43 | extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
        |              ^~~~~~

That call to memcpy() is in a conditional block that requires
REF_HAVE_NEW to be set. But in ref_transaction_update(), we make sure it
isn't set coming in:

  if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
          BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);

and then only set it if the variable isn't NULL:

  flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);

So it should be impossible to reach that memcpy() with a NULL oid. But
for whatever reason, gcc doesn't accept that hitting the BUG() means we
won't go any further, even though it's marked with the noreturn
attribute. And the conditional is correct; ALLOWED_FLAGS doesn't contain
HAVE_NEW or HAVE_OLD, and you can even simplify it to check for those
flags explicitly and the compiler still complains.

We can work around this by just clearing the disallowed flags
explicitly. This should be a noop because of the BUG() check, but it
makes the compiler happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/refs.c b/refs.c
index d7cc0a23a3..33e8867a9c 100644
--- a/refs.c
+++ b/refs.c
@@ -1089,6 +1089,13 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
 
+	/*
+	 * Clear flags outside the allowed set; this should be a noop because
+	 * of the BUG() check above, but it works around a -Wnonnull warning
+	 * with some versions of "gcc -O3".
+	 */
+	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
+
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
-- 
2.34.0.635.gde47f84164

