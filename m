From: Jeff King <peff@peff.net>
Subject: [PATCH 30/68] ref-filter: drop sprintf and strcpy calls
Date: Thu, 24 Sep 2015 17:07:12 -0400
Message-ID: <20150924210711.GA30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDmr-0004jk-C2
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbbIXVKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:10:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:35972 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753250AbbIXVHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:14 -0400
Received: (qmail 11970 invoked by uid 102); 24 Sep 2015 21:07:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:14 -0500
Received: (qmail 29237 invoked by uid 107); 24 Sep 2015 21:07:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:12 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278628>

The ref-filter code comes from for-each-ref, and inherited a
number of raw sprintf and strcpy calls. These are generally
all safe, as we custom-size the buffers, or are formatting
numbers into sufficiently large buffers. But we can make the
resulting code even simpler and more obviously correct by
using some of our helper functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 70 +++++++++++++++++++-----------------------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f38dee4..1f71870 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -192,9 +192,7 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
 			    struct atom_value *v)
 {
 	if (!strcmp(name, "objectname")) {
-		char *s = xmalloc(41);
-		strcpy(s, sha1_to_hex(sha1));
-		v->s = s;
+		v->s = xstrdup(sha1_to_hex(sha1));
 		return 1;
 	}
 	if (!strcmp(name, "objectname:short")) {
@@ -219,10 +217,8 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		if (!strcmp(name, "objecttype"))
 			v->s = typename(obj->type);
 		else if (!strcmp(name, "objectsize")) {
-			char *s = xmalloc(40);
-			sprintf(s, "%lu", sz);
 			v->ul = sz;
-			v->s = s;
+			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
 			grab_objectname(name, obj->sha1, v);
@@ -246,11 +242,8 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 			v->s = tag->tag;
 		else if (!strcmp(name, "type") && tag->tagged)
 			v->s = typename(tag->tagged->type);
-		else if (!strcmp(name, "object") && tag->tagged) {
-			char *s = xmalloc(41);
-			strcpy(s, sha1_to_hex(tag->tagged->sha1));
-			v->s = s;
-		}
+		else if (!strcmp(name, "object") && tag->tagged)
+			v->s = xstrdup(sha1_to_hex(tag->tagged->sha1));
 	}
 }
 
@@ -268,32 +261,22 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "tree")) {
-			char *s = xmalloc(41);
-			strcpy(s, sha1_to_hex(commit->tree->object.sha1));
-			v->s = s;
+			v->s = xstrdup(sha1_to_hex(commit->tree->object.sha1));
 		}
-		if (!strcmp(name, "numparent")) {
-			char *s = xmalloc(40);
+		else if (!strcmp(name, "numparent")) {
 			v->ul = commit_list_count(commit->parents);
-			sprintf(s, "%lu", v->ul);
-			v->s = s;
+			v->s = xstrfmt("%lu", v->ul);
 		}
 		else if (!strcmp(name, "parent")) {
-			int num = commit_list_count(commit->parents);
-			int i;
 			struct commit_list *parents;
-			char *s = xmalloc(41 * num + 1);
-			v->s = s;
-			for (i = 0, parents = commit->parents;
-			     parents;
-			     parents = parents->next, i = i + 41) {
+			struct strbuf s = STRBUF_INIT;
+			for (parents = commit->parents; parents; parents = parents->next) {
 				struct commit *parent = parents->item;
-				strcpy(s+i, sha1_to_hex(parent->object.sha1));
-				if (parents->next)
-					s[i+40] = ' ';
+				if (parents != commit->parents)
+					strbuf_addch(&s, ' ');
+				strbuf_addstr(&s, sha1_to_hex(parent->object.sha1));
 			}
-			if (!i)
-				*s = '\0';
+			v->s = strbuf_detach(&s, NULL);
 		}
 	}
 }
@@ -700,7 +683,6 @@ static void populate_value(struct ref_array_item *ref)
 			else if (!strcmp(formatp, "track") &&
 				 (starts_with(name, "upstream") ||
 				  starts_with(name, "push"))) {
-				char buf[40];
 
 				if (stat_tracking_info(branch, &num_ours,
 						       &num_theirs, NULL))
@@ -708,17 +690,13 @@ static void populate_value(struct ref_array_item *ref)
 
 				if (!num_ours && !num_theirs)
 					v->s = "";
-				else if (!num_ours) {
-					sprintf(buf, "[behind %d]", num_theirs);
-					v->s = xstrdup(buf);
-				} else if (!num_theirs) {
-					sprintf(buf, "[ahead %d]", num_ours);
-					v->s = xstrdup(buf);
-				} else {
-					sprintf(buf, "[ahead %d, behind %d]",
-						num_ours, num_theirs);
-					v->s = xstrdup(buf);
-				}
+				else if (!num_ours)
+					v->s = xstrfmt("[behind %d]", num_theirs);
+				else if (!num_theirs)
+					v->s = xstrfmt("[ahead %d]", num_ours);
+				else
+					v->s = xstrfmt("[ahead %d, behind %d]",
+						       num_ours, num_theirs);
 				continue;
 			} else if (!strcmp(formatp, "trackshort") &&
 				   (starts_with(name, "upstream") ||
@@ -745,12 +723,8 @@ static void populate_value(struct ref_array_item *ref)
 
 		if (!deref)
 			v->s = refname;
-		else {
-			int len = strlen(refname);
-			char *s = xmalloc(len + 4);
-			sprintf(s, "%s^{}", refname);
-			v->s = s;
-		}
+		else
+			v->s = xstrfmt("%s^{}", refname);
 	}
 
 	for (i = 0; i < used_atom_cnt; i++) {
-- 
2.6.0.rc3.454.g204ad51
