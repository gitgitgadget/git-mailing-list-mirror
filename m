Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56B1482F6
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056916; cv=none; b=XDZG3W766pGmyq5SN76s7GcWrtCRMb1BJAHwSjkfowqBGJPoi6uKUG1dC9B9fbTbJC2SNHVD/Y7xYNPlGeS9dWVAWXAadGgnMQDw/qoTIg3KGk7aw/71mXPp0DqtBXWRxBokTSltwgxk6skg6xPf2rtfqDhIfULPXWZAkXbWg2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056916; c=relaxed/simple;
	bh=F7LNQ4GZHbasaQfIjgS/INtZ2dHS+6q+C/PBlWFji50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVE9lm4aHsI1waJAGo9pjGFAQU5Oy7wfROaBv7BPLYlRimjCkZx6MTkhiO/gaVKCvPtrOUl10i3qHxE26MtudQKi+edmLnsMEIFqhiqRSS5lOcBIVHS/yxw35o6aOiVu7dKpgKRQz8xcmgVt7sAOpTRLNuAMZhYKYiwZLP04qDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17390 invoked by uid 109); 30 May 2024 08:15:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 08:15:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28565 invoked by uid 111); 30 May 2024 08:15:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 04:15:10 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 04:15:12 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/5] mv: move src_dir cleanup to end of cmd_mv()
Message-ID: <20240530081512.GG1949834@coredump.intra.peff.net>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
 <20240530064422.GC1949704@coredump.intra.peff.net>
 <Zlgk_MMDGlphfO9U@tanuki>
 <20240530072159.GF1949834@coredump.intra.peff.net>
 <ZlgpsrKN7N38V2GP@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlgpsrKN7N38V2GP@tanuki>

On Thu, May 30, 2024 at 09:24:34AM +0200, Patrick Steinhardt wrote:

> > Looks like no. The obvious candidate would be t7002-mv-sparse-checkout,
> > but it looks like the sparse-checkout code has minor leaks itself.
> 
> Okay, thanks for double checking! I was mostly asking because I plan to
> send another leak fixes series to the mailing list later this week.

OK, good news. t7002 _does_ trigger the leak fixed in my patch. You just
can't tell because of all of the sparse-checkout leaks. ;)

The (messy) patch below gets it to a leak-free state when applied on
top. Do you want me to do another mini-series with it, or do you want to
just roll it into what you're doing (I won't be surprised if you've
already found some of these).

-Peff

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0f52e25249..1ed9dfa886 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -311,6 +311,8 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		fprintf(fp, "%s/\n", pattern);
 		free(pattern);
 	}
+
+	string_list_clear(&sl, 0);
 }
 
 static int write_patterns_and_update(struct pattern_list *pl)
@@ -471,6 +473,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
 		free(sparse_filename);
+		clear_pattern_list(&pl);
 		return update_working_directory(NULL);
 	}
 
@@ -486,6 +489,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 			die(_("failed to open '%s'"), sparse_filename);
 
 		free(sparse_filename);
+		clear_pattern_list(&pl);
 		fprintf(fp, "/*\n!/*/\n");
 		fclose(fp);
 		return 0;
@@ -525,6 +529,10 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 
 		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
 			hashmap_add(&pl->parent_hashmap, &e->ent);
+		else {
+			free(e->pattern);
+			free(e);
+		}
 	}
 }
 
@@ -891,7 +899,6 @@ static int sparse_checkout_disable(int argc, const char **argv,
 		OPT_END(),
 	};
 	struct pattern_list pl;
-	struct strbuf match_all = STRBUF_INIT;
 
 	/*
 	 * We do not exit early if !core_apply_sparse_checkout; due to the
@@ -917,8 +924,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	pl.use_cone_patterns = 0;
 	core_apply_sparse_checkout = 1;
 
-	strbuf_addstr(&match_all, "/*");
-	add_pattern(strbuf_detach(&match_all, NULL), empty_base, 0, &pl, 0);
+	add_pattern("/*", empty_base, 0, &pl, 0);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.sparse_index = 0;
diff --git a/dir.c b/dir.c
index 2d83f3311a..5769c4e693 100644
--- a/dir.c
+++ b/dir.c
@@ -799,6 +799,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 	if (given->patternlen > 2 &&
 	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
+		struct pattern_entry *old;
+
 		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
 			/* Not a cone pattern. */
 			warning(_("unrecognized pattern: '%s'"), given->pattern);
@@ -824,7 +826,11 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		}
 
 		hashmap_add(&pl->parent_hashmap, &translated->ent);
-		hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
+		old = hashmap_remove_entry(&pl->recursive_hashmap, translated, ent, &data);
+		if (old) {
+			free(old->pattern);
+			free(old);
+		}
 		free(data);
 		return;
 	}
@@ -855,6 +861,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 clear_hashmaps:
 	warning(_("disabling cone pattern matching"));
+	/* should free ent->pattern too; refactor clear_pattern_list? */
 	hashmap_clear_and_free(&pl->parent_hashmap, struct pattern_entry, ent);
 	hashmap_clear_and_free(&pl->recursive_hashmap, struct pattern_entry, ent);
 	pl->use_cone_patterns = 0;
@@ -950,13 +957,20 @@ static int read_skip_worktree_file_from_index(struct index_state *istate,
  */
 void clear_pattern_list(struct pattern_list *pl)
 {
+	struct hashmap_iter iter;
+	struct pattern_entry *entry;
 	int i;
 
 	for (i = 0; i < pl->nr; i++)
 		free(pl->patterns[i]);
 	free(pl->patterns);
 	free(pl->filebuf);
+
+	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, entry, ent)
+		free(entry->pattern);
 	hashmap_clear_and_free(&pl->recursive_hashmap, struct pattern_entry, ent);
+	hashmap_for_each_entry(&pl->parent_hashmap, &iter, entry, ent)
+		free(entry->pattern);
 	hashmap_clear_and_free(&pl->parent_hashmap, struct pattern_entry, ent);
 
 	memset(pl, 0, sizeof(*pl));
-- 
2.45.1.692.gbe047d9c60

