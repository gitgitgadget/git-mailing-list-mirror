Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DD3939C2
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887986; cv=none; b=aT3Q8+koP7DOH+cDiOcuKRnci1T/bZeqsIZbSnoUQNwOo9ukh0GHxVYo3YVlHoCiRuDtZddpmCrQIfSoV3qsOteUQzsBadPAnpQrvkj+Wl9mDEwe9VUz5hsaKg8lHREbSX5JWhL9LLZmUBe8EO7M2PpWlvw0I52acdJs1iu8h0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887986; c=relaxed/simple;
	bh=7nVb/vsa3z74y+9fkAbFZ5YdtfjZ0z4Amrd7x081yCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVi37+n3XUD6nq6gvwSJDVYLtmejEVox/hDwUpCcP9WTcNaBZ95CjvkfHQFAtwi0qqXMELW5iTh4ZtmdI9v5pTE4FXwAL4yMPUAhi49ppOvxBGskBOyVGbaLlhDFlFvUhNQp7IC33akQ+wC8Bg7fgCl4/tuHB5Gc1Th61/uPsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S/J6mC5Y; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S/J6mC5Y"
Received: (qmail 76984 invoked by uid 106); 1 Jul 2026 06:39:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7nVb/vsa3z74y+9fkAbFZ5YdtfjZ0z4Amrd7x081yCI=; b=S/J6mC5YnVYV+2MoP+BLaMeicBq2Zttik1RvE32WmULRSuAOPUYWDdBrd1eTCSbUdaAAWg8Sbzae+2ql/i+8b/YzTF4EE48GWRTZeGxkteYa/7vCErslL7fA178JcNc9+bdKzvaj4FHDGgHc3YyIewKAJolSzGHvCEvFJLvcNwckhwHUbdvyxzv6y6sQdCwgb2Ze6XqRZUPj+HZYO+1BIS8vasn7gAmFcXw2522eQxvmmOIg3VOLtyHf8Ftr/rIujZgE5z4eNkZWUKzxtR1A2ikStkXG0+vl/qn3oNd10wD9a3+RhVFgnhKK48UbHbktcBcWN0GwzDhXIbeRhULuog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2026 06:39:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157785 invoked by uid 111); 1 Jul 2026 06:39:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2026 02:39:43 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jul 2026 02:39:42 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] bloom: make bloom-filter slab initialization idempotent
Message-ID: <20260701063942.GA2580331@coredump.intra.peff.net>
References: <20260701063538.GA2579765@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701063538.GA2579765@coredump.intra.peff.net>

Before using any of the commit-graph bloom-filter code, somebody needs
to call init_bloom_filters(). This initializes the commit-slab we use
for storing filter information. But we don't want to call it twice
(without a matching deinit call in the middle), since it overwrites the
existing slab pointers, leaking the old values.

Usually this init call is done lazily by parse_commit_graph() when we
read a graph file that contains bloom data. But this can lead to some
oddities:

  1. We may call parse_commit_graph() multiple times when we have a
     split commit graph. I think this doesn't produce any user-visible
     bug, because we parse all of the files back-to-back. So even though
     we call init_bloom_filters() multiple times, we never look up any
     commits in between, so the slab is always empty and initializing it
     again happens to do nothing. This is a little sketchy to rely on,
     though.

  2. We call init_bloom_filters() directly in the "test-tool bloom"
     helper so we can call get_or_compute_bloom_filter(). Normally this
     is OK, as there is no bloom data in the on-disk graph file. But if
     you build with SANITIZE=leak and run:

       GIT_TEST_COMMIT_GRAPH=1 \
       GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1 \
       ./t0095-bloom.sh

     there's a leak that happens like this:

       a. Our direct init_bloom_filters() sets up the slab.

       b. In get_or_compute_bloom_filter() we look in the slab for a
	  cached entry. We won't find anything yet, but since we don't
	  use the read-only "peek" accessor (since we'll fill in the
	  entry if not present), this actually populates the slab with
	  an allocated chunk.

       c. Now we look for an entry in the graph files. So we have to
	  load them and end up in parse_commit_graph(), which calls
	  init_bloom_filters() again. That trashes our existing slab
	  allocation, which is now leaked.

  3. There's a similar case in write_commit_graph(), which calls
     init_bloom_filters() before get_or_compute_bloom_filter(). I think
     this code path is lucky to avoid the leak because it reads the
     graph files first, then calls its init_bloom_filters(), and then
     starts filling in entries. So even though it has the same overwrite
     problem, we'd never actually allocate any slab entries between
     overwrites.

The easiest solution here is just to make initialization of the slab
idempotent using an extra flag.

We could actually get away without using the extra flag, for example by
checking whether bloom_filters.stride has been set. But it's probably
better to avoid being too intimate with the commit-slab details.
Likewise we don't actually need to re-initialize after a deinit call;
the slab-clearing function leaves things in a usable state. But it
seemed less surprising to pair the init/deinit calls explicitly.

I suspect this could all be cleaned up a bit more, but it's tricky. The
only function which uses the slab is get_or_compute_bloom_filter(), so
it would be much simpler if it just lazy-initialized the slab itself.
But I think there is a subtle dependency here: we usually only
initialize the slab when we find a graph file that has bloom entries. So
if we were to lose that signal, then even repos without on-disk bloom
data would start trying to populate the slab, wasting memory that will
never get entries filled in from the disk. So we'd need some other way
of signaling "it is worth considering bloom entries at all".

This patch takes a smaller and more direct route to just dealing with
the potential leak issue.

Signed-off-by: Jeff King <peff@peff.net>
---
 bloom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bloom.c b/bloom.c
index a805ac0c29..c98d1672ad 100644
--- a/bloom.c
+++ b/bloom.c
@@ -16,6 +16,7 @@
 define_commit_slab(bloom_filter_slab, struct bloom_filter);
 
 static struct bloom_filter_slab bloom_filters;
+static int bloom_filter_slab_initialized;
 
 struct pathmap_hash_entry {
     struct hashmap_entry entry;
@@ -263,7 +264,10 @@ void add_key_to_filter(const struct bloom_key *key,
 
 void init_bloom_filters(void)
 {
+	if (bloom_filter_slab_initialized)
+		return;
 	init_bloom_filter_slab(&bloom_filters);
+	bloom_filter_slab_initialized = 1;
 }
 
 static void free_one_bloom_filter(struct bloom_filter *filter)
@@ -276,6 +280,7 @@ static void free_one_bloom_filter(struct bloom_filter *filter)
 void deinit_bloom_filters(void)
 {
 	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
+	bloom_filter_slab_initialized = 0;
 }
 
 struct bloom_keyvec *bloom_keyvec_new(const char *path, size_t len,
-- 
2.55.0.394.gcf1c5597d2

