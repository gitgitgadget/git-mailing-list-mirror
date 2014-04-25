From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 10/19] refs.c: ref_transaction_delete to check for error and return status
Date: Fri, 25 Apr 2014 09:14:45 -0700
Message-ID: <1398442494-23438-11-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdioP-0001Jk-0m
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbaDYQQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:37 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:39810 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbaDYQPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:07 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so632014qcz.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LaUcZnuMdA7t0TfNbpSFEx6coT2WisuvzF6JjNLiX7s=;
        b=Tb2vwa0J4wFXkFIidOF1+ZYzbsZfRNx8lIqDnkb9EOSLyf/MPVS2N+6wZDOBQdljdn
         GbT2G85d21mVsNV4swqIY2vjbzDTGULe74uyBvcH/V+ulRvgBrK3ueXO66U5MxeO9IZh
         j7FVwL38VfPWUx/biWGjuhJMjm9taARHF4N73poi3cJr/RYXh3vwboF1p31ZrpCQtzz9
         RGHwYosfHwwvYT6JiGOjVxnj7pCoDhShM0ooEmzicJp/eJ/AV6pNenYu8iAwvrEqp3fK
         NhlUROgfrC1kATe51wCUpkCZQSQvJrcsUR3Zo9qFMFXz433NVjHOpFZgpAllShayQ2J5
         pBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LaUcZnuMdA7t0TfNbpSFEx6coT2WisuvzF6JjNLiX7s=;
        b=DJ0ZVYUrs8JIJgIFwQKR2QNRa9oR0fU+mvi24Fbev8cahPLIWNYwQCtAv7KLYdCotN
         vdRfOwZF648cjdcd7dMqFeTWbjH5/gFmsqROEo1eHVZG12cE8zcU/QI6Q6eZgCyUYuvR
         UdiuuYjIgMAapRHsMIhM98IqX7z7I3bbUuu5A/CRAvzSPJYH5hUcJOQG+UMpHxrlpQ+f
         1otcUJff7+91efRY9fc9aeGcpgrSNdf9q64Z6PEZHUC9jwY6iYzsK/2aR9gXYTPChEo+
         wvZEYpJzIV8NL8DPm+TN9RLFVLCUt6VhUq+IC6cQ5uyQ6Z+La1Br0g1xsgCAlg6J2Zms
         l/1A==
X-Gm-Message-State: ALoCoQn9CsQTY9+RtM90EZnOBzJy3l4iMnverjs266DTGZwwq8pQGqdz2IIG+lgwkqJvcYFZzgcE17hE9TgGP62aAWGfXlooWKBIt0r/ZieL8XPyYVROk44UvhByrxrDrT+kXsRtKViqHA0R6OLU3AfFqgLap4VtWgvVCNvbHw/C2wHN29uXWiNELvniD2bbMfMFT/dBjmHp
X-Received: by 10.224.29.129 with SMTP id q1mr4780896qac.3.1398442504165;
        Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r61si1051900yhf.1.2014.04.25.09.15.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id DA54D5A4260;
	Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9E58CE0855; Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247064>

Change ref_transaction_delete() to do basic error checking and return
status. Update all callers to check the return for ref_transaction_delete()

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 15 ++++++++++-----
 refs.h               |  8 ++++----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5f7dfc1..a600ab3 100644
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
index 762be85..1557c3c 100644
--- a/refs.c
+++ b/refs.c
@@ -3373,19 +3373,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index e984267..8135131 100644
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
1.9.1.521.g5dc89fa
