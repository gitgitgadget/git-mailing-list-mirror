From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 02/40] refs.c: ref_transaction_commit should not free the transaction
Date: Fri,  6 Jun 2014 15:28:40 -0700
Message-ID: <1402093758-3162-3-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:29:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2dc-0002CD-Bl
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbaFFW3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:41283 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-ie0-f202.google.com with SMTP id rd18so740482iec.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RnY1nv5KfaMyS7S0fa+Jw4P5v3sndMbqAWOfPssOEAw=;
        b=bZl1NtXIcSx+ml20pmcgQd2+bMr3wBFHJiQFF/Ceefe8GNb8OlrdhcvgNi+lNxZJCL
         uDTDdauTg73fwLj3gOLfycWcioa3oPMlJsBg4DFrpEsBlcpE7KPkryYjBn+ac3OKGqA0
         oPHuuzSi+znpVBU0HDs2gUGlex2s/e1L6XpjfXfNtj6VJ1tdnUtgjgdM3nUwi+KsnGZ5
         MTZyoXDb+e/msBaztHS6XsmpSpjwJjflx8WhjyFY7SvKAQUrf3TfQH6aMJb0HJaBfufb
         aRQQVZBFLiie5PXAKn1FL2DvDBKAOXVKCa2lyeqV4iRH4wc0BvaIjQpkkdfxfiCU4gfF
         bGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RnY1nv5KfaMyS7S0fa+Jw4P5v3sndMbqAWOfPssOEAw=;
        b=aNeni1onqQ0AqY1gHUV7MSPYLtJa31x/yKga2mDgPCp9xXCutY+xAzDO9Kg6Slt9Iz
         tp1Q7ReiTmdIxXWH65QAU1G2G0A97lXQe0SNzYwALKa/4dt7dEy3aEKqzERK4MXRocwj
         1Nz88KIBLfK/8W/EZuXLpHCVDxR0SvPGx76Rl0nV1Eb9G3m4HC8n47GZqqw0s1JxcYv2
         wrKirdNaTESkcqNV4BUdSieUaR5QlfncIK7i94E/IykorVqhvA4glunCD8+MfyodalAR
         Ch/iuOCl9VBpYms0uXq/j2LameV+d+AJJWxtY+YvbtAS39czJmkd46wXi1z/OFyTKq9s
         lLjg==
X-Gm-Message-State: ALoCoQkD2Gb5Aq9MdVD+EgR+PeSDbdx+5oAkJBRA0WttfIunaiKKQw1cp9wxgnq5PHXijxS9Qszm
X-Received: by 10.43.65.4 with SMTP id xk4mr4517756icb.12.1402093761625;
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id ds6si750426vdb.0.2014.06.06.15.29.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5FD5E31C61F;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0A8A7E047D; Fri,  6 Jun 2014 15:29:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250973>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 1 +
 refs.c               | 1 -
 refs.h               | 5 ++---
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..1fd7a89 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -369,6 +369,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		ret = ref_transaction_commit(transaction, msg,
 					     UPDATE_REFS_DIE_ON_ERR);
+		ref_transaction_free(transaction);
 		return ret;
 	}
 
diff --git a/refs.c b/refs.c
index 48573e3..33541f4 100644
--- a/refs.c
+++ b/refs.c
@@ -3483,7 +3483,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index a07a5d0..306d833 100644
--- a/refs.h
+++ b/refs.h
@@ -216,8 +216,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -265,7 +264,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
+ * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
2.0.0.582.ge25c160
