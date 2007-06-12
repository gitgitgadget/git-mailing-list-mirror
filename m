From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/3] Support branch^[merge] and branch^[push]
Date: Mon, 11 Jun 2007 23:10:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706112307000.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 05:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxwmh-0005uE-2G
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 05:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbXFLDK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 23:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbXFLDK4
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 23:10:56 -0400
Received: from iabervon.org ([66.92.72.58]:3098 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693AbXFLDKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 23:10:55 -0400
Received: (qmail 1971 invoked by uid 1000); 12 Jun 2007 03:10:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2007 03:10:54 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49914>

For a branch name, support getting related refs based on configuration.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 sha1_name.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 7df01af..dc5da7a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "remote.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -511,6 +512,51 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	return 0;
 }
 
+static int lookup_specials(const char *name, int len, unsigned char *sha1)
+{
+	const char *sp;
+
+	if (len < 5 || name[len - 1] != ']')
+		return -1;
+
+	for (sp = name + len - 1; name <= sp; sp--) {
+		int ch = *sp;
+		if (ch == '[' && name < sp && sp[-1] == '^')
+			break;
+	}
+
+	if (sp <= name)
+		return -1;
+
+	sp++; /* beginning of special name */
+	if (!strncmp("merge]", sp, 6)) {
+		char *word = xstrndup(name, sp - name - 2);
+		struct branch *branch = branch_get(word);
+		free(word);
+		if (branch && branch->merge) {
+			return get_sha1(branch->merge->dst, sha1);
+		}
+	} else if (!strncmp("push]", sp, 5)) {
+		char *word = xstrndup(name, sp - name - 2);
+		struct branch *branch = branch_get(word);
+		struct refspec remote;
+		struct refspec local;
+
+		if (!branch || !branch->remote)
+			return -1;
+
+		remote.src = branch->refname;
+		if (remote_find_push(branch->remote, &remote))
+			return -1;
+
+		local.src = remote.dst;
+		if (remote_find_tracking(branch->remote, &local))
+			return -1;
+		return get_sha1(local.dst, sha1);
+	}
+	return -1;
+}
+
 static int get_describe_name(const char *name, int len, unsigned char *sha1)
 {
 	const char *cp;
@@ -565,6 +611,10 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 		return get_nth_ancestor(name, len1, sha1, num);
 	}
 
+	ret = lookup_specials(name, len, sha1);
+	if (!ret)
+		return 0;
+
 	ret = peel_onion(name, len, sha1);
 	if (!ret)
 		return 0;
-- 
1.5.2.901.g27ad4-dirty
