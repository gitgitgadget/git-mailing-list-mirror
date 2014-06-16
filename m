From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 11/48] refs.c: make remove_empty_directories alwasy set errno to something sane
Date: Mon, 16 Jun 2014 11:03:42 -0700
Message-ID: <1402941859-29354-12-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKf-0007ix-VI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbaFPSIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:30 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:59902 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932625AbaFPSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:23 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so432828pde.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5lzAcbUtm7oac72Tq0ESESUTNyZr/joLTzLsDxoPaQM=;
        b=opNNkqEhDuwHRHEHtjUTC4phiuqcNCxrAg3Kaw3/NZCUQ4AY6so3zeNVxseOpn5OXh
         15hnwCJARDI2Tpx8wHP8FlNOIYzTLDkzkv2lcvY8iaJmsFgR1kk6ozuYrq0gKR4L5Q+R
         HNiDKD3xE9StIqhdXW5susN/y7nEt3AaDXQ35JWdF1DN2ygNAd8fiPVNsIuQF+KyoQ/4
         8COHK+HeXyw14fSgiCb0VKFWbV7vK8SMDEw8PyqVD6qxWM9cUbYpizSlURbvHtXKR+xD
         BHqIMbppsH4k4d3xlvpolna65dZNCgziS7R9susVXn80Z3UYHJjsEK+a4mM/RIPRAssH
         svEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5lzAcbUtm7oac72Tq0ESESUTNyZr/joLTzLsDxoPaQM=;
        b=jZSbhpZuhZk1+tMawfCt7FlAklovUyWJSin9Mci2AxtlWllFjOV5ymDQ8GzZLe2+SK
         Rgnji1Ll4dD2i2zI2j1C2QWHzCBBEhU1+o6plfOIbXswHCNTm3YjW9WxKOKzyOSGpCQy
         /0tAEv42bhOSPkrIEIt4UCtZWatRZKMuPKbseGrgI5K2RnX4+Mql2zYGv6t9oA1LOqnd
         tALYR1pLwtGYk5g6UEeSufx0noX6XbQYSQdW2XWRGX6r2Jd7CKg3k4Lgunaa2jivmY0I
         d9y5KBOF+JHRFb2zlvRCWennoV2+wQBW9EWb7WiE/30tFKbwyg7rA8MiMi4KIaCaNbBs
         T3zQ==
X-Gm-Message-State: ALoCoQmlXOhbuBFv1KuZAAihR7xiqsMsPro3tqI+mty778vu3nOiA3RKvqEV6OuV2W+R7CehIJvS
X-Received: by 10.66.169.79 with SMTP id ac15mr142480pac.48.1402941862735;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si997322yhk.4.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 868B85A4914;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 322D6E12AA; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251784>

Making errno when returning from remove_empty_directories() more
obviously meaningful, which should provide some peace of mind for
people auditing lock_ref_sha1_basic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3631a3b..dd28214 100644
--- a/refs.c
+++ b/refs.c
@@ -1932,14 +1932,16 @@ static int remove_empty_directories(const char *file)
 	 * only empty directories), remove them.
 	 */
 	struct strbuf path;
-	int result;
+	int result, save_errno;
 
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
 	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
+	save_errno = errno;
 
 	strbuf_release(&path);
+	errno = save_errno;
 
 	return result;
 }
@@ -2028,6 +2030,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+/* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
-- 
2.0.0.282.g3799eda.dirty
