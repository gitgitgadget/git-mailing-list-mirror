From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 18/41] replace.c: use the ref transaction functions for updates
Date: Tue, 27 May 2014 13:25:37 -0700
Message-ID: <1401222360-21175-19-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxt-0003Vl-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbaE0U1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:08 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:50969 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so1646263veb.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CVddVsiJUOYYhqqcbq+8PBjR93LCs/XlSIU8qIdL2DI=;
        b=YS9bgvlPih3U+CU6BbGf3LISc2EWoWhhJh50NB6girYBXnoYKA/M+wJIz5rYy7SZAY
         oZ3IqX/uhDHnM9scTkS71+vCeN1QOEAlB4RdcbqCu8+r9zVFGwNvEuaWCFzMU88XeEGG
         wy/TI+1cSytP9vqLo6mv8mHhHiBTjqEBOiVRyC+zn3ZskRPQ12STt9kLyqSKarQG5+1g
         RAT0VK7TvOdkYNTzVGKljSKRNkO4sohAM1MV1ESgIJWs2H1mKtaORiAgCgpm1e2yOEO2
         EsEUPjihjmNv2TJQ2khtixu29HhbMJ1GVZ34wKiRLKndtAYdHSOhVCxcV67kD9N2g+eo
         3pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CVddVsiJUOYYhqqcbq+8PBjR93LCs/XlSIU8qIdL2DI=;
        b=I0S6CELpB9kXlPPCo3PXCRIXBjH9lg60kktt91l9eKjCysLNkfKFDu+YG9ms1jVMgU
         2UPlSGDkdR1fUDJS/jYbiS6kCS8f/UgBazogoHMwF44G1a46e0HiH7Gt6PZniDTc0CEy
         04H9iPmLdPJUOZxUO1N46Viaq3iVjA1czI6Dgpvp5FNuGKMKU0xF4//fPsRYSx9/NCXI
         QaxndI/QvarKRO2nAu6cOffBwqvL0cbuDc9sauq/q9Ii+ptvODQaldTVxp+dNRDekbIk
         /7gxf0MqnFndYVkH24QQAB8sGi9LiC0cC8ZvYkPL1kxZp+9jSkrGSz4wItI9uSMc8PqC
         d39w==
X-Gm-Message-State: ALoCoQkhaeHD9ZKsTreUodc0lfh3DqK+E6X/VrI1Rj/vhr1Bn+ISxIeDiWwSQhn2hzPv6HULaKCs
X-Received: by 10.236.209.97 with SMTP id r61mr13942047yho.33.1401222364611;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si1283651yhg.2.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 726AA37053C;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4EC0BE0DE4; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250219>

Update replace.c to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 3da1bae..f24d814 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -133,7 +133,8 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (snprintf(ref, sizeof(ref),
 		     "refs/replace/%s",
@@ -156,12 +157,14 @@ static int replace_object_sha1(const char *object_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.rc3.474.g0203784
