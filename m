From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] prune: introduce OPT_EXPIRY_DATE() and use it
Date: Thu, 25 Apr 2013 11:13:49 -0700
Message-ID: <7v61za4gwy.fsf_-_@alter.siamese.dyndns.org>
References: <7vbo9ceqb3.fsf@alter.siamese.dyndns.org>
	<1366271195-4276-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 25 20:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQgA-0007bT-NU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758426Ab3DYSNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 14:13:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54570 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756171Ab3DYSNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 14:13:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3935D176FA;
	Thu, 25 Apr 2013 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zgjAY6RGzpnrp6MenjdXxNbODbg=; b=QLvepH
	YN71732e6W9UipuFNocJIniPvPKg1s2P+7k20b4i1dODtzQQ7SbzFQJyKe/SvQ+c
	Wzy/xW9oQseOwCrVAgqY0PlT3qoaAszRbP3nvKEPJLArnOb9vYHtL1fsRiUqTyf5
	3c5Ygozi+Z1yvR0pZ2YC6yVLORAX5cAwJWmfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xBhw+8p/iBV0SF5Ix6FRrqSX3iCKLv6h
	u63Eo9cnQXmS8QeIHPVl52NwYhNoP2qdcfxl1mPNUtmIoMkAmBuEK0Zm/bWJB5M5
	brN21emA4js3CstfIPuqIzRaJH9SX+AsnA/GfaCmY98e0B/mv7ipj2a9gtVjB/lL
	EE/fp6m2ZoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C909176F9;
	Thu, 25 Apr 2013 18:13:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38B36176F5;
	Thu, 25 Apr 2013 18:13:51 +0000 (UTC)
In-Reply-To: <1366271195-4276-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 18 Apr 2013 09:46:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1CB3260-ADD3-11E2-9372-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222403>

Earlier we added support for --expire=all (or --expire=now) that
considers all crufts, regardless of their age, as eligible for
garbage collection by turning command argument parsers that use
approxidate() to use parse_expiry_date(), but "git prune" used a
built-in parse-options facility OPT_DATE() and did not benefit from
the new function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-parse-options.txt | 4 ++++
 builtin/prune.c                               | 4 ++--
 parse-options-cb.c                            | 6 ++++++
 parse-options.h                               | 4 ++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index facc8c8..a8bae69 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -176,6 +176,10 @@ There are some macros to easily define options:
 	Introduce an option with date argument, see `approxidate()`.
 	The timestamp is put into `int_var`.
 
+`OPT_EXPIRY_DATE(short, long, &int_var, description)`::
+	Introduce an option with expiry date argument, see `parse_expiry_date()`.
+	The timestamp is put into `int_var`.
+
 `OPT_CALLBACK(short, long, &var, arg_str, description, func_ptr)`::
 	Introduce an option with argument.
 	The argument will be fed into the function given by `func_ptr`
diff --git a/builtin/prune.c b/builtin/prune.c
index 85843d4..b90e5cc 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -132,8 +132,8 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned objects")),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
-		OPT_DATE(0, "expire", &expire,
-			 N_("expire objects older than <time>")),
+		OPT_EXPIRY_DATE(0, "expire", &expire,
+				N_("expire objects older than <time>")),
 		OPT_END()
 	};
 	char *s;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 0de5fb1..be8c413 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -33,6 +33,12 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
+			     int unset)
+{
+	return parse_expiry_date(arg, (unsigned long *)opt->value);
+}
+
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 			    int unset)
 {
diff --git a/parse-options.h b/parse-options.h
index 71a39c6..8541811 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -140,6 +140,9 @@ struct option {
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
 	  parse_opt_approxidate_cb }
+#define OPT_EXPIRY_DATE(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry date"),(h), 0,	\
+	  parse_opt_expiry_date_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
 #define OPT_NUMBER_CALLBACK(v, h, f) \
@@ -215,6 +218,7 @@ extern int parse_options_concat(struct option *dst, size_t, struct option *src);
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
+extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
