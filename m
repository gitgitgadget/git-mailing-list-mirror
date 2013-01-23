From: Jeff King <peff@peff.net>
Subject: [PATCHv2 6/8] submodule: simplify memory handling in config parsing
Date: Wed, 23 Jan 2013 01:26:42 -0500
Message-ID: <20130123062642.GF5036@sigill.intra.peff.net>
References: <20130123062132.GA2038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txtnf-0008Si-Fi
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab3AWG0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:26:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44619 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240Ab3AWG0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:26:46 -0500
Received: (qmail 1342 invoked by uid 107); 23 Jan 2013 06:28:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:28:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:26:42 -0500
Content-Disposition: inline
In-Reply-To: <20130123062132.GA2038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214287>

We keep a strbuf for the name of the submodule, even though
we only ever add one string to it. Let's just use xmemdupz
instead, which is slightly more efficient and makes it
easier to follow what is going on.

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
 submodule.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index 25413de..9ba1496 100644
--- a/submodule.c
+++ b/submodule.c
@@ -127,7 +127,6 @@ int parse_submodule_config_option(const char *var, const char *value)
 int parse_submodule_config_option(const char *var, const char *value)
 {
 	struct string_list_item *config;
-	struct strbuf submodname = STRBUF_INIT;
 	const char *name, *key;
 	int namelen;
 
@@ -135,37 +134,36 @@ int parse_submodule_config_option(const char *var, const char *value)
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
1.8.0.2.15.g815dc66
