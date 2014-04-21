From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 13/13] refs.c: change update_ref to use a transaction
Date: Mon, 21 Apr 2014 15:53:31 -0700
Message-ID: <1398120811-20284-14-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6v-00007R-H0
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbaDUWyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:43 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:49886 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbaDUWxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:47 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so823087veb.0
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XuRvnqmwrbLBWz9o6jEKvcx/o18/+CQB/DSHnkYEwGo=;
        b=DMK/zXB1IZLjhIccmo/tmdFHRnV989jojmLYh4s/mFVfNO+3NYAz8tynlYjhOX1Kfc
         3lt3BXAmk8W2Ij6ulQcsvvD2xS0aSDcWGuL9DJAc0t5Y/lF9VGOsUppEUYFSgVja8TFp
         /xbiQ3FO2OWuQmQqtfrh92ak0azKUlyyKr7EqRUXP8c1LbYlyAXdhznhboCiQZS1jNS9
         bM8RYt/sCM72lVnkD8wfzSop11IOrotOlIOAtojCMKM9IAXvQa6LeXmafGVegBa7oXfn
         zIEB2AP8wceIhQ4KK3Nq5claxyZShyl0SOtaW/zXJ3wxDbybi6sYFfVO2yXvNmAQvavy
         j9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XuRvnqmwrbLBWz9o6jEKvcx/o18/+CQB/DSHnkYEwGo=;
        b=fzd7YodXx0SDOayPUHW/Z9CNZzgA6rQyTPvpZee6CgjOHdpnH7ureuysOaVgXcZpVF
         8E0y9HH892Fx4d7AIEyXrhJxTPBS/AOjx30pXODVstv4gUvkXQY2VrA1QZunA9/x9g6W
         oQzj34UWywUYBa9nkkPlnbsElvSUGKRuMvzfyw6CLsp5U+fI0BXMjiHIIJKMK3eFhfe5
         o+BUCFRhQ4c8GaovenJ6LbSiEC1kpz0aAZe7LTtqQMeohoGYJDU1YI/wop28UxDmZOuK
         MfWAdHf38B8bsKBPIHlQhzjbce+aHQUaj5yBIkt3WwHfjec2BNrSvJBnCt8+JBPtn0BL
         UJtw==
X-Gm-Message-State: ALoCoQlLkHBE5sUznbWEBMyOtsPglRZNzPEnZgz+Dj/MFSVZx/xKxhTq4kvH94cxnl4Q+Pi3dOmvNCMz9B5Z/FBGq0w1sBSy4lAb93N8g5POII6dZbFihgPaOuzEB3L1so2ajWZCBmeBq16H72GWQg4811xRISVWdcL51Y40JVZW+ElAKyPJPUAIlIXrftreoR7k4Knl94Lx
X-Received: by 10.58.30.78 with SMTP id q14mr19566836veh.10.1398120826548;
        Mon, 21 Apr 2014 15:53:46 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id s65si5368519yhc.2.2014.04.21.15.53.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6455C5A4207;
	Mon, 21 Apr 2014 15:53:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 272F2E06AA; Mon, 21 Apr 2014 15:53:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246674>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 878948a..e52b6bf 100644
--- a/refs.c
+++ b/refs.c
@@ -3390,11 +3390,29 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
-		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	struct ref_transaction *t;
+	const char *str = "update_ref failed for ref '%s'.";
+
+	t = ref_transaction_begin();
+	if (!t)
+		goto error_return;
+	if (ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval)) {
+		ref_transaction_rollback(t);
+		goto error_return;
+	}
+	if (ref_transaction_commit(t, action, onerr))
+		goto error_return;
+
+	return 0;
+
+error_return:
+	switch (onerr) {
+	case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
+	case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
+	case UPDATE_REFS_QUIET_ON_ERR: break;
+	}
+	return 1;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
1.9.1.515.g3b87021
