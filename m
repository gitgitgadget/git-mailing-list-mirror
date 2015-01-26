From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: clean up write_ref_sha1 returns
Date: Mon, 26 Jan 2015 13:10:38 -0800
Message-ID: <1422306638-23785-1-git-send-email-sbeller@google.com>
References: <CAGZ79kbQiVQJyZC8mKaSUnOpY6YJc0TYdX=msuZDXLd7DxmTmQ@mail.gmail.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, mhagger@alum.mit.edu, peff@peff.net,
	git@vger.kernel.org, loic@dachary.org
X-From: git-owner@vger.kernel.org Mon Jan 26 22:10:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFqvo-0004OS-3F
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 22:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbbAZVKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 16:10:44 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:48277 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbbAZVKm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 16:10:42 -0500
Received: by mail-ig0-f175.google.com with SMTP id hn18so660010igb.2
        for <git@vger.kernel.org>; Mon, 26 Jan 2015 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yMppZt/jvfAusSEA1VgO7rPjko+9DMaHJOdKYgeGg34=;
        b=XS/iRBvo26vHPsMFaF+IE50V/c6SMRDPlXeYyY2FMO9wisw0HM+z0gUHnAawB4XPNY
         bN8lisC803kuypyfDYkp4uA4BZwHn6ZZdlKN7ShnudR9wDHtmL+fGrLkbE/rBFEnmeHb
         9KcJyCjPK6g4tTZf8EpGCOZUbZ9Pf5dJycGoFR/SP8pTUKsZdPLcgBomWnH7FhfFApTZ
         pCmd0GeiN+bncjw99fIPExGM8wlmrubMG0K24RrWwHb5PnVF+9FpF43Bm0F7qXI3yNe0
         fTqWv9GqqwgS4/v19sNCjDPrxmf8KQ8OVLpVgd1yzRE1X9IAsHhYjVRmOkI6w+fa1HAh
         eSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yMppZt/jvfAusSEA1VgO7rPjko+9DMaHJOdKYgeGg34=;
        b=j4P+93MrzGuvwzP0o4AYIOVgN3AI7GHIVD4zbCy6mj1jExqb9sK+jQue4kTT4WuWxZ
         HFrkJK5Lw8O8yOT8HRJpJ6Z2HXQ/pCewXQUuXIxJL7ds3ToG3ih273tBWRmna3hsy7si
         MlKxWp24UpVf7buDTfiPFqP6Sid1iorZ3IlMFsl5Lb3GwBo4UvpIx8ehK9TkmAhgaiHB
         HnhXdArrrEE/00msmdaFxminsK7CVN/HaczkAM3FbNTMVFy5wUCDRRlvO3+5g1/zcCfa
         Yr0FkJrZv0Nsnm92f0xLYj3ZrawyG/hM+4zgEJBCm016pXesQEJUJA/Rs08CkKj2Vugv
         MzqQ==
X-Gm-Message-State: ALoCoQlPTnxfoIm525jkf8YPQ+ps4uKLi693+JWED/6mFc6L9BT9p7Yn/Y2enmdF4zWdi83IgXMq
X-Received: by 10.107.16.2 with SMTP id y2mr19651340ioi.39.1422306642180;
        Mon, 26 Jan 2015 13:10:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:ec7c:36fa:6ef4:bb62])
        by mx.google.com with ESMTPSA id n4sm6400832igr.15.2015.01.26.13.10.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 26 Jan 2015 13:10:41 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <CAGZ79kbQiVQJyZC8mKaSUnOpY6YJc0TYdX=msuZDXLd7DxmTmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263046>

write_ref_sha1 now either returns 0 for a successful write or !=0 if an
error occurred. This cleanup results in cleaning the code at other places
as well where we had to set force_write to make the write_ref_sha1(...)
|| commit_ref(...) combination work. Also the checks for the optimisation
of old and new sha1 values being the same has been moved to a helper
function so that check is not part of write_ref_sha1 or commit_ref any
more.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v1:
    
    applies on top of origin/sb/atomic-push-fix (79370dd9656)
    
    This undoes some of the changes of previous patches
    such as removing the check if old and new sha1 are equal
    and not being forced to rewrite the value.
    
    Junio, I think this patch adresses the concerns you raised.
    I can redo the atomic-push-fix series with this cleanup merged
    into the appropriate patches or you could just queue it on top 
    of said series.

 refs.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 2594b23..c8fd4a4 100644
--- a/refs.c
+++ b/refs.c
@@ -2817,9 +2817,6 @@ static int close_ref(struct ref_lock *lock)
 
 static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
 {
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
-		return 0;
-
 	if (commit_lock_file(lock->lk))
 		return -1;
 	return 0;
@@ -2880,7 +2877,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
 	}
-	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
 	if (write_ref_sha1(lock, orig_sha1, logmsg)
 	    || commit_ref(lock, orig_sha1)) {
@@ -2899,7 +2895,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollbacklog;
 	}
 
-	lock->force_write = 1;
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_sha1(lock, orig_sha1, NULL)
@@ -3062,12 +3057,22 @@ int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
+static int should_write_ref_sha1(struct ref_lock *lock,
+				 const unsigned char *new_sha1)
+{
+	/* If the old and new sha1 are equal only write if forced to. */
+	if (!lock->force_write && !hashcmp(lock->old_sha1, new_sha1))
+		return 0;
+	/* null sha indicates deletion, so don't write it */
+	return !is_null_sha1(new_sha1);
+}
+
 /*
  * Write sha1 into the ref specified by the lock. Make sure that errno
  * is sane on error.
  */
-static int write_ref_sha1(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
+static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
+			  const char *logmsg)
 {
 	static char term = '\n';
 	struct object *o;
@@ -3076,8 +3081,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
-		return 0;
 
 	o = parse_object(sha1);
 	if (!o) {
@@ -3752,7 +3755,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
-		if (!is_null_sha1(update->new_sha1)) {
+		if (should_write_ref_sha1(update->lock, update->new_sha1)) {
 			if (write_ref_sha1(update->lock, update->new_sha1,
 					   update->msg)) {
 				strbuf_addf(err, "Cannot write to the ref lock '%s'.",
@@ -3769,7 +3772,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (!is_null_sha1(update->new_sha1)) {
+		if (should_write_ref_sha1(update->lock, update->new_sha1)) {
 			if (commit_ref(update->lock, update->new_sha1)) {
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
@@ -3785,7 +3788,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->lock) {
+		if (is_null_sha1(update->new_sha1)) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
-- 
2.2.1.62.g3f15098
