From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/12] refs: do not invalidate the packed-refs cache unnecessarily
Date: Tue, 11 Jun 2013 23:48:32 +0200
Message-ID: <1370987312-6761-13-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWRO-0003wo-2u
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab3FKVtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:49:13 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64125 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756544Ab3FKVtM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:49:12 -0400
X-AuditID: 1207440c-b7f016d000005997-37-51b79b577fca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 10.E6.22935.75B97B15; Tue, 11 Jun 2013 17:49:11 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbj2015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:49:10 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqBs+e3ugwYnTMhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtjzdK/7AVL+CoutZ9kaWA8xt3FyMkhIWAi8b5/PjuELSZx4d56ti5GLg4hgcuMEl2b
	LkM5F5gkJm4+wQJSxSagK7Gop5kJxBYRUJOY2HaIBaSIWaCdUeJd8z5mkISwQJBEx7X/YGNZ
	BFQltq6cAFTEwcEr4CIx7483xDY5ifd3doHN5AQKb9y8GaxVSMBZ4ntPE+MERt4FjAyrGOUS
	c0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIzS/RSU0o3MUKCimcH47d1MocYBTgYlXh4D5htDxRi
	TSwrrsw9xCjJwaQkyss2DSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhFc3FyjHm5JYWZValA+T
	kuZgURLnVV2i7ickkJ5YkpqdmlqQWgSTleHgUJLgvTsTqFGwKDU9tSItM6cEIc3EwQkiuEA2
	8ABt4JsFsqG4IDG3ODMdougUo6KUOO8jkAkCIImM0jy4AbD4f8UoDvSPMO9FkCoeYOqA634F
	NJgJaHBRBtjgkkSElFQDI+8fpu5Xz/mBgWx6jGnlS0U5pd17tl29YfOY+epsnm02x86d6Z1d
	uOHr+TwJl+XzVLZ57grimer2QPSb7dVU7mhmzZuck7u3v2/69Sjwflfr4j/P1RiX9f+8n+wn
	/fPF/Yc7nr3Z/1Nh3plu8xM+Ev9Sw96ELVDbVhRyesvU6zWvJj4N5qoWNlBiKc5I 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227526>

Now that we keep track of the packed-refs file metadata, we can detect
when the packed-refs file has been modified since we last read it, and
we do so automatically every time that get_packed_ref_cache() is
called.  So there is no need to invalidate the cache automatically
when lock_packed_refs() is called; usually the old copy will still be
valid.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch is optional.  It makes the assumption that the metadata
stored in stat_validity are adequate to reliably detect when the
packed-refs file has changed.  Given that we are about to rewrite the
file, it is perhaps even more crucial not to make a mistake in this
codepath than in others.  So if the stat_validity check is not
considered safe enough, it might be prudent to omit this patch and
continue to reload the packed-refs data here unconditionally.

 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index aa4641b..d9cbfc4 100644
--- a/refs.c
+++ b/refs.c
@@ -2134,12 +2134,15 @@ int lock_packed_refs(struct lock_file *lock, int flags)
 	int fd;
 	struct packed_ref_cache *packed_ref_cache;
 
-	/* Discard the old cache because it might be invalid: */
-	clear_packed_ref_cache(&ref_cache);
 	fd = hold_lock_file_for_update(lock, git_path("packed-refs"), flags);
 	if (fd < 0)
 		return -1;
-	/* Read the current packed-refs while holding the lock: */
+	/*
+	 * Get the current packed-refs while holding the lock.  If the
+	 * packed-refs file has been modified since we last read it,
+	 * this will automatically invalidate the cache and re-read
+	 * the packed-refs file.
+	 */
 	packed_ref_cache = get_packed_ref_cache(&ref_cache);
 	packed_ref_cache->lock = lock;
 	packed_ref_cache->fd = fd;
-- 
1.8.3
