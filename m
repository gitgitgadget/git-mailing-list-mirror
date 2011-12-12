From: mhagger@alum.mit.edu
Subject: [PATCH v2 40/51] add_ref(): take (ref_entry *) instead of (ref_dir *)
Date: Mon, 12 Dec 2011 06:38:47 +0100
Message-ID: <1323668338-1764-41-git-send-email-mhagger@alum.mit.edu>
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
	id 1RZydU-0000k3-PS
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab1LLFky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:54 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34936 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab1LLFku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:50 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ar015577;
	Mon, 12 Dec 2011 06:40:41 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186853>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 0d8fdf0..439545b 100644
--- a/refs.c
+++ b/refs.c
@@ -338,9 +338,11 @@ static struct ref_entry *find_ref(struct ref_entry *direntry, const char *refnam
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
@@ -693,7 +695,7 @@ static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
 			last = create_ref_entry(refname, sha1, flag, 1);
-			add_ref(&direntry->u.subdir, last);
+			add_ref(direntry, last);
 			continue;
 		}
 		if (last &&
@@ -709,7 +711,7 @@ void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 {
 	if (!extra_refs)
 		extra_refs = create_dir_entry("");
-	add_ref(&extra_refs->u.subdir, create_ref_entry(refname, sha1, flag, 0));
+	add_ref(extra_refs, create_ref_entry(refname, sha1, flag, 0));
 }
 
 void clear_extra_refs(void)
-- 
1.7.8
