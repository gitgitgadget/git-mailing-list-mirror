From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/12] do_for_each_entry(): increment the packed refs cache refcount
Date: Tue, 11 Jun 2013 23:48:26 +0200
Message-ID: <1370987312-6761-7-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWRf-0004B4-A8
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620Ab3FKVtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:49:33 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49632 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756534Ab3FKVtD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:49:03 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-3b-51b79b4df526
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id DD.68.17335.D4B97B15; Tue, 11 Jun 2013 17:49:01 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbiu015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:49:00 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqOs7e3ugwcM98hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvjY/s1loJ3XBXHFz1ha2D8xtHFyMkhIWAisXNJMzuELSZx4d56ti5GLg4hgcuMEue3
	HGOHcC4wSbz+eJ8NpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbNAO6PEu+Z9zCAJYYEQiZlvp7KC
	2CwCqhK3Fm5nBLF5BZwlHh0/D7VOTuL9nV0sIDangIvExs2bwXqFgGq+9zQxTmDkXcDIsIpR
	LjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJKz4djC2r5c5xCjAwajEw3vAbHug
	EGtiWXFl7iFGSQ4mJVFetmlAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8urlAOd6UxMqq1KJ8
	mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO+VWUCNgkWp6akVaZk5JQhpJg5OEMEF
	soEHaMMhkELe4oLE3OLMdIiiU4yKUuK8p0ESAiCJjNI8uAGwBPCKURzoH2He/SBVPMDkAdf9
	CmgwE9DgogywwSWJCCmpBsb5Wx7yvBTxY33YfXXirn27X6xMfiGs9T+59kuBINe7Kf5fzjx+
	XZYcLTf/2mH7f1f+m/DkpnQ+a9x//lm/f/CaeTsrfHSTnjeaO+9iFG2eLy9/eMdRzegVl68q
	VdVu8l21Ndmbmc92N2vR3PM7zj87JGRt+bHoV1vNPYPwM4GiQXaL/s7YpNSmxFKc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227531>

This function calls a user-supplied callback function which could do
something that causes the packed refs cache to be invalidated.  So
acquire a reference count on the data structure to prevent our copy
from being freed while we are iterating over it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b0d77a7..d8e8ce2 100644
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
1.8.3
