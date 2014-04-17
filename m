From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/11] replace.c: use the ref transaction functions for updates
Date: Thu, 17 Apr 2014 12:46:22 -0700
Message-ID: <1397763987-4453-7-git-send-email-sahlberg@google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 21:53:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WasMx-0006eS-3U
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 21:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbaDQTxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 15:53:07 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:47710 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbaDQTxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 15:53:04 -0400
Received: by mail-yh0-f73.google.com with SMTP id c41so127820yho.4
        for <git@vger.kernel.org>; Thu, 17 Apr 2014 12:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZQbjKFrzwzQuVFtlvRQMpm6DAScX+yP+9Fo16H3e448=;
        b=eo3uWh4pAWBzYCU2AerWa2ntn0k67uT3SzeMvredT5hmfEyPuF0k4SEUAU4xYVjMPn
         ZWBINByGDcHnDsJL+PhkO4ICHgbIwfxD+UB1lFwCFBlNEqUX8yStN/6v/L4VdNeVrEhC
         lmey9u6WG5eVHmCtXpz/7R38f4zlKTip5TskBNfDB8hAnQZ2AuzAQk364FEbuK/tSwnu
         tTceGw7AAsHJywPLkL+75pgsELuEdNUdwP4Uy1hNsYZMaHIC1zqJPCz8CLSwegRKz56/
         JwnRBqOSPN4ZYGd4YMiYUXDiR4N3C7U9rX7FY1gkEu11vPVf7+gOmUYInhg25/gU5iju
         CMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZQbjKFrzwzQuVFtlvRQMpm6DAScX+yP+9Fo16H3e448=;
        b=YN2l+7d+zMH6AtihSJMZajV6kH1FKtM4R1Zsi139difKWKjcUXDCKo9eKk5/zrP6bX
         neLWlCypSczZArMpTTxRdxmhpTmCqzxghuDbmU/lS3590/k0tT4E170IOYcH9G4qs8UA
         TYeHgBbUvIjzK4feb67haDi31ZjLpgorqKr1h41Pv4IL9C2bfvq1va/nvcodXvtrnKWg
         +QOaHdIYeK2nncC4cWU0jaTLilZAQ+qy+TMlwELuld4AzO2fVc8XN1n6S+BKAI1n1Rw6
         qHkKyzhVD1CEYzYJeZ1aWMwRwLGVrjsbjApdGWb6BY6QSkzlYo1c8Pl069ea5JC3rorw
         Yerg==
X-Gm-Message-State: ALoCoQmAFTaLXOtMSYZp7tSjgRIe1qCwue+teb9+L8PdebXyBI2GSi4Lv899PRb3c9KP2LYA35HZS1brRN5kD6rCO+8Yq34W+4nBHfnR3a2fhOAVWGVEw2G7URjchFWCqZq3SKB0+IxKjQRvbtTMaQW/BEm4Q4XEBw2x1MopcDRoT0lgsbAWH/I6yrm4v/KAB05Z7BtsyEyh
X-Received: by 10.58.46.240 with SMTP id y16mr7901753vem.2.1397763997844;
        Thu, 17 Apr 2014 12:46:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si3652759yhb.6.2014.04.17.12.46.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Apr 2014 12:46:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A91A45A4252;
	Thu, 17 Apr 2014 12:46:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6DD3AE0967; Thu, 17 Apr 2014 12:46:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.513.gd486896
In-Reply-To: <1397763987-4453-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246448>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..d8bd6ee 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -129,7 +129,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	unsigned char object[20], prev[20], repl[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);
@@ -157,11 +157,14 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin();
+	if (!transaction)
+		die(_("%s: cannot start transaction"), ref);
+	if (ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev)))
+		die(_("%s: cannot update transaction"), ref);
+	if (ref_transaction_commit(transaction, NULL, UPDATE_REFS_DIE_ON_ERR))
+		die(_("%s: cannot commit transaction"), ref);
 
 	return 0;
 }
-- 
1.9.1.513.gd486896
