From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 08/43] refs.c: move the hidden refs functions to the common code
Date: Mon, 28 Sep 2015 18:01:43 -0400
Message-ID: <1443477738-32023-9-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:05:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXk-00030D-GT
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbbI1WFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:05:03 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36840 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbbI1WDF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:05 -0400
Received: by qgx61 with SMTP id 61so133693213qgx.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NjNS/j26wlXqMPG25zIP3FsHcdqYlszOx5g1qxdMIzQ=;
        b=RVdzmJMC4hdQKmuscm4uATNVdXu8g5+xdEhhXZ5uQwomiPVNUxDIxv1HmxXoItPej/
         ML+zNilsCZcnDRlGrDkaH3J/ePtsZP1fh+HmqbyKVrZBFx9i0rQW3gMYOdq1mSyMUuUs
         uSayd86iPRuZtosqB2kRUq3fGbTnYuzM0ehiMr+pgieDXpQsCLkT5pw9ljy2VgtTdLQX
         VNalUVYrUslYtk3eAW8CB+EBS4x6X2vlJwpP7jHLOJvjw/IM1/1g5+aMkFYe9s7rFNBu
         SY+W0HyBfe64GFHELunKzJPEum0MY1SWKWk+i4xrueJPqzEfl1mpMQ3wjqkkGlIjpJ7P
         MCrg==
X-Gm-Message-State: ALoCoQn/BKClmc37bQZF85ar7AwnzmB4VVdkx+CAerwljMPEB+5dTx1q3P4nOTMEqofj0ionrhEF
X-Received: by 10.140.82.163 with SMTP id h32mr24869186qgd.29.1443477784264;
        Mon, 28 Sep 2015 15:03:04 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278794>

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
index f6cdea9..3609d02 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -4181,57 +4181,6 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
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
