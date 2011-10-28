From: mhagger@alum.mit.edu
Subject: [PATCH 09/28] do_for_each_ref(): only iterate over the subtree that was requested
Date: Fri, 28 Oct 2011 14:28:22 +0200
Message-ID: <1319804921-17545-10-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:29:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlYv-0003gi-V6
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493Ab1J1M2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:28:51 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55679 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Ip; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184380>

From: Michael Haggerty <mhagger@alum.mit.edu>

If the base argument has a "/" chararacter, then only iterate over the
reference subdir whose name is the part up to the last "/".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   31 ++++++++++++++++++++++++++-----
 1 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 733d7a8..515b44c 100644
--- a/refs.c
+++ b/refs.c
@@ -1156,13 +1156,34 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 {
 	int retval = 0;
 	struct ref_cache *refs = get_ref_cache(submodule);
+	struct ref_dir *extra_dir = &extra_refs;
+	struct ref_dir *packed_dir = get_packed_refs(refs);
+	struct ref_dir *loose_dir = get_loose_refs(refs);
 
-	retval = do_for_each_ref_in_dir(&extra_refs, 0,
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
1.7.7
