From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 31/48] refs.c: change update_ref to use a transaction
Date: Mon, 16 Jun 2014 11:04:02 -0700
Message-ID: <1402941859-29354-32-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:06:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbJ2-0005sy-0n
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbaFPSGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:06:51 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:48598 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932652AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so432433pde.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pA02fNQ9gHTZ0wGpNJuaVe8wIwq0Eu9tOD98uQhX+RU=;
        b=Z33Yn0XtCQZEoW2ePfkyCdsF+hEEourXp5Yp1h34B1JjZ8H1ChFrOERWp1ztxgfnow
         tCsVr7f4AU0K2OcTBNY1f2J3VWqmAbFEpZBhAO8IgUlfEL73qgwYxfwcBLF9TJd5K3Lp
         NRe6Cf665+FR4HB5SxwLXby4wJX8RPItew39H/0unl42iFUfJE72k+8T2Lf1I/Kz7o//
         RFgUtJIOEIFJN17g4hf5qaX73sUz3Z5/4s1ChiFW2y4+UKTcApSSw05c6xcaoMFx5ykO
         W0fRoipqwbh+W0FwSH+ct7bhB1+5CPuR3xmcEOKCBO75/7QLWHOyaPFgEpj9zK14H4aB
         /BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pA02fNQ9gHTZ0wGpNJuaVe8wIwq0Eu9tOD98uQhX+RU=;
        b=CVg+nJydrF2ALKOCM2N4rpNZ0J2un6GX2ZYTsKrrceVyXwLqNs5of6UrwVEdUpXOe+
         LQbLhGoa3bFbAOvgbrTmypE+SjXmPNMGyrt67WGxvYjmna3iQmaG1BiFpKVmKR2lVhp0
         Pqei6WFDquK2P5Of20P4C2BYWFMEkef1a0YyiOVqW795qhkJEXIUZVtlCVCwk1/9zVc+
         VKaED7iLF0mQl9kUzQO4LSbaB2M7IeHYSh0DnjcpFlRpn6YJ53Yv7IV3/MgJ+SGoikD0
         DDGmj41rCVTNaJpi6M345VwSz/XEKYt+2BYvg3Y6nqx3ah46pHGk3+1YV4OqSQZhzsNU
         Hiag==
X-Gm-Message-State: ALoCoQm4zDwlEs/mQGPXYMlf96CKrFJFnighEQsoP3BPoYGXHQHwyFWkNFAtiXIXsaVBdsXd+OaL
X-Received: by 10.66.165.165 with SMTP id yz5mr24262pab.37.1402941863564;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si997326yhk.4.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 633F35A490D;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3F752E12AA; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251763>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index b75523f..50e5475 100644
--- a/refs.c
+++ b/refs.c
@@ -3521,11 +3521,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin(&err);
+	if (!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval, &err) ||
+	    ref_transaction_commit(t, action, &err)) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_free(t);
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
2.0.0.282.g3799eda.dirty
