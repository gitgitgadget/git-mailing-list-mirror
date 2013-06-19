From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/12] do_for_each_entry(): increment the packed refs cache refcount
Date: Wed, 19 Jun 2013 09:51:27 +0200
Message-ID: <1371628293-28824-7-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDBc-0002ed-9z
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933081Ab3FSHwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:08 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42751 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756657Ab3FSHv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:51:58 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-34-51c1631d8b24
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 05.AF.17335.D1361C15; Wed, 19 Jun 2013 03:51:57 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWY002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:56 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqCubfDDQYN05KYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ7xtXsRU8IGrovHKW7YGxh8cXYycHBICJhJLOs+zQ9hiEhfurWfr
	YuTiEBK4zCix7NxyFgjnNpPE0tY1YFVsAroSi3qamUBsEQE1iYlth8CKmAV2M0osP30KrEhY
	IFziyPONzCA2i4CqxP5n08DivAIuEj8OrmCDWKcgMeXhe6AaDg5OAVeJs8s8QcJCQCXzTk1m
	ncDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSKDx7WBsXy9ziFGA
	g1GJh7dh5YFAIdbEsuLK3EOMkhxMSqK87EkHA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8Oo5
	AOV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8VxOBGgWLUtNTK9Iy
	c0oQ0kwcnCCCC2QDD9CGIyCFvMUFibnFmekQRacYFaXEee+BJARAEhmleXADYCnhFaM40D/C
	vKwgx/MA0wlc9yugwUxAg4W+7wMZXJKIkJJqYLTOnbc+kdN7UeL5qjyO+KjOORvL62IqtJVj
	shff/rvf98g1HUW1+sObQu9VdBjm8Mmk8nSZ1/szvVz3b9EtO9tndqHyn+8u5JXMZzB6nSP+
	MnXd4tOc+60sbzJbTW/aY7Y8tOGtcFug4/8i9ZzfmbPDfrdyrzw+W3X93mPlUd8O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228362>

This function calls a user-supplied callback function which could do
something that causes the packed refs cache to be invalidated.  So
acquire a reference count on the data structure to prevent our copy
from being freed while we are iterating over it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e2e441d..d90f487 100644
--- a/refs.c
+++ b/refs.c
@@ -1587,10 +1587,12 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 static int do_for_each_entry(struct ref_cache *refs, const char *base,
 			     each_ref_entry_fn fn, void *cb_data)
 {
-	struct ref_dir *packed_dir = get_packed_refs(refs);
+	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
+	struct ref_dir *packed_dir = get_packed_ref_dir(packed_ref_cache);
 	struct ref_dir *loose_dir = get_loose_refs(refs);
 	int retval = 0;
 
+	acquire_packed_ref_cache(packed_ref_cache);
 	if (base && *base) {
 		packed_dir = find_containing_dir(packed_dir, base, 0);
 		loose_dir = find_containing_dir(loose_dir, base, 0);
@@ -1611,6 +1613,7 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 				loose_dir, 0, fn, cb_data);
 	}
 
+	release_packed_ref_cache(packed_ref_cache);
 	return retval;
 }
 
-- 
1.8.3.1
