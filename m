From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/6] Avoid accessing non-tag refs in git-describe unless --all is requested
Date: Sun, 24 Feb 2008 03:07:28 -0500
Message-ID: <20080224080728.GD22587@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTBua-0004Lv-57
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbYBXIHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbYBXIHy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:07:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42975 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbYBXIHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:07:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTBtQ-0001fZ-9e; Sun, 24 Feb 2008 03:07:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1E6C920FBC9; Sun, 24 Feb 2008 03:07:28 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74909>

If we aren't going to use a ref there is no reason for us to open
its object from the object database.  This avoids opening any of
the head commits reachable from refs/heads/ unless they are also
reachable through the commit we have been asked to describe and
we need to walk through it to find a tag.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index bfd25e2..9c958bd 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -46,11 +46,15 @@ static void add_to_known_names(const char *path,
 
 static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
+	int might_be_tag = !prefixcmp(path, "refs/tags/");
 	struct commit *commit;
 	struct object *object;
 	unsigned char peeled[20];
 	int is_tag, prio;
 
+	if (!all && !might_be_tag)
+		return 0;
+
 	if (!peel_ref(path, peeled) && !is_null_sha1(peeled)) {
 		commit = lookup_commit_reference_gently(peeled, 1);
 		if (!commit)
@@ -68,7 +72,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
-	if (!prefixcmp(path, "refs/tags/")) {
+	if (might_be_tag) {
 		if (is_tag) {
 			prio = 2;
 			if (pattern && fnmatch(pattern, path + 10, 0))
-- 
1.5.4.3.295.g6b554
