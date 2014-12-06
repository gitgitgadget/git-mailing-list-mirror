From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/8] refs.c: add transaction function to delete the reflog
Date: Fri,  5 Dec 2014 18:46:32 -0800
Message-ID: <1417833995-25687-6-git-send-email-sbeller@google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 03:47:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5Oc-0004pu-Rl
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaLFCqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:46:49 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:47215 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbaLFCqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:46:45 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so297942iga.14
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YWhCRIQEzmUkdhhyFCRdf381ZYPUI4H1d6M6oHeI6ck=;
        b=R4waCufgzM9B4XbTPVr0hIcGNl4s/Noqv9sMVl/Uluydxi4mZg+Yf91zSl6f2fypUh
         QgFjEWbgdoVTqow1GYiRXQvJ6OW23AaGK66xjnHL3Rbg4IYiEEUdLW7dMtGcK/zuOayg
         YCZu4j3uLfdY9YNYc8rtj7lGlW5oN9VCXFeIuO21PhwbZBkTg8+k//qjm2/Fsx2SOeQs
         p7r3C/1PQCb88mXhZ86saJzB6qn8V4QNZKjI2+agHTIiN7w5b85kaSmYpzKCuKH7+ryg
         rOVOmmedRixgq0yZh7KePMhU/bSYYWJv5jduCW7f+44UBgdfaLibf0JB9v83LTQ4nMy5
         si+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YWhCRIQEzmUkdhhyFCRdf381ZYPUI4H1d6M6oHeI6ck=;
        b=b7gq1W7h04SyXn/urDMH9YTkKDzaUnyRxnkaYbRik9ZDKzJoxlbtKF19qc45H8oeQi
         +MMnMmgT1GXoGbBTHNUbyP1PzFJF7sFbadHTpRdqcCIj3YLe4CvI7OIzt5VSQi6K4w60
         TwtxWSEaXxH2+1JqBPuyvw9i0Iekc2OnMeIQq5pzCUN+7p7kiuUa+Q6o+p7KtSzpTv65
         TmmzMvn43PShx/4JLEeWw8c1bK2iSiTEYmLsjWU8KK08BJxnqBqYbmOihMxQbFbTWJLw
         zjksqPXLxgLi0SUhW9a80A6w+iWV3r2+5SvLkDE61HxfZSam2WRdxzSWx4VPSlKDRx/O
         v+Cg==
X-Gm-Message-State: ALoCoQmgaUbyoH1QYxxnEuvwUA0okM3z/Tk9y13TMETDeaeyuZIw1QTzyCSFOJ0ZmWsngW3tfQeO
X-Received: by 10.107.8.102 with SMTP id 99mr1521534ioi.83.1417834004739;
        Fri, 05 Dec 2014 18:46:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id j2sm158903igj.14.2014.12.05.18.46.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:46:44 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260929>

This continues the work of the previous patch as reflogs not
only grow, but also need a cut sometimes. This patch introduces
transaction_delete_reflog as part of the transaction API to
delete the reflog.

This function serves two purposes. It can be used to actually
delete the reflog as the name indicates. The other purpose is
truncation of the reflog and rewriting it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index d767418..57f4941 100644
--- a/refs.c
+++ b/refs.c
@@ -3649,6 +3649,56 @@ int transaction_update_ref(struct transaction *transaction,
 }
 
 /*
+ * Delete the reflog for the given refname.
+ *
+ */
+static int transaction_delete_reflog(struct transaction *transaction,
+				       const char *refname,
+				       struct strbuf *err)
+{
+	struct lock_file *lock;
+	struct string_list_item *item;
+
+	if (transaction->state != TRANSACTION_OPEN)
+		die("BUG: delete_reflog called for transaction that is not open");
+
+	item = string_list_insert(&transaction->reflog_updates, refname);
+
+	if (!item->util) {
+		char *path = git_path("logs/locks/%s", refname);
+		lock = xcalloc(1, sizeof(struct lock_file));
+		item->util = lock;
+		if (safe_create_leading_directories(path)) {
+			strbuf_addf(err, "could not create leading directories of '%s': %s",
+				    path, strerror(errno));
+			goto failure;
+		}
+
+		if (hold_lock_file_for_update(lock, path, 0) < 0) {
+			unable_to_lock_message(path, errno, err);
+			goto failure;
+		}
+		/* The empty file indicates transaction_commit to
+		 * delete the reflog */
+		return 0;
+	}
+
+	/* The transaction already writes to this reflog.  Clear it. */
+	lock = item->util;
+	if (lseek(lock->fd, 0, SEEK_SET) < 0 ||
+	    ftruncate(lock->fd, 0)) {
+		strbuf_addf(err, "cannot truncate reflog '%s': %s",
+			    refname, strerror(errno));
+		goto failure;
+	}
+	return 0;
+
+failure:
+	transaction->state = TRANSACTION_CLOSED;
+	return -1;
+}
+
+/*
  * Append a reflog entry for refname.
  */
 static int transaction_update_reflog(struct transaction *transaction,
@@ -3885,7 +3935,17 @@ int transaction_commit(struct transaction *transaction,
 	/* Commit all reflog updates*/
 	for_each_string_list_item(item, &transaction->reflog_updates) {
 		struct lock_file *lock = item->util;
-		commit_lock_file_to(lock, git_path("logs/%s", item->string));
+
+		/* If the lock file is empty we want to delete the reflog*/
+		off_t filepos = lseek(lock->fd, 0, SEEK_END);
+		if (filepos < 0) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto cleanup;
+		}
+		if (filepos)
+			commit_lock_file_to(lock, git_path("logs/%s", item->string));
+		else
+			remove_path(git_path("logs/%s", item->string));
 	}
 
 	clear_loose_ref_cache(&ref_cache);
-- 
2.2.0
