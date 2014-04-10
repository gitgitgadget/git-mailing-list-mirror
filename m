From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 3/4] refs.c: change update_refs to run the commit loops once all work is finished
Date: Thu, 10 Apr 2014 11:30:24 -0700
Message-ID: <1397154625-11884-4-git-send-email-sahlberg@google.com>
References: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 20:30:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYJkN-0001Av-Gf
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbaDJSal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:30:41 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:53023 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbaDJSac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:30:32 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so621775qac.5
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mLTrkT1FsIsS7x4bj7tUv9v62aWbGgc5YGyIjjnOWnY=;
        b=McUQZHbCy5L/YjV/Kfte89r8xaPDkswbz9ShLX8D1LKz9891G2ndm3X1KdP/UjeUmO
         kCGaxI2eW59da0DjNH9GZihHUuGnScyF6rrIPYZLBngS6rMtuCHKkV70kjmlnC/bmUKx
         L6O6Hv4jxbUnDfphc5F7KvqqiHuSJu9jayqaxBlFSpqIyHJm+o4XiFGS8V0WMC3k2qCl
         zkum93cG1kFtbA+ZOCqDmVnciobg3/A1tLJR+kdc+r8fCi4wjZnFh/EcYiF+yCAczL/o
         2/hqona7C1sseCx+yLdifP/08kZy8fN1BdCKbFkpo63NcSFSLMBKoV8rJdB5/zvnbcM2
         Scug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mLTrkT1FsIsS7x4bj7tUv9v62aWbGgc5YGyIjjnOWnY=;
        b=TtsVQDzXdC5ne6+c8PliPYHGuBq1F3w8XTnFZgt7dhrtB8vOT2NYdkPpS8D0Cjd3vS
         OwmCzs3igOGPYPx19hV5PqIESFCMHCCqwqHDZ+hjZDKA+jfDTyQucuihxwh5L3nHsZto
         lvPm47Tb894cugmZJeTmoJ6FNZ5dUWfWfRQYQzTLApaxDfGRZdYYtfLPy4s66iMYp8qD
         ww/gNpWaWCL7HOf1cxMLw5m3AO0rG+yYHRGcp8ebPqVkMfisHkHxxBxUHqztR4CrQNGz
         3a959LY7IIRommx29c7SqTIB7KGdsld7ahxyCFCGxgp6B14WZpEvRI+TCeX1rdZLdIhz
         CHAA==
X-Gm-Message-State: ALoCoQlriq7IKWaqaATj3MSjsVNQgkPHx0ZxqjoKGIEtPsprkagigKg5bkiRHj1NGMxwY4PAw5a+mJr+D57vJt4KvECOi0qBc9+cXoXBmJ6Zr6C6023JGQC/NByUlylS1m/VSTdg5FGMNuNesHWgORZJ/MX6ydr9VcA7TFxoZPircdEi9b51ps0Vv1bYaedwnmnB2cuPAeLt
X-Received: by 10.224.36.137 with SMTP id t9mr8834884qad.4.1397154631290;
        Thu, 10 Apr 2014 11:30:31 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id x22si797735yhd.5.2014.04.10.11.30.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Apr 2014 11:30:31 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 21B415A4082;
	Thu, 10 Apr 2014 11:30:31 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DB0CFE0591; Thu, 10 Apr 2014 11:30:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.478.ga5a8238.dirty
In-Reply-To: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246024>

During update_refs we will both be deleting refs as well as updating/changing
the refs.
Since both delete and update now use the same lock/update/commit pattern

    lock = lock_ref_sha1_basic() (or varient of)
    write_ref_sha1(lock)/delete_ref_loose(lock)
    unlock_ref(lock) | commit_ref_lock(lock)

we can now simplify update_update refs to have one loop that locks all
involved refs.
A second loop that writes or flags for deletion, but does not commit, all
the refs.
And a final third loop that commits all the refs once all the work and
preparations are complete.

This makes updating/deleting multiple refs 'more atomic' since we will not start
the commit phase until all the preparations have completed successfully.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 038614d..1678e12 100644
--- a/refs.c
+++ b/refs.c
@@ -3368,34 +3368,38 @@ int update_refs(const char *action, const struct ref_update **updates_orig,
 		}
 	}
 
-	/* Perform updates first so live commits remain referenced */
-	for (i = 0; i < n; i++)
-		if (!is_null_sha1(updates[i]->new_sha1)) {
+	/* Go through and prepare all updates and deletes */
+	for (i = 0; i < n; i++) {
+		if (!is_null_sha1(updates[i]->new_sha1))
 			ret = update_ref_write(action,
 					       updates[i]->ref_name,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
-			if (ret)
-				unlock_ref(locks[i]);
-			else
-				commit_ref_lock(locks[i]);
-			locks[i] = NULL;
-			if (ret)
-				goto cleanup;
+		else {
+			delnames[delnum++] = locks[i]->ref_name;
+			ret = delete_ref_loose(locks[i], types[i]);
 		}
+		if (ret)
+			goto cleanup;
+	}
 
-	/* Perform deletes now that updates are safely completed */
+	ret = repack_without_refs(delnames, delnum);
+	for (i = 0; i < delnum; i++)
+		unlink_or_warn(git_path("logs/%s", delnames[i]));
+	clear_loose_ref_cache(&ref_cache);
+
+	/* Perform updates first so live commits remain referenced */
+	for (i = 0; i < n; i++)
+		if (locks[i] && !locks[i]->delete_ref) {
+			ret |= commit_ref_lock(locks[i]);
+			locks[i] = NULL;
+		}
+	/* And finally perform all deletes */
 	for (i = 0; i < n; i++)
 		if (locks[i]) {
-			delnames[delnum++] = locks[i]->ref_name;
-			ret |= delete_ref_loose(locks[i], types[i]);
 			ret |= commit_ref_lock(locks[i]);
 			locks[i] = NULL;
 		}
-	ret |= repack_without_refs(delnames, delnum);
-	for (i = 0; i < delnum; i++)
-		unlink_or_warn(git_path("logs/%s", delnames[i]));
-	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
 	for (i = 0; i < n; i++)
-- 
1.9.1.478.ga5a8238.dirty
