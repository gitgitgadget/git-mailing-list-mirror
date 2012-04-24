From: mhagger@alum.mit.edu
Subject: [PATCH 04/30] get_ref_dir(): require that the dirname argument ends in '/'
Date: Wed, 25 Apr 2012 00:45:10 +0200
Message-ID: <1335307536-26914-5-git-send-email-mhagger@alum.mit.edu>
References: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 00:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMoat-00059D-EP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 00:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170Ab2DXWwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 18:52:00 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:48850 "EHLO
	eddie.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758079Ab2DXWv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 18:51:57 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Apr 2012 18:51:57 EDT
Received: from michael.berlin.jpk.com (unknown [192.168.101.152])
	by eddie.berlin.jpk.com (Postfix) with ESMTP id 02506248144;
	Wed, 25 Apr 2012 00:45:56 +0200 (CEST)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335307536-26914-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196259>

From: Michael Haggerty <mhagger@alum.mit.edu>

This removes some conditional code and makes it consistent with the
way that direntry names are stored.  Please note that this function is
never used on the top-level .git directory; it is always called for
directories at level .git/refs or deeper.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index dc2b4df..01fcdc7 100644
--- a/refs.c
+++ b/refs.c
@@ -749,13 +749,17 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 			create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
+/*
+ * Read the loose references for refs from the namespace dirname.
+ * dirname must end with '/'.
+ */
 static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 			struct ref_dir *dir)
 {
 	DIR *d;
 	const char *path;
 	struct dirent *de;
-	int dirnamelen;
+	int dirnamelen = strlen(dirname);
 	struct strbuf refname;
 
 	if (*refs->name)
@@ -767,13 +771,8 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 	if (!d)
 		return;
 
-	dirnamelen = strlen(dirname);
 	strbuf_init(&refname, dirnamelen + 257);
 	strbuf_add(&refname, dirname, dirnamelen);
-	if (dirnamelen && dirname[dirnamelen-1] != '/') {
-		strbuf_addch(&refname, '/');
-		dirnamelen++;
-	}
 
 	while ((de = readdir(d)) != NULL) {
 		unsigned char sha1[20];
@@ -792,6 +791,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 		if (stat(refdir, &st) < 0) {
 			/* Silently ignore. */
 		} else if (S_ISDIR(st.st_mode)) {
+			strbuf_addch(&refname, '/');
 			get_ref_dir(refs, refname.buf, dir);
 		} else {
 			if (*refs->name) {
@@ -816,7 +816,7 @@ static void get_ref_dir(struct ref_cache *refs, const char *dirname,
 static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
-		get_ref_dir(refs, "refs", &refs->loose);
+		get_ref_dir(refs, "refs/", &refs->loose);
 		refs->did_loose = 1;
 	}
 	return &refs->loose;
-- 
1.7.10
