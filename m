From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 16/48] refs.c: make update_ref_write update a strbuf on failure
Date: Fri, 20 Jun 2014 07:42:57 -0700
Message-ID: <1403275409-28173-17-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05H-0003jx-OT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbaFTOq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:28 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:34316 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-qg0-f73.google.com with SMTP id q107so168109qgd.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=28zpzXOryjRxsPGlruwcIz0BLvkB3gv/3smARY8IPeg=;
        b=H1ObJJSau329DbHJ2RaWppKGF3Ef3vDRzX7BIWBu1q7FgboCxDmHLYJV1M+dE7biqD
         gzLlc19CiwU7yZ/1M/BWTJ4jMi6iFnmO1PCuuafjxkS+Aod0Xv7GzrnUTvt/nCpjd/OG
         VdSA5r5ryQWf6jiV1vf44xukBqXTnk/iw14UqRAL5ejB9/3jIap1Iama4OdETjE7SJgL
         1BpQW/s570DEj4XZifbwwJJBXV3/DOk34Gc1JeCv94N0d/4fxO4CHzvAOhOjC0zS+Yxo
         AXZqr1dtmSfDl5bNgImV9IBT4xsTlaZCJ/dxK7mF23/gvkdUIMAURTOUPt2YMElS5u2G
         /fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=28zpzXOryjRxsPGlruwcIz0BLvkB3gv/3smARY8IPeg=;
        b=N137p88uQeHYTodInlSWLz3Pbl0F/ZPTPBQwY11IeFcMEuku4iE2k+v/E1E5qLYG7C
         XAnnt/yDyOLzhYiaVrMcsigDywB41j7Th+CoZ9sMu6L/O+3XhhEF6q+hC3dxXqSCj1Xw
         OGysDKSai9+j1MN6cqVaFwwCqCUIc7NrI40PPbMUAA6BjlvPksLdbQYO9ZLmevHpW/he
         QXMeMjAtqh7DcmI4HponUorDxBBMqdO79izBTDoe/HoU8LuYieCp/SSLUkwYPLaYT167
         BV5fewezLCyJdktXp6IGkAuw6Kpa7j0cWj3niLtMqH7WNmtt27C5UamN3tonOz13Ar2W
         nu9g==
X-Gm-Message-State: ALoCoQnrFfXdOrwIE/P9FMfq4ZlL/ABvCZ7AqNK1Hb2rXOXPQOX2DMnvSP4b7v6U1ECSe0NOTf3K
X-Received: by 10.58.220.4 with SMTP id ps4mr1521859vec.38.1403275412579;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si591922yhe.2.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6ECE231C6B4;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4D2B0E0A04; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252262>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 115f143..003b313 100644
--- a/refs.c
+++ b/refs.c
@@ -3353,10 +3353,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
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
@@ -3477,7 +3480,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3559,7 +3562,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.420.g181e020.dirty
