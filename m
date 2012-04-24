From: mhagger@alum.mit.edu
Subject: [PATCH 12/30] get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:18 +0200
Message-ID: <1335307536-26914-13-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMoh1-00010Q-8M
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535Ab2DXW6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:58:31 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60966 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758445Ab2DXW45 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:56:57 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id E1122248157;
	Wed, 25 Apr 2012 00:46:08 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196283>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 24930ab..0259ad1 100644
--- a/refs.c
+++ b/refs.c
@@ -830,7 +830,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 	closedir(d);
 }
 
-static struct ref_dir *get_loose_refs(struct ref_cache *refs)
+static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry("");
@@ -838,7 +838,7 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 			    &search_for_subdir(&refs->loose->u.subdir,
 					       "refs/", 1)->u.subdir);
 	}
-	return &refs->loose->u.subdir;
+	return refs->loose;
 }
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
@@ -1165,7 +1165,8 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_entry *packed_direntry = get_packed_refs(refs);
 	struct ref_dir *packed_dir = &packed_direntry->u.subdir;
-	struct ref_dir *loose_dir = get_loose_refs(refs);
+	struct ref_entry *loose_direntry = get_loose_refs(refs);
+	struct ref_dir *loose_dir = &loose_direntry->u.subdir;
 	int retval = 0;
 
 	if (base && *base) {
@@ -1711,7 +1712,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!is_refname_available(newrefname, oldrefname, &get_packed_refs(refs)->u.subdir))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
+	if (!is_refname_available(newrefname, oldrefname, &get_loose_refs(refs)->u.subdir))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-- 
1.7.10
