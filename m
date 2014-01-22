From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] parse-options: refactor human-friendly-integer parser out of pack-objects
Date: Wed, 22 Jan 2014 11:58:04 -0800
Message-ID: <1390420685-18449-2-git-send-email-gitster@pobox.com>
References: <1390420685-18449-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 20:58:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W63wN-0007V8-8Y
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 20:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbaAVT6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 14:58:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56505 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbaAVT6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 14:58:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C46064376;
	Wed, 22 Jan 2014 14:58:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9XOv
	uE8qbyJdod0hmGtUyRSx764=; b=EyBkW824wVpigd+jnO83nWbT9cLJl1/LNTsc
	lNHWq/hpbTP0eUE5Tan/6h1wtBlh7lizjGrzd0CCrTV522JXBwNa3alTAdA/MYC+
	rQ80scRxOUGP8AjLkc7BW7yIig85BuPx/FA/9H37XHANTce7lvmV7SWlTvp5Qax1
	DP200bE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	O2qz5NLWmwDFl7py/M2mBkF3VwUuJ0NKg8nFyI570NOplmfzL5W/lE6UwMXdqu9U
	Xbr2scMAZntNfHjWqqZSi7nrbF4v/rartJsOAJo2oatxpizGQjsGxoLqDbW2h51V
	DA0qNSXssfRzUl6u8j5cIW1kw553MzoyVjIZdy+e1as=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89C4664372;
	Wed, 22 Jan 2014 14:58:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4501D6436C;
	Wed, 22 Jan 2014 14:58:16 -0500 (EST)
X-Mailer: git-send-email 1.9-rc0-151-ga5225c0
In-Reply-To: <1390420685-18449-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 88699FB6-839F-11E3-B299-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240847>

We only had code to understand unit suffixes such as g/m/k (as in
2g/400m/8k) in the configuration parser but not in the command line
option parser.  "git pack-objects" worked it around by having a
custom extension to the parse-options API; make it available to
other callers.

The new macro is not called OPT_ULONG() but OPT_HUM_ULONG(), as it
would be bizzarre to have ULONG that understands human friendly
units while INTEGER that does not.  It is not named with a shorter
"OPT_HULONG", primarily to avoid having to name a future parallel
for parsing human friendly integer "OPT_HINT".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-objects.c | 25 ++++---------------------
 parse-options.c        | 17 +++++++++++++++++
 parse-options.h        |  5 +++++
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..2fa8e1e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2417,23 +2417,6 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_ulong(const struct option *opt,
-			      const char *arg, int unset)
-{
-	if (unset)
-		die(_("option %s does not accept negative form"),
-		    opt->long_name);
-
-	if (!git_parse_ulong(arg, opt->value))
-		die(_("unable to parse value '%s' for option %s"),
-		    arg, opt->long_name);
-	return 0;
-}
-
-#define OPT_ULONG(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), "n", (h),	\
-	  PARSE_OPT_NONEG, option_parse_ulong }
-
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -2455,16 +2438,16 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("version[,offset]"),
 		  N_("write the pack index file in the specified idx format version"),
 		  0, option_parse_index_version },
-		OPT_ULONG(0, "max-pack-size", &pack_size_limit,
-			  N_("maximum size of each output pack file")),
+		OPT_HUM_ULONG(0, "max-pack-size", &pack_size_limit,
+			      N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
 			 N_("ignore borrowed objects from alternate object store")),
 		OPT_BOOL(0, "incremental", &incremental,
 			 N_("ignore packed objects")),
 		OPT_INTEGER(0, "window", &window,
 			    N_("limit pack window by objects")),
-		OPT_ULONG(0, "window-memory", &window_memory_limit,
-			  N_("limit pack window by memory in addition to object limit")),
+		OPT_HUM_ULONG(0, "window-memory", &window_memory_limit,
+		      N_("limit pack window by memory in addition to object limit")),
 		OPT_INTEGER(0, "depth", &depth,
 			    N_("maximum length of delta chain allowed in the resulting pack")),
 		OPT_BOOL(0, "reuse-delta", &reuse_delta,
diff --git a/parse-options.c b/parse-options.c
index c2cbca2..948ade7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -136,6 +136,23 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
 
+	case OPTION_ULONG:
+		if (unset) {
+			*(unsigned long *)opt->value = 0;
+		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			*(unsigned long *)opt->value = opt->defval;
+		} else if (get_arg(p, opt, flags, &arg)) {
+			return -1;
+		} else if (opt->flags & PARSE_OPT_HUMAN_NUMBER) {
+			if (!git_parse_ulong(arg, (unsigned long *)opt->value))
+				return opterror(opt, "expects a numerical value", flags);
+		} else {
+			*(unsigned long *)opt->value = strtoul(arg, (char **)&s, 10);
+			if (*s)
+				return opterror(opt, "expects a numerical value", flags);
+		}
+		return 0;
+
 	default:
 		die("should not happen, someone must be hit on the forehead");
 	}
diff --git a/parse-options.h b/parse-options.h
index 9b94596..d65ecdb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -16,6 +16,7 @@ enum parse_opt_type {
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
+	OPTION_ULONG,
 	OPTION_CALLBACK,
 	OPTION_LOWLEVEL_CALLBACK,
 	OPTION_FILENAME
@@ -40,6 +41,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
+	PARSE_OPT_HUMAN_NUMBER = 128,
 	PARSE_OPT_SHELL_EVAL = 256
 };
 
@@ -131,6 +133,9 @@ struct option {
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
+#define OPT_ULONG(s, l, v, h)       { OPTION_ULONG, (s), (l), (v), N_("n"), (h) }
+#define OPT_HUM_ULONG(s, l, v, h)   { OPTION_ULONG, (s), (l), (v), N_("n"), (h), \
+				      PARSE_OPT_HUMAN_NUMBER }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
-- 
1.9-rc0-151-ga5225c0
