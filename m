From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] describe: when failing, tell the user about options that work
Date: Wed, 28 Oct 2009 23:10:06 +0100
Message-ID: <956c69810977ac67ca2379a602fd7ffca3e0cae7.1256767275.git.trast@student.ethz.ch>
References: <7vmy3iaqfr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Gjh-0000hr-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 23:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbZJ1WLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbZJ1WLL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 18:11:11 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:43878 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbZJ1WLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 18:11:11 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 28 Oct
 2009 23:11:13 +0100
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 28 Oct
 2009 23:10:52 +0100
X-Mailer: git-send-email 1.6.5.1.161.g3b9c0
In-Reply-To: <7vmy3iaqfr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131502>

Users seem to call git-describe without reading the manpage, and then
wonder why it doesn't work with unannotated tags by default.

Make a minimal effort towards seeing if there would have been
unannotated tags, and tell the user.  Specifically, we say that --tags
could work if we found any unannotated tags.  If not, we say that
--always would have given results.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > However, it could be written e.g.
> >
> >   No annotated tags can describe '%s'.  However, there were
> >   unannotated tags: try --tags.
> 
> Sounds better.

Then let's make it so.  Sorry for taking so long.


 builtin-describe.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 2dcfd3d..4ea6f88 100644
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
+			die("No annotated tags can describe '%s'.\n"
+			    "However, there were unannotated tags: try --tags.",
+			    sha1_to_hex(sha1));
+		else
+			die("No tags can describe '%s'.\n"
+			    "Try --always, or create some tags.",
+			    sha1_to_hex(sha1));
 	}
 
 	qsort(all_matches, match_cnt, sizeof(all_matches[0]), compare_pt);
-- 
1.6.5.1.161.g3b9c0
