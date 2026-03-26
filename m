Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7A33BBAF
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553003; cv=none; b=aBiWlnIldRt8ZVzd410riPKVdnsThVV/VovnaGfsr/a2d3rAPRle0YhZRdhZBakkvnh5ipgh0Kw2VzrYpE5BDh1MWzh22M8lhikqYg90s73fjmGRHMa/eXp/IvYHfbrSoCAhniFh2DHT2WE7i2XV3tx/UIGJ5M841NhKwX3zlxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553003; c=relaxed/simple;
	bh=un7u6PmoIJqu84lUpBsIMDQP0zLMz9jieOPgzKgPvEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttQFQHZpOxb4BjTPQLqvqcliDo5N7Z2qmSrbo5NQYsPApZ/u7RkT5sgbNp5Ge3AK2glK38Ae50OMFFpLd9A8CTOc3KaUgtnvZjMz0QHn2tJ1gDI9JH/Q+nDGPLxEIQ1ojTNBacmvFQO+FCXh2wl05IoXTTLnGA09NkhnoaHK/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JMwKDbjE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JMwKDbjE"
Received: (qmail 155745 invoked by uid 106); 26 Mar 2026 19:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=un7u6PmoIJqu84lUpBsIMDQP0zLMz9jieOPgzKgPvEQ=; b=JMwKDbjEhAmoAKqPSggrvMSxL1WyGQfjgnmm5VFyuTowS300GRm6C3CSr+EweXfGMIw3R3f8leAOdW8p1xFH4jkIeqbNIh3BcjebGQoxb2zKuiFp1O+uHhAKy0vRWwUbsGpC2Bjkjv1RcKhKTPrzU1Pa24dPQ0o+0in6fLMzQgww5zIkBKq8e/6gCEpdUXy2JR+isDwSnRubSBqYZIBfTwk+B/Abayf/7XTCRAhVtDgET4mFMeo6xCRYpZifsQyNT2uciht5/AGWzzn3NQAyftBuvUQ7Nl3rZKJHZi21w+RHuPJhhFcAsAyF3XXxQvApxOCAoE6YE9nGQHeQVKjU1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 19:23:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 216054 invoked by uid 111); 26 Mar 2026 19:23:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 15:23:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 15:23:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: [PATCH] config: store allocated string in non-const pointer
Message-ID: <20260326192320.GA418281@coredump.intra.peff.net>
References: <cover.1774537954.git.git@grubix.eu>
 <a3a1d2759a0ec5a3ee285689832832e5e3a63768.1774537954.git.git@grubix.eu>
 <20260326173402.GB2447148@coredump.intra.peff.net>
 <xmqqy0jepjqy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0jepjqy.fsf@gitster.g>

On Thu, Mar 26, 2026 at 10:45:41AM -0700, Junio C Hamano wrote:

> > But we can untangle this for the compiler without having to cast by
> > using a non-const alias, like:
> [...]
> Yeah, this is much clearer.

Here it is as a patch with a commit message. I was eventually planning
to do a complete series that cleans up all the warnings, and this would
be part of it. But since other people are starting to work on it, too,
it may make sense to just send them out as we have them to avoid too
much duplication.

-- >8 --
Subject: [PATCH] config: store allocated string in non-const pointer

When git-config matches a url, we copy the variable section name and
store it in the "section" member of a urlmatch_config struct. That
member is const, since the url-matcher will not touch it (and other
callers really will have a const string).

But that means that we have only a const pointer to our allocated
string. We have to cast away the constness when we free it, and likewise
when we assign NUL to tie off the "." separating the subsection and key.
This latter happens implicitly via a strchr() call, but recent versions
of glibc have added annotations that let the compiler detect that and
complain.

Let's keep our own "section" pointer for the non-const string, and then
just point config.section at it. That avoids all of the casting, both
explicit and implicit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 7c4857be62..cf4ba0f7cc 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -838,6 +838,7 @@ static int get_urlmatch(const struct config_location_options *opts,
 			const char *var, const char *url)
 {
 	int ret;
+	char *section;
 	char *section_tail;
 	struct config_display_options display_opts = *_display_opts;
 	struct string_list_item *item;
@@ -851,8 +852,8 @@ static int get_urlmatch(const struct config_location_options *opts,
 	if (!url_normalize(url, &config.url))
 		die("%s", config.url.err);
 
-	config.section = xstrdup_tolower(var);
-	section_tail = strchr(config.section, '.');
+	config.section = section = xstrdup_tolower(var);
+	section_tail = strchr(section, '.');
 	if (section_tail) {
 		*section_tail = '\0';
 		config.key = section_tail + 1;
@@ -886,7 +887,7 @@ static int get_urlmatch(const struct config_location_options *opts,
 	string_list_clear(&values, 1);
 	free(config.url.url);
 
-	free((void *)config.section);
+	free(section);
 	return ret;
 }
 
-- 
2.53.0.1081.gf77a8b8145

