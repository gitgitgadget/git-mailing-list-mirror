From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] submodule: simplify memory handling in config parsing
Date: Mon, 14 Jan 2013 07:07:41 -0800
Message-ID: <20130114150741.GF16828@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 16:08:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuldu-0002Bo-HH
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 16:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab3ANPHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 10:07:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32929 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756415Ab3ANPHp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 10:07:45 -0500
Received: (qmail 20061 invoked by uid 107); 14 Jan 2013 15:09:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 10:09:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 07:07:41 -0800
Content-Disposition: inline
In-Reply-To: <20130114145845.GA16497@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213496>

We keep a strbuf for the name of the submodule, even though
we only ever add one buffer (which we know the length of) to
it. Let's just use xmemdupz instead, which is slightly more
efficient and makes it easier to follow what is going on.

Unfortunately, we still end up having to deal with some
memory ownership issues in some code branches, as we have to
allocate the string in order to do a string list lookup, and
then only sometimes want to hand ownership of that string
over to the string_list. Still, making that explicit in the
code (as opposed to sometimes detaching the strbuf, and then
always releasing it) makes it a little more obvious what is
going on.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm undecided on this one. I think the result is easier to follow, but
others might find the original easier. This would be a lot more
readable if the config parser gave us a broken-out representation with
real C strings. Then we could pass the subsection straight to the
string_list functions for lookup, and using the "dup" flag of string
list, avoid even having to deal with memory duplication at all.

 submodule.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4361207..23a8490 100644
--- a/submodule.c
+++ b/submodule.c
@@ -127,7 +127,6 @@ int parse_submodule_config_option(const char *var, const char *value)
 int parse_submodule_config_option(const char *var, const char *value)
 {
 	struct string_list_item *config;
-	struct strbuf submodname = STRBUF_INIT;
 	const char *name, *key;
 	int namelen;
 
@@ -136,37 +135,36 @@ int parse_submodule_config_option(const char *var, const char *value)
 		return 0;
 
 	if (!strcmp(key, "path")) {
-		strbuf_add(&submodname, name, namelen);
 		config = unsorted_string_list_lookup(&config_name_for_path, value);
 		if (config)
 			free(config->util);
 		else
 			config = string_list_append(&config_name_for_path, xstrdup(value));
-		config->util = strbuf_detach(&submodname, NULL);
-		strbuf_release(&submodname);
+		config->util = xmemdupz(name, namelen);
 	} else if (!strcmp(key, "fetchrecursesubmodules")) {
-		strbuf_add(&submodname, name, namelen);
-		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, submodname.buf);
+		char *name_cstr = xmemdupz(name, namelen);
+		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name_cstr);
 		if (!config)
-			config = string_list_append(&config_fetch_recurse_submodules_for_name,
-						    strbuf_detach(&submodname, NULL));
+			config = string_list_append(&config_fetch_recurse_submodules_for_name, name_cstr);
+		else
+			free(name_cstr);
 		config->util = (void *)(intptr_t)parse_fetch_recurse_submodules_arg(var, value);
-		strbuf_release(&submodname);
 	} else if (!strcmp(key, "ignore")) {
+		char *name_cstr;
+
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
 			return 0;
 		}
 
-		strbuf_add(&submodname, name, namelen);
-		config = unsorted_string_list_lookup(&config_ignore_for_name, submodname.buf);
-		if (config)
+		name_cstr = xmemdupz(name, namelen);
+		config = unsorted_string_list_lookup(&config_ignore_for_name, name_cstr);
+		if (config) {
 			free(config->util);
-		else
-			config = string_list_append(&config_ignore_for_name,
-						    strbuf_detach(&submodname, NULL));
-		strbuf_release(&submodname);
+			free(name_cstr);
+		} else
+			config = string_list_append(&config_ignore_for_name, name_cstr);
 		config->util = xstrdup(value);
 		return 0;
 	}
-- 
1.8.1.rc1.10.g7d71f7b
