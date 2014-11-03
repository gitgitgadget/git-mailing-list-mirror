From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 02/17] refs.c: return error instead of dying when locking fails during transaction
Date: Mon,  3 Nov 2014 11:02:04 -0800
Message-ID: <1415041339-18450-3-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMtq-0001Xv-Ml
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbaKCTCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:32 -0500
Received: from mail-ob0-f201.google.com ([209.85.214.201]:48314 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbaKCTCY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:24 -0500
Received: by mail-ob0-f201.google.com with SMTP id nt9so1726118obb.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9onQEQpFmPFBgGpBMUIH+qObIsKXQmMsymejMnOMFK0=;
        b=oySkXKYUrSYE7GkWFhWb3CmqGqa0GhPK/ucYJeOy2htHSuKrVBO2pXokY0NMGu32Sg
         aq9UbKRQ/Aj9UFQrKtr++06fwMmFcD+oX2SDuAxqFqCDkJLN19fQNBDUZrk6pHnL81K5
         WHh/OsBcC/KSYmvhZQ/NuW7dMabdwMj0ocYQhq2aQpk6HBTiF2tOySRMiZqUqXNCSyTZ
         i5TTgiFd4LwtjDZ66qZtc29JNOHO7m9okFQthL4Uwx5QRLcJBWMySqDZb/OzTXViiQR+
         6A+3msegxist+nLdELC59aj94a+2NcFz7oxtfgHJnJJ45VN4hhcMNcfptbKmtFgPM2jO
         LDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9onQEQpFmPFBgGpBMUIH+qObIsKXQmMsymejMnOMFK0=;
        b=nI2AIQOMBlS8PCO9AYL3vUfs4XrHK92QdIlsFo0R9+DzuCB7RRqlnq5rP7aWfYnv59
         Hx1FONQgOmQbfVNGikTVMTsz+cbGNvemmasIfsNXLSb8z2MsUIhY2372+t756PEXV8xj
         8ocyIsP9iZz7lfSBZMrgA4LyF0WFMKLUuO/QfHmj65Mw0/BNHWOxyzAVM7jojUslWfs7
         FotGR63tYC1/7au19pN5k3ykMQ/85+EHxXUso9Ju0Wu6+b0ge+IQFgO1cdkqMFZhzXtZ
         PQV4FfY1yX5Qa4DL5/g5WDR6XW2wvw4UjaoA/LzWofr1VvQsLIaG3tyMBFuoBMKXpyk4
         kzGA==
X-Gm-Message-State: ALoCoQkECaRkzJpib1DoTWYTfevw0CciLuXmTdH4ZsbWrxlkxwBdAM1xHHH5jCBheVderOri/9rO
X-Received: by 10.182.27.193 with SMTP id v1mr33244562obg.40.1415041343650;
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si975952yhf.0.2014.11.03.11.02.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:23 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Xf9eLy69.1; Mon, 03 Nov 2014 11:02:23 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B1CAAE0FC4; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
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
