Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA13D8E
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058065; cv=none; b=lJdH3YjzRk7ijkF5iKJbjM9jkpNOxjZQuO988TlvK0+M9Y84SJAqeyIWVV+wz/Qhwtu/ZN1yFgLHjpQvEt9/sHljEolNGsctMd+0kar70YsZe9HbkpvkM+p6MYzHGXuuvC/1gJGjWt9j9+eNQFD+jUkNtglsfCr126ytieOfLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058065; c=relaxed/simple;
	bh=BwTB2ixtbQEPWI+j83JR1PNKYXEmDtdV4YivpfnzS7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqz6OATP90DOlju6Og48lbUqO+gDNx2lbR1zqF4P92E43+opi6Oq/5cVNUfKO7m8wtRnTCSdkRXRT5VpxD0fwZ5vUThl7HQZxyJQmmMbC1SmWhzhTnwuH7tOOBSVeA7o9eDy8sCnkA3/rIjmiuqCVcjifYH6Ng3w9jkq+99dxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25680 invoked by uid 109); 24 Jan 2024 01:00:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jan 2024 01:00:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22392 invoked by uid 111); 24 Jan 2024 01:00:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jan 2024 20:00:57 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Jan 2024 20:00:56 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, bcmills@google.com
Subject: [PATCH] transport-helper: re-examine object dir after fetching
Message-ID: <20240124010056.GA2603087@coredump.intra.peff.net>
References: <ZbAqsf-2DWaXbN7K@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZbAqsf-2DWaXbN7K@google.com>

On Tue, Jan 23, 2024 at 01:08:01PM -0800, Josh Steadmon wrote:

> At $DAYJOB, we got a bug report that Git 2.21.0 breaks Go's CI due to
> not fetching all tags in the history. The bug reporter (Bryan, CCed) was
> kind enough to bisect this failure down to 61c7711cfe (sha1-file: use
> loose object cache for quick existence check, 2018-11-12). This was only
> recently discovered because Go's CI was using Git v2.17.6.
> 
> More details can be found in the original bug report [1] and Go's issue
> for the CI breakage [2].

Thanks, I was able to reproduce it. Besides using the v0 protocol, two
key elements are that the server is http and the use of --depth.

The patch below explains what's going on and should fix it. I prepared
the patch on top of 'master', but it can also be applied directly on
61c7711cfe or on v2.21.0, modulo some minor textual conflicts in the
test script (modern t5551 has some more tests, and no longer calls
stop_httpd manually).

-- >8 --
Subject: transport-helper: re-examine object dir after fetching

This patch fixes a bug where fetch over http (or any helper) using the
v0 protocol may sometimes fail to auto-follow tags. The bug comes from
61c7711cfe (sha1-file: use loose object cache for quick existence check,
2018-11-12). But to explain why (and why this is the right fix), let's
take a step back.

After fetching a pack, the object database has changed, but we may still
hold in-memory caches that are now out of date. Traditionally this was
just the packed_git list, but 61c7711cfe started using a loose-object
cache, as well.

Usually these caches are invalidated automatically. When an expected
object cannot be found, the low-level object lookup routines call
reprepare_packed_git(), which re-scans the set of packs (and thanks to
some preparatory patches ahead of 61c7711cfe, throws away the loose
object cache). But not all calls do this! In some cases we expect that
the object might not exist, and pass OBJECT_INFO_QUICK to tell the
low-level routines not to bother re-scanning. And the tag auto-following
code is one such caller, since we are asking about oids that the other
side has (but we might not have locally).

To deal with this, we explicitly call reprepare_packed_git() ourselves
after fetching a pack; this goes all the way back to 48ec3e5c07
(Incorporate fetched packs in future object traversal, 2008-06-15). But
that only helps if we call fetch_pack() in the main fetch process. When
we're using a transport helper, it happens in a separate sub-process,
and the parent process is left with old values. So this is only a
problem with protocols which require a separate helper process (like
http).

This patch fixes it by teaching the parent process in the transport
helper relationship to make that same reprepare call after the helper
finishes fetching.

You might be left with some lingering questions, like:

  1. Why only the v0 protocol, and not v2? It's because in v2 the child
     helper doesn't actually run fetch_pack(); it merely establishes a
     tunnel over which the main process can talk to the remote side (so
     the fetch_pack() and reprepare happen in the main process).

  2. Wouldn't we have the same bug even before the 61c7711cfe added
     the loose object cache? For example, when we store the fetch as a
     pack locally, wouldn't our packed_git list still be out of date?

     If we store a pack, everything works because other parts of the
     fetch process happen to trigger a call to reprepare_packed_git().
     In particular, before storing whatever ref was originally
     requested, we'll make sure we have the pointed-to object, and that
     call happens without the QUICK flag. So in that case we'll see that
     we don't know about it, reprepare, and then repeat our lookup. And
     now we _do_ know about the pack, and further calls with QUICK will
     find its contents.

     Whereas when we unpack the result into loose objects, we never get
     that same invalidation trigger. We didn't have packs before, and we
     don't after. But when we do the loose object lookup, we find the
     object. There's no way to realize that we didn't have the object
     before the pack, and that having it now means things have changed
     (in theory we could do a superfluous cache lookup to see that it
     was missing from the old cache; but depending on the tags the other
     side showed us, we might not even have filled in that part of the
     cache earlier).

  3. Why does the included test use "--depth 1"? This is important
     because without it, we happen to invalidate the cache as a side
     effect of other parts of the fetch process. What happens in a
     non-shallow fetch is something like this:

        1. we call find_non_local_tags() once before actually getting the
           pack, to see if there are any tags we can fill in from what we
           already have. This fills in the cache (which is obviously
           missing objects we're about to fetch).

        2. before fetching the actual pack, fetch_and_consume_refs()
           calls check_exist_and_connected(), to see if we even need to
           fetch a pack at all. This doesn't use QUICK (though arguably
           it could, as it's purely an optimization). And since it sees
           there are objects we are indeed missing, that triggers a
           reprepare_packed_git() call, which throws out the loose object
           cache.

        3. after fetching, now we call find_non_local_tags() again. And
           since step (2) invalidated our loose object cache, we find
           the new objects and create the tags.

     So everything works, but mostly due to luck. Whereas in a fetch
     with --depth, we skip step 2 entirely, and thus the out-of-date
     cache is still in place for step 3, giving us the wrong answer.

So the test works with a small "--depth 1" fetch, which makes sure that
we don't store the pack from the other side, and that we don't trigger
the accidental cache invalidation. And of course it forces the use of
v0 along with using the http protocol.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 18 ++++++++++++++++++
 transport-helper.c          |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e069737b80..a623a1058c 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -733,4 +733,22 @@ test_expect_success 'no empty path components' '
 	! grep "//" log
 '
 
+test_expect_success 'tag following always works over v0 http' '
+	upstream=$HTTPD_DOCUMENT_ROOT_PATH/tags &&
+	git init "$upstream" &&
+	(
+		cd "$upstream" &&
+		git commit --allow-empty -m base &&
+		git tag not-annotated &&
+		git tag -m foo annotated
+	) &&
+	git init tags &&
+	git -C tags -c protocol.version=0 \
+		fetch --depth 1 $HTTPD_URL/smart/tags \
+		refs/tags/annotated:refs/tags/annotated &&
+	git -C "$upstream" for-each-ref refs/tags >expect &&
+	git -C tags for-each-ref >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index e34a8f47cf..07e42e239a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -17,6 +17,7 @@
 #include "refspec.h"
 #include "transport-internal.h"
 #include "protocol.h"
+#include "packfile.h"
 
 static int debug;
 
@@ -432,6 +433,8 @@ static int fetch_with_fetch(struct transport *transport,
 			warning(_("%s unexpectedly said: '%s'"), data->name, buf.buf);
 	}
 	strbuf_release(&buf);
+
+	reprepare_packed_git(the_repository);
 	return 0;
 }
 
-- 
2.43.0.721.gf5abbd674f

