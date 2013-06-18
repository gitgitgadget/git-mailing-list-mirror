From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH v2] name-rev: Allow to specify a subpath for --refs option
Date: Tue, 18 Jun 2013 21:35:31 +0900
Message-ID: <1371558931-2980-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org, Namhyung Kim <namhyung.kim@lge.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:35:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uov8a-0000ml-RB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab3FRMfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:35:48 -0400
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:59014 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab3FRMfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:35:48 -0400
X-AuditID: 9c930197-b7beaae000004876-be-51c054227c7e
Received: from sejong.aot.lge.com ( [10.177.220.181])
	by LGEMRELSE7Q.lge.com (Symantec Brightmail Gateway) with SMTP id 8A.06.18550.22450C15; Tue, 18 Jun 2013 21:35:46 +0900 (KST)
X-Mailer: git-send-email 1.7.11.7
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228221>

From: Namhyung Kim <namhyung.kim@lge.com>

In its current form, when an user wants to filter specific ref using
 --refs option, she needs to give something like --refs=refs/tags/v1.*.

It'd be convenient providing a way to specify a subpath of ref pattern.
For example, --refs=origin/* can find refs/remotes/origin/master by
searching the pattern against its substrings in turn:

  refs/remotes/origin/master
  remotes/origin/master
  origin/master

If it finds a match in a subpath, unambigous part of the ref path will
be removed in the output.

Many thanks to Junio C. Hamano for suggesting better logic and code.

Signed-off-by: Namhyung Kim <namhyung.kim@lge.com>
---
 Documentation/git-name-rev.txt |  3 ++-
 builtin/name-rev.c             | 36 +++++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index ad1d146..6b0f1ba 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -25,7 +25,8 @@ OPTIONS
 	Do not use branch names, but only tags to name the commits
 
 --refs=<pattern>::
-	Only use refs whose names match a given shell pattern.
+	Only use refs whose names match a given shell pattern.  The pattern
+	can be one of branch name, tag name or fully qualified ref name.
 
 --all::
 	List all commits reachable from all refs
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6238247..87d4854 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -82,6 +82,20 @@ copy_data:
 	}
 }
 
+static int subpath_matches(const char *path, const char *filter)
+{
+	const char *subpath = path;
+
+	while (subpath) {
+		if (!fnmatch(filter, subpath, 0))
+			return subpath - path;
+		subpath = strchr(subpath, '/');
+		if (subpath)
+			subpath++;
+	}
+	return -1;
+}
+
 struct name_ref_data {
 	int tags_only;
 	int name_only;
@@ -92,13 +106,23 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 {
 	struct object *o = parse_object(sha1);
 	struct name_ref_data *data = cb_data;
+	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
 
 	if (data->tags_only && prefixcmp(path, "refs/tags/"))
 		return 0;
 
-	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
-		return 0;
+	if (data->ref_filter) {
+		switch (subpath_matches(path, data->ref_filter)) {
+		case -1: /* did not match */
+			return 0;
+		case 0:  /* matched fully */
+			break;
+		default: /* matched subpath */
+			can_abbreviate_output = 1;
+			break;
+		}
+	}
 
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
@@ -110,12 +134,10 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
-		if (!prefixcmp(path, "refs/heads/"))
+		if (can_abbreviate_output)
+			path = shorten_unambiguous_ref(path, 0);
+		else if (!prefixcmp(path, "refs/heads/"))
 			path = path + 11;
-		else if (data->tags_only
-		    && data->name_only
-		    && !prefixcmp(path, "refs/tags/"))
-			path = path + 10;
 		else if (!prefixcmp(path, "refs/"))
 			path = path + 5;
 
-- 
1.7.11.7
