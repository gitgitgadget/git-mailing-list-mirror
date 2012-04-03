From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] read-cache.c: move code to copy ondisk to incore cache
 to a helper function
Date: Tue,  3 Apr 2012 15:53:13 -0700
Message-ID: <1333493596-14202-7-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbi-0006ve-FF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab2DCWxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151Ab2DCWxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46CFD7F7E
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=MROp
	TyO3k+3VT1iamBV44etEFJg=; b=gkHj4bXGMLD/HXvHQ/jVRWyOAmGHpDKjQqHy
	mapJRiPa/OKXsQtAtm1WJEKYIDvnrwCvCG/dL7F+jprgy7rrcpOwIsacqGtAoRX+
	BC3IAHB432XVXI6J4hG14q5L8Zo6Gly79/MZiBt8gD6uUXym8/vXupCv9Yv0YgDt
	DpUd98I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=K31fPz
	T+nkgtm7GIEV8UKeFVMyfbFzF3IKY7TSHs/snzALsNc+lEopo96oG4QdJ0iDGoiT
	C5329WMQuYtqAoljHQ3xFSIolS45UCGMu6NxoDhMZm2KPYm5+EaH1hf9/fR5zL2+
	llzKSNtO/Bf7623vphyxnXiwbV1O0Hn8BQIJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D7987F7C
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF4DE7F7B for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D420F642-7DDF-11E1-A98A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194665>

This makes the change in a later patch look less scary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 2d93826..82711c2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1307,6 +1307,30 @@ static inline uint32_t ntoh_l_force_align(void *p)
 #define ntoh_l(var) ntoh_l_force_align(&(var))
 #endif
 
+static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
+						   unsigned int flags,
+						   const char *name,
+						   size_t len)
+{
+	struct cache_entry *ce = xmalloc(cache_entry_size(len));
+
+	ce->ce_ctime.sec = ntoh_l(ondisk->ctime.sec);
+	ce->ce_mtime.sec = ntoh_l(ondisk->mtime.sec);
+	ce->ce_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
+	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
+	ce->ce_dev   = ntoh_l(ondisk->dev);
+	ce->ce_ino   = ntoh_l(ondisk->ino);
+	ce->ce_mode  = ntoh_l(ondisk->mode);
+	ce->ce_uid   = ntoh_l(ondisk->uid);
+	ce->ce_gid   = ntoh_l(ondisk->gid);
+	ce->ce_size  = ntoh_l(ondisk->size);
+	ce->ce_flags = flags;
+	hashcpy(ce->sha1, ondisk->sha1);
+	memcpy(ce->name, name, len);
+	ce->name[len] = '\0';
+	return ce;
+}
+
 static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size)
 {
@@ -1335,25 +1359,7 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 
 	if (len == CE_NAMEMASK)
 		len = strlen(name);
-
-	ce = xmalloc(cache_entry_size(len));
-
-	ce->ce_ctime.sec = ntoh_l(ondisk->ctime.sec);
-	ce->ce_mtime.sec = ntoh_l(ondisk->mtime.sec);
-	ce->ce_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
-	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
-	ce->ce_dev   = ntoh_l(ondisk->dev);
-	ce->ce_ino   = ntoh_l(ondisk->ino);
-	ce->ce_mode  = ntoh_l(ondisk->mode);
-	ce->ce_uid   = ntoh_l(ondisk->uid);
-	ce->ce_gid   = ntoh_l(ondisk->gid);
-	ce->ce_size  = ntoh_l(ondisk->size);
-	ce->ce_flags = flags;
-
-	hashcpy(ce->sha1, ondisk->sha1);
-
-	memcpy(ce->name, name, len);
-	ce->name[len] = '\0';
+	ce = cache_entry_from_ondisk(ondisk, flags, name, len);
 	*ent_size = ondisk_ce_size(ce);
 	return ce;
 }
-- 
1.7.10.rc4.54.g1d5dd3
