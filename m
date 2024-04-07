Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871045223
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451706; cv=none; b=hUK/J4ky2K90fUb3Woa7hM98CqikBW7RXNsT/r3tPxwOak7BhTIFGgEeWGZvupS2dPD0sC6F/U/Z4xGC1Zqu1Z5ERILKpj9GxQnRYEQzsNb9RfX6IhzbDS5sZaUxrKcfeyXOlgGvs2a4H8glEK62yPJ0jsxKLDK7ZCAZAH6+TF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451706; c=relaxed/simple;
	bh=5DqckvpAG1SJYEPPA8KAZl/rocT08yu1ypZRk8AZe0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsU78x7yLtU5bGACZ6ODUn04KIzJuJXHWcN3iObg+O2Tg5yBhQ/Y+00LX1yca6IuCeqN1k5lRROHwJq6BK59cC57g6RQDAYKjPku/rA3tENxNnAGVGbUFXiu+uGwS0pGd2wan1ozOPDgOMND4RoHg4UjQAs6FwSXK60QXwiKjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7319 invoked by uid 109); 7 Apr 2024 01:01:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:01:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11243 invoked by uid 111); 7 Apr 2024 01:01:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:01:46 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:01:43 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 05/11] config: use git_config_string_dup() to fix leaky open
 coding
Message-ID: <20240407010143.GE868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

These are cases which open-code the equivalent of git_config_string(),
but end up leaking the resulting value if the config value is seen
multiple times (because they never free an existing value). Using
git_config_string_dup() plug these potential leaks.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/help.c | 7 ++-----
 config.c       | 8 ++------
 merge-ll.c     | 5 +----
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index dc1fbe2b98..1bdd2faee0 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -52,7 +52,7 @@ static enum help_action {
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
 
-static const char *html_path;
+static char *html_path;
 static int verbose = 1;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
@@ -407,10 +407,7 @@ static int git_help_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "help.htmlpath")) {
-		if (!value)
-			return config_error_nonbool(var);
-		html_path = xstrdup(value);
-		return 0;
+		return git_config_string_dup(&html_path, var, value);
 	}
 	if (!strcmp(var, "man.viewer")) {
 		if (!value)
diff --git a/config.c b/config.c
index a0aa45abd5..c115e6d8c9 100644
--- a/config.c
+++ b/config.c
@@ -1575,12 +1575,8 @@ static int git_default_core_config(const char *var, const char *value,
 	if (!strcmp(var, "core.checkroundtripencoding"))
 		return git_config_string(&check_roundtrip_encoding, var, value);
 
-	if (!strcmp(var, "core.notesref")) {
-		if (!value)
-			return config_error_nonbool(var);
-		notes_ref_name = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "core.notesref"))
+		return git_config_string_dup(&notes_ref_name, var, value);
 
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
diff --git a/merge-ll.c b/merge-ll.c
index bf1077ae09..660d9a3bd6 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -308,8 +308,6 @@ static int read_merge_config(const char *var, const char *value,
 		return git_config_string(&fn->description, var, value);
 
 	if (!strcmp("driver", key)) {
-		if (!value)
-			return config_error_nonbool(var);
 		/*
 		 * merge.<name>.driver specifies the command line:
 		 *
@@ -333,8 +331,7 @@ static int read_merge_config(const char *var, const char *value,
 		 * file named by %A, and signal that it has done with zero exit
 		 * status.
 		 */
-		fn->cmdline = xstrdup(value);
-		return 0;
+		return git_config_string_dup(&fn->cmdline, var, value);
 	}
 
 	if (!strcmp("recursive", key))
-- 
2.44.0.872.g288abe5b5b

