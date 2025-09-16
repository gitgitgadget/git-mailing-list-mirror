Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F13294FE
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054388; cv=none; b=SB7MSi1Knkvja5NOaukrXgXqvTqXzRM7CvQq/MhMPyObvdBMXRrhKmO/cRWnIMqaepL7sGwVJnVlgZjQGR1ckKCit2Aaz2Ph+nGLqNNV8lR4xcp8w2cKVCsuvesp/70i7AWSmiF2h1KX1IAYSmQovBzgN+PGtlRjIaqSWrOnaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054388; c=relaxed/simple;
	bh=UHgPiPAmFOCQ4/EfQMGhH9qKD2f/ok8wJBX1oG8vImQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BioVMSZL+mXrw/e/8MW4bRZ29qYJYANLyQtnixT0itxs3/EUZVS3xdeqmDbrPu2mndjDzTDvisRow0Hn54exekPtOwZeRK9XaIROQe2EFtpAcrjTX2X5YxSpPrmH3UMZAGUejBNMqw4+H6ocd4pWx4yNt4V0VWM91ixm5NESjSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AFGWWT++; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AFGWWT++"
Received: (qmail 102499 invoked by uid 109); 16 Sep 2025 20:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UHgPiPAmFOCQ4/EfQMGhH9qKD2f/ok8wJBX1oG8vImQ=; b=AFGWWT++tzSrQYMluopfi1kWu+NXeksSb40QO1tp4WAWVZRp6opsfR3jzRBBbK9C86jm5ClOdM2kW6TZDxOeDqdYDw9yCcaKansZfP8tc3EcKFF516PDJmLjsLgQX97Cgle/HY8+rzikcenLMAcQBxjQgzdeeo/5/2hyZL8DLI9tJMJ93Kr1wuEJs8ZiWYMYSRPYMRJJyBJ1lgGhzy4g9EbtiooXsEJwqsfM+D+99FvGC8KMmuaM1pvy42cJvbqXzZVYLwv5hMxgtvRNyomAvJP0GB5svcvk1naJ17JBLcTCO5iM3itEf833BDt49kmukIisTMdkfxzTlTmjyPKRrg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:26:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166304 invoked by uid 111); 16 Sep 2025 20:26:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:26:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:26:24 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 11/13] add-interactive: retain colorbool values longer
Message-ID: <20250916202624.GK612873@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

Most of the diff code stores the decision about whether to show color as
a git_colorbool, and evaluates it at point-of-use with want_color().
This timing is important for reasons explained in daa0c3d971 (color:
delay auto-color decision until point of use, 2011-08-17).

The add-interactive code instead converts immediately to strict boolean
values using want_color(), and then evaluates those. This isn't wrong.
Even though we pass the bool values to diff_use_color(), which expects a
colorbool, the values are compatible. But it is unlike the rest of the
color code, and is questionable from a type-system perspective (but C's
typing between enums, ints, and bools is weak enough that the compiler
does not complain).

Let's switch it to the more usual way of calling want_color() at the
point of use.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess this could also come earlier in the series, but I found it
easier to understand the conversion if we start using the git_colorbool
value.

 add-interactive.c | 14 +++++++-------
 add-interactive.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 000315971e..6ffe64c38d 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -20,14 +20,14 @@
 #include "prompt.h"
 #include "tree.h"
 
-static void init_color(struct repository *r, int use_color,
+static void init_color(struct repository *r, enum git_colorbool use_color,
 		       const char *section_and_slot, char *dst,
 		       const char *default_color)
 {
 	char *key = xstrfmt("color.%s", section_and_slot);
 	const char *value;
 
-	if (!use_color)
+	if (!want_color(use_color))
 		dst[0] = '\0';
 	else if (repo_config_get_value(r, key, &value) ||
 		 color_parse(value, dst))
@@ -36,7 +36,7 @@ static void init_color(struct repository *r, int use_color,
 	free(key);
 }
 
-static int check_color_config(struct repository *r, const char *var)
+static enum git_colorbool check_color_config(struct repository *r, const char *var)
 {
 	const char *value;
 	enum git_colorbool ret;
@@ -55,7 +55,7 @@ static int check_color_config(struct repository *r, const char *var)
 	    !repo_config_get_value(r, "color.ui", &value))
 		ret = git_config_colorbool("color.ui", value);
 
-	return want_color(ret);
+	return ret;
 }
 
 void init_add_i_state(struct add_i_state *s, struct repository *r,
@@ -76,7 +76,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 	init_color(r, s->use_color_interactive, "interactive.error",
 		   s->error_color, GIT_COLOR_BOLD_RED);
 	strlcpy(s->reset_color_interactive,
-		s->use_color_interactive ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
+		want_color(s->use_color_interactive) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
 
 	s->use_color_diff = check_color_config(r, "color.diff");
 
@@ -93,7 +93,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 	init_color(r, s->use_color_diff, "diff.new", s->file_new_color,
 		   diff_get_color(s->use_color_diff, DIFF_FILE_NEW));
 	strlcpy(s->reset_color_diff,
-		s->use_color_diff ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
+		want_color(s->use_color_diff) ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
 
 	FREE_AND_NULL(s->interactive_diff_filter);
 	repo_config_get_string(r, "interactive.difffilter",
@@ -1211,7 +1211,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps,
 	 * When color was asked for, use the prompt color for
 	 * highlighting, otherwise use square brackets.
 	 */
-	if (s.use_color_interactive) {
+	if (want_color(s.use_color_interactive)) {
 		data.color = s.prompt_color;
 		data.reset = s.reset_color_interactive;
 	}
diff --git a/add-interactive.h b/add-interactive.h
index ceadfa6bb6..da49502b76 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -12,8 +12,8 @@ struct add_p_opt {
 
 struct add_i_state {
 	struct repository *r;
-	int use_color_interactive;
-	int use_color_diff;
+	enum git_colorbool use_color_interactive;
+	enum git_colorbool use_color_diff;
 	char header_color[COLOR_MAXLEN];
 	char help_color[COLOR_MAXLEN];
 	char prompt_color[COLOR_MAXLEN];
-- 
2.51.0.527.g34bc42dacd

