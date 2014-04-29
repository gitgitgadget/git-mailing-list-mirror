From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 06/30] refs.c: make update_ref_write update a strbuf on failure
Date: Tue, 29 Apr 2014 15:18:51 -0700
Message-ID: <1398809955-32008-7-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGPN-00043Y-JO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169AbaD2WV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:21:27 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:62158 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965250AbaD2WTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:20 -0400
Received: by mail-pd0-f201.google.com with SMTP id fp1so163060pdb.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/BPEWRtne8Rg/Tz35sBOEzuvv5uKckK+1NvhpAih/8=;
        b=lWnSqRPKj+2Kfd7UraAdn6G3kIFq0kX8PBJ8W4qtaZGaa2dxzIRJ/4dOtnY7l/bvX7
         KvA2As+LyW5LYo4droIPTAQi3vbFsqPAr/FPSKi4wVqoGkg/HShhZtX3ilXV91KQE/IZ
         XCc34TGzUq++AC4SpRmz3Ud2Wi91J7afhteKvm7+tU8DQBpfGkXVE3tjyhgCupIs3rJK
         YQ1xbF894liDOqHqZ4263GOu6HLhdHmeSNJyCHxxUH6/elop4T8FvEJjnUMmqUWhwsAc
         3cP3JFIA2Uc7D0gyu9BrV3DIHmc60UR+qrAn5e4HHn+B+oGy9th2/Dz7PJI/fmPMypSu
         Xh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/BPEWRtne8Rg/Tz35sBOEzuvv5uKckK+1NvhpAih/8=;
        b=UWTyOvcDEfu44miVz2XCgkUFcEIeWRi6BEDwgfmIFXREeILsB0dkAD2hW7ZEYh0oif
         M86YAS/Ovg6qT8nTuA8mmsNM5g34lxjhXJKvsOQUsjHlBlIljdQ4Y3LHpJKagJU8jNqM
         GR0PtLRlAnejGlFkPNuZ12yUrWjCwvjTz4lOvp0PxH94X6gcIGTtO4BbMYlcmReV+/h9
         pu+2mnLGCc1fFUFEwduxkkDFPfhcwvXG5nECBfiRb1yHl8FiR+JBQ7aEXSMY7d15JNCb
         IhDpsSC51Z5ySELwYSXDhI3dwtMraq5KAcCnjF67S0RENkWTQy9Q06sHHjnojhyYaDld
         eqLg==
X-Gm-Message-State: ALoCoQmhXh7petVhvkfdB7lH2tlp7hUpLXkN5pPCUOGvuVUjHiUcoGghDRVS0X7gDoW8qeYYX2tZ0E26VtXhkpRJpq9Y3HL/jsP+cnUmifOd3HIUQbH3+eHfsELaOZP4rmFtgkts6lHgH8lfnFIVhbMN4YpVCrRiD5HzOLvHAnb8MWnjfwabKLUolIE7BLANc4VpbNKvEO11
X-Received: by 10.66.157.35 with SMTP id wj3mr319430pab.11.1398809960186;
        Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si2738478yhb.6.2014.04.29.15.19.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0145E5A4121;
	Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BA578E0A5B; Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247653>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 21a147b..5e06fd9 100644
--- a/refs.c
+++ b/refs.c
@@ -3253,10 +3253,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
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
@@ -3382,7 +3385,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3464,7 +3467,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
1.9.1.532.gf8485a6
