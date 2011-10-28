From: mhagger@alum.mit.edu
Subject: [PATCH 13/28] get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:26 +0200
Message-ID: <1319804921-17545-14-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlbI-0004wh-Er
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597Ab1J1Mbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:49 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55901 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1J1Mbt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:49 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-L4; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184395>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 425fdaa..d6d5d0e 100644
--- a/refs.c
+++ b/refs.c
@@ -855,13 +855,13 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 	}
 }
 
-static struct ref_dir *get_loose_refs(struct ref_cache *refs)
+static struct ref_entry *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->loose) {
 		refs->loose = create_dir_entry("");
 		get_ref_dir(refs, "refs/");
 	}
-	return &refs->loose->u.subdir;
+	return refs->loose;
 }
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
@@ -1173,7 +1173,8 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	struct ref_dir *extra_dir = extra_refs ? &extra_refs->u.subdir : NULL;
 	struct ref_entry *packed_direntry = get_packed_refs(refs);
 	struct ref_dir *packed_dir = &packed_direntry->u.subdir;
-	struct ref_dir *loose_dir = get_loose_refs(refs);
+	struct ref_entry *loose_direntry = get_loose_refs(refs);
+	struct ref_dir *loose_dir = &loose_direntry->u.subdir;
 
 	if (base && *base) {
 		if (extra_dir)
@@ -1730,7 +1731,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!is_refname_available(newrefname, oldrefname, &get_packed_refs(refs)->u.subdir))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
+	if (!is_refname_available(newrefname, oldrefname, &get_loose_refs(refs)->u.subdir))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-- 
1.7.7
