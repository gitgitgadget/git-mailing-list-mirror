From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] git-config: collect values instead of immediately
 printing
Date: Tue, 23 Oct 2012 18:40:04 -0400
Message-ID: <20121023224004.GF17392@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:40:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQn94-0002l8-6O
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933715Ab2JWWkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:40:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51692 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933508Ab2JWWkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:40:07 -0400
Received: (qmail 23384 invoked by uid 107); 23 Oct 2012 22:40:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:40:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:40:04 -0400
Content-Disposition: inline
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208267>

This is a refactor that will allow us to more easily tweak
the behavior for multi-valued variables, and it will
ultimately allow us to remove a lot git-config's custom code
in favor of the regular git_config code.

It does mean we're no longer streaming, and we're storing
more in memory for the --get-all case, but in practice it is
a tiny amount of data, and the results are instantaneous.

Signed-off-by: Jeff King <peff@peff.net>
---
The increase in line count is nicely offset by the next two patches.

 builtin/config.c | 50 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 60d36e7..08e83fc 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -15,7 +15,6 @@ static int do_not_match;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-static int seen;
 static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
@@ -95,8 +94,16 @@ static int show_config(const char *key_, const char *value_, void *cb)
 	return 0;
 }
 
-static int show_config(const char *key_, const char *value_, void *cb)
+struct strbuf_list {
+	struct strbuf *items;
+	int nr;
+	int alloc;
+};
+
+static int collect_config(const char *key_, const char *value_, void *cb)
 {
+	struct strbuf_list *values = cb;
+	struct strbuf *buf;
 	char value[256];
 	const char *vptr = value;
 	int must_free_vptr = 0;
@@ -111,11 +118,15 @@ static int show_config(const char *key_, const char *value_, void *cb)
 	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
 
+	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
+	buf = &values->items[values->nr++];
+	strbuf_init(buf, 0);
+
 	if (show_keys) {
-		printf("%s", key_);
+		strbuf_addstr(buf, key_);
 		must_print_delim = 1;
 	}
-	if (seen && !do_all)
+	if (values->nr > 1 && !do_all)
 		dup_error = 1;
 	if (types == TYPE_INT)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
@@ -138,15 +149,15 @@ static int show_config(const char *key_, const char *value_, void *cb)
 		vptr = "";
 		must_print_delim = 0;
 	}
-	seen++;
 	if (dup_error) {
 		error("More than one value for the key %s: %s",
 				key_, vptr);
 	}
 	else {
 		if (must_print_delim)
-			printf("%c", key_delim);
-		printf("%s%c", vptr, term);
+			strbuf_addch(buf, key_delim);
+		strbuf_addstr(buf, vptr);
+		strbuf_addch(buf, term);
 	}
 	if (must_free_vptr)
 		/* If vptr must be freed, it's a pointer to a
@@ -166,6 +177,8 @@ static int get_value(const char *key_, const char *regex_)
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
 	config_fn_t fn;
 	void *data;
+	struct strbuf_list values = {0};
+	int i;
 
 	local = given_config_file;
 	if (!local) {
@@ -223,8 +236,8 @@ static int get_value(const char *key_, const char *regex_)
 		}
 	}
 
-	fn = show_config;
-	data = NULL;
+	fn = collect_config;
+	data = &values;
 	if (respect_includes) {
 		inc.fn = fn;
 		inc.data = data;
@@ -241,19 +254,26 @@ static int get_value(const char *key_, const char *regex_)
 	if (do_all)
 		git_config_from_file(fn, local, data);
 	git_config_from_parameters(fn, data);
-	if (!do_all && !seen)
+	if (!do_all && !values.nr)
 		git_config_from_file(fn, local, data);
-	if (!do_all && !seen && global)
+	if (!do_all && !values.nr && global)
 		git_config_from_file(fn, global, data);
-	if (!do_all && !seen && xdg)
+	if (!do_all && !values.nr && xdg)
 		git_config_from_file(fn, xdg, data);
-	if (!do_all && !seen && system_wide)
+	if (!do_all && !values.nr && system_wide)
 		git_config_from_file(fn, system_wide, data);
 
 	if (do_all)
-		ret = !seen;
+		ret = !values.nr;
 	else
-		ret = (seen == 1) ? 0 : seen > 1 ? 2 : 1;
+		ret = (values.nr == 1) ? 0 : values.nr > 1 ? 2 : 1;
+
+	for (i = 0; i < values.nr; i++) {
+		struct strbuf *buf = values.items + i;
+		fwrite(buf->buf, 1, buf->len, stdout);
+		strbuf_release(buf);
+	}
+	free(values.items);
 
 free_strings:
 	free(repo_config);
-- 
1.8.0.3.g3456896
