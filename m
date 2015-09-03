From: David Turner <dturner@twopensource.com>
Subject: [PATCH 08/43] refs.c: move the hidden refs functions to the common code
Date: Wed,  2 Sep 2015 21:54:38 -0400
Message-ID: <1441245313-11907-9-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJkf-00065R-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357AbbICBzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:55:42 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33441 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbbICBze (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:34 -0400
Received: by qgev79 with SMTP id v79so18592893qge.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7m6YkaqhT0taP1Nt8pH1z6IQMirKoq1Q9jD0vXD83dg=;
        b=W9Lwm6zKSVzjOYs7xPN08loso7Cp3UIf5jvMq7OAJPf9WLIjS4qMnVzGX05p0OVqq6
         kr3m78WWiWsjY9gym61lQqgivhpbz7lj90cuEVJTMgXH0PK3S9/phczZDio0J6TPgu8H
         tbpay0mZqVaeiiiFnxHkfx0aYS/dO6vWxBpWwspSmw3fnrNgMIkWanisL0+XOmoOFMqI
         +h6MmxVw0ZHw7o21EXuVIyef1xX848qNP3bpW5J4z8Ztlrz1TgBn0/+9ilYTWHtlNY7Q
         KVvzM4zgikHjAbB2GAA8/Jfqbt1L6+g+pA2gGZ+vqu6hFpIjLGCCFvtRfcr0X/pa9AYi
         7uQw==
X-Gm-Message-State: ALoCoQlWEO0vR/hN6s3R+9YNl5ujk/fSZ5LBJ/rjm0CfigButW7J40rt1PobfFhXMpb3WgSJ7GBT
X-Received: by 10.140.128.2 with SMTP id 2mr68199107qha.8.1441245334195;
        Wed, 02 Sep 2015 18:55:34 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277142>

From: Ronnie Sahlberg <sahlberg@google.com>

Move the hidden refs functions to the refs.c file since these
functions do not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 51 ---------------------------------------------------
 refs.c          | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 085f776..e559d46 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -4179,57 +4179,6 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	return xstrdup(refname);
 }
 
-static struct string_list *hide_refs;
-
-int parse_hide_refs_config(const char *var, const char *value, const char *section)
-{
-	if (!strcmp("transfer.hiderefs", var) ||
-	    /* NEEDSWORK: use parse_config_key() once both are merged */
-	    (starts_with(var, section) && var[strlen(section)] == '.' &&
-	     !strcmp(var + strlen(section), ".hiderefs"))) {
-		char *ref;
-		int len;
-
-		if (!value)
-			return config_error_nonbool(var);
-		ref = xstrdup(value);
-		len = strlen(ref);
-		while (len && ref[len - 1] == '/')
-			ref[--len] = '\0';
-		if (!hide_refs) {
-			hide_refs = xcalloc(1, sizeof(*hide_refs));
-			hide_refs->strdup_strings = 1;
-		}
-		string_list_append(hide_refs, ref);
-	}
-	return 0;
-}
-
-int ref_is_hidden(const char *refname)
-{
-	int i;
-
-	if (!hide_refs)
-		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
-		int neg = 0;
-		int len;
-
-		if (*match == '!') {
-			neg = 1;
-			match++;
-		}
-
-		if (!starts_with(refname, match))
-			continue;
-		len = strlen(match);
-		if (!refname[len] || refname[len] == '/')
-			return !neg;
-	}
-	return 0;
-}
-
 struct expire_reflog_cb {
 	unsigned int flags;
 	reflog_expiry_should_prune_fn *should_prune_fn;
diff --git a/refs.c b/refs.c
index 5a8ef0c..6b2fc39 100644
--- a/refs.c
+++ b/refs.c
@@ -328,3 +328,53 @@ int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time,
 
 	return 1;
 }
+
+static struct string_list *hide_refs;
+
+int parse_hide_refs_config(const char *var, const char *value, const char *section)
+{
+	if (!strcmp("transfer.hiderefs", var) ||
+	    /* NEEDSWORK: use parse_config_key() once both are merged */
+	    (starts_with(var, section) && var[strlen(section)] == '.' &&
+	     !strcmp(var + strlen(section), ".hiderefs"))) {
+		char *ref;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		ref = xstrdup(value);
+		len = strlen(ref);
+		while (len && ref[len - 1] == '/')
+			ref[--len] = '\0';
+		if (!hide_refs) {
+			hide_refs = xcalloc(1, sizeof(*hide_refs));
+			hide_refs->strdup_strings = 1;
+		}
+		string_list_append(hide_refs, ref);
+	}
+	return 0;
+}
+
+int ref_is_hidden(const char *refname)
+{
+	int i;
+
+	if (!hide_refs)
+		return 0;
+	for (i = hide_refs->nr - 1; i >= 0; i--) {
+		const char *match = hide_refs->items[i].string;
+		int neg = 0;
+		int len;
+		if (*match == '!') {
+			neg = 1;
+			match++;
+		}
+
+		if (!starts_with(refname, match))
+			continue;
+		len = strlen(match);
+		if (!refname[len] || refname[len] == '/')
+			return !neg;
+	}
+	return 0;
+}
-- 
2.0.4.315.gad8727a-twtrsrc
