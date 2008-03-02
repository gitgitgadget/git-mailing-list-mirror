From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] diff-lib.c: constness strengthening
Date: Sun,  2 Mar 2008 01:43:30 -0800
Message-ID: <1204451012-17487-2-git-send-email-gitster@pobox.com>
References: <1204451012-17487-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 10:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVkkD-000078-ER
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 10:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbYCBJnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 04:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbYCBJnw
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 04:43:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbYCBJnu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 04:43:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1797D224B
	for <git@vger.kernel.org>; Sun,  2 Mar 2008 04:43:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 65970224A for <git@vger.kernel.org>; Sun,  2 Mar 2008 04:43:48 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.468.g36990
In-Reply-To: <1204451012-17487-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75756>

The internal implementation of diff-index codepath used to use non const
pointer to pass sha1 around, but it did not have to.  With this, we can
also lose the private no_sha1[] array, as we can use the public null_sha1[]
array that exists exactly for the same purpose.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 94b150e..4581b59 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -472,22 +472,21 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 static void diff_index_show_file(struct rev_info *revs,
 				 const char *prefix,
 				 struct cache_entry *ce,
-				 unsigned char *sha1, unsigned int mode)
+				 const unsigned char *sha1, unsigned int mode)
 {
 	diff_addremove(&revs->diffopt, prefix[0], mode,
 		       sha1, ce->name, NULL);
 }
 
 static int get_stat_data(struct cache_entry *ce,
-			 unsigned char **sha1p,
+			 const unsigned char **sha1p,
 			 unsigned int *modep,
 			 int cached, int match_missing)
 {
-	unsigned char *sha1 = ce->sha1;
+	const unsigned char *sha1 = ce->sha1;
 	unsigned int mode = ce->ce_mode;
 
 	if (!cached) {
-		static unsigned char no_sha1[20];
 		int changed;
 		struct stat st;
 		if (lstat(ce->name, &st) < 0) {
@@ -501,7 +500,7 @@ static int get_stat_data(struct cache_entry *ce,
 		changed = ce_match_stat(ce, &st, 0);
 		if (changed) {
 			mode = ce_mode_from_stat(ce, st.st_mode);
-			sha1 = no_sha1;
+			sha1 = null_sha1;
 		}
 	}
 
@@ -514,7 +513,7 @@ static void show_new_file(struct rev_info *revs,
 			  struct cache_entry *new,
 			  int cached, int match_missing)
 {
-	unsigned char *sha1;
+	const unsigned char *sha1;
 	unsigned int mode;
 
 	/* New file in the index: it might actually be different in
@@ -533,7 +532,7 @@ static int show_modified(struct rev_info *revs,
 			 int cached, int match_missing)
 {
 	unsigned int mode, oldmode;
-	unsigned char *sha1;
+	const unsigned char *sha1;
 
 	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0) {
 		if (report_missing)
-- 
1.5.4.3.468.g36990

