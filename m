From: mhagger@alum.mit.edu
Subject: [PATCH v2 43/51] add_entry(): take (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:50 +0100
Message-ID: <1323668338-1764-44-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydV-0000k3-Tt
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab1LLFlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:00 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34975 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab1LLFk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:56 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8au015577;
	Mon, 12 Dec 2011 06:40:47 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186859>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 30ff9b8..54f65e3 100644
--- a/refs.c
+++ b/refs.c
@@ -199,8 +199,11 @@ static void free_ref_entry(struct ref_entry *entry)
  * stored directly in dir; no recursion into subdirectories is
  * done.
  */
-static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
+static void add_entry(struct ref_entry *direntry, struct ref_entry *entry)
 {
+	struct ref_dir *dir;
+	assert(direntry->flag & REF_DIR);
+	dir = &direntry->u.subdir;
 	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
 	dir->entries[dir->nr++] = entry;
 }
@@ -310,7 +313,7 @@ static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
 				break;
 			}
 			entry = create_dir_entry(refname_copy);
-			add_entry_to_dir(&direntry->u.subdir, entry);
+			add_entry(direntry, entry);
 		}
 		slash[1] = tmp;
 		assert(entry->flag & REF_DIR);
@@ -348,7 +351,7 @@ static int add_ref(struct ref_entry *direntry, struct ref_entry *ref)
 	direntry = find_containing_direntry(direntry, ref->name, 1);
 	if (!direntry)
 		return -1;
-	add_entry_to_dir(&direntry->u.subdir, ref);
+	add_entry(direntry, ref);
 	return 0;
 }
 
@@ -812,8 +815,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_entry_to_dir(&direntry->u.subdir,
-					 create_ref_entry(refname, sha1, flag, 1));
+			add_entry(direntry, create_ref_entry(refname, sha1, flag, 1));
 		}
 		free(refname);
 		closedir(d);
-- 
1.7.8
