From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 27/48] commit.c: use ref transactions for updates
Date: Tue, 10 Jun 2014 15:29:15 -0700
Message-ID: <1402439376-25839-28-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:40:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYK-0004jq-D4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbaFJW3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:29:53 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:34980 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so7008igb.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XOjQZc3zje0mWfPeqtnsF6e60Pjs1SGtrUulZJMewMI=;
        b=dP1GiJCRZ8DAZlLJblXNTmHVJp+gCpuFw1vJBNsh+v9mUm0EhfF36yHSoUJmSQzBmC
         hT78v3os/HICBGTFq8Z5aJc3YVtvJjKzI+35M4SMs4VlEhCWticG91C3aRMbSoAIUdp9
         +jvOMlHK8d+KFxPEjzUEN8hdrcjwyX2fnlocq8NAQRY6v5B8Xha2Cot2zvbSCX++XHsS
         yZSe0DJxuAL/GIYIvERFS9BBYFOBGVCIdhWQWIEI211b4e5W4lzylAQuY/TZyqZPu5r2
         spFFqdbDTDUN1zgf5DBHxBGRxQZY6m7Fzc7NZ33aqeQmC9bfcXsfNfYn+0V3ZlYmF9wd
         cO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XOjQZc3zje0mWfPeqtnsF6e60Pjs1SGtrUulZJMewMI=;
        b=J25pqUIhFUNcTYiNWGT6dmSg/QiL6viacO+Eh4BWk3pgtIm58oUqasKED9wgzzOOpx
         v/5hrX6IFHrfthVR36uK7O0LnvAbfwqMPdPgv8lCFG3KBfKwqL5o+pv6z+OfpOvKNEyJ
         IKv87C8H0N9U/G5bi4nd4KWjnhCatQ6FOZAC0TSu5WFIYkmiHPp3z8jhnfIneuS2HdgB
         Is/ASGzMcudJ7z2NpuK5sQaIWeKmKmHL8sf9VwartqCJqD9X8kAfhosL4Y36B1+12SpW
         QjoYcnbBdFrT7PyxjKqD5P8ugR9O5JoUaxoYQROJ3/DBuhtw5nPqrhsALVoqN6izd/Ea
         WvtA==
X-Gm-Message-State: ALoCoQkaMEDrhm5ej9+PxoIsTaCAfqF0oo+EIVFd1KKmjX01zJpQ8JPNk4aVX/eI+M5EAe7tF4Bs
X-Received: by 10.182.27.40 with SMTP id q8mr4464619obg.22.1402439381152;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si1395562yhj.5.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 04FCC31C741;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D628FE0CCA; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251312>

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
2.0.0.574.g30c2c5e
