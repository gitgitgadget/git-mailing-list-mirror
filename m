From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH] notes.c: replace git_config with git_config_get_string
Date: Mon, 23 Jun 2014 03:41:44 -0700
Message-ID: <1403520105-23250-5-git-send-email-tanayabh@gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:42:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1i6-0002BP-1f
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbaFWKmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:42:45 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39400 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaFWKmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:42:44 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so5687261pac.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UkuppYFIy/LFeWjSP1mzX9TmHBPoDOs9K82mmh5gUww=;
        b=dnACKEFO8+fGqD4Ce2PA4cMoCSrgfgfM+o2u7GfA28Ne1lytoUZu2Zb1e0n2zBS084
         72kfQ86YIlZ6yeemanExP3t9XYmVYXMBOjcMJxwJleJ79G2mrDXY+imMWgfDr+b4gMxn
         D+bzxGEKlB3ZpyOoIgAZQ33T8n3BtKaQzxArBN2Qp9t1Zhikusyf7G7Wt2b4MPV4k81B
         xkJ1mcvjlcCx8NQLnNslXJfNm6HqP9ufVCK4OeKKtVcrtCMsMRgkzjcse9Qx37rZwAzm
         D+Az+8/fA1Fejn0CpshTaaekDoCpS2Rc6ctyQ26FmRn3MZ76cRb1Tq+Yi/dsMBjAksz3
         a2sw==
X-Received: by 10.66.246.138 with SMTP id xw10mr27514533pac.142.1403520164462;
        Mon, 23 Jun 2014 03:42:44 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id zc10sm91487896pac.46.2014.06.23.03.42.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:42:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252338>

Use git_config_get_string instead of git_config to take advantage of
the config hash-table api which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 notes.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/notes.c b/notes.c
index 5fe691d..fc92eec 100644
--- a/notes.c
+++ b/notes.c
@@ -961,19 +961,6 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	free(globs_copy);
 }
 
-static int notes_display_config(const char *k, const char *v, void *cb)
-{
-	int *load_refs = cb;
-
-	if (*load_refs && !strcmp(k, "notes.displayref")) {
-		if (!v)
-			config_error_nonbool(k);
-		string_list_add_refs_by_glob(&display_notes_refs, v);
-	}
-
-	return 0;
-}
-
 const char *default_notes_ref(void)
 {
 	const char *notes_ref = NULL;
@@ -1041,6 +1028,7 @@ struct notes_tree **load_notes_trees(struct string_list *refs)
 void init_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
+	const char *value;
 	int load_config_refs = 0;
 	display_notes_refs.strdup_strings = 1;
 
@@ -1058,7 +1046,11 @@ void init_display_notes(struct display_notes_opt *opt)
 			load_config_refs = 1;
 	}
 
-	git_config(notes_display_config, &load_config_refs);
+	if (load_config_refs && !git_config_get_string("notes.displayref", &value)) {
+		if (!value)
+			config_error_nonbool("notes.displayref");
+		string_list_add_refs_by_glob(&display_notes_refs, value);
+	}
 
 	if (opt) {
 		struct string_list_item *item;
-- 
1.9.0.GIT
