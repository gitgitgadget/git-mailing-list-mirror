From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] submodule: use match_config_key when parsing config
Date: Mon, 14 Jan 2013 07:04:38 -0800
Message-ID: <20130114150438.GE16828@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 16:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tulax-000828-DE
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 16:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271Ab3ANPEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 10:04:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32920 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512Ab3ANPEm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 10:04:42 -0500
Received: (qmail 19956 invoked by uid 107); 14 Jan 2013 15:05:59 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 10:05:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 07:04:38 -0800
Content-Disposition: inline
In-Reply-To: <20130114145845.GA16497@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213495>

This makes the code a lot simpler to read by dropping a
whole bunch of constant offsets.

As a bonus, it means we also feed the whole config variable
name to our error functions:

  [before]
  $ git -c submodule.foo.fetchrecursesubmodules=bogus checkout
  fatal: bad foo.fetchrecursesubmodules argument: bogus

  [after]
  fatal: bad submodule.foo.fetchrecursesubmodules argument: bogus

Signed-off-by: Jeff King <peff@peff.net>
---
 submodule.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2f55436..4361207 100644
--- a/submodule.c
+++ b/submodule.c
@@ -126,15 +126,17 @@ int parse_submodule_config_option(const char *var, const char *value)
 
 int parse_submodule_config_option(const char *var, const char *value)
 {
-	int len;
 	struct string_list_item *config;
 	struct strbuf submodname = STRBUF_INIT;
+	const char *name, *key;
+	int namelen;
 
-	var += 10;		/* Skip "submodule." */
+	if (match_config_key(var, "submodule", &name, &namelen, &key) < 0 ||
+	    !name)
+		return 0;
 
-	len = strlen(var);
-	if ((len > 5) && !strcmp(var + len - 5, ".path")) {
-		strbuf_add(&submodname, var, len - 5);
+	if (!strcmp(key, "path")) {
+		strbuf_add(&submodname, name, namelen);
 		config = unsorted_string_list_lookup(&config_name_for_path, value);
 		if (config)
 			free(config->util);
@@ -142,22 +144,22 @@ int parse_submodule_config_option(const char *var, const char *value)
 			config = string_list_append(&config_name_for_path, xstrdup(value));
 		config->util = strbuf_detach(&submodname, NULL);
 		strbuf_release(&submodname);
-	} else if ((len > 23) && !strcmp(var + len - 23, ".fetchrecursesubmodules")) {
-		strbuf_add(&submodname, var, len - 23);
+	} else if (!strcmp(key, "fetchrecursesubmodules")) {
+		strbuf_add(&submodname, name, namelen);
 		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, submodname.buf);
 		if (!config)
 			config = string_list_append(&config_fetch_recurse_submodules_for_name,
 						    strbuf_detach(&submodname, NULL));
 		config->util = (void *)(intptr_t)parse_fetch_recurse_submodules_arg(var, value);
 		strbuf_release(&submodname);
-	} else if ((len > 7) && !strcmp(var + len - 7, ".ignore")) {
+	} else if (!strcmp(key, "ignore")) {
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
 			return 0;
 		}
 
-		strbuf_add(&submodname, var, len - 7);
+		strbuf_add(&submodname, name, namelen);
 		config = unsorted_string_list_lookup(&config_ignore_for_name, submodname.buf);
 		if (config)
 			free(config->util);
-- 
1.8.1.rc1.10.g7d71f7b
