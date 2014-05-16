From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 08/44] update-ref.c: log transaction error from the update_ref
Date: Fri, 16 May 2014 10:36:56 -0700
Message-ID: <1400261852-31303-9-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6u-0003E3-9S
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144AbaEPRjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:44 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:49148 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so17442iec.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KdY9P1usf3TdFZy+m+Pl3pHY1is22aaNhPln5LTws6g=;
        b=CpW4TUl13to510xCOi76zsd7UMLYxC7NJePtqkeiDjOdFl0XDR59Lp2CXl3YWVEKmo
         KgpMjCVKDIb3XEVrX2OOPRUFwq5diUbgpNYoCAZd/BtuZY/rZYN+bv+LoDm7lGcm5S0w
         aVAEhbTqoTwyX+R03SQpMjLxHkJHz4t9bnmUtsHQdu6T3lfGRDumQRi7+Ulo2xRWtFAV
         BhnCL5lhMuWeGcpdlu7YqgI8E/K2zywYFr+OTFsqCEYjVYPSwo0iwiabVHHuB9ifR1Hn
         1V0kw1oH+/Xbpvh259CW9466QkWGnOj+gmtLQUR5BkRMKdqZgDrzR27J6waj/UflKRnh
         sqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KdY9P1usf3TdFZy+m+Pl3pHY1is22aaNhPln5LTws6g=;
        b=kCa2Qel6jwKn4VcalzJNlU0a3Z0mlQrP7vbqwAzJPYbUP17HPHRDdhJGPfU8SAbqjb
         JabxrUS1DcJUJc96UlMpWKkfkeu/Xn02tVPafDTTitem72H+OwOTOZEhk5H+NcKV1v/G
         gmMXEmpQtKcj/OCicqyR6Cy0anp8fNxQWm4dAXIVdhZcD9rNGGCkgh29qRGs4dvlbOo2
         InDkpTr7+4v5g0rNraAyWY7pB87g3iz0pHWAZN5eLjIW4IQFxGrCGlpP2e3eOnPq/gIE
         OZHILVi6Es+tm33XKZ3qBatiK/3PsEBNH2audTBPTs42bTN+B5MJVPs0l/GdRnfX0YG8
         XAkg==
X-Gm-Message-State: ALoCoQnWjYku4hJTg1aEB7bQWxxgq95qcD4eYCe/hm06jG0GOYJgRiTRoR2kh/RXNDcfmXVejX5f
X-Received: by 10.182.58.71 with SMTP id o7mr9059941obq.3.1400261857075;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si441215yhl.7.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E60B15A427A;
	Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A202DE0B9F; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249392>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aaa06aa..207e24d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,17 +360,16 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
-		return ret;
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.0.rc3.510.g20c254b
