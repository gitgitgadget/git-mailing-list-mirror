From: mhagger@alum.mit.edu
Subject: [PATCH 17/28] add_ref(): take (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:30 +0200
Message-ID: <1319804921-17545-18-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlb9-0004sU-RA
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab1J1Mbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:45 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:55892 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753397Ab1J1Mbo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:44 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-NB; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184393>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index f402d39..f5aaafe 100644
--- a/refs.c
+++ b/refs.c
@@ -380,9 +380,11 @@ static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refnam
  * subdirectories as necessary.  dir must represent the top-level
  * directory.  Return 0 on success.
  */
-static int add_ref(struct ref_dir *dir, struct ref_entry *ref)
+static int add_ref(struct ref_entry *direntry, struct ref_entry *ref)
 {
-	dir = find_containing_dir(dir, ref->name, 1);
+	struct ref_dir *dir;
+	assert(direntry->flag & REF_DIR);
+	dir = find_containing_dir(&direntry->u.subdir, ref->name, 1);
 	if (!dir)
 		return -1;
 	add_entry_to_dir(dir, ref);
@@ -738,7 +740,7 @@ static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag);
-			add_ref(&direntry->u.subdir, last);
+			add_ref(direntry, last);
 			continue;
 		}
 		if (last &&
@@ -754,7 +756,7 @@ void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
 	if (!extra_refs)
 		extra_refs = create_dir_entry("");
-	add_ref(&extra_refs->u.subdir, create_ref_entry(refname, sha1, flag));
+	add_ref(extra_refs, create_ref_entry(refname, sha1, flag));
 }
 
 void clear_extra_refs(void)
-- 
1.7.7
