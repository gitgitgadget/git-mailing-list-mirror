From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: handle locking failure during transaction better
Date: Tue, 18 Nov 2014 17:13:17 -0800
Message-ID: <1416359597-15481-1-git-send-email-sbeller@google.com>
References: <CAGZ79kbH=pqSizhUeuiCeYXZWk015K49Pj0F5pPvkOTqg4PMuQ@mail.gmail.com>
Cc: Stefan Beller <sbeller@google.com>
To: sahlberg@google.com, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 02:13:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqtpr-0002Ny-6c
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbaKSBN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:13:26 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37020 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbaKSBNX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:13:23 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so5064485igi.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 17:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3N/JoNNa3TQ6839ZONlzhevgJSoKaw0Q/KTXnL1qB1Q=;
        b=H43TKKLws6kRFyVqWBXyXATLjkXXLqsRD8VfrlzuJRp6la+Wm82l5a6yPo63+IhLkh
         bBv2Kc/z2eZNAiymmnQf+BwXI32PYzaMH/Zj0qkvr6cIfFe23SPzarZ3ge9qBiei0gj6
         N1DqwI9XngBLvQep+bVXNjIWVKu9vMifVB41LfOsOp1J4eDeUd3WrXndcgJSgNA3A+P+
         X07D3ZGCHXEwpKHnjuLwCfK4EzfB9yUMEjJLLzSwQh7qAwvORG7YjcvrrcpRuCjFSwOZ
         z2Mc4rv66OkxWLEXUEuY/1Ds8O2DQ93CEbIXLiBVa/VxHv2/aQGojm+1teSw5jew4XRP
         /sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3N/JoNNa3TQ6839ZONlzhevgJSoKaw0Q/KTXnL1qB1Q=;
        b=P6uDZXU39vBsRx5ug+bJ1X2M55IdUpgTWahFGqb71SuDP9TAFw1bHSVdfkCRDkEnCo
         oLzHSJiJZjQYbkFktVh+FzqYc2Ty+cj18ZOM4R1lkuWevVQd7pc09n19ulfI5zDVQIR6
         eJZKQWl8t0efpDaxeHR7w83q38g9HN/AmG7LPfig0Dne0E3xoj0fxaCgpkg0ebfQ/zTn
         crzTYSuRruGiO9a/3b4YZo5yIY3nLE+8+77LD9T4cXV0Qrp3CrYNnU0RqbyIt1GIvqjI
         iO9Mxfa9kJTsbu4yfkIPtKivbwj8iI/fOyQKXlqxQMaib1jW8GpXPoYQ6+LLGbb5bIeD
         mH3Q==
X-Gm-Message-State: ALoCoQk3A7Ipx9W/nUJPVCYKmEZX1BczQyO/K2iVhqDS2OHrJesiqR2WUP62HRw+IJFNyvUXWbt4
X-Received: by 10.42.51.133 with SMTP id e5mr334356icg.44.1416359603148;
        Tue, 18 Nov 2014 17:13:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d130:77f5:c37c:28a8])
        by mx.google.com with ESMTPSA id hz2sm60602igb.15.2014.11.18.17.13.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 17:13:22 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <CAGZ79kbH=pqSizhUeuiCeYXZWk015K49Pj0F5pPvkOTqg4PMuQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Change lock_ref_sha1_basic to return an error instead of dying,
when we fail to lock a file during a transaction. This function is
only called from transaction_commit() and it knows how to handle
these failures.

[sb: This was part of a larger patch series, cherry-picked to master]

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..0347328 100644
--- a/refs.c
+++ b/refs.c
@@ -2318,6 +2318,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
 	if (lock->lock_fd < 0) {
+		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
 			 * Maybe somebody just deleted one of the
@@ -2325,8 +2326,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
2.2.0.rc2.5.gf7b9fb2
