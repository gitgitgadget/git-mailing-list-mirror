From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 2/5] refs.c: return error instead of dying when locking fails during transaction
Date: Wed, 18 Jun 2014 10:24:28 -0700
Message-ID: <1403112271-21331-3-git-send-email-sahlberg@google.com>
References: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:24:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJbG-0007Qo-Rg
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbaFRRYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:24:36 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:45221 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbaFRRYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:24:35 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so306976iec.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmZRPQ8jPHDaYb2Wau8axb2rkW9/b0TnwNvY/no7PbA=;
        b=LDYMv+zPLCLiq5CazRvG6vta6SFaswoMpPKX1j+l3gw5SDwmMIUsyiE8Xy21PzyyGn
         LViIBQx1zMZ+MsaBtPz6Hk/qYBnlaGVTfbCgMb5sXenwRVGvF5ThbMiQodviGMax1I5M
         BbMjmZNJzU3nUgjnXcI2uLh8a+aw5enKo7YIlUL8atX2xq5pXT6CWc9vLlp0FOLw25rb
         ni1Nth5smJzhRFbS/LRYfZacMDBGrmlYDU2nqrB2w/cyJx2acGGUWlduBGKdj+TlwZc9
         QMweDWH11663DOvHVITCQ+hLLCLaUmGcY47SCaTeikTx8vPrVtLd0If78SYIBB/U+A3Z
         Hftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mmZRPQ8jPHDaYb2Wau8axb2rkW9/b0TnwNvY/no7PbA=;
        b=PWGOvaENpKqGDP1TT2HTH08f9ks1yy7QultICU6FkFvMmESmyYxLI0rhz6Szb447+x
         cx2f+p3+AkL76kx77KjPFHR9VhASeo4lDQFY3URQVjBIejIp409AXpgyl8LiIIESF7lB
         IGJse5+d4hBMBd9+Rw+HEy8+HEEfc+1GvRMSfnk6xqemLZeCYrBO5Z4M9dyIGi3+7qiv
         tH3xDXCMAcqf7xlnGPRkhViav9Tcb4+r2KuacpRYWNL0qDdogugLwc+M7ogaKACUUMrI
         UyN2ChfX8Imu6aza2ufjpe/CivvzykmjrzsSVX8jdh8/Fv32CFENB6kswgX9cRvLEIp9
         2Flw==
X-Gm-Message-State: ALoCoQkNKkU/gQwBTdk7g+1Yr2i6WbqnOzxSSh/fpDlkiAoPhZ1bghs7liDiM+gLNth29431N/yI
X-Received: by 10.182.120.129 with SMTP id lc1mr1319400obb.21.1403112274855;
        Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si177093yhi.1.2014.06.18.10.24.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B0B9031C813;
	Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5BAF8E0424; Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252008>

Change lock_ref_sha1_basic to return an error instead of dying when
we fail to lock a file during a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 11dcb07..a644e7c 100644
--- a/refs.c
+++ b/refs.c
@@ -2195,7 +2195,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else
-			unable_to_lock_index_die(ref_file, errno);
+			goto error_return;
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.0.0.467.g08c0633
