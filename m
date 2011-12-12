From: mhagger@alum.mit.edu
Subject: [PATCH v2 39/51] read_packed_refs(): take (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:46 +0100
Message-ID: <1323668338-1764-40-git-send-email-mhagger@alum.mit.edu>
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
	id 1RZydU-0000k3-6e
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab1LLFkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:52 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34924 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab1LLFks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:48 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aq015577;
	Mon, 12 Dec 2011 06:40:39 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186852>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index df7416f..0d8fdf0 100644
--- a/refs.c
+++ b/refs.c
@@ -670,12 +670,13 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
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
@@ -692,7 +693,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag, 1);
-			add_ref(dir, last);
+			add_ref(&direntry->u.subdir, last);
 			continue;
 		}
 		if (last &&
@@ -732,7 +733,7 @@ static struct ref_entry *get_packed_refs(struct ref_cache *refs)
 			packed_refs_file = git_path("packed-refs");
 		f = fopen(packed_refs_file, "r");
 		if (f) {
-			read_packed_refs(f, &refs->packed->u.subdir);
+			read_packed_refs(f, refs->packed);
 			fclose(f);
 		}
 	}
-- 
1.7.8
