From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 39/44] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu, 15 May 2014 10:29:54 -0700
Message-ID: <1400174999-26786-40-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVY-0001sq-RO
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbaEORbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:46 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:44988 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so290477iec.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YPBmdk9RwE8eJUkVoHg9/Cwx+VL+UXyAND9CCz6gQCE=;
        b=A4CSlz8pSXSEc+MfTTASNEEQI+jUu1jCNDup3aVsoOiqpXrvagNU6fgWVd+S5xIJ15
         jFpNKkVA1AdQmjgAobf0c8Qktew5ZzKj6dohcuTq7setIWvhZpYEj8cUV0y9moyyb8lx
         XOlD7bRv2FTOZF6GcyFoteWpTY/6r+oeKATlTsL5amKCPoYwQojT1CneUWxplV0XcB6E
         g9jCKXb8Gt11VNcdrBJwbRJfZZZEKsCkrv5xtLZAA/bqM9Gnh7K9d7yKrLYE/nt62vYY
         8yBMWcA0DtMCYXcRz5vGztVpmFmJb5Pia6tpv30dMETT77BcOAJa1zOyNSgiJh7EnCeP
         CS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YPBmdk9RwE8eJUkVoHg9/Cwx+VL+UXyAND9CCz6gQCE=;
        b=iQY+O+Vmh+NNoltpUjruWnj4yKqD4+LZVvvzMb/0GQD0XrJiUErW3ChnTMpoR5nS24
         Q2WMEFKqGfwJaorsCT4/u3EPcn96MldahuoJBNd8cpBSF1xze1q2Nen229Q24zJuQOYl
         SmyQwR7chZyXY/6bTkW9JZGLlPpeVH3I8QdBJBuXRgmdF4TvCvGi5XzNuyexazOefKwa
         jCgXpoybn7V9fwV4RurPsPTxcGtpLB8yB8lNwRqr7TzV4/gAGqZVokgAobpA4wYkgHzG
         Fhm44NZRuCwjVSWywDj+v0qOobCIeDMJAsTsTg5IPvzgjhneHaEdqCd65CwbtoM2HyzW
         hJkg==
X-Gm-Message-State: ALoCoQk5ltkbypg8bJnf2yeRri/2m0NBNk9pVhnLlV7zqsNi1nG8s9E7nGVXIRZMCIr3JArpUI46
X-Received: by 10.43.67.67 with SMTP id xt3mr4690687icb.23.1400175007460;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si272585yhb.6.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4DCC231C1CD;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2C8A6E16A3; Thu, 15 May 2014 10:30:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249147>

Move the check for check_refname_format from lock_any_ref_for_update
to lock_ref_sha1_basic. At some later stage we will get rid of
lock_any_ref_for_update completely.

This leaves lock_any_ref_for_updates as a no-op wrapper which could be removed.
But this wrapper is also called from an external caller and we will soon
make changes to the signature to lock_ref_sha1_basic that we do not want to
expose to that caller.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 79d95db..53fdbd1 100644
--- a/refs.c
+++ b/refs.c
@@ -2044,6 +2044,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2135,8 +2138,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.rc3.477.g0f8edf7
