From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 05/13] refs.c: ref_transaction_delete to check for error and return status
Date: Mon, 21 Apr 2014 15:53:23 -0700
Message-ID: <1398120811-20284-6-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6b-0008HG-GB
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbaDUWy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:27 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:45235 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751AbaDUWxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:41 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so822763qab.4
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oOBFxUj/HYtrdKIL+CLz6FwR5t04Zw1UO7pnAKfK28=;
        b=QxhOAL3ps483xljf1rOfAoN+AvONLaJS/Xv6Lg+NxNvqOjPIYc7YzF7OjQFETJd397
         LSr2L1BRBGNdaOnpvgcAIdOKUO55lmo/O65Du//64nvyvGO+uzbnmPaGZiRBCeZmepy4
         +njYDYlRfdTwxTwqzPk58GZ4WEV3fzGJtx/mDT2qOFeKsU9Yu4WGpMQ6AjXsQfuwz2E0
         aQz44w4prUIJfSwSsUsmypkad2F1memqfDWy6s2ByZ8G3KVh+cHuEleOk3cYYQ6AUKe7
         P7TC8aOy0StCq9qc6Q3BaVONV9GYgViD5v2lPRgrlfqCLQMaNueRZOEszb7+GSgQDG1m
         yuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8oOBFxUj/HYtrdKIL+CLz6FwR5t04Zw1UO7pnAKfK28=;
        b=fiIKf+l6AwVS81+Oyv86NfPtFemr8zjHdw2/qNZSo0XT49ERz2PJ1XFkBZFAerWd/N
         tJ4OVPehglhZLiDlHtm5E0p9TI/xFQ++mcfAB20AMku1lQb3nu3T3JLWsgtoOwVIWYoz
         VoX3tQiC2LitlDJ2EYF+snZmlCbSBTPXZOyxKyWLItgmTcq0hsHzHHpc4KDxBfxgrdLv
         wOUI8imRCgFFAVWr+IAzuUT56u5T/OjYKQmH/Zbs9BI4SZAo4DwpcIYxHEAAupOuUlfV
         PmWro9ZV+UVPmxDCLhERuYnOBh9YCAstAlTsZ2v7ZxNeigz7vCV3za6GG/ZD7tmH6RTt
         St9A==
X-Gm-Message-State: ALoCoQlCnzAcP7m/7DxQw3N5/dh53/6I8YefbC0993c+klekugwjZQrz/tFJ2GkBlsojjsR9oPYv4/NlKNLcURa5L2e+Nqb0jY7sJY4VXUkxP870f841KzvR/Mzi6d3Gw/aHLu9QYvT6WVykqa025DUB5141aMG4yj93f3DczZASI+1wBPgQCYMKgnMtUnEF24wfkgPSMgaB
X-Received: by 10.58.178.137 with SMTP id cy9mr22367746vec.34.1398120820845;
        Mon, 21 Apr 2014 15:53:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r61si5369493yhf.1.2014.04.21.15.53.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AA8455A4207;
	Mon, 21 Apr 2014 15:53:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6AB78E06AA; Mon, 21 Apr 2014 15:53:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246667>

Change ref_transaction_delete() to do basic error checking and return
status. Update all callers to check the return for ref_transaction_delete()

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 15 ++++++++++-----
 refs.h               |  8 ++++----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7d1e0c0..b65445d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -257,8 +257,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 8c728c6..878948a 100644
--- a/refs.c
+++ b/refs.c
@@ -3366,19 +3366,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
 
+	if (have_old && !old_sha1)
+		die("have_old is true but old_sha1 is NULL");
+
+	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old) {
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	return 0;
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 8799e15..7050da2 100644
--- a/refs.h
+++ b/refs.h
@@ -259,10 +259,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
1.9.1.515.g3b87021
