From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [RFC/PATCH 1/2] config: Add safe-include directive
Date: Fri,  3 Oct 2014 03:37:33 +0200
Message-ID: <1412300254-11281-2-git-send-email-rv@rasmusvillemoes.dk>
References: <xmqqy4t7a5vx.fsf@gitster.dls.corp.google.com>
 <1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
Cc: Jeff King <peff@peff.net>, Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 03:38:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZrot-00016E-T2
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 03:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbaJCBh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 21:37:59 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:57395 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbaJCBh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 21:37:56 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so221185lbi.27
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gBAxK9nZW6Fm3dP39XF243icL4pPmo1Mhew/HOyjlBo=;
        b=i8wMT40AqXPErNh+ti0jw9xBt83HqmsA2nVC5Qxiy1iJzGZMkstJdFEjiyyyQQNEwW
         X/ZWLasaj1pUWXlutsVPPRwYQkaI9iZSFBbX31JIKDE+eTYH3+5YGLbr5kj+naD2CyIX
         ahu4B0fYnTrbPsgku0qqCBLJW4hM2+hZ/Wkow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gBAxK9nZW6Fm3dP39XF243icL4pPmo1Mhew/HOyjlBo=;
        b=ekhQWwJZIz9Ywdv7YxV7DGow+RE8uFHc/zV+Zn/wyC4Knfoz5Wn/D50FAQXFqgczR+
         nTk33JSBdXvNvO1YJdYstp3gm+Cqaz1mUf9CJVFc86J2n4sYBuNy8jZAJQ9jn+U1U237
         25nOHo36V0/tyr9gGZcZyT2iUtNLkXz92ymhPq/8Ej5nH10iex9ixKu/U+CROvIGewBN
         NsdVftHYejzdjcsF4/sToRQVatIRCAUnysv5tvih6iONf0ia7XdprFMS3nW+v/os3BNF
         fNwKcOB6l6v4pGCxSXloAOJshFsPG0cvlM5y9I21PuuxXvzpVmK1+N8P4E8/InXStDST
         dI0A==
X-Gm-Message-State: ALoCoQklWHIStFRVmKL3fLFOGpYP4jrr6/GPUwvKOWjG41LH4sA2gxWIF/qwSPmTK/fjboWKPF/7
X-Received: by 10.153.7.73 with SMTP id da9mr892603lad.56.1412300275106;
        Thu, 02 Oct 2014 18:37:55 -0700 (PDT)
Received: from spencer.imf.au.dk ([130.225.20.51])
        by mx.google.com with ESMTPSA id v7sm2126751lbp.44.2014.10.02.18.37.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2014 18:37:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1412300254-11281-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257829>

This adds a variant of the include directive, where only certain
config variables in the included files are honoured. The set of
honoured variables consists of those the user has mentioned in a
safe-include.whitelist directive, along with a small set of git.git
blessed ones.

This can, for example, be used by a project to supply a set of
suggested configuration variables, such as "diff.renames = true". The
project would provide these in e.g project.gitconfig, and the user then
has to explicitly opt-in by putting

[safe-include]
    path = ../project.gitconfig

into .git/config, possibly preceding the path directive with a
whitelist directive.

The problem with simply using the ordinary include directive for this
purpose is that certain configuration variables (e.g. diff.external)
can allow arbitrary programs to be run.

Older versions of git do not understand the safe-include directives,
so they will effectively just ignore them.

Obviously, we must ignore safe-include.whitelist directives when we
are processing a safe-included file.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 config.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index a677eb6..764cda1 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "quote.h"
 #include "hashmap.h"
 #include "string-list.h"
+#include "wildmatch.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -39,6 +40,79 @@ static struct config_source *cf;
 
 static int zlib_compression_seen;
 
+struct safe_var {
+	struct safe_var *next;
+	const char *pattern;
+	int blacklisted;
+};
+
+static int safe_include_depth;
+static struct safe_var *safe_var_head;
+
+static const char *builtin_safe_patterns[] = {
+	"diff.renames",
+};
+
+static int config_name_is_safe(const char *var)
+{
+	struct safe_var *sv;
+	unsigned i;
+
+	for (sv = safe_var_head; sv; sv = sv->next) {
+		/* Handle malformed patterns? */
+		if (wildmatch(sv->pattern, var, WM_CASEFOLD, NULL) == WM_MATCH)
+			return !sv->blacklisted;
+	}
+	for (i = 0; i < ARRAY_SIZE(builtin_safe_patterns); ++i) {
+		if (wildmatch(builtin_safe_patterns[i], var, WM_CASEFOLD, NULL) == WM_MATCH)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void config_add_safe_pattern(const char *p)
+{
+	struct safe_var *sv;
+	int blacklist = 0;
+
+	if (*p == '!') {
+		blacklist = 1;
+		++p;
+	}
+	if (!*p)
+		return;
+	sv = xmalloc(sizeof(*sv));
+	sv->pattern = xstrdup(p);
+	sv->blacklisted = blacklist;
+	sv->next = safe_var_head;
+	safe_var_head = sv;
+}
+
+static void config_add_safe_names(const char *value)
+{
+	char *patterns = xstrdup(value);
+	char *p, *save;
+
+	/*
+	 * This allows giving multiple patterns in a single line, e.g.
+	 *
+	 *     whitelist = !* foo.bar squirrel.*
+	 *
+	 * to override the builtin list of safe vars and only declare
+	 * foo.bar and the squirrel section safe. But it has the
+	 * obvious drawback that one cannot match subsection names
+	 * containing whitespace. The alternative is that the above
+	 * would have to be written on three separate whitelist lines.
+	 */
+	for (p = strtok_r(patterns, " \t", &save); p; p = strtok_r(NULL, " \t", &save)) {
+		config_add_safe_pattern(p);
+	}
+
+	free(patterns);
+}
+
+
 /*
  * Default config_set that contains key-value pairs from the usual set of config
  * config files (i.e repo specific .git/config, user wide ~/.gitconfig, XDG
@@ -142,12 +216,23 @@ int git_config_include(const char *var, const char *value, void *data)
 	 * Pass along all values, including "include" directives; this makes it
 	 * possible to query information on the includes themselves.
 	 */
-	ret = inc->fn(var, value, inc->data);
-	if (ret < 0)
-		return ret;
+	if (safe_include_depth == 0 || config_name_is_safe(var)) {
+		ret = inc->fn(var, value, inc->data);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (!strcmp(var, "include.path"))
 		ret = handle_path_include(value, inc);
+	else if (safe_include_depth == 0
+		 && !strcmp(var, "safe-include.whitelist")) {
+		config_add_safe_names(value);
+	}
+	else if (!strcmp(var, "safe-include.path")) {
+		safe_include_depth++;
+		ret = handle_path_include(value, inc);
+		safe_include_depth--;
+	}
 	return ret;
 }
 
-- 
2.0.4
