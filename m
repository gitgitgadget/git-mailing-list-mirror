From: mhagger@alum.mit.edu
Subject: [PATCH 16/28] read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
Date: Fri, 28 Oct 2011 14:28:29 +0200
Message-ID: <1319804921-17545-17-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlae-0004ci-NI
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708Ab1J1MbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:14 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55816 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686Ab1J1MbN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:13 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Mf; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184388>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index e7d4482..f402d39 100644
--- a/refs.c
+++ b/refs.c
@@ -715,12 +715,13 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
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
@@ -737,7 +738,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag);
-			add_ref(dir, last);
+			add_ref(&direntry->u.subdir, last);
 			continue;
 		}
 		if (last &&
@@ -777,7 +778,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 			packed_refs_file = git_path("packed-refs");
 		f = fopen(packed_refs_file, "r");
 		if (f) {
-			read_packed_refs(f, &refs->packed->u.subdir);
+			read_packed_refs(f, refs->packed);
 			fclose(f);
 		}
 	}
-- 
1.7.7
