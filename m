From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: get rid of force_write flag
Date: Tue, 10 Feb 2015 15:12:31 -0800
Message-ID: <1423609951-8301-1-git-send-email-sbeller@google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	pclouds@gmail.com, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Feb 11 00:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLJyy-0004Iv-D4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 00:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbbBJXMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 18:12:36 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:44883 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbbBJXMf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 18:12:35 -0500
Received: by iecar1 with SMTP id ar1so38258iec.11
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 15:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fyGkHFwfvzrTo3etSLLHMvdZz/RCFhTjpH2y9fBnRYo=;
        b=CIe7xWDclTzeie1ruDaojACZzRDjwOv3CjlH7eCV29ttkU39LWs6D1etm3S87raPhq
         aSy4qOwZYIyofn3oYvwa2xTcdizqE55S0ATNpYgynOwnlKq0O03x9lzcCeMien6ZEPmm
         SLsLUeB8cFxHuCmfa/l9R3ZBUQRgFsykrdFFOR/23pDqckcKXJj12GplSj0hBpR3TQef
         8DOlpBhX/wt3hAV2zZz+coqKTLCErlkWFq0s6v+oHZCY/ZSkZXlEfdlgnSYkkxnEqNF+
         sx0H9xYRM4UesXVVKAflSbO6LfqPX+RIHhFcKprwDOxhzzsrlPbRRnk1PdET1OJbTiCh
         1mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fyGkHFwfvzrTo3etSLLHMvdZz/RCFhTjpH2y9fBnRYo=;
        b=Ocb8weCmTRpFo5TFm27F6kdIM9TZwgdwdgahl3OLhF//Z06rWDFTTEfT9exvBqv2y7
         1s+yp1GKufeREoe8MFXzXVFjUP89ndtxaIei1/8F8KvzeqGUSyhnoAJJI2664yJ5f5+W
         I4AhL9CCEJDuWzZxX+i7F1nv0UnpPapCmuR6HnYUKtT2V3vtYxiIys2w8sa2N6ok6EgE
         F/jPD9US1p7bvZpARADwz2WUThFLOxZQPMXhdwFOUyq6d884FXU/n6JFdiPpjwxWJWtZ
         phDQ5aLVKcFaEYFD3hSSAF8Sr8aX1nuis+9mnNAui/RHdwSR0MOTW9w7NOhN81CR0c6Y
         yeZg==
X-Gm-Message-State: ALoCoQkBWA83Yi1GRMTZC/bMAWd6vaQSaJpmJGxsVO1VXQBeh076bd/SZ2MHW0OfjRsiV2bd+fr9
X-Received: by 10.50.43.201 with SMTP id y9mr253571igl.6.1423609954498;
        Tue, 10 Feb 2015 15:12:34 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b140:96b2:4fcd:bd2b])
        by mx.google.com with ESMTPSA id 199sm9531995ioe.14.2015.02.10.15.12.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Feb 2015 15:12:34 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263658>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    When this patch series is applied, you only have 3 occurences of force_write.
    
    1. In the struct as an undocumented int.
    2. In  lock_ref_sha1_basic:
    	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
    		lock->force_write = 1;
    3: In ref_transaction_commit:
    	/* Perform updates first so live commits remain referenced */
    	for (i = 0; i < n; i++) {
    		struct ref_update *update = updates[i];
    
    		if (!is_null_sha1(update->new_sha1)) {
    			if (!update->lock->force_write &&
    			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
    				unlock_ref(update->lock);
    				update->lock = NULL;
    			} else if (write_ref_sha1(update->lock, update->new_sha1,
    						  update->msg)) {
    				update->lock = NULL; /* freed by write_ref_sha1 */
    				strbuf_addf(err, "Cannot update the ref '%s'.",
    					    update->refname);
    				ret = TRANSACTION_GENERIC_ERROR;
    				goto cleanup;
    			} else {
    				/* freed by write_ref_sha1(): */
    				update->lock = NULL;
    			}
    		}
    	}
    
    So maybe we can solve it even more elegant by omiting the first 2 occurences and
    directly check the type and flags in ref_transaction_commit.
    
    Maybe this makes sense to go on top of that series?
    
    Thanks,
    Stefan

 refs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 3fcf342..ae24502 100644
--- a/refs.c
+++ b/refs.c
@@ -12,7 +12,6 @@ struct ref_lock {
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
 	int lock_fd;
-	int force_write;
 };
 
 /*
@@ -2319,8 +2318,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock->ref_name = xstrdup(refname);
 	lock->orig_ref_name = xstrdup(orig_refname);
 	ref_file = git_path("%s", refname);
-	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
-		lock->force_write = 1;
 
  retry:
 	switch (safe_create_leading_directories(ref_file)) {
@@ -3788,8 +3785,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			if (!update->lock->force_write &&
-			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
+			/* Ignore symbolic links when told not to dereference */
+			if (!((update->type & REF_ISSYMREF)
+			      && (update->flags & REF_NODEREF))
+			    && !hashcmp(update->lock->old_sha1, update->new_sha1)) {
 				unlock_ref(update->lock);
 				update->lock = NULL;
 			} else if (write_ref_sha1(update->lock, update->new_sha1,
-- 
2.2.1.62.g3f15098
