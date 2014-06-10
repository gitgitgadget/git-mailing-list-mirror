From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 31/48] refs.c: change update_ref to use a transaction
Date: Tue, 10 Jun 2014 15:29:19 -0700
Message-ID: <1402439376-25839-32-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:37:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYL-0004jq-FY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbaFJW34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:29:56 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:39989 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-pd0-f202.google.com with SMTP id fp1so602819pdb.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SC/yNFiTw5X4bFGFVdoHQxwdmc61TNQVGewrI6/vAPQ=;
        b=WIQgrs6UyWdSmDZ/hjMlPP2V1uvZ/OL2eeVbDbrnhePe4B1lBJqbvkBJJsmvGZpyHC
         OuXf8rVzRHditK8T2ADcsgBTC37CbDKD+gir6bfmxci5po1iP8qwlLqwnivcKY6Nz4VH
         I2nA6CIj3WkidZ1LA6/uZHASNInDob/GQcU6A9SLDucyAMeeJfNhcaQenxxOWa1gdklg
         6fr9xbP8kTqGPvzYQBMjqNpvoZQyDrfNtGXe2tTl8SVNjuxbcy5uwTalFaMxsLtkbfDm
         f/4JK5mQqkcO2f774cAmwxljWzo9TFzQa6tHCOm8A2j4/ZyBIxlG4ckB7/+thnG41pvv
         qfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SC/yNFiTw5X4bFGFVdoHQxwdmc61TNQVGewrI6/vAPQ=;
        b=hUKLrgwN6SATomxYlr/dnfFvJmzeM2AefANvwE3AWEETQDx3mmsepbwZunZj0RMmlR
         WXmEGegcOWPGlQH4rx5ZA8gQolC2/w6sMBK6xk/Bnud2unp3MTT3ZYBa2J6n1R0AuvQe
         rwwPKjBsjWSy+mBatYR2NAdn/yWFqDv0xEzs0aIzQ2t1zgOwKdAqbcv+q7IzAtvzMhfT
         OboM0F5ZjS/xh+79tcMg917/XQ1FV+YVtS473QcnD9UJ4PWaIi4m8cAj/d9R/vigGZHt
         sEaPEMPD2mu1jI7A65cgF0gTKe/nE9VtWcYOHtiYTqOEPeZ6JT743m7eAlNC/jXhe/Q5
         Zx+g==
X-Gm-Message-State: ALoCoQl2qg9lvxTsY3ecXbDERlaGprnTfuHYqmrbajSqWPuPzj7Bmc/GtSXvaHeWwBU+F4L8xNDv
X-Received: by 10.66.234.39 with SMTP id ub7mr3920651pac.26.1402439381330;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si1374941yhm.0.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2A97431C746;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0977AE0A0A; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251275>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index b47abdd..b9a6adc 100644
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
2.0.0.574.g30c2c5e
