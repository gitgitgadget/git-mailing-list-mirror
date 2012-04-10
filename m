From: mhagger@alum.mit.edu
Subject: [PATCH 15/15] do_for_each_ref(): only iterate over the subtree that was requested
Date: Tue, 10 Apr 2012 07:30:27 +0200
Message-ID: <1334035827-20331-16-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfz-0002SQ-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab2DJFbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:13 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59264 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2DJFbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:31:12 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXe8000870;
	Tue, 10 Apr 2012 07:31:07 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195066>

From: Michael Haggerty <mhagger@alum.mit.edu>

If the base argument has a "/" chararacter, then only iterate over the
reference subdir whose name is the part up to the last "/".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index cdfb53d..f97a256 100644
--- a/refs.c
+++ b/refs.c
@@ -1144,13 +1144,34 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 			   int trim, int flags, void *cb_data)
 {
 	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_dir *packed_refs = get_packed_refs(refs);
-	struct ref_dir *loose_refs = get_loose_refs(refs);
-	sort_ref_dir(packed_refs);
-	sort_ref_dir(loose_refs);
-	return do_for_each_ref_in_dirs(packed_refs,
-				       loose_refs,
-				       base, fn, trim, flags, cb_data);
+	struct ref_dir *packed_dir = get_packed_refs(refs);
+	struct ref_dir *loose_dir = get_loose_refs(refs);
+	int retval = 0;
+
+	if (base && *base) {
+		packed_dir = find_containing_dir(packed_dir, base, 0);
+		loose_dir = find_containing_dir(loose_dir, base, 0);
+	}
+
+	if (packed_dir && loose_dir) {
+		sort_ref_dir(packed_dir);
+		sort_ref_dir(loose_dir);
+		retval = do_for_each_ref_in_dirs(
+				packed_dir, loose_dir,
+				base, fn, trim, flags, cb_data);
+	} else if (packed_dir) {
+		sort_ref_dir(packed_dir);
+		retval = do_for_each_ref_in_dir(
+				packed_dir, 0,
+				base, fn, trim, flags, cb_data);
+	} else if (loose_dir) {
+		sort_ref_dir(loose_dir);
+		retval = do_for_each_ref_in_dir(
+				loose_dir, 0,
+				base, fn, trim, flags, cb_data);
+	}
+
+	return retval;
 }
 
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
-- 
1.7.10
