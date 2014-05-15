From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 39/44] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu, 15 May 2014 16:15:36 -0700
Message-ID: <1400195741-22996-40-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4t5-0005L1-Eq
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbaEOXQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:28 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:49705 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so719462yhl.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l8QM0ormfVQEWXmcm4H+t+Fkh96a4pUCqat+DePLv+E=;
        b=ogifvGtEFbBgxTYdlR2/as8DSD6kEg+dW8yYRdEf9CDj0j7HZ9R1/618RpwW6XeDxT
         qM1hTS8o/uc9qWoedKjWLpcpuCGP7ZucJ2yeR2XKeobaRNso8MuW0f0KnSguPcACI3/2
         sKcdoog5DfNmaADz6TZK+cbzpqwcyKxLhQ7lf7uMxWSdsyd+1AQ/w9BoBCDPG06yFwf5
         06c+6YBFHx2H+2BIPKwWXyzvpjKt1JBAt6Eh7I2S06VK0Jt+plr7aiNOmVSXP3rbDOhv
         z4rJC9BKceuF7LKaK1Epkj2dFXR3h14qIjZ/+vDwY8ST0uHMIi1IhkeLfRoKTui9/mAA
         JRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l8QM0ormfVQEWXmcm4H+t+Fkh96a4pUCqat+DePLv+E=;
        b=i1Lkl9LBOm7fpR3jpNNLb7wtjvd8nt9bLo753XP7sUhw9DNNB/UvFBlnLOrPIyDDC5
         yqJInxKpAOeyhFheWje0cHNjw2qOOehjqdunJ6Ardo3T5CuKvIbSUPaEWTXkGbS0L8w+
         9DusikWaDQGTkIySgu6nNyfU1I/Qes7xABvuZ7gjkNR2weUUO+lsMqDD1v9cj5BCH0Z1
         AOGOOPLfnfG+e3Sg6WsRBUyJm3Tf1aO6xkLfG7+TZh0s3kSzFbtxAqQtJMe5Oi7rhrsv
         18tyxlrI4jWh950hJWuXGBhCquQKtVCvpFofzNzgByvnnf5NMjiYhlCChz6jZ8n7GjDs
         Oi7g==
X-Gm-Message-State: ALoCoQmfB2hhYX6uMoQ7mOIdOo9rkQruLYqk24Ehq0X6pI3/cnKYvJ8ZLL1jCN4U7NXJfW2smmX9
X-Received: by 10.236.123.68 with SMTP id u44mr5810523yhh.19.1400195746248;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si318645yhk.4.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1E6F731C1CD;
	Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EEF95E0475; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249233>

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
index fb36cba..baa620f 100644
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
2.0.0.rc3.477.gffe78a2
