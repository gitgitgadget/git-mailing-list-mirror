From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 27/48] commit.c: use ref transactions for updates
Date: Tue, 17 Jun 2014 08:53:41 -0700
Message-ID: <1403020442-31049-28-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvjw-0005ko-5l
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbaFQPzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:55:55 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:52667 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-ve0-f202.google.com with SMTP id oy12so672867veb.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EhAG9m3MiCapwIbXcYiW6EYZKOPxp/gPyaYHfCBuqOo=;
        b=mmlc/sr126C1JrenYhVEgrXC4Lp8Wze6A5TJ+Ol7BgvT4t0zaH+nLOe1LhlJFZfHF/
         dUeoBOZ4UAeH7rY+T3h36fMgGsRqaQmJYJN/+i9vZ2dBiOzeZHFPtJb6MBupoS5bGq2w
         jLcakFlDa1Lj1pyhYVEQCL3Eusz90IpqWVrTBCGU8KKpPPsMFHXdYsQnoX+VIy5eBGsQ
         rYruMh0D7rbtgEVWETj175jwpQclEIoNkL9hpfnxk5KuRWCkj8aXou6RtOEaF99E9Lpn
         urccHYBk6ResBNyhpINAqEX4NRByLn6J+XWNzZ8vSLW94NAlq8QaL8DvmO+vkWbk9SLG
         Tk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EhAG9m3MiCapwIbXcYiW6EYZKOPxp/gPyaYHfCBuqOo=;
        b=JmygCM7aQbdecIJMyek7dm00wRAXUmQ7FbvVHKzuEMvDqun9+ut1kvOxXiyKILziXo
         pcMW9nSXovrCE4pAi29NpDhlkED8HOmaNSPkbF3625ge6zDVg2VJEPfmUO+pbPooETWm
         ZSDKLvmavteH9Vj1kVkDtlVbSwjM+QvJwaRq99ANt5EwNkJJX9ItOzQCSnBdRrwA84EO
         qzi3ishpBptiyRIK6fDyryxcnT+/3szIT0ipM/FkhLRFW8vOXth/3DVEJUja3/ANl8Wz
         jAMC6OuY9Lzcd4y9ojxUTGrHj6A6wVahRtOgsb/XGaDcdpdgUWWOUvrnXJlFI3+atxvO
         8BGg==
X-Gm-Message-State: ALoCoQmZT+/54tH4R7zBVczh8B0tvjmsur6WZRB297oSrtRR9IrzA0GPprrzEiY43nwr1L8C8Kk8
X-Received: by 10.52.175.3 with SMTP id bw3mr446662vdc.5.1403020445198;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si1209156yhb.3.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0F02031C76C;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DF3CBE1129; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251895>

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5e2221c..668fa6a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1627,11 +1627,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1753,16 +1754,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
@@ -1771,10 +1762,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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
2.0.0.438.gec92e5c
