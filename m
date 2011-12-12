From: mhagger@alum.mit.edu
Subject: [PATCH v2 32/51] do_for_each_ref(): only iterate over the subtree that was requested
Date: Mon, 12 Dec 2011 06:38:39 +0100
Message-ID: <1323668338-1764-33-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeG-00015m-G6
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab1LLFll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:41 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34832 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab1LLFkc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:32 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aj015577;
	Mon, 12 Dec 2011 06:40:23 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186871>

From: Michael Haggerty <mhagger@alum.mit.edu>

If the base argument has a "/" chararacter, then only iterate over the
reference subdir whose name is the part up to the last "/".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index f01da78..6a11235 100644
--- a/refs.c
+++ b/refs.c
@@ -1121,13 +1121,34 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 {
 	int retval = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
-
-	retval = do_for_each_ref_in_dir(&extra_refs, 0,
+	struct ref_dir *extra_dir = &extra_refs;
+	struct ref_dir *packed_dir = get_packed_refs(refs);
+	struct ref_dir *loose_dir = get_loose_refs(refs);
+
+	if (base && *base) {
+		extra_dir = find_containing_dir(extra_dir, base, 0);
+		packed_dir = find_containing_dir(packed_dir, base, 0);
+		loose_dir = find_containing_dir(loose_dir, base, 0);
+	}
+
+	if (extra_dir)
+		retval = do_for_each_ref_in_dir(
+				extra_dir, 0,
+				base, fn, trim, flags, cb_data);
+	if (!retval) {
+		if (packed_dir && loose_dir)
+			retval = do_for_each_ref_in_dirs(
+					packed_dir, loose_dir,
+					base, fn, trim, flags, cb_data);
+		else if (packed_dir)
+			retval = do_for_each_ref_in_dir(
+					packed_dir, 0,
 					base, fn, trim, flags, cb_data);
-	if (!retval)
-		retval = do_for_each_ref_in_dirs(get_packed_refs(refs),
-						 get_loose_refs(refs),
-						 base, fn, trim, flags, cb_data);
+		else if (loose_dir)
+			retval = do_for_each_ref_in_dir(
+					loose_dir, 0,
+					base, fn, trim, flags, cb_data);
+	}
 
 	current_ref = NULL;
 	return retval;
-- 
1.7.8
