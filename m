From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 14/30] sequencer.c: use ref transactions for all ref updates
Date: Tue, 29 Apr 2014 15:18:59 -0700
Message-ID: <1398809955-32008-15-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGOD-0002pg-8Q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965337AbaD2WUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:32 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:42912 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965276AbaD2WTY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:24 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so159811pab.5
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jrHPmH2kGVVHNXuGQL6tjHahDE17XKh6l3r+SHEQgqw=;
        b=EMLDbY7gWiZ5v2M+UaMmx+LPkXgqdYe9xdmsRFFI/V+2//67c6/9BheKqmMHVaXEW+
         ingzwRbk9gYpbFZwJCPCoFBsDscwt7GOpWm754ilv27gwvMheDlXRd3RTeAL7fCuyA1i
         rZa9pTpgQN5FS5OGGK6VUOO6KQkZyXfpqD80ye4re8ZCGYFC+iNQLc6EfjnwQNTscdx2
         960dkbcLwkKBxmqiYdEi1fJO5tMeJ2e58B+gE6MSa+VRlm4uCA0i15smunF/yLGrKDFe
         fAMWCBUnl5KRsAWj+D5GIi+diUmdS2eqQv7+//EX8YAo1ArTd8i+bmm3BW33hKVrW7A7
         sKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jrHPmH2kGVVHNXuGQL6tjHahDE17XKh6l3r+SHEQgqw=;
        b=mQ1fIZ+jdPn+B577KhePZlu/6UT2ls5WZIw5jClDSQdH4ugCNLWH/tJXJeVQVJHnR8
         ziTnbQ6tx35/UaBZ6WqoVAVB7lSDwSZjiojY4iK02w5eSIgFJIzaiIXfjb7zyZt6DZWi
         UybgO+eCDj8XMWi7UmXq+vuDeUCrHBzSBeQzQDn/f2JI8SGQJxlmoac+ZY80Lp4CYZTs
         sG6q4JE/Oaa4xac5SUlg/0PF2h3xoqF2u4RLfkJAcs19ezLQGu7LeeWWAzSAgAZlXser
         iyM6coC5iv22Uw3tNHCvk/a9ef8Z+OQZXn/izNaaPyE6SYLqXOiADkP+yoDP4NGAGkrl
         bsiw==
X-Gm-Message-State: ALoCoQnrkUBXXPBRwzex92XHdBzY+6RectcwFp0f4DxaDgldCrH8OZlOzBvDvi3ZnWC87NjWjMizfKH7OBsZVi0Pv2H9EoJrOnHdSucCn5v/R+k7bwK/b8BY75XWa9a5QVMviBHtR2BfEO/FWVMx48vQg9AZz4/i4TYoYXoizYmxW6+21kMXRSgTyRyV/mPCuoiyu0eT+bsA
X-Received: by 10.66.137.105 with SMTP id qh9mr380699pab.30.1398809963633;
        Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si2739372yhk.4.2014.04.29.15.19.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6391F5A4121;
	Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 13758E0A5B; Tue, 29 Apr 2014 15:19:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247641>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bde5f04..9282a12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,19 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
+
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin();
+	if ((!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn)) ||
+	    (ref_transaction_commit(transaction, sb.buf, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
+
 	strbuf_release(&sb);
-	return ret;
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
1.9.1.532.gf8485a6
