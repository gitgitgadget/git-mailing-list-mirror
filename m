Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D03210EC
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923911; cv=none; b=HO8SqpglVxqUD2js9coQqFp0qRRubmjG243EIrSpMVudUOvC9ZHoHILfRMJK25Kh9ZSwqc8VTI1KjoImhbQM5ijACKSqF3f/EixzrMuKFoIGRpgDk262JgwbKYs54pXUCk1Sbx1/Da9gZvWJRCEHPUEw02fA8hEWRwxhNBCqN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923911; c=relaxed/simple;
	bh=5W84GesuWOqpWj86ZaTxUz+YMEE2OElo2bKmBakVjFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnjswJ1EPpoYcq6bwwgMgePk0vQwXLW6z7QDlH+Ss2zu4BERDNWviIBfYfTNI9dGaKXT0x3XNJKODz5IzI2Q1vM8D3igpO8Q2Pj15yqkTQLGu0tvOQqJPQo6YRgVDtagWfew8euAjA/7iSzjz7ZvvBL3XVuF6k09+4AXUhhe3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32243 invoked by uid 109); 9 Sep 2024 23:18:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:18:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24969 invoked by uid 111); 9 Sep 2024 23:18:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:18:28 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:18:28 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 6/9] ref-filter: fix leak of %(trailers) "argbuf"
Message-ID: <20240909231828.GF921834@coredump.intra.peff.net>
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

When we parse a placeholder like "%(trailers:key=foo)", our atom parsing
function is passed just the argument string "key=foo". We duplicate this
into its own string, but never free it, causing a leak.

We do the duplication for two reasons:

  1. There's a mismatch with the pretty.c trailer-formatting code that
     we rely on. It expects to see a closing paren, like "key=foo)". So
     we duplicate the argument string with that extra character to pass
     along.

     This is probably something we could fix in the long run, but it's
     somewhat non-trivial if we want to avoid regressing error cases for
     things like "git log --format='%(trailer:oops'". So let's accept
     it as a necessity for now.

  2. The argument parser expects to store the list of "key" entries
     ("foo" in this case) in a string-list. It also stores the length of
     the string in the string-list "util" field. The original caller in
     pretty.c uses this with a "nodup" string list to avoid making extra
     copies, which creates a subtle dependency on the lifetime of the
     original format string.

     We do the same here, which creates that same dependency. So we
     can't simply free it as soon as the parsing is done.

There are two possible solutions here. The first is to hold on to the
duplicated "argbuf" string in the used_atom struct, so that it lives as
long as the string_list which references it.

But I think a less-subtle solution, and what this patch does, is to
switch to a duplicating string_list. That makes it self-contained, and
lets us free argbuf immediately. It may involve a few extra allocations,
but this parsing is something that happens once per program, not once
per output ref.

This clears up one case that LSan finds in t6300, but there are more.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ebddc041c7..54c5079dde 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -567,7 +567,8 @@ static int trailers_atom_parser(struct ref_format *format UNUSED,
 	atom->u.contents.trailer_opts.no_divider = 1;
 
 	if (arg) {
-		const char *argbuf = xstrfmt("%s)", arg);
+		char *argbuf = xstrfmt("%s)", arg);
+		const char *arg = argbuf;
 		char *invalid_arg = NULL;
 		struct ref_trailer_buf *tb;
 
@@ -579,21 +580,23 @@ static int trailers_atom_parser(struct ref_format *format UNUSED,
 		 * They must be allocated in a separate, stable struct.
 		 */
 		atom->u.contents.trailer_buf = tb = xmalloc(sizeof(*tb));
-		string_list_init_nodup(&tb->filter_list);
+		string_list_init_dup(&tb->filter_list);
 		strbuf_init(&tb->sepbuf, 0);
 		strbuf_init(&tb->kvsepbuf, 0);
 
 		if (format_set_trailers_options(&atom->u.contents.trailer_opts,
 						&tb->filter_list,
 						&tb->sepbuf, &tb->kvsepbuf,
-						&argbuf, &invalid_arg)) {
+						&arg, &invalid_arg)) {
 			if (!invalid_arg)
 				strbuf_addf(err, _("expected %%(trailers:key=<value>)"));
 			else
 				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), invalid_arg);
 			free(invalid_arg);
+			free(argbuf);
 			return -1;
 		}
+		free(argbuf);
 	}
 	atom->u.contents.option = C_TRAILERS;
 	return 0;
-- 
2.46.0.867.gf99b2b8e0f

