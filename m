From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/12] packed_ref_cache: increment refcount when locked
Date: Thu, 20 Jun 2013 10:37:49 +0200
Message-ID: <1371717474-28942-8-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:39:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaOe-0008Bz-1O
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027Ab3FTIiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:38:22 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52885 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935353Ab3FTIiT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:19 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-81-51c2bf7a1c26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.D4.17335.A7FB2C15; Thu, 20 Jun 2013 04:38:18 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sF001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:17 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqFu1/1CgwY7z5hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgznh2cwtrwQWeii/bNzI1MM7n6mLk5JAQMJFoXTCLHcIWk7hwbz1b
	FyMXh5DAZUaJ1mfToZxzTBKf/p1hBqliE9CVWNTTzARiiwioSUxsO8QCUsQssJtRYvnpU2Cj
	hAW8JH62vwUrYhFQlVjwfgsjiM0r4CKxcs5fJoh1ChJTHr4HG8op4Crx5vAcVhBbCKhm664d
	rBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECAk1vh2M7etlDjEK
	cDAq8fBqXD4YKMSaWFZcmXuIUZKDSUmUd9PeQ4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhT
	5wDleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvB9AhgoWpaanVqRl
	5pQgpJk4OEEEF8gGHqANxvtANhQXJOYWZ6ZDFJ1iVJQS55UASQiAJDJK8+AGwJLCK0ZxoH+E
	eaVBqniACQWu+xXQYCagwXtWgw0uSURISTUwJjIc/bo07m3jSt2eNwz77zw6ILjkxn7d5Er+
	7/OX1ExsWb11x+znOVO+qpSIRupZNlqIViuamf5I8a8IkZZd8PPGPvUjs663VwZ6a/FkHLxx
	X9El45XtXDtNp8uiOn/kj/dmuGyN/h91sPzExVAXyfh8I/ZJf3N/3efm784IC7oa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228457>

Increment the packed_ref_cache reference count while it is locked to
prevent its being freed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f33d224..a5a5b5d 100644
--- a/refs.c
+++ b/refs.c
@@ -820,7 +820,9 @@ struct packed_ref_cache {
 	/*
 	 * Iff the packed-refs file associated with this instance is
 	 * currently locked for writing, this points at the associated
-	 * lock (which is owned by somebody else).
+	 * lock (which is owned by somebody else).  The referrer count
+	 * is also incremented when the file is locked and decremented
+	 * when it is unlocked.
 	 */
 	struct lock_file *lock;
 };
@@ -2099,6 +2101,8 @@ int lock_packed_refs(int flags)
 	/* Read the current packed-refs while holding the lock: */
 	packed_ref_cache = get_packed_ref_cache(&ref_cache);
 	packed_ref_cache->lock = &packlock;
+	/* Increment the reference count to prevent it from being freed: */
+	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
 }
 
@@ -2119,6 +2123,7 @@ int commit_packed_refs(void)
 	if (commit_lock_file(packed_ref_cache->lock))
 		error = -1;
 	packed_ref_cache->lock = NULL;
+	release_packed_ref_cache(packed_ref_cache);
 	return error;
 }
 
@@ -2131,6 +2136,7 @@ void rollback_packed_refs(void)
 		die("internal error: packed-refs not locked");
 	rollback_lock_file(packed_ref_cache->lock);
 	packed_ref_cache->lock = NULL;
+	release_packed_ref_cache(packed_ref_cache);
 	clear_packed_ref_cache(&ref_cache);
 }
 
-- 
1.8.3.1
