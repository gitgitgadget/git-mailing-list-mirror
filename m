From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/12] do_for_each_entry(): increment the packed refs cache refcount
Date: Thu, 20 Jun 2013 10:37:48 +0200
Message-ID: <1371717474-28942-7-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:38:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaO9-00075w-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055Ab3FTIiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:38:24 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53125 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932757Ab3FTIiS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:18 -0400
X-AuditID: 1207440d-b7f006d000000adf-37-51c2bf790984
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 72.F0.02783.97FB2C15; Thu, 20 Jun 2013 04:38:17 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sE001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:15 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqFu5/1Cgwb9H3BZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzrjfdoGl4ANXxcfOB6wNjD84uhg5OSQETCQmLW9lh7DFJC7cW8/W
	xcjFISRwmVFiyprj7BDOOSaJjfvfM4FUsQnoSizqaQazRQTUJCa2HWIBKWIW2M0osfz0KbBR
	wgLhEo9vT2cBsVkEVCX2b/jGCGLzCrhI/Jh4mAlinYLElIfvmUFsTgFXiTeH57CC2EJANVt3
	7WCdwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZIqPHuYPy/TuYQ
	owAHoxIPr8blg4FCrIllxZW5hxglOZiURHnn7jsUKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	N3UOUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMGbBjJUsCg1PbUi
	LTOnBCHNxMEJIrhANvAAbVgGUshbXJCYW5yZDlF0ilFRSpx3FUhCACSRUZoHNwCWFF4xigP9
	I8w7FaSKB5hQ4LpfAQ1mAhq8ZzXY4JJEhJRUA+N0Rda7L+xfh8moRiuUqEsHXZiXl98kHHlz
	yp5tSSE3nysL7Vvk6PL9TAurb1qI6vIPAc6rTZceqZ5jfqEyoOna8bZNZSXJHP94Wy0XHu82
	TdjvUpPjmLfB+td8/y1yW02De91kjLM22PBfXM5QX/m2er17bcB2c5k1W14UzgyW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228456>

This function calls a user-supplied callback function which could do
something that causes the packed refs cache to be invalidated.  So
acquire a reference count on the data structure to prevent our copy
from being freed while we are iterating over it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 80c172f..f33d224 100644
--- a/refs.c
+++ b/refs.c
@@ -1590,10 +1590,12 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
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
@@ -1614,6 +1616,7 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 				loose_dir, 0, fn, cb_data);
 	}
 
+	release_packed_ref_cache(packed_ref_cache);
 	return retval;
 }
 
-- 
1.8.3.1
