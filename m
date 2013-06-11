From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/12] packed_ref_cache: increment refcount when locked
Date: Tue, 11 Jun 2013 23:48:27 +0200
Message-ID: <1370987312-6761-8-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWRN-0003wo-IO
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab3FKVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:49:11 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51518 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756544Ab3FKVtD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:49:03 -0400
X-AuditID: 12074412-b7f656d00000102f-28-51b79b4f04dc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 75.83.04143.F4B97B15; Tue, 11 Jun 2013 17:49:03 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbiv015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:49:01 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqOs/e3ugQeMtbouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ0xtXUTS8F0noo9C1+xNDC+4exi5OSQEDCRePv2NiuELSZx4d56ti5GLg4hgcuMEvMn
	nIJyLjBJ7L73hwWkik1AV2JRTzMTiC0ioCYxse0QC0gRs0A7o8S75n3MIAlhAXeJuX82gBWx
	CKhK7HwwAczmFXCWuHOpA2qdnMT7O7vAhnIKuEhs3LwZrFcIqOZ7TxPjBEbeBYwMqxjlEnNK
	c3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCwkpoB+P6k3KHGAU4GJV4eA+YbQ8UYk0s
	K67MPcQoycGkJMrLNg0oxJeUn1KZkVicEV9UmpNafIhRgoNZSYRXNxcox5uSWFmVWpQPk5Lm
	YFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwXt3JlCjYFFqempFWmZOCUKaiYMTRHCBbOAB
	2sA3C2RDcUFibnFmOkTRKUZFKXHeRyATBEASGaV5cANgCeAVozjQP8K8F0GqeIDJA677FdBg
	JqDBRRlgg0sSEVJSDYzs5iIFU7nu1IcuvzKV7WnE6T1VazI5ykS2cXsYybgXrfwmVBpRoSey
	ZpJc+I4SZe70Tdx9P69wlB9beOY8BzO/ZiLrwd27v0rPT01Z/s9975L0604lYdem9C9+6vtH
	1P6bb3TWpDCZC9PD5i2o6Hkbz5898crWXo3aLQtFdtnKHudv7Og8ZaHEUpyRaKjF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227524>

Increment the packed_ref_cache reference count while it is locked to
prevent its being freed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index d8e8ce2..92c8e97 100644
--- a/refs.c
+++ b/refs.c
@@ -816,7 +816,9 @@ struct packed_ref_cache {
 	/*
 	 * Iff the packed-refs file associated with this instance is
 	 * currently locked for writing, this points at the associated
-	 * lock (which is owned by somebody else).
+	 * lock (which is owned by somebody else).  The referrer count
+	 * is also incremented when the file is locked and decremented
+	 * when it is unlocked.
 	 */
 	struct lock_file *lock;
 
@@ -2099,6 +2101,8 @@ int lock_packed_refs(struct lock_file *lock, int flags)
 	packed_ref_cache = get_packed_ref_cache(&ref_cache);
 	packed_ref_cache->lock = lock;
 	packed_ref_cache->fd = fd;
+	/* Increment the reference count to prevent it from being freed: */
+	acquire_packed_ref_cache(packed_ref_cache);
 	return 0;
 }
 
@@ -2119,6 +2123,7 @@ int commit_packed_refs(void)
 		error = -1;
 	packed_ref_cache->lock = NULL;
 	packed_ref_cache->fd = -1;
+	release_packed_ref_cache(packed_ref_cache);
 	return error;
 }
 
@@ -2132,6 +2137,7 @@ void rollback_packed_refs(void)
 	rollback_lock_file(packed_ref_cache->lock);
 	packed_ref_cache->lock = NULL;
 	packed_ref_cache->fd = -1;
+	release_packed_ref_cache(packed_ref_cache);
 	clear_packed_ref_cache(&ref_cache);
 }
 
-- 
1.8.3
