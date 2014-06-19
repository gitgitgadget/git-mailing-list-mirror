From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 30/48] refs.c: change update_ref to use a transaction
Date: Thu, 19 Jun 2014 08:53:12 -0700
Message-ID: <1403193210-6028-31-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxefJ-0006jB-31
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758106AbaFSPx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:56 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:49651 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-qg0-f74.google.com with SMTP id z60so110095qgd.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4T9QkztrQ1+Nn0pZJm9GTqXBqIUWGJKgsOonKFdrl6o=;
        b=U0H1c5UFFczqLezarI6CLcMB7EKTg1kcRc8q5Ty5qALrxG/kf5xY8VTsQH4TyOIrCy
         PZF3M9WCNF0jY9pkS+Ln6KDG/JjEXlxgTI7L0WzQZy5Eicr1CpyG0ERhElJH3MGId8BD
         gzMQv8SkNvVh7HUzEx1mLQnTWKo8B0d+Atw1yMYsU+1hLzvpTBVlB+0EOMH/b40P3Es/
         k4EcpUlTsl6NjlauF3eaDcdboAr1CTiZwzazWm31r0w+SEygfByQwMMbx4Y1vjEz6Ni3
         1gS00eghT18eLSXnW66DlmP+wtbxGboMXo/GvrMF1Z0UvLeYjwrc6kgcEwftcSX1KCag
         lAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4T9QkztrQ1+Nn0pZJm9GTqXBqIUWGJKgsOonKFdrl6o=;
        b=QOrFCqGuNTiBxc9CehLjwD+3nFATkUebXdGFUxHc4omQ7/1QjLJz5rzSarD+twQYAt
         DloFOky9ABW4FxwdfhQLxrFzVzAm6/UKZp5dkYtUtXR4c0+D3yLgsokTDCkVA84lqbHL
         09w6g7sVL46a/T3ryfqHYKEVeLiEvg2W+B27famevxtWRegbCPHJs/K9hIR3VGb1T3zR
         pTQ2Lbez5mS6O1hxttkQbDJ85r9neLmgGSCpWn6JGURVtM8me1SEn6K5dPM/2f7kaveO
         hMCXd2U+spksfkeU4AmwsFzV0Pi1gM5yYNmGpsRuOqbrFPNbldJxFZeqCf6czSyfbMok
         if8Q==
X-Gm-Message-State: ALoCoQkpC63da3LIs+f+I4S994H5TstxAzGbjU+srnHVMaIuDTNLk9FCm4Hfl16oHq2TR7mWEOEM
X-Received: by 10.58.48.233 with SMTP id p9mr2620829ven.31.1403193213935;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si418320yhl.7.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C60EB5A4618;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A21E4E11C5; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252126>

Change the update_ref helper function to use a ref transaction internally.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8c695ba..8b2c598 100644
--- a/refs.c
+++ b/refs.c
@@ -3524,11 +3524,28 @@ int update_ref(const char *action, const char *refname,
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
2.0.0.438.g337c581
