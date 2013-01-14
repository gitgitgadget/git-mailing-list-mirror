From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] config: add helper function for parsing key names
Date: Mon, 14 Jan 2013 07:00:13 -0800
Message-ID: <20130114150012.GA16828@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 16:00:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TulWh-0003fb-Ud
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 16:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab3ANPAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 10:00:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32889 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720Ab3ANPAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 10:00:17 -0500
Received: (qmail 19826 invoked by uid 107); 14 Jan 2013 15:01:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 10:01:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 07:00:13 -0800
Content-Disposition: inline
In-Reply-To: <20130114145845.GA16497@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213491>

The config callback functions get keys of the general form:

  section.subsection.key

(where the subsection may be contain arbitrary data, or may
be missing). For matching keys without subsections, it is
simple enough to call "strcmp". Matching keys with
subsections is a little more complicated, and each callback
does it in an ad-hoc way, usually involving error-prone
pointer arithmetic.

Let's provide a helper that keeps the pointer arithmetic all
in one place.

Signed-off-by: Jeff King <peff@peff.net>
---
No users yet; they come in future patches.

 cache.h  | 15 +++++++++++++++
 config.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/cache.h b/cache.h
index c257953..14003b8 100644
--- a/cache.h
+++ b/cache.h
@@ -1164,6 +1164,21 @@ extern int git_config_include(const char *name, const char *value, void *data);
 #define CONFIG_INCLUDE_INIT { 0 }
 extern int git_config_include(const char *name, const char *value, void *data);
 
+/*
+ * Match and parse a config key of the form:
+ *
+ *   section.(subsection.)?key
+ *
+ * (i.e., what gets handed to a config_fn_t). The caller provides the section;
+ * we return -1 if it does not match, 0 otherwise. The subsection and key
+ * out-parameters are filled by the function (and subsection is NULL if it is
+ * missing).
+ */
+extern int match_config_key(const char *var,
+		     const char *section,
+		     const char **subsection, int *subsection_len,
+		     const char **key);
+
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
 
diff --git a/config.c b/config.c
index 7b444b6..18d9c0e 100644
--- a/config.c
+++ b/config.c
@@ -1667,3 +1667,36 @@ int config_error_nonbool(const char *var)
 {
 	return error("Missing value for '%s'", var);
 }
+
+int match_config_key(const char *var,
+		     const char *section,
+		     const char **subsection, int *subsection_len,
+		     const char **key)
+{
+	int section_len = strlen(section);
+	const char *dot;
+
+	/* Does it start with "section." ? */
+	if (prefixcmp(var, section) || var[section_len] != '.')
+		return -1;
+
+	/*
+	 * Find the key; we don't know yet if we have a subsection, but we must
+	 * parse backwards from the end, since the subsection may have dots in
+	 * it, too.
+	 */
+	dot = strrchr(var, '.');
+	*key = dot + 1;
+
+	/* Did we have a subsection at all? */
+	if (dot == var + section_len) {
+		*subsection = NULL;
+		*subsection_len = 0;
+	}
+	else {
+		*subsection = var + section_len + 1;
+		*subsection_len = dot - *subsection;
+	}
+
+	return 0;
+}
-- 
1.8.1.rc1.10.g7d71f7b
