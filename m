From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 4/6] notes.c: replace `git_config()` with `git_config_get_value()`
Date: Mon, 21 Jul 2014 04:12:23 -0700
Message-ID: <1405941145-12120-5-git-send-email-tanayabh@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 13:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9BXQ-0008Lh-2r
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 13:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755072AbaGULNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 07:13:42 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60827 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaGULNk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 07:13:40 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so9614611pac.17
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/nhC8EAbZVXZfGqrsUTFH9sVdC9e36WXAgBsNzRl8uM=;
        b=GPewQpaAB/WjfI0zZJRwdYHQJTl59Lqdhz1yghOLJ16G3TvFevaTXvSGaeLOywdaMR
         t3olnd5sW5eyJ+GxggRiwCQCylqso/wczGqADax5J6QreqaJU3hR76iJXLCZR00QSr93
         cUd2xy5GxBTcnt1gHUeWR5a+P12tlvbkAagqHcW8vyUjYHEcKdLL+t4BYOHn4d66ZcZL
         qUUYnTHQhfu4ZVolgti/i8lDDWkjDbhuDuqYOYyIkN+1q5jGNYwgvOsqw/iwyruZTMhq
         Jud6Cq4qSg0KkXTa5q8+SXE2TwPxB6o1gHeudOvET4BplAS+3e9eLRS6RNt69UFQIs7h
         ONCg==
X-Received: by 10.68.69.109 with SMTP id d13mr9104432pbu.111.1405941219862;
        Mon, 21 Jul 2014 04:13:39 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.202])
        by mx.google.com with ESMTPSA id bl12sm2603688pac.44.2014.07.21.04.13.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 04:13:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253951>

Use `git_config_get_value()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow, also previously
'string_list_add_refs_by_glob()' was called even when the retrieved value
was NULL, correct it while we are at it.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 notes.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/notes.c b/notes.c
index 5fe691d..20c20f5 100644
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
+	const char *value = NULL;
 	int load_config_refs = 0;
 	display_notes_refs.strdup_strings = 1;
 
@@ -1058,7 +1046,12 @@ void init_display_notes(struct display_notes_opt *opt)
 			load_config_refs = 1;
 	}
 
-	git_config(notes_display_config, &load_config_refs);
+	if (load_config_refs && !git_config_get_value("notes.displayref", &value)) {
+		if (!value)
+			config_error_nonbool("notes.displayref");
+		else
+			string_list_add_refs_by_glob(&display_notes_refs, value);
+	}
 
 	if (opt) {
 		struct string_list_item *item;
-- 
1.9.0.GIT
