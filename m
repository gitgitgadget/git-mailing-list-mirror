Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBFF1F461
	for <e@80x24.org>; Fri, 17 May 2019 04:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfEQEjm (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 00:39:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:60364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725929AbfEQEjm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 00:39:42 -0400
Received: (qmail 15423 invoked by uid 109); 17 May 2019 04:39:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 04:39:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10649 invoked by uid 111); 17 May 2019 04:40:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 May 2019 00:40:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 May 2019 00:39:39 -0400
Date:   Fri, 17 May 2019 00:39:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190517043939.GA12063@sigill.intra.peff.net>
References: <20190516214257.GD10787@sigill.intra.peff.net>
 <20190516231509.253998-1-jonathantanmy@google.com>
 <20190517010950.GA30146@sigill.intra.peff.net>
 <20190517012234.GA31027@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517012234.GA31027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 09:22:34PM -0400, Jeff King wrote:

> On Thu, May 16, 2019 at 09:09:50PM -0400, Jeff King wrote:
> 
> >   - will we ever append a presumed-thin base to the pack, only to later
> >     realize that we already have that object, creating a duplicate
> >     object in the pack? If so, do we handle this correctly when
> >     generating the index (I know we've had issues in the past and have
> >     expressly forbidden duplicates from appearing in the index; even
> >     having a duplicate in the pack stream itself is non-ideal, though,
> >     as it screws up things like on-disk size calculations).
> > 
> >     Because of the sorting in fix_unresolved_deltas(), I think this
> >     could easily be prevented if the non-thin delta is OFS_DELTA (by
> >     just checking for the base in our already-found list of objects
> >     before we call read_object_file(). But for REF_DELTA, I think we
> >     have no way of knowing that appending is the wrong thing (and no
> >     good way of backing it out afterwards).
> 
> Actually, I think even for REF_DELTA our pack-objects would never
> produce such a pack, because IIRC we _always_ put bases in the pack
> before their deltas. But that's a pretty subtle thing to depend on. I'm
> fine with it if violating it just means things are slightly less
> optimal. I'm more worried if it means that index-pack silently produces
> a bogus pack.
> 
> I think to trigger it you'd have to manually assemble an evil pack as I
> described (e.g., using the routines in t/lib-pack.sh). I'm going offline
> for a bit, but I may have a go at it later tonight or tomorrow.

OK, doing so wasn't _too_ bad, though I did have to resurrect the
horrible generator patch from [1]. My results are below. But more
importantly, there is good news.

As it turns out, index-pack does not handle these complicated cases at
all! In the final fix_unresolved_deltas(), we are only looking for thin
deltas, and anything that was not yet resolved is assumed to be a thin
object. In many of these cases we _could_ resolve them if we tried
harder. But that is good news for us because it means that these
expectations about delta relationships are already there, and the
pre-fetch done by your patch should always be 100% correct and
efficient.

If you knew this already and were wondering what I've been babbling
about this whole time, then apologies for the noise. If not, then I hope
you enjoyed this deep dive into the inner workings of our delta
resolution. :) This was a part of index-pack I hadn't really had to
touch before, so I learned a lot.

Here's the script I used to test this (the comments explaining what's
going on were obviously written _after_ I ran it and figured out why it
didn't work; I had initially expected the first one to pass).

I don't really think it's worth carrying these tests in our tree. I'm
mostly just showing my work.

-- >8 --
diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index c4d907a450..43785335e0 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -77,6 +77,18 @@ pack_obj () {
 			;;
 		esac
 		;;
+
+	# blob containing "\7\1"
+	0231abe3332fca6abc6a7e0f8000473692ce8c83)
+		case "$2" in
+		01d7713666f4de822776c7622c10f1b07de280dc)
+			printf '\165\2\61\253\343\63\57\312\152\274\152\176' &&
+			printf '\17\200\0\107\66\222\316\214\203\170\234' &&
+			printf '\143\142\142\142\147\0\0\0\53\0\16'
+			return
+			;;
+		esac
+		;;
 	esac
 
 	# If it's not a delta, we can convince pack-objects to generate a pack
diff --git a/t/t1234-foo.sh b/t/t1234-foo.sh
new file mode 100755
index 0000000000..22f1e85f81
--- /dev/null
+++ b/t/t1234-foo.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='delta resolution torture tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-pack.sh
+
+# blobs that lib-pack.sh knows about
+A=0231abe3332fca6abc6a7e0f8000473692ce8c83
+B=01d7713666f4de822776c7622c10f1b07de280dc
+C=e68fe8129b546b101aee9510c5328e7f21ca1d18
+
+test_expect_success 'create local copy of object C' '
+	# contents from lib-pack.sh
+	printf "\\7\\76" | git hash-object -w --stdin
+'
+
+# Create a pack with a delta chain A->B->C. The important things are:
+#
+#   - these are all REF_DELTA, which is what lib-pack produces
+#
+#   - the delta from $C is thin; the receiver should have that object
+#
+#   - the base (if present) comes _before_ the delta in the file (we assume
+#     that the final delta resolution uses pack order to break ties)
+test_expect_success 'create thin pack' '
+	{
+		pack_header 2 &&
+		pack_obj $B $C &&
+		pack_obj $A $B
+	} >ba.pack &&
+	pack_trailer ba.pack
+'
+
+# In theory this could work if we noticed that we had just generated $B.
+# However, fix_unresolved_deltas() never looks in the pack; it assumes anything
+# we found at that point is thin, and looks only at our regular object
+# database for the base.
+test_expect_failure 'index ba.pack' '
+	git index-pack --fix-thin --stdin <ba.pack
+'
+
+# Same pack, but order reversed; the base comes after the delta.
+test_expect_success 'create thin pack' '
+	{
+		pack_header 2 &&
+		pack_obj $A $B &&
+		pack_obj $B $C
+	} >ab.pack &&
+	pack_trailer ab.pack
+'
+
+# This one is even less likely to work, because when we are processing $A and
+# look for its base $B, we would not yet have processed $B. So we know nothing
+# about it.  It would take two passes (and in the general case, up to O(n)
+# passes) to resolve everything (assuming we even start looking in the current
+# pack for objects, as ba.pack would require).
+test_expect_failure 'index ab.pack' '
+	git index-pack --fix-thin --stdin <ab.pack
+'
+
+test_done
