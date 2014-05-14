From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 21/31] refs.c allow multiple updates of the same ref in a transaction
Date: Wed, 14 May 2014 15:13:20 -0700
Message-ID: <1400105610-21194-22-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRr-00088M-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbaENWOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:08 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:61177 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbaENWNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:40 -0400
Received: by mail-vc0-f202.google.com with SMTP id hr9so443085vcb.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vASTXXpMCIJcN2OP6AC/hiA9e+n5spvOHAQIlzd1obI=;
        b=LbzKxW7uSaHkSy58QIEvhbZ3IvNKsA8z0yfctcTQuAfFf8+XYOlUFhmA/ZcKN3/pwB
         GNiGp2z+wDKEZEycd40mwLtjhNbF8v/P5Vela9v5Lw0L+XHGPtsmNXwzaC6E4S7cYb19
         Pp4x5SHDs1ooT5ODWcIx8s10VXmrhdYZUjDm8vDrJIqmUcr+Sf2UUhF2JVf+cyWr1MPh
         BPagLh4+FplAQwlTF92Ji52OBShl7vvsJnexXS4GKl2FBsN4A2QDw3IpcO+V49SOVAiY
         ftElYLP+r/JVCDMccGhMQ8GO3zjban4N/67rc1uTVAw6Y8QlGJsNtOV7irfe+32Ei0uD
         NbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vASTXXpMCIJcN2OP6AC/hiA9e+n5spvOHAQIlzd1obI=;
        b=grNzcPEcO3OF4HllmXS4k14Bwb+6BpZDkDLxaAxciwEElUaH8fv0VHwFQk09TbdmLD
         crObPXbVW7/p1z2Mi8qL8zeJlEWoJjs80//8bN4+6kOw0gz1Xv/J+wBgZ/zDwpgugXzb
         GG/YoXsNT/BrLvIbC5iSkeL+EzCnesqXxkSXoQzkpAIsy3jacuANpAMAlgqcK09EJO98
         1YfNL5hXfLSXU6ZHKd56azIGwDxzhzCiJTRnqDcRRBsnUCm2XQlQ6EWn5BGKNkmvnnAP
         Sa9tODwZ+LVIrroN2bNpUVVJCaJ0pPM5ZutTmfLO2UYzs3I5fWG9WlINtzTOPrQNHMIV
         BaHg==
X-Gm-Message-State: ALoCoQn/ZMQ1iUAQWRju8goUg0Mr+F8pT7YGPhf+gLxScY6P1bY9hGd/0rSTCeJ3FHHYaBCD0Bf1
X-Received: by 10.236.128.195 with SMTP id f43mr2639475yhi.45.1400105619612;
        Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si151871yhk.4.2014.05.14.15.13.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5765B31C25B;
	Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 39C73E038E; Wed, 14 May 2014 15:13:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249026>

Allow multiple updates of a ref in the same transaction as long as
each update has have_old and old_sha1 matches the new_sha1 of the
previous update.

Add a test that verifies that a valid sequence such as
  create ref a
  update ref b a
  update ref c b
works and a test that an invalid sequence such as this still fails:
  update ref a c
  update ref b b
  update ref c c

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c                | 23 +++++++++++++++++------
 t/t1400-update-ref.sh | 23 +++++++++++++++++++++--
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 76cab6e..87cdd91 100644
--- a/refs.c
+++ b/refs.c
@@ -3455,12 +3455,6 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 	if (update->lock)
 		return 0;
 
-	/* If we could not lock the ref it means we either collided with a
-	   different command or that we tried to perform a second update to
-	   the same ref from within the same transaction.
-	*/
-	transaction->status = REF_TRANSACTION_ERROR;
-
 	/* -1 is the update we just added. Start at -2 and find the most recent
 	   previous update for this ref.
 	*/
@@ -3472,6 +3466,23 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 			    update->refname))
 			break;
 	}
+	/* If the current update has_old==1 and old_sha1 matches the new_sha1
+	 * of the previous update then merge the two updates into one.
+	 */
+	if (i >= 0 && update->have_old && !hashcmp(update->old_sha1,
+			   transaction->updates[i]->new_sha1)) {
+		hashcpy(transaction->updates[i]->new_sha1, update->new_sha1);
+		transaction->nr--;
+		free((char *)transaction->updates[transaction->nr]->msg);
+		free(transaction->updates[transaction->nr]);
+		return 0;
+	}
+	/* If we could not lock the ref it means we either collided with a
+	   different command or that we tried to perform a second update to
+	   the same ref from within the same transaction.
+	*/
+	transaction->status = REF_TRANSACTION_ERROR;
+
 	if (err)
 		if (i >= 0) {
 			const char *str =
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f9b7bef..078cd4b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -446,7 +446,7 @@ test_expect_success 'stdin fails option with unknown name' '
 	grep "fatal: option unknown: unknown" err
 '
 
-test_expect_success 'stdin fails with duplicate refs' '
+test_expect_success 'stdin fails with duplicate create refs' '
 	cat >stdin <<-EOF &&
 	create $a $m
 	create $b $m
@@ -464,6 +464,25 @@ test_expect_success 'stdin create ref works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stdin succeeds with correctly chained update refs' '
+	cat >stdin <<-EOF &&
+	update $a $A $m
+	update $a $B $A
+	update $a $C $B
+	EOF
+	git update-ref --stdin <stdin
+'
+
+test_expect_success 'stdin fails with incorrectly chained update refs' '
+	cat >stdin <<-EOF &&
+	update $a $A $C
+	update $a $B $B
+	update $a $B $B
+	EOF
+	test_must_fail git update-ref --stdin <stdin &&
+	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+'
+
 test_expect_success 'stdin succeeds with quoted argument' '
 	git update-ref -d $a &&
 	echo "create $a \"$m\"" >stdin &&
@@ -786,7 +805,7 @@ test_expect_success 'stdin -z fails option with unknown name' '
 	grep "fatal: option unknown: unknown" err
 '
 
-test_expect_success 'stdin -z fails with duplicate refs' '
+test_expect_success 'stdin -z fails with duplicate create refs' '
 	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
-- 
2.0.0.rc3.506.g3739a35
