From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 26/48] commit.c: use ref transactions for updates
Date: Thu, 19 Jun 2014 08:53:08 -0700
Message-ID: <1403193210-6028-27-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxegl-00005d-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933516AbaFSPzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:40 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:44042 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so693198ieb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NaCN8NEYUClIhtrcWJtzARZ5vcFG5o40IHLD8J1afFs=;
        b=fmI2loXJ+MBqnMXnsM30fUiHlkM+SndxTRUz1zoBOOJ2eFI200aIU/WnbTwLRk6bvU
         vxj7tjPgOuhrs7gpehvgSBlW/dkQc3C9lUHWWPRCKCWTauiAoLoXJ50V9SAoVW3TOmLs
         FzpDbUXwkHD2NTJHW1se9rsd858CsK+PbsFKl4KmhDqKglpoipQvsZlRigTpC+Wacvh+
         b5SZTe/PIgmfYedbMR+MZyVfhPj1oaI2P/TkMt63X6zPYtpnLhoBNuZHLpp9tNWW7YsY
         Wv9aiVm+Kp35+czro280pYIYh/wqBywda5/HGNg6SI+NipjvOECWUuXhardg+zb9ev53
         vNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NaCN8NEYUClIhtrcWJtzARZ5vcFG5o40IHLD8J1afFs=;
        b=miU8vppqyWEdRYfy71HcaO0K5oduAfAkBCItyAC5zjdkEWLvd5PLXVADVyDuR+zU/9
         voJLNmTEFVrtrPEekOI/87B3oTTY/mOWnLL+OiuV0c/W1e9oM0iYPudsX3Q/bRfBtEyA
         HdtOvy7HPi61X6oU5p5bvnUbgDQu0mAgOCcfhisCG2HQpOFjyzE0ZxMcXUOeqZqxzkVk
         FecgSVdJEc3D5YXG0IZ/pNWrxM7lGRtlH0nQ3a+5EUpvvWIUAm96SGhyN6INCcJP/9YN
         VVNBF61s9inXcnMQy35nlwgYAJETu08xRO7YRWXJNgf1QcZBGORO2oSENKDRO+eVSr5g
         vwqQ==
X-Gm-Message-State: ALoCoQnQw2dU8IxQnK4LLR1Pm+frFZezrRjUM2IjklvjLP9yG3VLHGLLKnXrKCWzceK1709pBndk
X-Received: by 10.182.104.74 with SMTP id gc10mr2743595obb.40.1403193213763;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si187565yhh.5.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9BC655A42EE;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 768D0E0B50; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252143>

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
2.0.0.438.g337c581
