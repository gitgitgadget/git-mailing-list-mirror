From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 05/42] update-ref.c: log transaction error from the update_ref
Date: Wed, 14 May 2014 14:16:39 -0700
Message-ID: <1400102236-30082-6-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgcN-00024e-Qa
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbaENVV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:21:27 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:50276 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbaENVRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:22 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so429133vcb.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jXbsvHJ/gmcgQ/9Up2PqscBimrNcHF8CrhYcRButy9w=;
        b=i0vtK9hxK1DC9b9PsG8sU7UFE6i0G0Xvq7P0xYOvozF7I5KlBqKvVljeMh9byGNBpZ
         LIfY67Qci+pgzKi/cjvu1QyCgHVnDzWmb+Y9SCrZSL5LDxb8LlWQ+lVeirTeqMOGP/vg
         KOgimyzzREbU7IEywrZSLb9iv0rj37EQ6lhmDf1qbBADSVw8MsnPdggnkzC5oC6WIot0
         vib7cxmqC00WeqiwTWhxQ5HfcOMN/4ENdKYJTsxeVAsPtCI/IVCwRKoGCGFWQQjngx5T
         R22N53pS1k1pY99zNOBrWEG9L1KF6lMlT4cGc7YZBuS4TOJWfIt8BU5n8Y3BUB9DI0Pm
         rBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jXbsvHJ/gmcgQ/9Up2PqscBimrNcHF8CrhYcRButy9w=;
        b=DwcLUEXx3sT/0cmYvdMruhgAGpGzEt4bU/oZpf6WmctnO9z2Rnp7boaNJKdExKDb5S
         OcCKDX18HLR/2QlJ65sZCQzmN0mfR6f6DkhYgSgVCTb88Qv/XmVI97CL47OdeMhRx//n
         PNxgzkca7TUsS2NJovsSW28eaFVcE/HPh6JpeA1XnfMxccM9eNtRsCFK2KNmeLbaTxRh
         aGhigAXeYNcrRoxJ4GrjZ7/D8PUul5/1u+6MF9COjGXmerUI9Y8t2AgK7CUkUsXXA11i
         JnBHm7HSkESpNmzh5+LcpwdV0s3eCs45UU/9rWOv+41PWIcYqCXhI+knz21VjG33p1r0
         8VLg==
X-Gm-Message-State: ALoCoQneopq0UgVFxGY18IlUPMV+NPJ9h5eCY2x6a1Z9tNZaX9Tt0oOV1PTmq7pd21tcQAixWbGD
X-Received: by 10.236.137.50 with SMTP id x38mr2818854yhi.9.1400102241227;
        Wed, 14 May 2014 14:17:21 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si146325yhj.0.2014.05.14.14.17.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1B5935A4292;
	Wed, 14 May 2014 14:17:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D65E9E0973; Wed, 14 May 2014 14:17:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248996>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

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
2.0.0.rc3.471.g2055d11.dirty
