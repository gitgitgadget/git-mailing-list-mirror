From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 39/43] refs: break out a ref conflict check
Date: Mon, 28 Sep 2015 18:02:14 -0400
Message-ID: <1443477738-32023-40-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggWM-00019y-U0
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbbI1WDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:37 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35151 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbbI1WDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:35 -0400
Received: by qgt47 with SMTP id 47so133563236qgt.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BghZZtMt/OW/fZxyCY8PucNxnpsC3DELJeN9j0Y4gtA=;
        b=l23oQLY2xC7UmQlNUlgCYTkR6T14uSdtIGUsE9hQuw8+O4/GfpcB+u82TNkeKjN+zq
         GY18RyXczNS4suOdOHK2qbexz6RlP3CN/xcObfjul7UENiedMG9J3wurOoxX/mnLUfAT
         7hioDZfKkqn4Mz2yjzOzJoFZqzyp4KVAsCX394Jfvhhgeai6vqbIAUvX1myQlxhqcn/T
         jp1XI1DzEwaAl04y5txPYnOkezmWMWmk+IS8rG2DY5NCvKIhzu7+Bbddqov4W6k0aAWD
         C80uuoqvM067t6V51zBa7SIhg2C8xtBYmQXJEnExAZ67J7VxV1Nuy3kDdjN6N+lFyOI3
         8RlQ==
X-Gm-Message-State: ALoCoQmZVj2zBK6LpQxLSvwYAfYpRJX20R7LxTc6guYJndbA3o8kGCaEEz+UGGwJeUG4zspWocPD
X-Received: by 10.140.150.4 with SMTP id 4mr25118929qhw.35.1443477815138;
        Mon, 28 Sep 2015 15:03:35 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278767>

Create new function verify_no_descendants, to hold one of the ref
conflict checks used in verify_refname_available.  Multiple backends
will need this function, so it goes in the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 33 ++++++++-------------------------
 refs.c          | 28 ++++++++++++++++++++++++++++
 refs.h          |  4 ++++
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 943604c..8815111 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -753,6 +753,7 @@ static int verify_refname_available_dir(const char *refname,
 					struct strbuf *err)
 {
 	const char *slash;
+	const char *extra_refname;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
 	int ret = -1;
@@ -858,33 +859,15 @@ static int verify_refname_available_dir(const char *refname,
 		}
 	}
 
-	if (extras) {
-		/*
-		 * Check for entries in extras that start with
-		 * "$refname/". We do that by looking for the place
-		 * where "$refname/" would be inserted in extras. If
-		 * there is an entry at that position that starts with
-		 * "$refname/" and is not in skip, then we have a
-		 * conflict.
-		 */
-		for (pos = string_list_find_insert_index(extras, dirname.buf, 0);
-		     pos < extras->nr; pos++) {
-			const char *extra_refname = extras->items[pos].string;
-
-			if (!starts_with(extra_refname, dirname.buf))
-				break;
-
-			if (!skip || !string_list_has_string(skip, extra_refname)) {
-				strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
-					    refname, extra_refname);
-				goto cleanup;
-			}
-		}
+	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
+	if (extra_refname) {
+		strbuf_addf(err,
+			    "cannot process '%s' and '%s' at the same time",
+			    refname, extra_refname);
+	} else {
+		ret = 0;
 	}
 
-	/* No conflicts were found */
-	ret = 0;
-
 cleanup:
 	strbuf_release(&dirname);
 	return ret;
diff --git a/refs.c b/refs.c
index 1c2dd79..17a364a 100644
--- a/refs.c
+++ b/refs.c
@@ -994,6 +994,34 @@ enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 	return PEEL_PEELED;
 }
 
+const char *find_descendant_ref(const char *refname,
+				const struct string_list *extras,
+				const struct string_list *skip)
+{
+	int pos;
+	if (!extras)
+		return NULL;
+
+	/*
+	 * Check for entries in extras that start with "$refname/". We
+	 * do that by looking for the place where "$refname/" would be
+	 * inserted in extras. If there is an entry at that position
+	 * that starts with "$refname/" and is not in skip, then we
+	 * have a conflict.
+	 */
+	for (pos = string_list_find_insert_index(extras, refname, 0);
+	     pos < extras->nr; pos++) {
+		const char *extra_refname = extras->items[pos].string;
+
+		if (!starts_with(extra_refname, refname))
+			break;
+
+		if (!skip || !string_list_has_string(skip, extra_refname))
+			return extra_refname;
+	}
+	return NULL;
+}
+
 /* backend functions */
 int refs_initdb(struct strbuf *err, int shared)
 {
diff --git a/refs.h b/refs.h
index da29232..cf1780e 100644
--- a/refs.h
+++ b/refs.h
@@ -571,6 +571,10 @@ enum ref_type ref_type(const char *refname);
 
 int copy_reflog_msg(char *buf, const char *msg);
 
+const char *find_descendant_ref(const char *refname,
+				const struct string_list *extras,
+				const struct string_list *skip);
+
 int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err);
-- 
2.4.2.644.g97b850b-twtrsrc
