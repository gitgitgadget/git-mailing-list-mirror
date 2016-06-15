From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 08/30] refs.c: change ref_transaction_update() to do error checking and return status
Date: Tue, 29 Apr 2014 15:18:53 -0700
Message-ID: <1398809955-32008-9-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:20:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGOJ-0002w6-QL
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965347AbaD2WUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:20:38 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:63667 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965268AbaD2WTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:21 -0400
Received: by mail-ob0-f201.google.com with SMTP id vb8so205093obc.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o15MMpG1MR3PtaEW0Ab/xlRfdJx3FZZzio1/3uEe2Dg=;
        b=dGCAmnPAEFW9L0XylQLtigNgJZ1C4WPk9h5Y02FvJ3c2K+UzdDlEWm8sFZOqemFbUv
         p3bgpFoEUC6E9CdaKyErIDUK+twm6C/mEWPSScVQH0H9muC1pYR7jgwajD4caiVuhs7I
         hOWbatfZ+s92l0pvEMDnKBgjs44ds9gx9lTDiZ9nMjjDnCQTmC3fPWeH9qoThoVJB6d7
         Q/nfXKUmINY9tek5e3949ZXuhTpnogaim+d38X2mvxSevRmkeBffFvPKY+nNO5kWXmml
         faRP6NVzSR7Coyji94wFIpBksE2+M73aw8IOTSD13FmkRSTw0UOdVW+g8eouMNgr40e7
         fnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o15MMpG1MR3PtaEW0Ab/xlRfdJx3FZZzio1/3uEe2Dg=;
        b=GXrjPPuHYQn19lvpOxltaiowDOKDSZv0VFVdq7hF04qYYXDPmGcR4dNeN3Aer0w3Ko
         st5AgJCbaLCXm3Q8163BkRueACW2nIdzfU0BkUcRX0loRaDURmJ+QBoQRE2Djq4gNwEc
         5FSPd9mygkUgXKMwN0c4CBsBH3bNNNL5Kao+SrC8/fsZsgKfQ/skWMcPw+tY8ISefKip
         t7QAv87WR8E3SF0v7Yn3zFFpmnhsz15TBcyz5UXYG+83eHTWlzTdO1S8Wuag22IA6+gX
         BfNJLSWHgS2NBlHq+3MgNOomB9pq/JX0aVPZgw7begEyVCcGVB9ep12MY8w5MNDfLMrg
         859g==
X-Gm-Message-State: ALoCoQnXwTvfcGiqXlfQ4PEz45qhxV03JqETsfUTTUKCO6gF707fn6kSdyUmV0m6jRm5ADZaJYcORiI/aexkdEISjHzRUOdOJBFKb3es3BFh1T/ZbZO5n3gSoYp2j3dBTD4GtcxsUxuGt6xhVv+Af6lKE6Fn9rLpL4FDi+YD1Q4pKeg0h7Bl5pTVnReCb/o01pqq6QreepOf
X-Received: by 10.182.252.166 with SMTP id zt6mr283460obc.17.1398809961012;
        Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si2738481yhb.6.2014.04.29.15.19.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CD8BA5A4121;
	Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9256FE0B2F; Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247642>

Update ref_transaction_update() do some basic error checking and return
true on error. Update all callers to check ref_transaction_update() for error.
There are currently no conditions in _update that will return error but there
will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 ++++++----
 refs.c               |  9 +++++++--
 refs.h               | 10 +++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2bef2a0..59c4d6b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("update %s: failed", refname);
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 308e13e..1a903fb 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,19 +3333,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-void ref_transaction_update(struct ref_transaction *transaction,
+int ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (have_old && !old_sha1)
+		die("have_old is true but old_sha1 is NULL");
 
+	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	return 0;
 }
 
 void ref_transaction_create(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index bc7715e..0364a3e 100644
--- a/refs.h
+++ b/refs.h
@@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
  */
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
-- 
1.9.1.532.gf8485a6
