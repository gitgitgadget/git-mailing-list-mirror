From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/11] commit.c: use ref transactions for updates
Date: Thu, 17 Apr 2014 12:46:23 -0700
Message-ID: <1397763987-4453-8-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:47:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasH9-000402-H3
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbaDQTrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:47:05 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:37264 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbaDQTqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:39 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so175574iec.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qs0AeiVEdhZnZhorl2thmb0Jy0MR4tlju4DVoWsRq1U=;
        b=ULD9eVZ2GKKCnI0ox6LN37xBjX1wtzGmQrcZ8+X7tcN1C+ZyvtKEyehKjVGLDBfii3
         vWrG3lOaR6tOR1hA8HONfVBEgNmg80v07doDDPAhyl6r2e2okgtJqG7Pe9W7P/TnYG/B
         rZa7yiu7ab3gmCYqxSbul5J4Hm2G/BiiGw4hYE97qonPYOfXbJdRe/b9WLOz9Ye/b6Bq
         O8vK8wxjBn6Zoi6rz+axoAfP8FmcZHX0POtyxU14QCU5pGf4MVZaRX85a6btkXxv770i
         iKmPFFAhtkP5gNjRpos3fwxr/2k9tV79TvzOuukFhMf086rbTOtKa/mGICSj93vdlN5l
         QHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qs0AeiVEdhZnZhorl2thmb0Jy0MR4tlju4DVoWsRq1U=;
        b=PBg8XDbd5YLX2xBneo39mzh5MYVVbHtLdPZzmMwIuatfXw7zwXT9iA3CHDU7+hSz3o
         Thu5uohKcy68zrjIgw1uHpktXMNX1xbNWalxn5SSBN2sVQrw39nIKGRk9ak2yv+GlvfT
         AKm2ox1PVh0aA+xzbWyT1BFysQFLkg6Aqzt0xfNtwcSWg3Sb2BU0rrfF1SHIEcDfUDLB
         cfDfPCcj7XSGRGE79UwbWPL7EibvhJMFCcFJX/K8O9of30NDUTr5pmf8HiTd5kibSTla
         IGcwWRGrbzhOEq1WO3etN23UV6GkuM6hOaeCzhYNmlErCXS+2N7GjpA74C4efEdA1hXj
         D0Xw==
X-Gm-Message-State: ALoCoQkXw8jn34FbBf3LKFBLWtbwo1oBlWXh/qDbi6H9v6YUq8rTB/uOXd2WXw/pe1QQEKpnrNMyJ76Vwmqth2xC7N0s7o2EaJWAyEvP5ug2HGNsP4arxB6fsOgeEkjsyETWkMFLlLFM0WzGtottJNthA9GZt/Ppm7WcqqGuqfMhezJcm898aV5wgl7SFYx8lDwYGwpm3Y0U
X-Received: by 10.182.5.42 with SMTP id p10mr8297348obp.37.1397763998744;
        Thu, 17 Apr 2014 12:46:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id s65si3654771yhc.2.2014.04.17.12.46.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8EEEE31C20C;
	Thu, 17 Apr 2014 12:46:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5393AE06A3; Thu, 17 Apr 2014 12:46:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246443>

Change commit.c to use ref transactions for all ref updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/commit.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..b8e4389 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1541,11 +1541,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct ref_transaction *transaction;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1667,12 +1667,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	ref_lock = lock_any_ref_for_update("HEAD",
-					   !current_head
-					   ? NULL
-					   : current_head->object.sha1,
-					   0, NULL);
-
 	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
@@ -1681,14 +1675,22 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (!ref_lock) {
+	transaction = ref_transaction_begin();
+	if (!transaction) {
 		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
+		die(_("HEAD: cannot start transaction"));
 	}
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	if (ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head->object.sha1,
+				   0, !!current_head)) {
 		rollback_index_files();
 		die(_("cannot update HEAD ref"));
 	}
+	if (ref_transaction_commit(transaction, sb.buf,
+				   UPDATE_REFS_QUIET_ON_ERR)) {
+		rollback_index_files();
+		die(_("cannot commit HEAD ref"));
+	}
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
-- 
1.9.1.513.gd486896
