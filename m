Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA72E7F03
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760763; cv=none; b=HPwT+z/8YVwdJw4QVplZKz43jXjAWJwxk3CecblRcIhBqqh9mCNemMsVTb7AKcIMIDYlyVKZqsBb6RnFV4GrHulAeFzubDFKwR7hMpU5rU/a8cy9LJpNIwc4xn04K+7bLleH3SGIX0Y2MukVN9uYLladG1VjDZhcLO75UEuWQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760763; c=relaxed/simple;
	bh=GSKEulN+BSkaYLCIod+3hVFyXLCFdx7Ea68t9crjgzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuKcND7azVyLI0zMzRO8r3Z8F/nlwK6HwZbv0RHYxqwx2VaEdrBtMTS2RdrJah9oaJYh6uW3RhtGzyV6gYPTpEZE9QBFQ7Nzw8/h3YDqorl40RtHy90dkGJgHmTeGCF8UzbajTDj3HMUfULe4ihJfBFjNRu8fH5oMqzs6f/ArPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L5j/ODUv; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L5j/ODUv"
Received: (qmail 42121 invoked by uid 109); 21 Aug 2025 07:19:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GSKEulN+BSkaYLCIod+3hVFyXLCFdx7Ea68t9crjgzM=; b=L5j/ODUv3edkUOFo3kBJFsx3FDB/tBnaFGFHiluPs3ZxjLdgz92FbDHtxBtaCiwJVmS02hXrHV2rTncfQ9y9qmjP5xOJKVgj7u1rH7QfXdJRqN6ogNERc4qnHOw2OQf3tZhIypukDE0Gj3Aajb0NAjJjj1j31RNMxT95K62y8ilxALyVM2HJFPaZs2WEfr3R90T+877Zc6asyn2UjIEVFYv90ZUUqrnNSGpXzbKFRRYr4opUZH4QQB4hh4ae1IWCEJkVIPGTKXs+wF0Ef7MAKsDe/prDVCL+N7Y1dGeknmzTTIU/Hr0epoOrD+oiKuqiuPGdC3PqsVW2TA4reJifhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Aug 2025 07:19:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 72287 invoked by uid 111); 21 Aug 2025 07:19:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Aug 2025 03:19:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Aug 2025 03:19:18 -0400
From: Jeff King <peff@peff.net>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: git@vger.kernel.org
Subject: [PATCH 2/4] add-interactive: respect color.diff for diff coloring
Message-ID: <20250821071918.GB1839835@coredump.intra.peff.net>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821070740.GA3356411@coredump.intra.peff.net>

The old perl git-add--interactive.perl script used the color.diff config
option to decide whether to color diffs (and if not set, it fell back to
the value of color.ui via git-config's --get-colorbool option). When we
switched to the builtin version, this was lost: we respect only
color.ui. So for example:

  git -c color.diff=false add -p

would color the diff, even when it should not.

The culprit is this line in add-interactive.c's parse_diff():

  if (want_color_fd(1, -1))

That "-1" means "no config has been set", which causes it to fall back
to the color.ui setting. We should instead be passing the value of
color.diff. But the problem is that we never even parse that config
option!

Instead the builtin interactive code parses only the value of
color.interactive, which is used for prompts and other messages. One
could perhaps argue that this should cover interactive diff coloring,
too, but historically it did not. The perl script treated
color.interactive and color.diff separately. So we should grab the
values for both, keeping separate fields in our add_i_state variable,
rather than a single use_color field.

We also load individual color slots (e.g., color.interactive.prompt),
leaving them as the empty string when color is disabled. This happens
via the init_color() helper in add-interactive, which checks that
use_color field. Now that there are two such fields, we need to pass the
appropriate one for each color.

The colors are mostly easy to divide up; color.interactive.* follows
color.interactive, and color.diff.* follows color.diff. But the "reset"
color is tricky. It is used for both types of coloring, but the two can
be configured independently. So we introduce two separate reset colors,
and use each in the appropriate spot.

There are two new tests. The first enables interactive prompt colors but
disables color.diff. We should see a colored prompt but not a colored
diff, showing that we are now respecting color.diff (and not
color.interactive or color.ui).

The second does the opposite. We disable color.interactive but turn on
color.diff with a custom fragment color. When we split a hunk, the
interactive code has to re-color the hunk header, which lets us check
that we correctly loaded the color.diff.frag config based on color.diff,
not color.interactive.

Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c          | 79 ++++++++++++++++++++++----------------
 add-interactive.h          |  7 +++-
 add-patch.c                | 12 +++---
 t/t3701-add-interactive.sh | 36 +++++++++++++++++
 4 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 3e692b47ec..95ab251963 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -20,14 +20,14 @@
 #include "prompt.h"
 #include "tree.h"
 
-static void init_color(struct repository *r, struct add_i_state *s,
+static void init_color(struct repository *r, int use_color,
 		       const char *section_and_slot, char *dst,
 		       const char *default_color)
 {
 	char *key = xstrfmt("color.%s", section_and_slot);
 	const char *value;
 
-	if (!s->use_color)
+	if (!use_color)
 		dst[0] = '\0';
 	else if (repo_config_get_value(r, key, &value) ||
 		 color_parse(value, dst))
@@ -36,42 +36,54 @@ static void init_color(struct repository *r, struct add_i_state *s,
 	free(key);
 }
 
-void init_add_i_state(struct add_i_state *s, struct repository *r,
-		      struct add_p_opt *add_p_opt)
+static int check_color_config(struct repository *r, const char *var)
 {
 	const char *value;
+	int ret;
+
+	if (repo_config_get_value(r, var, &value))
+		ret = -1;
+	else
+		ret = git_config_colorbool(var, value);
+	return want_color(ret);
+}
 
+void init_add_i_state(struct add_i_state *s, struct repository *r,
+		      struct add_p_opt *add_p_opt)
+{
 	s->r = r;
 	s->context = -1;
 	s->interhunkcontext = -1;
 
-	if (repo_config_get_value(r, "color.interactive", &value))
-		s->use_color = -1;
-	else
-		s->use_color =
-			git_config_colorbool("color.interactive", value);
-	s->use_color = want_color(s->use_color);
-
-	init_color(r, s, "interactive.header", s->header_color, GIT_COLOR_BOLD);
-	init_color(r, s, "interactive.help", s->help_color, GIT_COLOR_BOLD_RED);
-	init_color(r, s, "interactive.prompt", s->prompt_color,
-		   GIT_COLOR_BOLD_BLUE);
-	init_color(r, s, "interactive.error", s->error_color,
-		   GIT_COLOR_BOLD_RED);
-
-	init_color(r, s, "diff.frag", s->fraginfo_color,
-		   diff_get_color(s->use_color, DIFF_FRAGINFO));
-	init_color(r, s, "diff.context", s->context_color, "fall back");
+	s->use_color_interactive = check_color_config(r, "color.interactive");
+
+	init_color(r, s->use_color_interactive, "interactive.header",
+		   s->header_color, GIT_COLOR_BOLD);
+	init_color(r, s->use_color_interactive, "interactive.help",
+		   s->help_color, GIT_COLOR_BOLD_RED);
+	init_color(r, s->use_color_interactive, "interactive.prompt",
+		   s->prompt_color, GIT_COLOR_BOLD_BLUE);
+	init_color(r, s->use_color_interactive, "interactive.error",
+		   s->error_color, GIT_COLOR_BOLD_RED);
+	strlcpy(s->reset_color_interactive,
+		s->use_color_interactive ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
+
+	s->use_color_diff = check_color_config(r, "color.diff");
+
+	init_color(r, s->use_color_diff, "diff.frag", s->fraginfo_color,
+		   diff_get_color(s->use_color_diff, DIFF_FRAGINFO));
+	init_color(r, s->use_color_diff, "diff.context", s->context_color,
+		   "fall back");
 	if (!strcmp(s->context_color, "fall back"))
-		init_color(r, s, "diff.plain", s->context_color,
-			   diff_get_color(s->use_color, DIFF_CONTEXT));
-	init_color(r, s, "diff.old", s->file_old_color,
-		diff_get_color(s->use_color, DIFF_FILE_OLD));
-	init_color(r, s, "diff.new", s->file_new_color,
-		diff_get_color(s->use_color, DIFF_FILE_NEW));
-
-	strlcpy(s->reset_color,
-		s->use_color ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
+		init_color(r, s->use_color_diff, "diff.plain",
+			   s->context_color,
+			   diff_get_color(s->use_color_diff, DIFF_CONTEXT));
+	init_color(r, s->use_color_diff, "diff.old", s->file_old_color,
+		diff_get_color(s->use_color_diff, DIFF_FILE_OLD));
+	init_color(r, s->use_color_diff, "diff.new", s->file_new_color,
+		diff_get_color(s->use_color_diff, DIFF_FILE_NEW));
+	strlcpy(s->reset_color_diff,
+		s->use_color_diff ? GIT_COLOR_RESET : "", COLOR_MAXLEN);
 
 	FREE_AND_NULL(s->interactive_diff_filter);
 	repo_config_get_string(r, "interactive.difffilter",
@@ -109,7 +121,8 @@ void clear_add_i_state(struct add_i_state *s)
 	FREE_AND_NULL(s->interactive_diff_filter);
 	FREE_AND_NULL(s->interactive_diff_algorithm);
 	memset(s, 0, sizeof(*s));
-	s->use_color = -1;
+	s->use_color_interactive = -1;
+	s->use_color_diff = -1;
 }
 
 /*
@@ -1188,9 +1201,9 @@ int run_add_i(struct repository *r, const struct pathspec *ps,
 	 * When color was asked for, use the prompt color for
 	 * highlighting, otherwise use square brackets.
 	 */
-	if (s.use_color) {
+	if (s.use_color_interactive) {
 		data.color = s.prompt_color;
-		data.reset = s.reset_color;
+		data.reset = s.reset_color_interactive;
 	}
 	print_file_item_data.color = data.color;
 	print_file_item_data.reset = data.reset;
diff --git a/add-interactive.h b/add-interactive.h
index 4213dcd67b..ceadfa6bb6 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -12,16 +12,19 @@ struct add_p_opt {
 
 struct add_i_state {
 	struct repository *r;
-	int use_color;
+	int use_color_interactive;
+	int use_color_diff;
 	char header_color[COLOR_MAXLEN];
 	char help_color[COLOR_MAXLEN];
 	char prompt_color[COLOR_MAXLEN];
 	char error_color[COLOR_MAXLEN];
-	char reset_color[COLOR_MAXLEN];
+	char reset_color_interactive[COLOR_MAXLEN];
+
 	char fraginfo_color[COLOR_MAXLEN];
 	char context_color[COLOR_MAXLEN];
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
+	char reset_color_diff[COLOR_MAXLEN];
 
 	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
diff --git a/add-patch.c b/add-patch.c
index 302e6ba7d9..b0389c5d5b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -300,7 +300,7 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 	va_start(args, fmt);
 	fputs(s->s.error_color, stdout);
 	vprintf(fmt, args);
-	puts(s->s.reset_color);
+	puts(s->s.reset_color_interactive);
 	va_end(args);
 }
 
@@ -457,7 +457,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	}
 	strbuf_complete_line(plain);
 
-	if (want_color_fd(1, -1)) {
+	if (want_color_fd(1, s->s.use_color_diff)) {
 		struct child_process colored_cp = CHILD_PROCESS_INIT;
 		const char *diff_filter = s->s.interactive_diff_filter;
 
@@ -714,7 +714,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
-			strbuf_addf(out, "%s\n", s->s.reset_color);
+			strbuf_addf(out, "%s\n", s->s.reset_color_diff);
 		else
 			strbuf_addch(out, '\n');
 	}
@@ -1107,7 +1107,7 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
 			      s->s.file_new_color :
 			      s->s.context_color);
 		strbuf_add(&s->colored, plain + current, eol - current);
-		strbuf_addstr(&s->colored, s->s.reset_color);
+		strbuf_addstr(&s->colored, s->s.reset_color_diff);
 		if (next > eol)
 			strbuf_add(&s->colored, plain + eol, next - eol);
 		current = next;
@@ -1528,8 +1528,8 @@ static int patch_update_file(struct add_p_state *s,
 						: 1));
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
 		       s->buf.buf);
-		if (*s->s.reset_color)
-			fputs(s->s.reset_color, stdout);
+		if (*s->s.reset_color_interactive)
+			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF)
 			break;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 04d2a19835..3f9cb9453f 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -866,6 +866,42 @@ test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	test_grep "old<" output
 '
 
+test_expect_success 'diff color respects color.diff' '
+	git reset --hard &&
+
+	echo old >test &&
+	git add test &&
+	echo new >test &&
+
+	printf n >n &&
+	force_color git \
+		-c color.interactive=auto \
+		-c color.interactive.prompt=blue \
+		-c color.diff=false \
+		-c color.diff.old=red \
+		add -p >output.raw 2>&1 <n &&
+	test_decode_color <output.raw >output &&
+	test_grep "BLUE.*Stage this hunk" output &&
+	test_grep ! "RED" output
+'
+
+test_expect_success 're-coloring diff without color.interactive' '
+	git reset --hard &&
+
+	test_write_lines 1 2 3 >test &&
+	git add test &&
+	test_write_lines one 2 three >test &&
+
+	test_write_lines s n n |
+	force_color git \
+		-c color.interactive=false \
+		-c color.diff=true \
+		-c color.diff.frag="bold magenta" \
+		add -p >output.raw 2>&1 &&
+	test_decode_color <output.raw >output &&
+	test_grep "<BOLD;MAGENTA>@@" output
+'
+
 test_expect_success 'diffFilter filters diff' '
 	git reset --hard &&
 
-- 
2.51.0.356.g99d8374de0

