Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AA257831
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900611; cv=none; b=AZTvysk549I+/GJ9P8cE3pXzXKaw38QL1OyaEsRtWEk4QPMlB2EOwX6rc0UbxRFC+k/HQms1298if7k3/qK/czNZtJNThDJPpWrHBZxTa34y4naWa2ABn4un+mpVQlISg8IYDDkjT4zrMo/4ovVfm4xnwGdkDrrxdXkW5A2tvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900611; c=relaxed/simple;
	bh=BARsLHGriGabkdQILzISDhhRODbfO2jCVCaO0uzAATQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gWwYx/yI0HG+n0srSDP/iZZngPTsc00Ro+n4+cfQ2nawDqXoWvIxsB1O0FTj/lYOl/mRtTqT9F3ZyOeMBpc2FpSr6l5fMtz/VPe8g5lOTu6RWu3ZySuzxxx+JrZULPWimNYuRJ5Ee8zg/yBL7T7U7jr1IphsdyJYBxcpxYmKeYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=byO7uuoG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="byO7uuoG"
Received: (qmail 490168 invoked by uid 109); 11 Nov 2025 22:36:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=BARsLHGriGabkdQILzISDhhRODbfO2jCVCaO0uzAATQ=; b=byO7uuoGebwioJUMa/IB7YiU6b6L8F2WM/+PCLJepqd5M8/1nrdYL98q7dYyW633hF1W0P9npzrqfU0AWtXPi7pLRN9vrhiJSZn+Z9VxZUv2yUvI9KpqfcGJBJY2AxB0ZA92MrbOOIwaaz3qfikeQ02RRPKMb1IZl+u1SI5enX504JB1J3nHZnULp/CEk+Iu123PFaoXc+XfhXzbM/ygeZ2CA/Ds/UhIJRMbzVyYXpMH5oGcSTZB4P7B05sRbaz5rHb26PTCZc83XZCIVECXoDswA0PQ/wbqiqkYr9tckIMIhBl0xh51S60o4ws2I+cU9GZ5Rxe2n4DhYSiV5Lyuwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Nov 2025 22:36:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 780998 invoked by uid 111); 11 Nov 2025 22:36:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Nov 2025 17:36:48 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Nov 2025 17:36:47 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Ben Stav <benstav@miggo.io>
Subject: [PATCH] attr: avoid recursion when expanding attribute macros
Message-ID: <20251111223647.GA4055973@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Given a set of attribute macros like:

   [attr]a1 a2
   [attr]a2 a3
   ...
   [attr]a300000 -text
   file a1

expanding the attributes for "file" requires expanding "a1" to "a2",
"a2" to "a3", and so on until hitting a non-macro expansion ("-text", in
this case). We implement this via recursion: fill_one() calls
macroexpand_one(), which then recurses back to fill_one(). As a result,
very deep macro chains like the one above can run out of stack space and
cause us to segfault.

The required stack space is fairly small; I needed on the order of
200,000 entries to get a segfault on Linux. So it's unlikely anybody
would hit this accidentally, leaving only malicious inputs. There you
can easily construct a repo which will segfault on clone (we look at
attributes during the checkout step, but you'd see the same trying to do
other operations, like diff in a bare repo). It's mostly harmless, since
anybody constructing such a repo is only preventing victims from cloning
their evil garbage, but it could be a nuisance for hosting sites.

One option to prevent this is to limit the depth of recursion we'll
allow. This is conceptually easy to implement, but it raises other
questions: what should the limit be, and do we need a configuration knob
for it?

The recursion here is simple enough that we can avoid those questions by
just converting it to iteration instead. Rather than iterate over the
states of a match_attr in fill_one(), we'll put them all in a queue, and
the expansion of each can add to the queue rather than recursing. Note
that this is a LIFO queue in order to keep the same depth-first order we
did with the recursive implementation. I've avoided using the word
"stack" in the code because the term is already heavily used to refer to
the stack of .gitattribute files that matches the tree structure of the
repository.

The test uses a limited stack size so we can trigger the problem with a
much smaller input than the one shown above. The value here (3000) is
enough to trigger the issue on my x86_64 Linux machine.

Reported-by: Ben Stav <benstav@miggo.io>
Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c                | 50 +++++++++++++++++++++++++++++--------------
 t/t0003-attributes.sh | 20 +++++++++++++++++
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/attr.c b/attr.c
index d1daeb0b4d..4999b7e09d 100644
--- a/attr.c
+++ b/attr.c
@@ -1064,24 +1064,52 @@ static int path_matches(const char *pathname, int pathlen,
 			      pattern, prefix, pat->patternlen);
 }
 
-static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem);
+struct attr_state_queue {
+	const struct attr_state **items;
+	size_t alloc, nr;
+};
+
+static void attr_state_queue_push(struct attr_state_queue *t,
+				 const struct match_attr *a)
+{
+	for (size_t i = 0; i < a->num_attr; i++) {
+		ALLOC_GROW(t->items, t->nr + 1, t->alloc);
+		t->items[t->nr++] = &a->state[i];
+	}
+}
+
+static const struct attr_state *attr_state_queue_pop(struct attr_state_queue *t)
+{
+	return t->nr ? t->items[--t->nr] : NULL;
+}
+
+static void attr_state_queue_release(struct attr_state_queue *t)
+{
+	free(t->items);
+}
 
 static int fill_one(struct all_attrs_item *all_attrs,
 		    const struct match_attr *a, int rem)
 {
-	size_t i;
+	struct attr_state_queue todo = { 0 };
+	const struct attr_state *state;
 
-	for (i = a->num_attr; rem > 0 && i > 0; i--) {
-		const struct git_attr *attr = a->state[i - 1].attr;
+	attr_state_queue_push(&todo, a);
+	while (rem > 0 && (state = attr_state_queue_pop(&todo))) {
+		const struct git_attr *attr = state->attr;
 		const char **n = &(all_attrs[attr->attr_nr].value);
-		const char *v = a->state[i - 1].setto;
+		const char *v = state->setto;
 
 		if (*n == ATTR__UNKNOWN) {
+			const struct all_attrs_item *item =
+				&all_attrs[attr->attr_nr];
 			*n = v;
 			rem--;
-			rem = macroexpand_one(all_attrs, attr->attr_nr, rem);
+			if (item->macro && item->value == ATTR__TRUE)
+				attr_state_queue_push(&todo, item->macro);
 		}
 	}
+	attr_state_queue_release(&todo);
 	return rem;
 }
 
@@ -1106,16 +1134,6 @@ static int fill(const char *path, int pathlen, int basename_offset,
 	return rem;
 }
 
-static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem)
-{
-	const struct all_attrs_item *item = &all_attrs[nr];
-
-	if (item->macro && item->value == ATTR__TRUE)
-		return fill_one(all_attrs, item->macro, rem);
-	else
-		return rem;
-}
-
 /*
  * Marks the attributes which are macros based on the attribute stack.
  * This prevents having to search through the attribute stack each time
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 3c98b622f2..582e207aa1 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -664,4 +664,24 @@ test_expect_success 'user defined builtin_objectmode values are ignored' '
 	test_cmp expect err
 '
 
+test_expect_success ULIMIT_STACK_SIZE 'deep macro recursion' '
+	n=3000 &&
+	{
+		i=0 &&
+		while test $i -lt $n; do
+			echo "[attr]a$i a$((i+1))" &&
+			i=$((i+1)) ||
+			return 1
+		done &&
+		echo "[attr]a$n -text" &&
+		echo "file a0"
+	} >.gitattributes &&
+	{
+		echo "file: text: unset" &&
+		test_seq -f "file: a%d: set" 0 $n
+	} >expect &&
+	run_with_limited_stack git check-attr -a file >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.52.0.rc1.258.g0c10df6ae5
