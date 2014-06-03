From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 09/41] refs.c: make update_ref_write update a strbuf on failure
Date: Tue,  3 Jun 2014 14:37:27 -0700
Message-ID: <1401831479-3388-10-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwT6-0007ro-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965423AbaFCVls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:48 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:34854 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934172AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-qg0-f74.google.com with SMTP id i50so470556qgf.5
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/KXoYTKs0UwePXSaaR3nw6QSiI+nlH6iAKjykY6luM4=;
        b=cXuC05NPg+2GJZ6s1Z8M8jS+SW7Dk6bxzSWKC26JrCxBzx8M6c8mTFGW1YpDfEZ0d6
         pwH/Yz9/xBmljycrwvszfgR8/tpYVlxpFaZVKbf8mdDwO/wlJ952+n1tKgrIatsC5ern
         kltGz7WS17DpXBr6VC+Q83+zw/YvVKAsjOXgscxKM8zjPl1FJS0YBz3812KaJtrx4Tut
         VdwQ9b4zDUBXfN1WZvqL1M18mgT8gPGRDFtErQ6B0ctcxPDz6NNb/VoBfzPCUd0kcmrJ
         YMc7ZCSBjWs1tClwB1VZ7Z7XQlJk1s+PaJbZhXSrWR5ZXGaVuiqYnwjoyQ36MBxnMsSm
         TU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/KXoYTKs0UwePXSaaR3nw6QSiI+nlH6iAKjykY6luM4=;
        b=BFVscLA+b/aK9OdiEPZNC2gYEjT8Yu/wPbQ55NKMCZx7aPHtuifLXfti3sL60I6EuY
         pLOZYgVL9xT4uyhWM+DWcOnH8nXQbn32OBTkn5F2BJ/79yugAFSufXQUdfJ78V7rAOWu
         70jFm9mczYpZ4aSEj7eSJl0dsE0YD5BetP67X3xQLDoxHbvZ3F29K5afBk2URkqOTLmC
         7JeSQgNrTvAvewNfdG+HTKj5uKjBvRrzMc6TYiSojbMFq+rzh9IsHWvpxa06/cnIvqnw
         0amZNvARMBN3LpXbs90h20/YiCQ0fZzz43NkSC3DDa12rAHu3FwodylZY6g7NyJDMB4z
         Ijqg==
X-Gm-Message-State: ALoCoQlqFtXEoJTlhG65j1n0vL5SAFvvgD2t1alF+HXiK+ctuO3knkDbAz2v3jTAk1QPSqQ909jm
X-Received: by 10.58.127.66 with SMTP id ne2mr19448029veb.27.1401831487367;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si29581yhk.4.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3806531C45F;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C63D6E05F1; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250685>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index dd498cf..6696082 100644
--- a/refs.c
+++ b/refs.c
@@ -3343,10 +3343,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
-			    enum action_on_err onerr)
+			    struct strbuf *err, enum action_on_err onerr)
 {
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
+		if (err)
+			strbuf_addf(err, str, refname);
+
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
 		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
@@ -3467,7 +3470,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3549,7 +3552,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.567.g64a7adf
