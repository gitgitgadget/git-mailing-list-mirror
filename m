Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4038210EC
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923817; cv=none; b=iQdRTcMOZO5Ng5G9s4n+CGqnYGCayDpVKdyIkBw2maTzIi0KoxJnNTUqxA596/rK4rMfuvx7bppU3OqkM1vVUWGF/r6MfxL8C+toFdyQfFwTNI000/NNYa9Gto+RsfM5fcx5fBcmRmc/JlQsYfrLt6UdIYDgw1XDyEu9vwz3Cu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923817; c=relaxed/simple;
	bh=8Ht51ueZy27CHoEBJztzQvbnsMmiMWFJZ32NYilwoNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHGJj5mTzxksKOm4RWoy2kxa0dpOVZRRq2rP/cRbcxmN75hT4VElLADq3YcG1EDz96RjCbKM5Q/cJF+bGlHwIEeFxvLCrVlStceGfR7aGmdxAsP3tK0WmOyXALLtEGxk9j2ntkcotxdxEaCqjtnciYZarmTlXuOcXfLyDKz4Pm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32229 invoked by uid 109); 9 Sep 2024 23:16:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:16:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24955 invoked by uid 111); 9 Sep 2024 23:16:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:16:54 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:16:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 5/9] ref-filter: store ref_trailer_buf data per-atom
Message-ID: <20240909231653.GE921834@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909230758.GA921697@coredump.intra.peff.net>

The trailer API takes options via a trailer_opts struct. Some of those
options point to data structures which require extra storage. Those
structures aren't actually embedded in the options struct, but rather we
pass pointers, and the caller is responsible for managing them. This is
a little convoluted, but makes sense since some of them are not even
concrete (e.g., you can pass a filter function and a void data pointer,
but the trailer code doesn't even know what's in the pointer).

When for-each-ref, etc, parse the %(trailers) placeholder, they stuff
the extra data into a ref_trailer_buf struct. But we only hold a single
static global instance of this struct. So if a format string has
multiple %(trailer) placeholders, they'll stomp on each other: the "key"
list will end up with entries for all of them, and the separator buffers
will use the values from whichever was parsed last.

Instead, we should have a ref_trailer_buf for each instance of the
placeholder, and store it alongside the trailer_opts in the used_atom
structure.

And that's what this patch does. Note that we also have to add code to
clean them up in ref_array_clear(). The original code did not bother
cleaning them up, but it wasn't technically a "leak" since they were
still reachable from the static global instance.

Reported-by: Brooke Kuhlmann <brooke@alchemists.io>
Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            | 36 ++++++++++++++++++++++++++++++------
 t/t6300-for-each-ref.sh | 19 +++++++++++++++++++
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 4d0df546da..ebddc041c7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -75,11 +75,11 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
 
-static struct ref_trailer_buf {
+struct ref_trailer_buf {
 	struct string_list filter_list;
 	struct strbuf sepbuf;
 	struct strbuf kvsepbuf;
-} ref_trailer_buf = {STRING_LIST_INIT_NODUP, STRBUF_INIT, STRBUF_INIT};
+};
 
 static struct expand_data {
 	struct object_id oid;
@@ -201,6 +201,7 @@ static struct used_atom {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,
 			       C_SIG, C_SUB, C_SUB_SANITIZE, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
+			struct ref_trailer_buf *trailer_buf;
 			unsigned int nlines;
 		} contents;
 		struct {
@@ -568,12 +569,24 @@ static int trailers_atom_parser(struct ref_format *format UNUSED,
 	if (arg) {
 		const char *argbuf = xstrfmt("%s)", arg);
 		char *invalid_arg = NULL;
+		struct ref_trailer_buf *tb;
+
+		/*
+		 * Do not inline these directly into the used_atom struct!
+		 * When we parse them in format_set_trailers_options(),
+		 * we will make pointer references directly to them,
+		 * which will not survive a realloc() of the used_atom list.
+		 * They must be allocated in a separate, stable struct.
+		 */
+		atom->u.contents.trailer_buf = tb = xmalloc(sizeof(*tb));
+		string_list_init_nodup(&tb->filter_list);
+		strbuf_init(&tb->sepbuf, 0);
+		strbuf_init(&tb->kvsepbuf, 0);
 
 		if (format_set_trailers_options(&atom->u.contents.trailer_opts,
-		    &ref_trailer_buf.filter_list,
-		    &ref_trailer_buf.sepbuf,
-		    &ref_trailer_buf.kvsepbuf,
-		    &argbuf, &invalid_arg)) {
+						&tb->filter_list,
+						&tb->sepbuf, &tb->kvsepbuf,
+						&argbuf, &invalid_arg)) {
 			if (!invalid_arg)
 				strbuf_addf(err, _("expected %%(trailers:key=<value>)"));
 			else
@@ -2988,6 +3001,17 @@ void ref_array_clear(struct ref_array *array)
 		struct used_atom *atom = &used_atom[i];
 		if (atom->atom_type == ATOM_HEAD)
 			free(atom->u.head);
+		else if (atom->atom_type == ATOM_TRAILERS ||
+			 (atom->atom_type == ATOM_CONTENTS &&
+			  atom->u.contents.option == C_TRAILERS)) {
+			struct ref_trailer_buf *tb = atom->u.contents.trailer_buf;
+			if (tb) {
+				string_list_clear(&tb->filter_list, 0);
+				strbuf_release(&tb->sepbuf);
+				strbuf_release(&tb->kvsepbuf);
+				free(tb);
+			}
+		}
 		free((char *)atom->name);
 	}
 	FREE_AND_NULL(used_atom);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b830b542c4..e8db612f95 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1560,6 +1560,25 @@ test_trailer_option '%(trailers:separator,key_value_separator) changes both sepa
 	Reviewed-by,A U Thor <author@example.com>,Signed-off-by,A U Thor <author@example.com>
 	EOF
 
+test_expect_success 'multiple %(trailers) use their own options' '
+	git tag -F - tag-with-trailers <<-\EOF &&
+	body
+
+	one: foo
+	one: bar
+	two: baz
+	two: qux
+	EOF
+	t1="%(trailers:key=one,key_value_separator=W,separator=X)" &&
+	t2="%(trailers:key=two,key_value_separator=Y,separator=Z)" &&
+	git for-each-ref --format="$t1%0a$t2" refs/tags/tag-with-trailers >actual &&
+	cat >expect <<-\EOF &&
+	oneWfooXoneWbar
+	twoYbazZtwoYqux
+	EOF
+	test_cmp expect actual
+'
+
 test_failing_trailer_option () {
 	title=$1 option=$2
 	cat >expect
-- 
2.46.0.867.gf99b2b8e0f

