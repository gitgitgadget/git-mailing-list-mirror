From: mhagger@alum.mit.edu
Subject: [PATCH 20/28] add_entry(): take (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:33 +0200
Message-ID: <1319804921-17545-21-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlbZ-00056m-Vn
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab1J1McE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:32:04 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:55947 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755643Ab1J1McD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:32:03 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Om; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184398>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index e91cc15..3567d56 100644
--- a/refs.c
+++ b/refs.c
@@ -234,8 +234,11 @@ static void free_ref_entry(struct ref_entry *entry)
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
@@ -352,7 +355,7 @@ static struct ref_entry *find_containing_direntry(struct ref_entry *direntry,
 				break;
 			}
 			entry = create_dir_entry(refname_copy);
-			add_entry_to_dir(&direntry->u.subdir, entry);
+			add_entry(direntry, entry);
 		}
 		slash[1] = tmp;
 		assert(entry->flag & REF_DIR);
@@ -390,7 +393,7 @@ static int add_ref(struct ref_entry *direntry, struct ref_entry *ref)
 	direntry = find_containing_direntry(direntry, ref->name, 1);
 	if (!direntry)
 		return -1;
-	add_entry_to_dir(&direntry->u.subdir, ref);
+	add_entry(direntry, ref);
 	return 0;
 }
 
@@ -858,8 +861,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname)
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			add_entry_to_dir(&direntry->u.subdir,
-					 create_ref_entry(refname, sha1, flag));
+			add_entry(direntry, create_ref_entry(refname, sha1, flag));
 		}
 		free(refname);
 		closedir(d);
-- 
1.7.7
