From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 15/44] commit.c: use ref transactions for updates
Date: Thu, 15 May 2014 16:15:12 -0700
Message-ID: <1400195741-22996-16-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:18:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4ul-0001Dk-Kd
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363AbaEOXRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:53 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:47219 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so390337iec.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sXrB3xXpGM+/GMGgicuQ44rWcWxI5GZKx5PvyRXx4Ow=;
        b=oDsS4C9S3j/p9Qji35c48Eq2X3CMPjVmGL77mlkcwD7BgPps/xnjt18Lrdv/Q8E28p
         OITZGFufc3DJ4UkL8DblfFb395HmnzGsY+U58nLioI4yv/Ln6yaje11YZxAJlIsIV/8d
         NRtsz2veeEBW+Db//lI731e6QVCThsu3ILjFxpmugpJa8GZbeNniQSrIjAgB1296gEBp
         NW+hcYhHs9m3sHIUFB9yy1S6IKZnZ24elfJeN0e7qGb2dwDD2bXLzhsxFQkgRbcFJeio
         FwYzWV0KPBSr7rS+CbrQJvvJOq3FOiJXei2qPOIA5/0p/J/fZbz//IwrRnUrn4anDIhK
         /ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sXrB3xXpGM+/GMGgicuQ44rWcWxI5GZKx5PvyRXx4Ow=;
        b=NabUy0B9vO8nrxZTuD0D+yeF7s09v7VPopjg1hskUXH5iQIQvStaQ5gNg+F+qZ6qyu
         LLu+S4bYnUGIg8esHBbm8gZSmi0NKkCDFrM9QjISHixNPEEAxLMwRPUUpcBLiB0rTT1j
         ad/XF9QRN93elPyQ30EVRjXhb6MNOehMGO/SaOBWr/KkI2Y8YfWgEiEHis/AHWSOPjJX
         kigcq7qNYLy2S+Srh5yLoNMb9f2RgqT9CC3q14bmk2Klm+W/VlaYsxp0zQ0jPQMRf5md
         382wsZ/skNsXZrjow8CRr+CvhTO8XLfiwbwz/H6kR4HFuAAzHpBF60B4YbFqTi5qyjLf
         FF9Q==
X-Gm-Message-State: ALoCoQmgMLO1wO+FlEXueoxGdn+EbOOPKvsJ7tZGnu78wDsblPXL1aJMHEAfwbDpuiQbmO6NJRpf
X-Received: by 10.42.206.77 with SMTP id ft13mr5716226icb.22.1400195745022;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si318881yhq.3.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D80B131C31F;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B2448E0764; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249266>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d28505a..c429216 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1581,11 +1581,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1707,16 +1708,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1725,9 +1716,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin();
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
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
-- 
2.0.0.rc3.477.gffe78a2
