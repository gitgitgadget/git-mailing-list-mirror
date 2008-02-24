From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/6] Teach git-describe to use peeled ref information when scanning tags
Date: Sun, 24 Feb 2008 03:07:25 -0500
Message-ID: <20080224080725.GC22587@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTBuO-0004Lv-0Z
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbYBXIHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbYBXIHw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:07:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42955 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbYBXIH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:07:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTBtN-0001fQ-Te; Sun, 24 Feb 2008 03:07:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B616220FBAE; Sun, 24 Feb 2008 03:07:25 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74907>

By using the peeled ref information inside of the packed-refs file we
can avoid opening tag objects to obtain the commits they reference.
This speeds up git-describe when there are a large number of tags
in the repository as we have less objects to parse before we can
start commit matching.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 3428483..bfd25e2 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -46,19 +46,30 @@ static void add_to_known_names(const char *path,
 
 static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct commit *commit;
 	struct object *object;
-	int prio;
+	unsigned char peeled[20];
+	int is_tag, prio;
+
+	if (!peel_ref(path, peeled) && !is_null_sha1(peeled)) {
+		commit = lookup_commit_reference_gently(peeled, 1);
+		if (!commit)
+			return 0;
+		is_tag = !!hashcmp(sha1, commit->object.sha1);
+	} else {
+		commit = lookup_commit_reference_gently(sha1, 1);
+		object = parse_object(sha1);
+		if (!commit || !object)
+			return 0;
+		is_tag = object->type == OBJ_TAG;
+	}
 
-	if (!commit)
-		return 0;
-	object = parse_object(sha1);
 	/* If --all, then any refs are used.
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
 	if (!prefixcmp(path, "refs/tags/")) {
-		if (object->type == OBJ_TAG) {
+		if (is_tag) {
 			prio = 2;
 			if (pattern && fnmatch(pattern, path + 10, 0))
 				prio = 0;
-- 
1.5.4.3.295.g6b554
