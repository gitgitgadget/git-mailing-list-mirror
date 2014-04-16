From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 2/2] commit.c: check for lock error and return early
Date: Wed, 16 Apr 2014 11:56:53 -0700
Message-ID: <1397674613-4922-3-git-send-email-sahlberg@google.com>
References: <1397674613-4922-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 20:57:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaV15-0002gV-SF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 20:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbaDPS47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 14:56:59 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:56640 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbaDPS45 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 14:56:57 -0400
Received: by mail-yh0-f74.google.com with SMTP id f10so1666868yha.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n8i1Z5J7H5QBJlPSbW5xkWh8QmRk0abHstQxxzULNuY=;
        b=Evpay0yzBSTi9HNPMYoxanTCUbnVDm3wwZY1lTDpS2BbZtp5SBrsJQUiusa066ZCg2
         fomFsrbWvp+o6AOr7GNZXjeAvIMtw5Qo3wTuV3vT3bTVk4rXnXuB1engHisUnlxawLoy
         OT78VQeg131UL4NeckPUoOY8CibcAa6qzFJpqunNmrpsz8jrs/XhZEoNwfdTmMANrb37
         PVxA7cJXBCIWOSk5zQ2u4405DAG+wjzJ0LnZmqivmA7WUOxtZCfahwVTb88ZxXAbNDwT
         F0MhowUD2pxMcQem6t/R3TL0ycru5D1Ul2Csm8IoIkiGoSW4e+6gdaXfSSQR6TxI1xhH
         aL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n8i1Z5J7H5QBJlPSbW5xkWh8QmRk0abHstQxxzULNuY=;
        b=cYfDNev3roc7gtNIBz+8T74J4h4r9AN+VLGxjXFth9nXp8eMhJDeJN9jWNGX/2cVvn
         nch3bkI1qI4JDUhH5Z1qxRWRepwj1BOnoeuNl3lSISi0QZ46uHDIU/HF3BQdJW2hWDV5
         m/Y0mjAkc6z8p+YpLXB/E9E0Wl3Q++FLmk9WyFU67wMD7crWuvqsBomKi+qyp/yHephU
         3sse2ugP5EcXv495wa0UPE9IeVP0ZyCGZ/TNEYUtosJqhEqTcBSkV3oplLjy9A91Hy1m
         Fw3CcnmShrknflnD+sO9f9a62tgT40IWqMIdwBYLOGOMlkKsYxPx3WKL41Yf9UwWetg3
         cmQQ==
X-Gm-Message-State: ALoCoQnxdWZ25G9Ic0r1Uz//ALm9m7YnmGwzf5sEr4Nolk1jI/9PRVi/m8lK1vFSBorovusPF7MaycJWsQzDybzeoR7MIR28GNmp6gbt+se+vp7ADuDQ9/Zcn+e+0eoTqtcBYrZNiLUpVVQIeDDNCA3cTFmOQv1UfXjvzZQMwH1owPWUH3ytWeYv3biVdCuZjTh3oe9quApY
X-Received: by 10.236.130.101 with SMTP id j65mr439991yhi.29.1397674616605;
        Wed, 16 Apr 2014 11:56:56 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r61si3215821yhf.1.2014.04.16.11.56.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Apr 2014 11:56:56 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6E5BA31C1E3;
	Wed, 16 Apr 2014 11:56:56 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2F7C8E0B22; Wed, 16 Apr 2014 11:56:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.504.g5a62d94
In-Reply-To: <1397674613-4922-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246373>

Move the check for the lock failure to happen immediately after
lock_any_ref_for_update().
Previously the lock and the check-if-lock-failed was separated by a handful
of string manipulation statements.

Moving the check to occur immediately after the failed lock makes the
code slightly easier to read and makes it follow the pattern of
 try-to-take-a-lock()
 if (check-if-lock-failed){
    error
 }
---
 builtin/commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..c6320f1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1672,6 +1672,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 					   ? NULL
 					   : current_head->object.sha1,
 					   0, NULL);
+	if (!ref_lock) {
+		rollback_index_files();
+		die(_("cannot lock HEAD ref"));
+	}
 
 	nl = strchr(sb.buf, '\n');
 	if (nl)
@@ -1681,10 +1685,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
 	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
 		rollback_index_files();
 		die(_("cannot update HEAD ref"));
-- 
1.9.1.504.g5a62d94
