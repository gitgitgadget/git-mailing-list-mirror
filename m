From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] describe: when failing, tell the user about options that work
Date: Thu, 22 Oct 2009 17:44:39 +0200
Message-ID: <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch>
References: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 17:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0zrC-0000Z7-ST
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 17:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbZJVPpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 11:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbZJVPpc
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 11:45:32 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:12375 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756128AbZJVPpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 11:45:31 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 17:45:34 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 22 Oct
 2009 17:45:13 +0200
X-Mailer: git-send-email 1.6.5.1.70.g1383ae
In-Reply-To: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131028>

Users seem to call git-describe without reading the manpage, and then
wonder why it doesn't work with unannotated tags by default.

Make a minimal effort towards seeing if there would have been
unannotated tags, and tell the user.  Specifically, we say that --tags
could work if we found any unannotated tags.  If not, we say that
--always would have given results.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Eugene Sajine wrote:
> [git-describe fails if you don't have annotated tags]
>  
> Thanks! It is working ok.
> Although it is probably not the best error handling.
> I believe git should fail with some meaningful message in this case...

We already had most of the information available, so hey, why not.


 builtin-describe.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 2dcfd3d..1ffa0d8 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -96,8 +96,6 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void 
 	if (!all) {
 		if (!prio)
 			return 0;
-		if (!tags && prio < 2)
-			return 0;
 	}
 	add_to_known_names(all ? path + 5 : path + 10, commit, prio, sha1);
 	return 0;
@@ -184,6 +182,7 @@ static void describe(const char *arg, int last_one)
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
 	unsigned long seen_commits = 0;
+	unsigned int unannotated_cnt = 0;
 
 	if (get_sha1(arg, sha1))
 		die("Not a valid object name %s", arg);
@@ -217,7 +216,9 @@ static void describe(const char *arg, int last_one)
 		seen_commits++;
 		n = c->util;
 		if (n) {
-			if (match_cnt < max_candidates) {
+			if (!tags && !all && n->prio < 2) {
+				unannotated_cnt++;
+			} else if (match_cnt < max_candidates) {
 				struct possible_tag *t = &all_matches[match_cnt++];
 				t->name = n;
 				t->depth = seen_commits - 1;
@@ -259,7 +260,14 @@ static void describe(const char *arg, int last_one)
 			printf("%s\n", find_unique_abbrev(sha1, abbrev));
 			return;
 		}
-		die("cannot describe '%s'", sha1_to_hex(sha1));
+		if (unannotated_cnt)
+			die("cannot describe '%s'"
+			    " with only\nannotated tags. Try --tags.",
+			    sha1_to_hex(sha1));
+		else
+			die("cannot describe '%s'"
+			    " with tags\nTry --always, or create some tags.",
+			    sha1_to_hex(sha1));
 	}
 
 	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
-- 
1.6.5.1.70.g1383ae
