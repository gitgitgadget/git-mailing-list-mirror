From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 08/11] sequencer.c: use ref transactions for all ref updates
Date: Thu, 17 Apr 2014 12:46:24 -0700
Message-ID: <1397763987-4453-9-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasHV-0004jR-QD
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbaDQTrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:47:15 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:54576 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbaDQTqk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:46:40 -0400
Received: by mail-ob0-f201.google.com with SMTP id va2so176293obc.0
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RygoZ/kWFdaK3mNl8O/j/0H2gjVVVoMdHAjlG4952lI=;
        b=jkYgi86qY+noOtJ/nZxOYp+jisYEUofcWeUnozV+zVj3juXhhmAeMSreMo0PfdLl3a
         sSdWraiHomcKtKKqChdBlM0PAjq3mZvvR+w4J/H9HhjIYneXx7BDoF29/a4W/y6/X0RZ
         Rq72ykJoyLdsMZXmh6VoAgIiO8meKL0+0F4ylkE7jc1lFboIELw0Qlph4kkXDUL5+UZm
         pgaR8qwzPCj8MWjKID6IdhbYCE4oqiMdaVZKMak9x9wSF9ugzsxOjnNue5FNTaGN3ZiN
         jdOlupALW5wDWo5fwp/AqSLI0FUjHdFYWD+sfkZkTJwfSHLY6yXGnHk46bfhRPjlAFT4
         m03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RygoZ/kWFdaK3mNl8O/j/0H2gjVVVoMdHAjlG4952lI=;
        b=k2qaY40kRy/SnxyVfX1zEWnaX467nFwgf4rer5Orxm805PRlx2pLNPDUslJCk0YWOS
         upMvgLpwWiS9K+F9y0zN5+fULlGZ1lIfjIQ7w0gzlsGjvnD/uIdRCu0akthRJEF9uJeS
         hA8h/zJL8vKfZp1SZTTZ3MYUV6O4E3tArwZY/WQuAkYRo8UnfnoEVAthdtt6tHF61Thn
         pLl2Fh5qSub22ksU1z1YzXJRkJrvHIK897nJl9+eCJmEFppKlJ+I+ufLPBC+6lgzWKQy
         eOPx+WXDQittwiBd9YFSbABPczyaNmzXlNKjE3RENMgTqhMku9eMJ4Zoay6L7ng2GZer
         auvw==
X-Gm-Message-State: ALoCoQkykB2PlJ2b46qFvdEM7ZKDHUYGFcaccDOPP9rSQG1ceaw6apycWeRdJEJNTMTmi0+MYK/HPGFLyeWCxijr/iT+KuUngqGWzVGETpVk8OmZbmaT8I8ulHSEAKD+a1CPiOojp74ch7Sx+32clkCkL21r+zpGTTQykmegucO2efQcm02z5f11XlaaMxYbD/KOaWmch3KI
X-Received: by 10.182.87.2 with SMTP id t2mr8430707obz.2.1397763999565;
        Thu, 17 Apr 2014 12:46:39 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id s65si3654778yhc.2.2014.04.17.12.46.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 68C4A5A4252;
	Thu, 17 Apr 2014 12:46:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2D13BE0967; Thu, 17 Apr 2014 12:46:39 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246444>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bde5f04..fa14ac0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,17 +272,26 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
+
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		return 1;
+	if (ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn)) {
+		ref_transaction_rollback(transaction);
+		return 1;
+	}
+
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+	ret = ref_transaction_commit(transaction, sb.buf,
+				     UPDATE_REFS_MSG_ON_ERR);
 	strbuf_release(&sb);
 	return ret;
 }
-- 
1.9.1.513.gd486896
