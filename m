From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 09/14] refs.c: only write reflog update if msg is non-NULL
Date: Wed, 18 Jun 2014 10:09:01 -0700
Message-ID: <1403111346-18466-10-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMk-0007A7-5f
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbaFRRJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:29 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:57169 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so299964iec.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l21dl41PvRxvu7MLj7pvLqrnptu+uc3b1U4Ln0GqUGw=;
        b=ZSvbE7GgRxATwXqFdyQQ1Wh+sMdcjo79dJpIqnPL/wfLXvKjelu4mWxgWtMCSC+RGq
         pF06S5ppeI80/hRQXNGo/s33SWATypRo18NHbUA8Fee7k/TOCYGUQa3/sYCT2w63LNfe
         yosfZBbUCmBfAtC8bOT7ZgM9eF/DznkTia8YCDhMu4hOdBX+LI/oyGmnYLkOG5Yf9ekW
         YYkZqfVgzSQzrjKEK4gpJnRBOvYQDh3Lk59NCQEFi1mEeStOlNooOGm6JZMIV5NYblj6
         u590Uxr9mpaoWqwWHxsHN87ZOux+0ccmuCLmmopR/6xfp8tvYFNb6v7thhhKTGKWifP8
         +X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l21dl41PvRxvu7MLj7pvLqrnptu+uc3b1U4Ln0GqUGw=;
        b=mVBx8pJoJBygQdBngruFxsfLkaonlqi17WzaCz9wSnAWqPw87VOHlei9B1KXjM5U8j
         8oUBRNRyIb9ys9agNZOQBGVjnmFPgE7NxqHO1rxQQ8XaM0qwxUgVVgzehW/09jOsvar6
         X4Kq/iDes/NYXJP57gV/swjtiX9P3Te0uzf1cXEq+sy3wH4r5oyUdqbXkJOjWWqdsarX
         z2eEVjTvVCCpkRv2YXcx6cRnKMjPv44YnSnBaxFBui7TfLzrXLumrRFZYGgCeR9GN/jl
         Eu2UqhaEP2b6VhxyinpBr9Z52spj/b08wqUPetkQeu4Ahd6s2KXUduNdeK9zrAhBkqdk
         yXQA==
X-Gm-Message-State: ALoCoQn5wVs9Gpgl2tVM+0JrhG9uUNjYj0LThMy70W33j2C4kLPK7Tn+yQ/bJRlGVNzk6B+7/yqz
X-Received: by 10.182.60.40 with SMTP id e8mr1368215obr.7.1403111350154;
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si174769yhm.0.2014.06.18.10.09.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 05FCB5A4790;
	Wed, 18 Jun 2014 10:09:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AF29CE0F08; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251997>

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 +++--
 refs.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index c33d19e..d6df28d 100644
--- a/refs.c
+++ b/refs.c
@@ -3763,8 +3763,9 @@ int transaction_commit(struct ref_transaction *transaction,
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
index f14c8db..1d7906c 100644
--- a/refs.h
+++ b/refs.h
@@ -337,6 +337,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
  */
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.0.467.g08c0633
