From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 27/48] commit.c: use ref transactions for updates
Date: Mon, 16 Jun 2014 11:03:58 -0700
Message-ID: <1402941859-29354-28-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbHr-0004We-8h
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbaFPSFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:33 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:39397 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so868428veb.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DSl5drzYcrJTl1vqt7fEyjJSNUg1IGsYTLSvnOBLyX0=;
        b=JMz4/LIwFvOH32qNi9h/p9dsFMa3AoolqZ+5Icvdu1biglfstHs3XuVwXnM/dGQPwe
         gq2MycwRXs/O86OxxvDeH5tdaW2QZ3GHdGIV18R737H1tJubckOHuywwHU6LbV3NL7P/
         GH+rI+I/zNjnEHJ8ywEwDZ0qXTzp+P1CZebbS5cMwd518ZHL62ykCMxAw61uAZz+91gK
         TOBp7HIZg/ISuMjCHjdItQ7oFzKEb2U5fXKslg/ss/GOtmNA9JBic24Tjo53h1sEDv6a
         Se/JR1f5XHW0Z4oNx/n5uKuBxFPshnPIFltFVrszKjkuI0bGpIpBJxW1orC+qjf30lmj
         9OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DSl5drzYcrJTl1vqt7fEyjJSNUg1IGsYTLSvnOBLyX0=;
        b=LPeDEcx3Oy5sZ3XqFBRPVmYLmxbj+wG8m7RcpqSDEhEKhrhNLUFUHfERX4faAj+GxN
         FOdMMOB6dsSNtx3Z5zxJWE1Bfz8xr/Zvo07otRfavA2NKe120M0qBWjhN++5OaMjaEXO
         4djs+lKWdTczHwY5lP1wu7dRfxtyxUTfZ80XDsnB5P3kJ4metkMrYBCg7gSVJzC7KM7m
         nzG2CyIegbmUJF+m4DzMq4sr++ybFJGnwBWrqor77yfNt+aw7PHvZaA0nqJc8ZUeCjgg
         UhF+FJ/wpXGQP5tTEGS+HF3NZdD3yl4d80svoQQyhBX/K78bRMUZ5z/65wQ6efxdivzw
         cK2w==
X-Gm-Message-State: ALoCoQnccMEV/TK7dhp24Q1X4X1MqBKI5cBKXF8LHQwMiob5F+p5/1k/Owql/yat5YD5YtEZuNVl
X-Received: by 10.236.197.226 with SMTP id t62mr1705065yhn.50.1402941863302;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si997796yhb.3.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 26B5831C8AC;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 036F1E0AF7; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251751>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 99c2044..14cd9f4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1613,11 +1613,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1739,16 +1740,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	ref_lock = lock_any_ref_for_update("HEAD",
-					   !current_head
-					   ? NULL
-					   : current_head->object.sha1,
-					   0, NULL);
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
-
 	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
@@ -1757,10 +1748,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head ?
+				   current_head->object.sha1 : NULL,
+				   0, !!current_head, &err) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		rollback_index_files();
-		die(_("cannot update HEAD ref"));
+		die("%s", err.buf);
 	}
+	ref_transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
-- 
2.0.0.282.g3799eda.dirty
