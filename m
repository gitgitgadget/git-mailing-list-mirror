From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 18/41] replace.c: use the ref transaction functions for updates
Date: Tue,  3 Jun 2014 14:37:36 -0700
Message-ID: <1401831479-3388-19-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPp-0005eg-7T
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934339AbaFCViU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:20 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:37760 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934207AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so1408505veb.5
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FnJwuOK4Eigv+l1ySQmNOVsYn9I4q9RoLVTfYFGEFgw=;
        b=BhoFOmVKz5UQev5LdqYRQOD7YcwqRn7g7+UxAH4XRVONmUgz00+ZMsj9yuPTGuV0+C
         D8neTJKm7lPssZf9SDprT3HgV+22oVfOUNNRFgId8wS9GtaO2FjgYB2Nbabpr1+CkbKF
         R0aYd+rE1e/i63ELs2WX3GZW4G5GSb6RzcVVWgS3SFoIaRpjyRkQHLFmHwgR2p2ycuFY
         woe4n9KE7AMadUDbT72jkQJBic+wLrj0cHv3piWLnp4qgcI3o75G+fENz+qE6fNYb05f
         b2csFJAvgDiAzOuc3X7LzcEBDzauqlMVeQUX/0z3NyUGA5+/l2BPweXXIXNnwCL2RXHn
         axzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FnJwuOK4Eigv+l1ySQmNOVsYn9I4q9RoLVTfYFGEFgw=;
        b=khi6UH+jnV4xx2arwqDxax8xdTgk4WXuqlY9a2my+F8CVrYmxNJtf5xRf/SUbI9Xlz
         +OU5IgkGZ34V5+mzx9c5DaE//1sLGBbHImBbSYIH0pX3jdrk8RhMCaAMQhiH0w24Quwj
         As3uFDX9MN+8e3X9dS5E6NHOi8rDVccsP9MrOYbX00a07sYpPTx0byEwaox467Y3k+Rf
         NVnPYLiVHbNT8XoEg7h3l3YyqXQZHXOT5fwDNWkexxqpSXqMNBdsSYj3yOxBRlhUUG9d
         zlaxB6OCc7KmMUqF5u1SN1TCPR0VFxhrm2W/EkdknDjqygfRWBzewZAs3RAD2T9qEHoN
         lc0w==
X-Gm-Message-State: ALoCoQnrd1nKmNRUSmeuK30gQwhzvaoSfRXF3E2U4ZbXeZ2pbEM6rS4JZ4vcxxgGXbiozFn21IAo
X-Received: by 10.224.43.202 with SMTP id x10mr17235179qae.0.1401831487663;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si28350yhl.7.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 76DE831C45F;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 52976E05F1; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250657>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 4b3705d..cf92e5d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -154,7 +154,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
@@ -167,12 +168,14 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.567.g64a7adf
