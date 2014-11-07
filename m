From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 02/16] refs.c: return error instead of dying when locking fails during transaction
Date: Fri,  7 Nov 2014 11:38:51 -0800
Message-ID: <1415389145-6391-3-git-send-email-sahlberg@google.com>
References: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 20:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpNQ-0003pU-Kd
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbaKGTjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:39:16 -0500
Received: from mail-ie0-f202.google.com ([209.85.223.202]:64974 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbaKGTjL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:39:11 -0500
Received: by mail-ie0-f202.google.com with SMTP id tr6so843288ieb.5
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9onQEQpFmPFBgGpBMUIH+qObIsKXQmMsymejMnOMFK0=;
        b=N63wTy7I1/SswaKPhAnN+NuwkAdyuPaTKxrCfuY1ZPr15tdXiyjgkRFH+suhG5e+yF
         LRKoy2VT5kK7hzs/pWXu83bdLhdL44ww9PBSOxcy0H4G2NHb8yzyIzxv4St2PwDE0kX7
         ng0FLH71lff6tsPimHqxtyYV7IZmpgs0NeLESV8+VweNFOkR5ZKihgTfnWvtqerULwnS
         suVlQFTs38qt0tXUPfqMSrZHNSwORq/xzjVHqoScwB+fbg6x1MkoA9qOb+zBNlZQv+jM
         9d6Eo74nzWbSAH1nSaXjKhS04XwzAAjEWb6X0F0j3x2fCg2D7dAnkWZpJ9VPXGA4/ekH
         RJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9onQEQpFmPFBgGpBMUIH+qObIsKXQmMsymejMnOMFK0=;
        b=EAmEpetJ8re6HJbA96piQFl5D22+zKsjrmQD/rP2tvrUMoaEdlERpW+ejXpBjVd4Aq
         NlPsnezBG06fUuIrVSm2aEPmxQ7v/+FCZAxSduDVSpPBj16lpdELkEuWrlYi02O6ATxx
         8OMbrLatYXWyef4sBHkVAOSFUBbbg7Mm5bjOlCfyeaMRaMOhYDQ2h7N+1vexAW8o3mVa
         405JrvNM3yeARYNIzm41nl2VgIPFtvpmMAQlMOydC6iktUcsuJUnRfDotlu1AjgCcTtH
         FAH/5pLF6yGTTaCriwxR1pF6/KceJZedgKXGJsxAcIGXQN6fok5IlJ7tEtNcIknOfPx7
         b7hQ==
X-Gm-Message-State: ALoCoQnairjBuB+zQ7wO0bL6+opfKQ3yTwuXzK6RXFHKk5Wy6W3sFtMQyvYtvwtnjytqLWbPIVp+
X-Received: by 10.50.141.135 with SMTP id ro7mr4072408igb.7.1415389150203;
        Fri, 07 Nov 2014 11:39:10 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id l45si403582yha.2.2014.11.07.11.39.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2014 11:39:10 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id Y0ezxMPd.1; Fri, 07 Nov 2014 11:39:10 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5E431E0379; Fri,  7 Nov 2014 11:39:09 -0800 (PST)
X-Mailer: git-send-email 2.1.2.810.gfbd2bf7.dirty
In-Reply-To: <1415389145-6391-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change lock_ref_sha1_basic to return an error instead of dying when
we fail to lock a file during a transaction.
This function is only called from transaction_commit() and it knows how
to handle these failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 1791166..d4ab65c 100644
--- a/refs.c
+++ b/refs.c
@@ -2340,6 +2340,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
 	if (lock->lock_fd < 0) {
+		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
 			 * Maybe somebody just deleted one of the
@@ -2347,8 +2348,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 * again:
 			 */
 			goto retry;
-		else
-			unable_to_lock_die(ref_file, errno);
+		else {
+			struct strbuf err = STRBUF_INIT;
+			unable_to_lock_message(ref_file, errno, &err);
+			error("%s", err.buf);
+			strbuf_reset(&err);
+			goto error_return;
+		}
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.1.0.rc2.206.gedb03e5
