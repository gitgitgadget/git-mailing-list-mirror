From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 08/26] refs.c: move the hidden refs functions to the common code
Date: Thu, 15 Oct 2015 15:46:32 -0400
Message-ID: <1444938410-2345-9-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVX-0007WP-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbbJOTrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:16 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35945 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbbJOTrP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:15 -0400
Received: by qgx61 with SMTP id 61so80920405qgx.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JNWDymkNRbHJ37UFuqW26LGrf/NazosBicUKHDMY3Qw=;
        b=W7RqTJNUaIwEQqeS7cPGaeNpbaW7euRQ5YAhLNLvELeID8l/spud4MYWrtcyLLHqJr
         C1zTVG5CClSk4WQ7SgjTcjQx1nCBiG+SwpclPD3kp4z1BA6ZApEkrJhiUEMq0bO/YsBa
         Cdxvomfig3Bn+9B7v9qMR7Sobt3yw+4l+wY7mSLDLdDdgGFHPakfSE+R9xYa6A4kyacz
         blsQud1SYFXKt2CeCnJh9UNQT9Gs2o5kzGQlEP2UNPLGXVN4VTq7QD6N/Czk9Eiv+gPw
         t2AWZqNuuQMFgFe/7b4RL5cPWdqfzotjtmC+oQM1AflarCbarU1ztLwGvToOfQTQTAyi
         EOyg==
X-Gm-Message-State: ALoCoQkBYkZgOuXWBPg5q0sHGV94AILblNwogKjDpOGHowEUzOYQu7SJbk5OAGQljrqNH0BooUg8
X-Received: by 10.140.99.117 with SMTP id p108mr14101367qge.91.1444938434431;
        Thu, 15 Oct 2015 12:47:14 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:13 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279700>

From: Ronnie Sahlberg <sahlberg@google.com>

Move the hidden refs functions to the refs.c file since these
functions do not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 51 ---------------------------------------------------
 refs.c          | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 04c3206..dad23c7 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -4215,57 +4215,6 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
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
index 8245118..6e5c8f8 100644
--- a/refs.c
+++ b/refs.c
@@ -292,3 +292,54 @@ int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time,
 
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
+
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
2.4.2.644.g97b850b-twtrsrc
