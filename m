From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 17/27] refs.c: change update_ref to use a transaction
Date: Mon, 28 Apr 2014 15:54:32 -0700
Message-ID: <1398725682-30782-18-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:55:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuSQ-0006FO-84
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbaD1WzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:55:22 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:55944 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbaD1Wyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:53 -0400
Received: by mail-ob0-f201.google.com with SMTP id vb8so1612104obc.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xjFW+2Qh+2kk8XQxoW9Ee6kHf4W36T4r0hsd+3rKhUA=;
        b=H+KrcWolr+3ZmCW64Z76dGCD7rVPNvfn7F3rSxgog62hATyoRd0T9Ws5UA3EZQSs5v
         MLi9ul86Cq/bvuJlzUYFa7/FVajATjda37dSEP/AasdtyG8xNzi4RXQxhsPKsk5e1wda
         C5Crj2SbXVDnyn18fG/X4rfyWcR8hxlxCFa7Fi4Q8OFZpqtl4qxTonyqlk0qwGImXYgC
         V3dGpkU5nYvALDjCFXcqPl2fH9atfrT3OjGXmTc9q3LCNg5dSZflIf581Bnlv+Z++f9V
         N+V4lGXoieFjqTlwBlJItxpKQjyvfrz8L75RK83zMQX1QxTxB22Dw9rjmi2XklrkkXrX
         T8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xjFW+2Qh+2kk8XQxoW9Ee6kHf4W36T4r0hsd+3rKhUA=;
        b=Em41HI73eoW8VVam+y+qVOJF2jM43z2dJM+jxYPUHYkq0n012aTVdIO6q8gtYgJvjJ
         7hNBUOnXcOGj3q1hh4AGNTYTw4dAOY+gT2DZf0nWf6tDGFlZTceSjscgBSXpfsLRB2GT
         r+IgWEdOIpX1+cS+cAsCzfYctIJ4yOjEDsHOj19u5GPYAzLSIsxalpjaPUPIsSF1Lobj
         /+93ru6l2um+UWDZ1JicqIKC8c/J65/rYB1LUn/cZ4gxFCUGG+k06X+mpvX7bR5yWgAg
         g11ew7nDCAdqlPkcyAhq+5W6a8/MAlKeqkydijRlZ9d3HG8676bjjV0BBS/s3bTw5eV9
         HUwQ==
X-Gm-Message-State: ALoCoQkXjvnYaf9tH35Gi7wColYzkgxRDMZbwrFvL8OjpARVU9b9LSd0/BDkuqR8dP5ri/B/6J7RvdK5C+XQa2jshq1q5gfnki+YqeF7XYufz5qABheFfSY0zT7wGa2Bwm2JnRFZQ40xInEpl5qT8VFKKAWpReNwfEeTOgpor0LHnc1xfXNJjlbx+eJvib07LlluHVSoXnFq
X-Received: by 10.42.155.137 with SMTP id u9mr12744971icw.12.1398725692997;
        Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si2351137yhe.3.2014.04.28.15.54.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CAE5831C20B;
	Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7A18EE08C1; Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247473>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 0a4e28e..563f336 100644
--- a/refs.c
+++ b/refs.c
@@ -3396,11 +3396,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin();
+	if ((!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval)) ||
+	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_rollback(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf); break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
1.9.1.528.g98b8868.dirty
