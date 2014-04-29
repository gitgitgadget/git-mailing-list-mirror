From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 05/30] update-ref.c: log transaction error from the update_ref
Date: Tue, 29 Apr 2014 15:18:50 -0700
Message-ID: <1398809955-32008-6-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGP9-0003nO-9x
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984AbaD2WV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:21:29 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:47274 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965263AbaD2WTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:20 -0400
Received: by mail-oa0-f73.google.com with SMTP id i4so72057oah.0
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KvuTF8+LI2NMgnwea2BS2NTOriW+4dNnThYUZocK24w=;
        b=S24dlO0UKaWapPQlbFVdFP8bPi1RO5nRd6d0UfeXvi8qwn7IO2Gl4oS2X2xbZjfuGr
         gIIcCfEu9v5HL2qWoQHbRizNRxrMgeA9MY4xTihtfCIAuDPldC7AoW1lmVj8Ah3afiwT
         4x/eulUt9VAOZzYfL42lf0Aa+CL47mY4xk7Nh+OsIEQ1L80gmngJ0mLcG1BjqWY6/gTj
         +sSUWvCaaOPo/52ElbR4UHfVO34qenJ/nIuS5+wH9CD0B0O023QXBH4NRmUOCtCukUIr
         +sMD+6VHuEVUI3puWuF3WGyD/k6O/lA/O8mDvFByVQ4OCq9eEH6Pe3mVYiNDQe/srgnY
         mPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KvuTF8+LI2NMgnwea2BS2NTOriW+4dNnThYUZocK24w=;
        b=QS+bsfLiaF/bwYI79JACs0bxOKgG6+/+KNQ3mvKPLm4sf8dIlQ6EA2/oggU60sySae
         sSaCx3m414M/2iVn0Ay3r6V7DkkRr0TA5hhSc/1WOmZnG5MuD+81klZLsgti1DStZAsh
         84zX341I9xYL5Fw4e+i7lzn309W/7A0IVBdy07LeFHCKQptLwQTamPF904r1hHywIuZ0
         FlMfnfvbOzzb4dX0/L4fFVucgjFVs3MRzNKn/nzh63J3XxwRCjFuRcRJPlGJGp8+5jPo
         xxddErzVxIPfrG9xUew3N1tXJmGZhds5WexlQg+hhYUwTWcbmsFFWlW3iKpbLQwthTsK
         zNWQ==
X-Gm-Message-State: ALoCoQm3GeuqshwqlxMMeXXZj9W0dooBYyKAZR0Hy5knT86Lv1y1k1PAv4IQEAt7iXAjMOoBfgnTWOKnJAVJV8uOUxIaWFTcx3NPJqN/5wa8/TcP0mQxWwPePzQmclvSwrCkzj+kGZr4GUDgmqA1EzdNPYN4rNVPFqrxmAFZQHyH8K8ECpFXIYQ7rOBVU1qGNaBehvbrZ+um
X-Received: by 10.42.107.146 with SMTP id d18mr289577icp.8.1398809959624;
        Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si2739666yhe.3.2014.04.29.15.19.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6DF1C31C1D2;
	Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 50439E0A5B; Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247650>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aaa06aa..207e24d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,17 +360,16 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
-		return ret;
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
+		return 0;
 	}
 
 	if (end_null)
-- 
1.9.1.532.gf8485a6
