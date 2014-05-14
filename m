From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 08/31] refs.c: only write reflog update if msg is non-NULL
Date: Wed, 14 May 2014 15:13:07 -0700
Message-ID: <1400105610-21194-9-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhQm-00064m-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbaENWNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:38 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:58575 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbaENWNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:35 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so47532qcv.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YSyQ/eKUQsbuEXgI5Ubtl3VLBHwG/KWebFFHSbYvtfM=;
        b=VcANx7btHeWxIwvgB9VdIgKORAXOmUVn/kFaC/HzetkSK9rfL3TlIE94GEno79htyD
         Uu65Nt29+CpV5uSzMXz9yB40wrs/bjD93N/hSH7ezq5OZvNMYij2tZHMV/AcP61D7Eoh
         QNWdZiI4LKNWnOwDt3nZ9bhweAOnQhKSVzeYm9HGd80YAc5ziRWAco8FncyD+BTqu82t
         9yY4Lm8hmHU1cMssfVPRgrA+Zr6MUafgrz+JjQtEJP3oawZ0QUc/ldEnprZVeQPU8fs7
         EX3wUIG5KxVkcV8+QRNOYkLC5DC3/Lqzff4MjTa1TSDMV9W9zeTGkyqgK4PmJvGFQ9TU
         aTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YSyQ/eKUQsbuEXgI5Ubtl3VLBHwG/KWebFFHSbYvtfM=;
        b=G31ariF3N+GYzAtm/KpB4aDnrsAIXiaXLPEYZSGAkaDko5Nu54kURGyZtvFH+OO2ab
         sxyK2wz1LUH6oa0xILfBMuIwe50Hvxz+OOoJKYu8uLJXM0rYzr9Ir5dkG0oXwfQeX3+U
         gsMAxeZqmpUNvBhFHVaBEU6jb1o3Qn9js7+23c10YCZ9YwobrsHt6LFXO2KllOL/60d+
         xP4oVhqrMITbAlV5E2vCoLw3qtSF6jmuEO2te0BRAeBKdZs+l5MjcL08BDLlVnEhmTmN
         pUBaGXiwQdFIKxBp5ECskdOsrY7JiDtDiusyktlaG1AXZcr06vC9SvCq/lbeysOtZZ2B
         WWhQ==
X-Gm-Message-State: ALoCoQlER6W8NhGkgmffkLC7YnWytFGPr8PHl/BL7kdKqD0e9EE9EtXYY0Em1NLowk3PHDaYDJX2
X-Received: by 10.224.147.72 with SMTP id k8mr2412754qav.5.1400105615132;
        Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si152796yho.1.2014.05.14.15.13.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 02BC85A41E5;
	Wed, 14 May 2014 15:13:35 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B0957E0973; Wed, 14 May 2014 15:13:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249009>

When performing a reflog transaction update, only write to the reflog iff
msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
an update that only truncates but does not write.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 8 +++++---
 refs.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index a8b583a..a3f60ad 100644
--- a/refs.c
+++ b/refs.c
@@ -3625,9 +3625,11 @@ int transaction_commit(struct ref_transaction *transaction,
 			    ftruncate(update->reflog_fd, 0)) {
 				error("Could not truncate reflog");
 			}
-		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
-				     update->new_sha1,
-				     update->committer, update->msg)) {
+		if (update->msg && log_ref_write_fd(update->reflog_fd,
+						    update->old_sha1,
+						    update->new_sha1,
+						    update->committer,
+						    update->msg)) {
 			rollback_lock_file(&update->reflog_lock);
 			update->reflog_fd = -1;
 		}
diff --git a/refs.h b/refs.h
index b1b97e7..c552f04 100644
--- a/refs.h
+++ b/refs.h
@@ -273,6 +273,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
+ * If msg is NULL no update will be written to the log.
  */
 int transaction_update_reflog(struct ref_transaction *transaction,
 			      const char *refname,
-- 
2.0.0.rc3.506.g3739a35
