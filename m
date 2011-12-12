From: mhagger@alum.mit.edu
Subject: [PATCH v2 36/51] get_loose_refs(): return (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:43 +0100
Message-ID: <1323668338-1764-37-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydS-0000k3-Fj
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab1LLFko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:44 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34883 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab1LLFkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:40 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8an015577;
	Mon, 12 Dec 2011 06:40:32 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186854>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 6a65a21..918b787 100644
--- a/refs.c
+++ b/refs.c
@@ -809,13 +809,13 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
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
@@ -1138,7 +1138,8 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	struct ref_dir *extra_dir = extra_refs ? &extra_refs->u.subdir : NULL;
 	struct ref_entry *packed_direntry = get_packed_refs(refs);
 	struct ref_dir *packed_dir = &packed_direntry->u.subdir;
-	struct ref_dir *loose_dir = get_loose_refs(refs);
+	struct ref_entry *loose_direntry = get_loose_refs(refs);
+	struct ref_dir *loose_dir = &loose_direntry->u.subdir;
 
 	if (base && *base) {
 		if (extra_dir)
@@ -1688,7 +1689,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!is_refname_available(newrefname, oldrefname, &get_packed_refs(refs)->u.subdir))
 		return 1;
 
-	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(refs)))
+	if (!is_refname_available(newrefname, oldrefname, &get_loose_refs(refs)->u.subdir))
 		return 1;
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-- 
1.7.8
