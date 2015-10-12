From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 08/44] refs.c: move the hidden refs functions to the common code
Date: Mon, 12 Oct 2015 17:51:28 -0400
Message-ID: <1444686725-27660-9-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll18-0004JB-QQ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbbJLVwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:52:23 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34876 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbJLVwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:21 -0400
Received: by qkap81 with SMTP id p81so63249129qka.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m8bmDD3aFPj0gJmao4NQmbL0fF9Bj5x/02mR0xN5oZI=;
        b=O5CSKGtc5GlTvlGMHY7IEpnVGEKmuckp7koOqOW8KX4IwC0+si+enrf2oZtCEzxcsV
         JBdSh8Kf7hNDSngnTtMI/Z23YfevwYoey0vTkQJp9XPO7p0FP9DOxwTGJxl75eMKi998
         AEFCvubWGodFCYYuHwgbjNuL4UKwE6J6B/E4N56ythe6OFdz0dLb7lMtEBu7hdOCEqM7
         byixUM/J9R/Wn5UVeofaRLHG2PHbzYsS7OvEMSyGXSA827x1L5fk5jSRAhgXz5whKWso
         vw4QPdap2Hc29Eeg1uGaNwL5yCaZQsckcgwRu9xucnwYdmuPAvhTzq8+dTSMEtIaleIM
         Ft3g==
X-Gm-Message-State: ALoCoQkwniMElzxgUnqQJfDGInjnnhOw88U9QjbBGhmGXUGRdkAvlPOSuaea21nBkMrvq+x1e7Ty
X-Received: by 10.55.201.217 with SMTP id m86mr35182415qkl.85.1444686741279;
        Mon, 12 Oct 2015 14:52:21 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279422>

From: Ronnie Sahlberg <sahlberg@google.com>

Move the hidden refs functions to the refs.c file since these
functions do not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 51 ---------------------------------------------------
 refs.c          | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 4e7e05e..d110bf8 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -4169,57 +4169,6 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
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
2.4.2.644.g97b850b-twtrsrc
