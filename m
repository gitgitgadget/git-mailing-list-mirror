From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] refs.c: handle locking failure during transaction better
Date: Tue, 18 Nov 2014 15:17:19 -0800
Message-ID: <1416352639-10150-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: sahlberg@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 19 00:17:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqs1a-0000nJ-Ua
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 00:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbaKRXR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 18:17:27 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34093 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188AbaKRXR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 18:17:26 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so4714481igb.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 15:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=X0mEpiB3wBVxqvB83kZMe6mDb4JwEVk6eezq0UVp20A=;
        b=nDJ5QBj0RdPgGXhijtYn+KbGdCy9yDJBZEnsuc2LoWUFRlJXRRRj8KMAlsrkqvvO5G
         tzMbEt9FdkXpcFQTzrVfq65UfKzmKg0Jiky1whv9JE1xOOYKUjDVjRvbmOlzOigU/1sl
         rPeXoKqzbDQr1LGrhRCgrjiN46uGJcOTI2/eqp6MgG764rOI9mRFptdgtLqcuMS6+GGO
         2qp09iJYGHXN7ooR6Z+TeXHSMXSqrWC1w3woHpj+qyXfesYDvmAJy0/YvCDsn+vadOev
         qL4ALwJ0cv+Jt8Ya3JyVvphfCalHs/J1548C8f5fHU+PBAjokzz1FU1gqAJt4b1scmwi
         CTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X0mEpiB3wBVxqvB83kZMe6mDb4JwEVk6eezq0UVp20A=;
        b=hpT8UnkektMtIN600fGUb7lmOcN5b1s5U0BhkvhHCsysHV+XCkNtF7T2NtCVntN98S
         uuZRBAous4KVO1DAKeGaSgMnt9WJGmypkwaQyqjFr70vN7pwNE6UM7ycvsvrc4jsgUhE
         ouWljbCylBzcCCEcscri8BH5oq9d7Aa/bHlHrBCwqUyMsWTs14kXpC8ZihnWcVJqXJDH
         9H6cydVnluOKiLowZQm4p5/C6cttMzfaeYMLjtbzif+CnJcFDNo/6ySqALqqEaxIVrhf
         hVMFCXZcSxlf3ACU+r0QiBBIOKJGF2mviKoRNCuDY5eH5r94hROTnNOqXNysCHA+PpEb
         MxPQ==
X-Gm-Message-State: ALoCoQkF93lDRJUK/0yYdr5VSfawOcXtTkm8ZRIzEQK/4y3zImgu02HvZ000/Brj8UuDKMu3wLwl
X-Received: by 10.107.138.131 with SMTP id c3mr36345134ioj.0.1416352645837;
        Tue, 18 Nov 2014 15:17:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d130:77f5:c37c:28a8])
        by mx.google.com with ESMTPSA id sd11sm366264igb.1.2014.11.18.15.17.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 15:17:25 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change lock_ref_sha1_basic to return an error instead of dying,
when we fail to lock a file during a transaction. This function is
only called from transaction_commit() and it knows how to handle
these failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Cherry-picked-to-master: Stefan Beller <sbeller@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
 
This was part of the ref-transactions-rename series[1], 
but it makes sense to send this one as a separate patch.

Thanks,
Stefan

[1] https://www.mail-archive.com/git@vger.kernel.org/msg60604.html

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
