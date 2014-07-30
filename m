From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 2/5] refs.c: return error instead of dying when locking fails during transaction
Date: Wed, 30 Jul 2014 14:52:45 -0700
Message-ID: <1406757168-3729-3-git-send-email-sahlberg@google.com>
References: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:53:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCboD-0005qk-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbaG3VxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:53:10 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:40145 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbaG3Vwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:52:55 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so403437obb.0
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMwZwnkKYMHGj/grBEMEOggs+ZkHZgye9kkfEHYbYvA=;
        b=VJq9l73tHtX8BFrYgfMIKvqqiW37RTNJaASuzdjjTSd1fsH7NIZTpuBRmFFdIUl/fb
         2LILHRRt8BYcjvil0SOgFWeT2tYK899kSInmj71HooJkmN0MPp9gSMDpJKswAkIvTPw8
         Tieu5tSmw+4Ms/U8Armo3DUAseq3yt50DcvaLC/uTNETnVVgSEookBg1Oe0L0wAxpbuz
         qOefQgadkPVZHC24GVPb8unTEdSZMBfKn4zAFnaheWeayXmEsw0DRrHXNrPi83VKql0S
         tNr6PLSBoyqFBDombVMoDCCHy5vCOotRXu1O1Inp4JmVsAWpLha1zNIH0c62aQYyi1Bg
         CFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMwZwnkKYMHGj/grBEMEOggs+ZkHZgye9kkfEHYbYvA=;
        b=OkixaISdFbvRyXW2sQEEKJTFKawxDJ5s7XHt3TyGQzAYeplyv+d2MJFiQyos0jQLZh
         NMgxXkkuZepeQ9TdARwjW4fS7HdYq4iSOhYgFyHDwXp2diXD9Oe6qnqNKn6O9FUPeuJ9
         PMnoLkN0gwzTu10ygxZge6dZpNZL9WY3mSYQYf8Q1Pf2G0jyjgPK6pUc7/ePYSNPEHEU
         r0bFJu0nHH2fEtL6g/jn2oizGoOXWRD9k1FXJHm/T4PTp7ICTxyRVCH3sewrfxyp9ww6
         Q3cQEENc2Fp6lAbQUdmGNAEVz9yLzyQMmL9QRGg78Uz1i4IH5ldYYP17OpL4rJD8ewRt
         aIHw==
X-Gm-Message-State: ALoCoQkKDm/a2+h/IrbSrsoicj+SfX9Wsb+IFEn682buzwJ2hvlMEfKbPe4iMUWwfszbH+4+bdC9
X-Received: by 10.50.50.130 with SMTP id c2mr3372302igo.4.1406757175158;
        Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si227062yhg.1.2014.07.30.14.52.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:52:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8E1C031C543;
	Wed, 30 Jul 2014 14:52:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F2379E075A; Wed, 30 Jul 2014 14:52:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
In-Reply-To: <1406757168-3729-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254523>

Change lock_ref_sha1_basic to return an error instead of dying when
we fail to lock a file during a transaction.
This function is only called from transaction_commit() and it knows how
to handle these failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 41cb51d..35f6db1 100644
--- a/refs.c
+++ b/refs.c
@@ -2206,6 +2206,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
 	if (lock->lock_fd < 0) {
+		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
 			 * Maybe somebody just deleted one of the
@@ -2213,8 +2214,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 * again:
 			 */
 			goto retry;
-		else
-			unable_to_lock_index_die(ref_file, errno);
+		else {
+			unable_to_lock_error(ref_file, errno);
+			goto error_return;
+		}
 	}
 	if (bad_ref)
 		return lock;
-- 
2.0.1.523.g0041e8a
