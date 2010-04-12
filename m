From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 5/5] describe: Break annotated tag ties by tagger date
Date: Mon, 12 Apr 2010 16:25:29 -0700
Message-ID: <1271114729-18166-5-git-send-email-spearce@spearce.org>
References: <20100411024008.GC23075@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 01:33:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1T86-0000wh-JK
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 01:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab0DLXdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 19:33:18 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:21396 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab0DLXdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 19:33:17 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2216302qwh.37
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 16:33:16 -0700 (PDT)
Received: by 10.229.212.9 with SMTP id gq9mr4647732qcb.84.1271114753909;
        Mon, 12 Apr 2010 16:25:53 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id w30sm6719869qce.16.2010.04.12.16.25.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 16:25:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.246.g978a8
In-Reply-To: <20100411024008.GC23075@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144776>

If more than one annotated tag points at the same commit, use the
tag whose tagger field has a more recent date stamp.  This resolves
non-deterministic cases where the maintainer has done:

  $ git tag -a -m "2.1-rc1" v2.1-rc1  deadbeef
  $ git tag -a -m "2.1"     v2.1      deadbeef

If the tag is an older-style annotated tag with no tagger date,
we assume a date stamp of 1 second after the UNIX epoch. This will
cause us to prefer an annotated tag that has a valid date, or to
simply avoid scanning the tag object again if a 3rd tag was found
for the same commit.

We could also try to consider the tag object chain, favoring a tag
that "includes" another one:

  $ git tag -a -m "2.1-rc0" v2.1-rc1  deadbeef
  $ git tag -a -m "2.1"     v2.1      v2.1-rc1

However traversing the tag's object chain looking for inclusion
is much more complicated.  Its already very likely that even in
these cases the v2.1 tag will have a more recent tagger date than
v2.1-rc1, so with this change describe should still resolve this
by selecting the more recent v2.1.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin/describe.c  |   49 +++++++++++++++++++++++++++++++++++++++++++++----
 t/t6120-describe.sh |    8 +++++---
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 71be2a9..43caff2 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -35,7 +35,8 @@ static const char *diff_index_args[] = {
 
 struct commit_name {
 	struct tag *tag;
-	int prio; /* annotated tag = 2, tag = 1, head = 0 */
+	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
+	unsigned name_checked:1;
 	unsigned char sha1[20];
 	char path[FLEX_ARRAY]; /* more */
 };
@@ -43,18 +44,53 @@ static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
 
+static int replace_name(struct commit_name *e,
+			       int prio,
+			       const unsigned char *sha1,
+			       struct tag **tag)
+{
+	if (!e || e->prio < prio)
+		return 1;
+
+	if (e->prio == 2 && prio == 2) {
+		/* Multiple annotated tags point to the same commit.
+		 * Select one to keep based upon their tagger date.
+		 */
+		struct tag *t;
+
+		if (!e->tag) {
+			t = lookup_tag(e->sha1);
+			if (!t || parse_tag(t))
+				return 1;
+			e->tag = t;
+		}
+
+		t = lookup_tag(sha1);
+		if (!t || parse_tag(t))
+			return 0;
+		*tag = t;
+
+		if (e->tag->date < t->date)
+			return 1;
+	}
+
+	return 0;
+}
+
 static void add_to_known_names(const char *path,
 			       struct commit *commit,
 			       int prio,
 			       const unsigned char *sha1)
 {
 	struct commit_name *e = commit->util;
-	if (!e || e->prio < prio) {
+	struct tag *tag = NULL;
+	if (replace_name(e, prio, sha1, &tag)) {
 		size_t len = strlen(path)+1;
 		free(e);
 		e = xmalloc(sizeof(struct commit_name) + len);
-		e->tag = NULL;
+		e->tag = tag;
 		e->prio = prio;
+		e->name_checked = 0;
 		hashcpy(e->sha1, sha1);
 		memcpy(e->path, path, len);
 		commit->util = e;
@@ -165,10 +201,15 @@ static void display_name(struct commit_name *n)
 {
 	if (n->prio == 2 && !n->tag) {
 		n->tag = lookup_tag(n->sha1);
-		if (!n->tag || parse_tag(n->tag) || !n->tag->tag)
+		if (!n->tag || parse_tag(n->tag))
 			die("annotated tag %s not available", n->path);
+	}
+	if (n->tag && !n->name_checked) {
+		if (!n->tag->tag)
+			die("annotated tag %s has no embedded name", n->path);
 		if (strcmp(n->tag->tag, all ? n->path + 5 : n->path))
 			warning("tag '%s' is really '%s' here", n->tag->tag, n->path);
+		n->name_checked = 1;
 	}
 
 	if (n->tag)
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 065dead..876d1ab 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -8,7 +8,7 @@ test_description='test describe
  o----o----o----o----o----.    /
        \        A    c        /
         .------------o---o---o
-                     D   e
+                   D,R   e
 '
 . ./test-lib.sh
 
@@ -68,6 +68,8 @@ test_expect_success setup '
 	echo D >another && git add another && git commit -m D &&
 	test_tick &&
 	git tag -a -m D D &&
+	test_tick &&
+	git tag -a -m R R &&
 
 	test_tick &&
 	echo DD >another && git commit -a -m another &&
@@ -89,10 +91,10 @@ test_expect_success setup '
 
 check_describe A-* HEAD
 check_describe A-* HEAD^
-check_describe D-* HEAD^^
+check_describe R-* HEAD^^
 check_describe A-* HEAD^^2
 check_describe B HEAD^^2^
-check_describe D-* HEAD^^^
+check_describe R-* HEAD^^^
 
 check_describe c-* --tags HEAD
 check_describe c-* --tags HEAD^
-- 
1.7.1.rc1.246.g978a8
