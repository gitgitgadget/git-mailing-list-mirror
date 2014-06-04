From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/11] refs.c: only write reflog update if msg is non-NULL
Date: Wed,  4 Jun 2014 11:57:50 -0700
Message-ID: <1401908272-7600-10-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:59:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGOx-0008BH-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbaFDS60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:26 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:44127 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaFDS6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:08 -0400
Received: by mail-yk0-f202.google.com with SMTP id 9so569372ykp.5
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wTATkpE8mf6PWgZPZ4dQkXdjr4PTTFslJIdChU+cTdw=;
        b=NJN6jwRMi4lKKw4+oJq/BYkWMPQdzSRd37ycjhBlpDkR9MdCXdC+xHlObDKqDLpo9u
         O+JdctGG5g41ynKXpoCdLb8jIbVQf+v6QwCj0Zmk785YpSqS2IRbRea3vduYmLalTQA0
         CfLni1hleQX7IWVGR4n1Nmawgj6e2d3BdFpOyTBVd+pUCzilghw2/ILxKPz2j3JstCZK
         nOAKAuT0Q5LYIF11PzPiD6akmnmXn498Apit6iX0dnMo1rlL60BlhmMMOoxOiqNotm2Q
         URRE5rwHL53z94K0BHiQmQMme/AOELBL0EXydto0hEK8BIf2AvQFP9wCvIoVxXaFGhjv
         kk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wTATkpE8mf6PWgZPZ4dQkXdjr4PTTFslJIdChU+cTdw=;
        b=h8YZbSkqOWImlOclpPc4EqGbntxqadOPulAwdLDybGgPLhhAmfKj77r0Vt5CjrDBBK
         JVcj6nnGfhnpxqniYaSh1dAwDTF0VVu7gDd6fHFfMYuhGVcs/swenFIStWAxTRx9kN6B
         tgmUuIV0J9WPvr1AqHjmbguP7NUY9c5+/iC7K1jX7Y3MRc/lWZv4PLNEKWMJ3Ri3m6Jf
         c6LvKaezwsPOpiFZDxlBqIlL/Dawfs6mCtGA9gDzRk663YRQ28pe9KpRJdpGfo43kl43
         sxUNB7mjJNK5G7Kea1ZOSiSNvBCG63CUKLjO3Zu5+ED3fERr7gXmlzCGzBFertDOUvvO
         KqKg==
X-Gm-Message-State: ALoCoQkOpn1ABcjqXi7zwZxjD/DK50FppYlGB4LPNLbpi+rFqhTi2io+FHfD8Lyd9IBJA0Jk3Esd
X-Received: by 10.52.144.106 with SMTP id sl10mr17952000vdb.9.1401908287114;
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si311086yhm.0.2014.06.04.11.58.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EF8102F42DC;
	Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A4303E072B; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250769>

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 +++--
 refs.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f2619e1..8faf5c1 100644
--- a/refs.c
+++ b/refs.c
@@ -3736,8 +3736,9 @@ int transaction_commit(struct ref_transaction *transaction,
 				update->reflog_fd = -1;
 				continue;
 			}
-		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
-				     update->new_sha1,
+		if (update->msg &&
+		    log_ref_write_fd(update->reflog_fd,
+				     update->old_sha1, update->new_sha1,
 				     update->committer, update->msg)) {
 			error("Could write to reflog: %s. %s",
 			      update->refname, strerror(errno));
diff --git a/refs.h b/refs.h
index 5748cde..1b6a055 100644
--- a/refs.h
+++ b/refs.h
@@ -321,6 +321,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
  */
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.0.578.gb9e379f
