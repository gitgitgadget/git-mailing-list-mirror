Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801320BB39
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400573; cv=none; b=TML96t1kivfkudskW+cgwMvzT20A0yPctxJZtsoVtEtzhkTQUNeaD79ZOlNwZ9+TL0+C7Vf9lfdNs5fUSzv7FDso7UmycaYUdO041auRJn5arSudCMQM2dconCmr5pwHhZyAJ0Z1WywOhnNkGoTJ0Vwq4zAQ+6ZRcgBEiGv/kHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400573; c=relaxed/simple;
	bh=dB6xvX7dwxjjFbnYxPsLmPcP5KfCo0vy2rzw446NpU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6oWK8efY3CdeVj8Z0HQzCD1jKbTE9an/0bNezTFe6a0crvWaqi72VvPqdHuAzahBpYWIRK9JPBhr7OIAjeP0LVxvn2TtgpjHCv/CuBJrwLI39fwq8DQ6YfSft7QBTzzoHn3rdKlPeRJKEDEnBJnxpWnsGQEhvEfvWYDHt9Hfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VjJpXDTP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VjJpXDTP"
Received: (qmail 30316 invoked by uid 109); 12 Nov 2024 08:36:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dB6xvX7dwxjjFbnYxPsLmPcP5KfCo0vy2rzw446NpU4=; b=VjJpXDTPYRbmAroYAMXPyaclcOtvnWVFgNW74y0YXU4gfhFca3E+md36O8F2zA6CYGe6gFG1j1YHaOba4gFnZmcLoPDCuzZzjpz6u2yDiFF/TqJg+cFvoLVKPOtkkAh8/JIIG/rysAkBSbUQx2vd2iH6i2mpawuuzQy5uMIbLUVNU4smtkzQUY0MemW7qrlsfhzS48rjWzfLw9bFjPJSuVej5v4WxER5vtnCnRYXNmPJ1c6dLxdUO5TCFVzsMbGXp8TFBp4hispmrGcTInRBLKfF6sxpASJP1mdXRY3zKD1ercrAhWBrC16HnZ09b6RcBAJS2IZJfl7W9tC4LDCFbw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 08:36:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27570 invoked by uid 111); 12 Nov 2024 08:36:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2024 03:36:14 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Nov 2024 03:36:10 -0500
From: Jeff King <peff@peff.net>
To: Eric Mills <ermills@epic.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 2/3] refspec: drop separate raw_nr count
Message-ID: <20241112083610.GB3529122@coredump.intra.peff.net>
References: <20241112083204.GA2636868@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112083204.GA2636868@coredump.intra.peff.net>

A refspec struct contains zero or more refspec_item structs, along with
matching "raw" strings. The items and raw strings are kept in separate
arrays, but those arrays will always have the same length (because we
write them only via refspec_append_nodup(), which grows both). This can
lead to bugs when manipulating the array, since the arrays and lengths
must be modified in lockstep. For example, the bug fixed in the previous
commit, which forgot to decrement raw_nr.

So let's get rid of "raw_nr" and have only "nr", making this kind of bug
impossible (and also making it clear that the two are always matched,
something that existing code already assumed but was not guaranteed by
the interface).

Even though we'd expect "alloc" and "raw_alloc" to likewise move in
lockstep, we still need to keep separate counts there if we want to
continue to use ALLOC_GROW() for both.

Conceptually this would all be simpler if refspec_item just held onto
its own raw string, and we had a single array. But there are callers
which use refspec_item outside of "struct refspec" (and so don't hold on
to a matching "raw" string at all), which we'd possibly need to adjust.
So let's not worry about refactoring that for now, and just get rid of
the redundant count variable. That is the first step on the road to
combining them anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c  |  1 -
 builtin/remote.c |  8 ++++----
 refspec.c        | 15 ++++++++-------
 refspec.h        |  1 -
 submodule.c      |  4 ++--
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9e0cabebe7..d9027e4dc9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -463,7 +463,6 @@ static void filter_prefetch_refspec(struct refspec *rs)
 				rs->raw[j - 1] = rs->raw[j];
 			}
 			rs->nr--;
-			rs->raw_nr--;
 			i--;
 			continue;
 		}
diff --git a/builtin/remote.c b/builtin/remote.c
index 76670ddd8b..875d6c3bad 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -633,11 +633,11 @@ static int migrate_file(struct remote *remote)
 		git_config_set_multivar(buf.buf, remote->url.v[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
-	for (i = 0; i < remote->push.raw_nr; i++)
+	for (i = 0; i < remote->push.nr; i++)
 		git_config_set_multivar(buf.buf, remote->push.raw[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
-	for (i = 0; i < remote->fetch.raw_nr; i++)
+	for (i = 0; i < remote->fetch.nr; i++)
 		git_config_set_multivar(buf.buf, remote->fetch.raw[i], "^$", 0);
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(git_path("remotes/%s", remote->name));
@@ -759,12 +759,12 @@ static int mv(int argc, const char **argv, const char *prefix)
 		goto out;
 	}
 
-	if (oldremote->fetch.raw_nr) {
+	if (oldremote->fetch.nr) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
-		for (i = 0; i < oldremote->fetch.raw_nr; i++) {
+		for (i = 0; i < oldremote->fetch.nr; i++) {
 			char *ptr;
 
 			strbuf_reset(&buf2);
diff --git a/refspec.c b/refspec.c
index c3cf003443..8e8ee8542d 100644
--- a/refspec.c
+++ b/refspec.c
@@ -186,10 +186,12 @@ static void refspec_append_nodup(struct refspec *rs, char *refspec)
 	refspec_item_init_or_die(&item, refspec, rs->fetch);
 
 	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
-	rs->items[rs->nr++] = item;
+	rs->items[rs->nr] = item;
 
-	ALLOC_GROW(rs->raw, rs->raw_nr + 1, rs->raw_alloc);
-	rs->raw[rs->raw_nr++] = refspec;
+	ALLOC_GROW(rs->raw, rs->nr + 1, rs->raw_alloc);
+	rs->raw[rs->nr] = refspec;
+
+	rs->nr++;
 }
 
 void refspec_append(struct refspec *rs, const char *refspec)
@@ -217,18 +219,17 @@ void refspec_clear(struct refspec *rs)
 {
 	int i;
 
-	for (i = 0; i < rs->nr; i++)
+	for (i = 0; i < rs->nr; i++) {
 		refspec_item_clear(&rs->items[i]);
+		free(rs->raw[i]);
+	}
 
 	FREE_AND_NULL(rs->items);
 	rs->alloc = 0;
 	rs->nr = 0;
 
-	for (i = 0; i < rs->raw_nr; i++)
-		free(rs->raw[i]);
 	FREE_AND_NULL(rs->raw);
 	rs->raw_alloc = 0;
-	rs->raw_nr = 0;
 
 	rs->fetch = 0;
 }
diff --git a/refspec.h b/refspec.h
index 3760fdaf2b..0461c9def6 100644
--- a/refspec.h
+++ b/refspec.h
@@ -45,7 +45,6 @@ struct refspec {
 
 	char **raw;
 	int raw_alloc;
-	int raw_nr;
 
 	int fetch;
 };
diff --git a/submodule.c b/submodule.c
index 74d5766f07..307f73fb5b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1174,7 +1174,7 @@ static int push_submodule(const char *path,
 		if (remote->origin != REMOTE_UNCONFIGURED) {
 			int i;
 			strvec_push(&cp.args, remote->name);
-			for (i = 0; i < rs->raw_nr; i++)
+			for (i = 0; i < rs->nr; i++)
 				strvec_push(&cp.args, rs->raw[i]);
 		}
 
@@ -1209,7 +1209,7 @@ static void submodule_push_check(const char *path, const char *head,
 	strvec_push(&cp.args, head);
 	strvec_push(&cp.args, remote->name);
 
-	for (i = 0; i < rs->raw_nr; i++)
+	for (i = 0; i < rs->nr; i++)
 		strvec_push(&cp.args, rs->raw[i]);
 
 	prepare_submodule_repo_env(&cp.env);
-- 
2.47.0.508.g57228aee23

