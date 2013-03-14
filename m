From: Michal Novotny <minovotn@redhat.com>
Subject: [PATCH v2] git-tag: Allow --points-at syntax to create a tag pointing to specified commit
Date: Thu, 14 Mar 2013 13:34:54 +0100
Message-ID: <4150f65f3e425d6120ed80c6bec36c1fe209a876.1363264398.git.minovotn@redhat.com>
Cc: Michal Novotny <minovotn@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 13:35:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG7NY-0006Sd-WE
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 13:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582Ab3CNMe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 08:34:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6867 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab3CNMe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 08:34:59 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2ECYxhV020244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 14 Mar 2013 08:34:59 -0400
Received: from miglaptop.brq.redhat.com (dhcp-1-114.brq.redhat.com [10.34.1.114])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r2ECYvlB006065;
	Thu, 14 Mar 2013 08:34:58 -0400
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218130>

This patch adds the option to specify SHA-1 commit hash using --points-at
option of git tag to create a tag pointing to a historical commit.

This was pretty easy in the past for the lightweight tags that are just simple
pointers (by creating .git/refs/tags/$tagname with SHA-1 hash) but it was not
possible for signed and annotated commits.

It's been tested for all of the tag types mentioned - lightweight tags, signed
tags and also annotated tags and everything is working fine in all scenarios
mentioned above.

Differences between v1 and v2 (this one):
 - The bogus sha1-lookup.h hunk has been removed as it's not required and
   I accidentally forgot to remove it before posting v1

Michal

Signed-off-by: Michal Novotny <minovotn@redhat.com>
---
 builtin/tag.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index f826688..f642acd 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -437,7 +437,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1, list = 0,
-		delete = 0, verify = 0;
+		delete = 0, verify = 0, points_at_commit = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -521,8 +521,24 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("-n option is only allowed with -l."));
 	if (with_commit)
 		die(_("--contains option is only allowed with -l."));
-	if (points_at.nr)
-		die(_("--points-at option is only allowed with -l."));
+	if (points_at.nr) {
+		if (points_at.nr > 1)
+			die(_("--points-at option is only allowed with -l or a single "
+				"SHA-1 hash is allowed to create a tag to commit."));
+		else {
+			unsigned char *ref = points_at.sha1[0];
+
+			struct object *obj = parse_object(ref);
+			if ((obj != NULL) && (obj->type == OBJ_COMMIT)) {
+				memcpy(object, ref, 20);
+				points_at_commit = 1;
+			}
+			else
+				die(_("--points-at option points to an invalid commit"));
+
+			free(ref);
+		}
+	}
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
@@ -548,12 +564,16 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	tag = argv[0];
 
-	object_ref = argc == 2 ? argv[1] : "HEAD";
 	if (argc > 2)
 		die(_("too many params"));
 
-	if (get_sha1(object_ref, object))
-		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
+	/* Option --points-at option is setting this already */
+	if (!points_at_commit) {
+		object_ref = argc == 2 ? argv[1] : "HEAD";
+
+		if (get_sha1(object_ref, object))
+			die(_("Failed to resolve '%s' as a valid ref."), object_ref);
+	}
 
 	if (strbuf_check_tag_ref(&ref, tag))
 		die(_("'%s' is not a valid tag name."), tag);
-- 
1.7.11.7
