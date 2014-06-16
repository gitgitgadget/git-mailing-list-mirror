From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 29/48] fast-import.c: change update_branch to use ref transactions
Date: Mon, 16 Jun 2014 11:04:00 -0700
Message-ID: <1402941859-29354-30-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbH8-0003dl-EX
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbaFPSEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:04:47 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:63932 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-ve0-f202.google.com with SMTP id oy12so474863veb.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNigA/w8vxVNQ7yUeMea/OG61U7ma0R1oRY1qkNUHas=;
        b=l0qD67vTM1PBTJ35LSRmDWUzamjFHDy+g53exICPTsFH61nSY5RO2bpdSKmaN7cIR0
         Wy7Vz4Ug0AT+gZh9Vf0sAucgMeAGPl7Mx7+FSdITtsshVHU2EF0AfsgUG8nYlnargLwL
         yVspAmhat/VQodWzuw+u0WaAzGLFmMhvKOxLZHUe5ns2xpyUc9tY653GzpcOVsmK71x5
         JflaRMK1DPTkVDE4mdGXNY1/4Wt7wAfQ5ZnBW5TLHc1GQ0IqbH7Cnz901ASduR1IKqEE
         bEXBQ2XxTWcV5MCuIG+2z88Iu/fumPTn4lL53iTOYy9jOkVCd2Z9Ji3aJ4WjoddH42k5
         E26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNigA/w8vxVNQ7yUeMea/OG61U7ma0R1oRY1qkNUHas=;
        b=dUXAeQXREiadmcx+6x4Z+5PGf+QXvrp1f+3TLUvsl/x9Ms3cdHvxKgrW4CaACcfPId
         RPZBiJHGGnkn22pDetEBVZNJT8ktiYA33WdKfEyP1DHIKNXMfr4HjbBLg7MnAFzWhyPd
         3ryx6tM7J2Fxt4VV9fzFVJ/quqyGUz0ItvU7L3KyIMULPceg3tS+7rpLK2Hr8qDMTjqD
         vR8zkDw3Ayk4uMc3ETcBDzY6i7vu4fMwdMJu6ooTE4vf88w1WlgBBYSa1OGI/jasSUUn
         PmUVykN2oP+r5bRHIqmBF1eupjgyZ1uhduY//JXvo+ok844koDZ24txwMgeBCpn46TUd
         HwEw==
X-Gm-Message-State: ALoCoQkMBCnRXHVX4Qso1l5cdpZDgfMTHAfuiJ/C2ELzkBEojGfXwZQ/jYQDdItBacqejOxmCC3Z
X-Received: by 10.58.34.47 with SMTP id w15mr3241193vei.20.1402941863581;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si996133yhl.7.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6F75031C8AD;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4C2FEE05A0; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251746>

Change update_branch() to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fb4738d..0752f0a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1678,36 +1678,40 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (is_null_sha1(b->sha1))
 		return 0;
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
-		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
+		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
-		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, msg, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.282.g3799eda.dirty
