From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] read-cache.c: make create_from_disk() report number of
 bytes it consumed
Date: Tue,  3 Apr 2012 15:53:11 -0700
Message-ID: <1333493596-14202-5-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbV-0006o1-8I
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab2DCWxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687Ab2DCWx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B56137F6F
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VXO0
	kj7PN+mqd+jkUEwWFUUO0w8=; b=NYlLS4NGDH3LXBZQCOKoGypl0NAzFRlmkTc8
	6AZM0qVd4BcnC3MIBvNAfvz3Wup91G8q+kr/LiOcj+9p+xivD/035Mqz5vMcQnnK
	55nlz6uSrEXf1lnH3C4sBLEEavVZxWxfJo76+WsmTWelQGOTpawIJ3jWsDU1cxP1
	aNKQhOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AG4eXN
	Q8vEhuqsKamovYLNPMyJJufm3zL2H/Mmdt0QgvU0LEooSAq2WoIuNwRMRy6gwEi2
	x7h36okQaA/rXmMIV18nMj4AAja7xsA51wbBZb6KwhtI8dEymNBwkhwF+sDGzJtq
	oOagsDt/x0kvrpJEo5wyPRMdiqzKNBLqChmCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE29E7F6E
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 305CC7F6D for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D1FEA8D2-7DDF-11E1-89D2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194664>

The function is the one that is reading from the data stream. It only is
natural to make it responsible for reporting this number, not the caller.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d8865f5..58bfb24 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1305,7 +1305,8 @@ static inline uint32_t ntoh_l_force_align(void *p)
 #define ntoh_l(var) ntoh_l_force_align(&(var))
 #endif
 
-static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk)
+static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
+					    unsigned long *ent_size)
 {
 	struct cache_entry *ce;
 	size_t len;
@@ -1351,6 +1352,7 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk)
 
 	memcpy(ce->name, name, len);
 	ce->name[len] = '\0';
+	*ent_size = ondisk_ce_size(ce);
 	return ce;
 }
 
@@ -1404,12 +1406,13 @@ int read_index_from(struct index_state *istate, const char *path)
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
+		unsigned long consumed;
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = create_from_disk(disk_ce);
+		ce = create_from_disk(disk_ce, &consumed);
 		set_index_entry(istate, i, ce);
 
-		src_offset += ondisk_ce_size(ce);
+		src_offset += consumed;
 	}
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
-- 
1.7.10.rc4.54.g1d5dd3
