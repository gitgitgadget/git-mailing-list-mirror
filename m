From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/10] bisect: store good revisions in a "sha1_array"
Date: Sat, 09 May 2009 17:55:40 +0200
Message-ID: <20090509155548.5387.1802.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:03:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p1m-00065t-3Y
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbZEIQDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbZEIQDr
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:47 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:37220 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbZEIQDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:39 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 6D78CD48165;
	Sat,  9 May 2009 18:03:33 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 3A87DD48118;
	Sat,  9 May 2009 18:03:31 +0200 (CEST)
X-git-sha1: e1ade4d6ae4f3a3def4760831e0a6c62bb5a4456 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118665>

This will make it easier to use good revisions for checking merge
bases later.

To simplify the code, a new "sha1_array_push" function is also
introduced.

And while at it we move the earlier part of the code to fill the
argv that is passed to "setup_revisions", so that all this code is
now completely after "read_bisect_refs".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index f99637d..7976cbf 100644
--- a/bisect.c
+++ b/bisect.c
@@ -15,6 +15,7 @@ struct sha1_array {
 	int sha1_alloc;
 };
 
+static struct sha1_array good_revs;
 static struct sha1_array skipped_revs;
 
 static const char **rev_argv;
@@ -418,18 +419,22 @@ static void rev_argv_push(const unsigned char *sha1, const char *format)
 	rev_argv[rev_argv_nr++] = strbuf_detach(&buf, NULL);
 }
 
+static void sha1_array_push(struct sha1_array *array,
+			    const unsigned char *sha1)
+{
+	ALLOC_GROW(array->sha1, array->sha1_nr + 1, array->sha1_alloc);
+	hashcpy(array->sha1[array->sha1_nr++], sha1);
+}
+
 static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
 		current_bad_sha1 = sha1;
-		rev_argv_push(sha1, "%s");
 	} else if (!prefixcmp(refname, "good-")) {
-		rev_argv_push(sha1, "^%s");
+		sha1_array_push(&good_revs, sha1);
 	} else if (!prefixcmp(refname, "skip-")) {
-		ALLOC_GROW(skipped_revs.sha1, skipped_revs.sha1_nr + 1,
-			   skipped_revs.sha1_alloc);
-		hashcpy(skipped_revs.sha1[skipped_revs.sha1_nr++], sha1);
+		sha1_array_push(&skipped_revs, sha1);
 	}
 
 	return 0;
@@ -524,16 +529,23 @@ struct commit_list *filter_skipped(struct commit_list *list,
 
 static void bisect_rev_setup(struct rev_info *revs, const char *prefix)
 {
+	int i;
+
 	init_revisions(revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
+	if (read_bisect_refs())
+		die("reading bisect refs failed");
+
 	/* argv[0] will be ignored by setup_revisions */
 	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
 	rev_argv[rev_argv_nr++] = xstrdup("bisect_rev_setup");
 
-	if (read_bisect_refs())
-		die("reading bisect refs failed");
+	rev_argv_push(current_bad_sha1, "%s");
+
+	for (i = 0; i < good_revs.sha1_nr; i++)
+		rev_argv_push(good_revs.sha1[i], "^%s");
 
 	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
 	rev_argv[rev_argv_nr++] = xstrdup("--");
-- 
1.6.3.rc1.112.g17e25
