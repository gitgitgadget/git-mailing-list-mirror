From: Jeff King <peff@peff.net>
Subject: [PATCHv2 1/8] config: add helper function for parsing key names
Date: Wed, 23 Jan 2013 01:23:05 -0500
Message-ID: <20130123062305.GA5036@sigill.intra.peff.net>
References: <20130123062132.GA2038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:23:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxtkA-0006Yw-JY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab3AWGXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:23:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44589 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab3AWGXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:23:08 -0500
Received: (qmail 1233 invoked by uid 107); 23 Jan 2013 06:24:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:24:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:23:05 -0500
Content-Disposition: inline
In-Reply-To: <20130123062132.GA2038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214282>

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
 cache.h  | 15 +++++++++++++++
 config.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/cache.h b/cache.h
index c257953..b19305b 100644
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
+extern int parse_config_key(const char *var,
+			    const char *section,
+			    const char **subsection, int *subsection_len,
+			    const char **key);
+
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
 
diff --git a/config.c b/config.c
index 7b444b6..11bd4d8 100644
--- a/config.c
+++ b/config.c
@@ -1667,3 +1667,36 @@ int config_error_nonbool(const char *var)
 {
 	return error("Missing value for '%s'", var);
 }
+
+int parse_config_key(const char *var,
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
1.8.0.2.15.g815dc66
