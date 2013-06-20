From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/12] refs: do not invalidate the packed-refs cache unnecessarily
Date: Thu, 20 Jun 2013 10:37:54 +0200
Message-ID: <1371717474-28942-13-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaOA-00075w-B3
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082Ab3FTIib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:38:31 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:52885 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965070Ab3FTIi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:27 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-9f-51c2bf83731f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 70.E4.17335.38FB2C15; Thu, 20 Jun 2013 04:38:27 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sK001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:26 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqNu8/1CgwZ4zihZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzph38R5zwXWuircL5RsYr3J0MXJySAiYSCw/sY4RwhaTuHBvPVsX
	IxeHkMBlRonLXVuZIZxzTBJf+w6ygFSxCehKLOppZgKxRQTUJCa2HWIBKWIW2M0osfz0KXaQ
	hLBAqERHcx/YWBYBVYmzZ06CNfMKuEp8vr+AGWKdgsSUh+/BbE6g+JvDc1hBbCEBF4mtu3aw
	TmDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJND4djC2r5c5xCjA
	wajEw6tx+WCgEGtiWXFl7iFGSQ4mJVHeTXsPBQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4U2d
	A5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwfgAZKliUmp5akZaZ
	U4KQZuLgBBFcIBt4gDYY7wPZUFyQmFucmQ5RdIpRUUqcVwIkIQCSyCjNgxsASwmvGMWB/hHm
	lQap4gGmE7juV0CDmYAG71kNNrgkESEl1cA4db9Zb13LS/3dKxIDV6oZc/hGmRpP/Hx7lbrL
	OTFTL3OjhpO92xMaYl6tPX5io6W+y5v09mPLBSbYpodeTZJwEry5pWjj/Wn7pjwSWrg4kUWA
	d/qLQ0fTn5ppmE1o1Ph0fteVc7Hbch7Gl9SceLJz69yedPk+RbFTknENLa+u/5j3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228453>

Now that we keep track of the packed-refs file metadata, we can detect
when the packed-refs file has been modified since we last read it, and
we do so automatically every time that get_packed_ref_cache() is
called.  So there is no need to invalidate the cache automatically
when lock_packed_refs() is called; usually the old copy will still be
valid.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 787cc1c..038e5c7 100644
--- a/refs.c
+++ b/refs.c
@@ -2136,11 +2136,14 @@ int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
-	/* Discard the old cache because it might be invalid: */
-	clear_packed_ref_cache(&ref_cache);
 	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), flags) < 0)
 		return -1;
-	/* Read the current packed-refs while holding the lock: */
+	/*
+	 * Get the current packed-refs while holding the lock.  If the
+	 * packed-refs file has been modified since we last read it,
+	 * this will automatically invalidate the cache and re-read
+	 * the packed-refs file.
+	 */
 	packed_ref_cache = get_packed_ref_cache(&ref_cache);
 	packed_ref_cache->lock = &packlock;
 	/* Increment the reference count to prevent it from being freed: */
-- 
1.8.3.1
