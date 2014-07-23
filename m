From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 09/15] refs.c: only write reflog update if msg is non-NULL
Date: Wed, 23 Jul 2014 10:03:49 -0700
Message-ID: <1406135035-26441-10-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zxj-0004JU-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbaGWREN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:13 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:33895 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so418583ieb.2
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0T4mvup3xz94PCK94phO/sJECRHWS6N81mgZBQVvQEE=;
        b=MRvAydl9P6Vsw/WjTUJjdB7vRamFIs3UuK4I9HncZmROHrVEAE+6FSG7Lj+RJU80N+
         0Pn23+PHrrfGokMyqSf7PPrwM/YbfJlK7Os6R33me4mcHXpvESA3MzFgh8bYAVMlhAPD
         T735YIkEG8BeDeAVH9hrA38F5mkCjYaLN9TIJWIfX02qc8ROgNoQFeCW2aoxks3z/BBI
         bgnGam14mkjDr4TdrkJ7WyPjPulcjmXfqRA1rXBI2lzytPN2D8s84K7rMAuDwnj/9VKO
         uIq17ydN1i3fGFK0Vg4p7Wn/d2eAIOyfxu/b0S1qF9Ep08Y1I1MlaZ1Xy4ZftvTSzHpX
         yS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0T4mvup3xz94PCK94phO/sJECRHWS6N81mgZBQVvQEE=;
        b=KBYEm8HNXIiYEv0FF/8oxlAcfzIDEIOqndFHt74bRSWu+34osA24RqpBY8VwRZ+jMu
         mk6DAZTy0l8Fa71g106oe05oPJCNxy6w0Lp3LoOBD9vrVaNFHdhM11EBq9MzCgnXRBEO
         w172UJHG6cqJT9CRxHv9e23lj57E9g6x+X38we+7rODgC9ZrJo4tw4sT5OEUe6baOfKe
         vltKzA0RUnzY7M/WGOVRFqpumc5bFmIx0lLmn+bmN/IIBuHxBuraFTZXOix4atJwnZkQ
         XWKHoMIsF02ThCxeHZd6xWbuAMd/nd+6k6mZNYDwdbOr9jG7ZOTULjLYyQoARKTHB1Hw
         t7yw==
X-Gm-Message-State: ALoCoQl2/ARC8ck8Q13nxXFnnSe10iVt1c/Sou+5kG6/5l0I7DzZeGia0EuGhFCdSmdSiaZpnjtf
X-Received: by 10.42.85.142 with SMTP id q14mr1460894icl.16.1406135038890;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v44si487009yhv.0.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B6C305A4308;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8DD42E0AF7; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254082>

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 +++--
 refs.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 181c957..c431088 100644
--- a/refs.c
+++ b/refs.c
@@ -3769,8 +3769,9 @@ int transaction_commit(struct ref_transaction *transaction,
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
index 66cf38b..a8b7047 100644
--- a/refs.h
+++ b/refs.h
@@ -330,6 +330,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
  */
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.1.508.g763ab16
