From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 26/48] replace.c: use the ref transaction functions for updates
Date: Tue, 10 Jun 2014 15:29:14 -0700
Message-ID: <1402439376-25839-27-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYV-0004uB-60
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319AbaFJW37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:29:59 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:53222 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1062706yhl.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6j7ZepqwvGWdRhguxOIxjtLGUKVftp0l7AfwiFRBXEE=;
        b=DC3HhWK1zNIhkxMonGJP8tLTzuB4+2n43rcJ0xg+5bnDA43nGhqiUl3cYFLt9B6dc5
         StRlD82bdniLtyhIMIZRpJYIr5+865wHuhgLeFKNoXuIwhz5iQrPAwfYPXcZDETT8mX+
         41Cp7xgBZYRnFMEz4ZtloTOddnU2o9UCSPLLeVgYzI2e5D2VCSl8MBOFZtxNjsHpsdBA
         0NVM9pSD0TuNtcB+gXUUlIvFtcdmFZAtMBQp71jaXjY7lyWDqluWVW80WRM4rqB+chrn
         6qDsmRGkPyGgKPkhW4tCJgI+iLgBu+BVcCGfgbDCKBTa9RE+DP6Fvck0zFGUI55gOA00
         PzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6j7ZepqwvGWdRhguxOIxjtLGUKVftp0l7AfwiFRBXEE=;
        b=QU2vWppIwKFP9RJsRC892Drg8/YCK89cjo5o7pwi5ctQLy5bV5brumg0t8xNIP7Du/
         nGlXPGCZL/XoNb9DBRhOEYZJVwisFs/1Z0bxzsUaX5S9a53pjuKlKnISN0Wgj/2B4Eur
         W9VYM02FGMrSDNLwwJNLae6FO7+IREHkLU5y9XSRATbGm/MPRtVPmXE0/w+wnjuUUD0n
         ZVSRgvnmF8LQau6oM80qBs1MS7gECta5CudXD+DZhP8CO2ssXqnAoXle4ICsngr5jVVj
         arNJhhmudDmC1YBnp2dmlCig8gwSTEc8LZXbXRSObe19A+CTMzuQfufyKBvW3Mxu47md
         86Tg==
X-Gm-Message-State: ALoCoQn+yb6YOs9a6GWEAFZeNIao/eqF1dkSJw1Jxxp8It24FZzEDz1vLgUizbM5PU7yr2t+v1+6
X-Received: by 10.236.126.79 with SMTP id a55mr1167747yhi.4.1402439381189;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si1395065yhp.6.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 119715A472D;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E28E9E0AA8; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251303>

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
2.0.0.574.g30c2c5e
