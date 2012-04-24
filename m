From: mhagger@alum.mit.edu
Subject: [PATCH 15/30] read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
Date: Wed, 25 Apr 2012 00:45:21 +0200
Message-ID: <1335307536-26914-16-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:57:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMofi-00005X-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758483Ab2DXW5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:57:08 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:60978 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758271Ab2DXW5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:57:00 -0400
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 815AA24815F;
	Wed, 25 Apr 2012 00:46:12 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196265>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index c40cbd6..694d802 100644
--- a/refs.c
+++ b/refs.c
@@ -708,12 +708,13 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 	return line;
 }
 
-static void read_packed_refs(FILE *f, struct ref_dir *dir)
+static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 {
 	struct ref_entry *last = NULL;
 	char refline[PATH_MAX];
 	int flag = REF_ISPACKED;
 
+	assert(direntry->flag & REF_DIR);
 	while (fgets(refline, sizeof(refline), f)) {
 		unsigned char sha1[20];
 		const char *refname;
@@ -730,7 +731,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag, 1);
-			add_ref(dir, last);
+			add_ref(&direntry->u.subdir, last);
 			continue;
 		}
 		if (last &&
@@ -755,7 +756,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 			packed_refs_file = git_path("packed-refs");
 		f = fopen(packed_refs_file, "r");
 		if (f) {
-			read_packed_refs(f, &refs->packed->u.subdir);
+			read_packed_refs(f, refs->packed);
 			fclose(f);
 		}
 	}
-- 
1.7.10
