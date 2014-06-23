From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Mon, 23 Jun 2014 03:41:43 -0700
Message-ID: <1403520105-23250-4-git-send-email-tanayabh@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:42:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1i1-00026t-Tf
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbaFWKml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:42:41 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51840 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaFWKmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:42:40 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so5759822pab.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PBV6M7N3V3qIUXhNu/WCnQlP6wtQgHY41h7DsxZH87I=;
        b=D9uMKbXFYa5SL/9woZhBjnfqAY8K3vBvmqZ4aVf4GU0a1cE35uQb+vpve8gqoVWKUt
         NReoLjceBfRtwZMOBL9jK0wQzrMXXu77+qAIidf2EtUQGN5P7QIgQCK2tqt4NPZwMtI7
         6upAQvQMi0F3VMZxoFiwJl57g2wtmC5/brmJOnqcUv24zFntUBF/Ul24AmgrdG1TSEFP
         OvPfJ63ekp5MiBJ50TOgycfukXGuXfx5lxNEDRGWT0gATwMIPqAppEEPAJJUQUOMenGL
         d10crb+Ql6pNLRAbyFrOCAxzV7frsPKts8R64hFGI0hQgEQgXIX7peJXR7TTJwdBNFNx
         o/Ug==
X-Received: by 10.67.11.14 with SMTP id ee14mr27466232pad.107.1403520160344;
        Mon, 23 Jun 2014 03:42:40 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id zc10sm91487896pac.46.2014.06.23.03.42.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:42:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252337>

Use git_config_get_string instead of git_config to take advantage of
the config hash-table api which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 notes-utils.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index a0b1d7b..fdc9912 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -68,22 +68,23 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
 		return NULL;
 }
 
-static int notes_rewrite_config(const char *k, const char *v, void *cb)
+static void notes_rewrite_config(struct notes_rewrite_cfg *c)
 {
-	struct notes_rewrite_cfg *c = cb;
-	if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
-		c->enabled = git_config_bool(k, v);
-		return 0;
-	} else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
+	struct strbuf key = STRBUF_INIT;
+	const char *v;
+	strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
+
+	if (!git_config_get_string(key.buf, &v))
+		c->enabled = git_config_bool(key.buf, v);
+
+	if (!c->mode_from_env && !git_config_get_string("notes.rewritemode", &v)) {
 		if (!v)
-			return config_error_nonbool(k);
+			config_error_nonbool("notes.rewritemode");
 		c->combine = parse_combine_notes_fn(v);
-		if (!c->combine) {
+		if (!c->combine)
 			error(_("Bad notes.rewriteMode value: '%s'"), v);
-			return 1;
-		}
-		return 0;
-	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
+	}
+	if (!c->refs_from_env && !git_config_get_string("notes.rewriteref", &v)) {
 		/* note that a refs/ prefix is implied in the
 		 * underlying for_each_glob_ref */
 		if (starts_with(v, "refs/notes/"))
@@ -91,10 +92,8 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
 		else
 			warning(_("Refusing to rewrite notes in %s"
 				" (outside of refs/notes/)"), v);
-		return 0;
 	}
-
-	return 0;
+	strbuf_release(&key);
 }
 
 
@@ -123,7 +122,7 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 		c->refs_from_env = 1;
 		string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
 	}
-	git_config(notes_rewrite_config, c);
+	notes_rewrite_config(c);
 	if (!c->enabled || !c->refs->nr) {
 		string_list_clear(c->refs, 0);
 		free(c->refs);
-- 
1.9.0.GIT
