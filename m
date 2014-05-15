From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 14/44] replace.c: use the ref transaction functions for updates
Date: Thu, 15 May 2014 10:29:29 -0700
Message-ID: <1400174999-26786-15-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzV6-0000tR-M7
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbaEORbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:19 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:49179 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so637290yhl.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y92R6gIlt88q7X5D9ErsuqgHbOIUUiArax/59UuAptI=;
        b=UgJxPAlreo6xud/F6+MUD9CiVgjis8KxNgUnZO3mWfRC88qgR8b3DRPdjkCKZO8Lir
         +2howzeqxByzg93kjLn2swUA3OGG/yY0zGrqJ5jAWYLq/UOj1uo0ON1nzRXAZRFY6bwF
         rNvp/fzafhORivKZGVhPe5TkqPBzsXI18pN2CPD0P2Vgdm1ucLf5iL8Bl51sc44BUTH/
         kBdW2jmuozDBzJwISmtOLUF0VVRSJi7sY/gvlVD4lr4VwqOznlL/oNwkdgHD4cjnOXZW
         BCGypkX4vxhbH8ccdFpnny1n3gq8K9a1OEfjCMY5dMcTvdRDL3APjaBUUMlCPzhWXftH
         bndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y92R6gIlt88q7X5D9ErsuqgHbOIUUiArax/59UuAptI=;
        b=EhhP1Oox94CexFRHZ9plX6RmRhzpK51s+37tzR0traD78+XigTGTE93SvhilaBGWzP
         sH+YuFV7obO1J2R+1Z29DlNHwfYO/NWGddZeSu4yqDrENWkYJsJCoYnvyv7iX5kftz0u
         Gkh8dqDMD0zkN07+gw+LPcbLRJtBXWIcOKyYChn5edmtONYcMnNhiZ3P7s84591yZggQ
         V7yf2hZ/57irbqPbKVKGHGsjqJ4cXFhhbFjagMjLgagbZCLQuyV84LcvAkWIJWfA/2lc
         1QAcMoMVAi69r8qPPI9D6EdpWUfQMZ0+F9tSOYiUtkGTCPCkH8jkLvgcXwouoT9W1Dlr
         srWA==
X-Gm-Message-State: ALoCoQmp5JQNlTK8tqPQodf9B0uWEWIeTHHCcPuwh3189xEzPgkuli8Vc+5nNKThIuokaElaHocc
X-Received: by 10.58.168.137 with SMTP id zw9mr5878172veb.15.1400175006503;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si273163yhk.4.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5431931C2D7;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 12CB4E1832; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249139>

Update replace.c to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/replace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 3da1bae..ee34d5d 100644
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
@@ -156,11 +157,12 @@ static int replace_object_sha1(const char *object_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
-	if (!lock)
-		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref, repl, prev,
+				   0, !is_null_sha1(prev)) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s: failed to replace ref: %s", ref, err.buf);
 
 	return 0;
 }
-- 
2.0.0.rc3.477.g0f8edf7
