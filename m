From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] get_sha1(): :path and :[0-3]:path to extract from index.
Date: Fri, 21 Apr 2006 17:49:40 -0700
Message-ID: <7v7j5iph7f.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 22 02:51:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX6L4-0001cS-UG
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 02:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWDVAuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 20:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWDVAuT
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 20:50:19 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45727 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750792AbWDVAuR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Apr 2006 20:50:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422005016.TVFZ20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Apr 2006 20:50:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19033>

[ NOTE! The reason I put "RFC" in the subject rather than "PATCH" is that 
  I'm not 100% sure this isn't just a "shiny object" of mine rather than a 
  really useful thing to do. What do people think? Have you ever wanted to 
  access individual files in some random revision? Do you think this is 
  useful? I think it's cool and _may_ be useful, but I'm not going to 
  really push this patch. Consider it a throw-away patch unless somebody 
  else finds it intriguing enough.. ]

This is a fairly straightforward patch to allow "get_sha1()" to
also have shorthands for blob objects in the current index.

The syntax is very simple and intuitive: you can specify a blob
from the current index by simply specifying :<stage>:<path> or
:<path>, and get_sha1() will do the SHA1 lookup from the index
for you.

You can currently do it with "git ls-files -s <path>" and parsing the 
output, but that's actually pretty awkward.

With this, you can do something like

	git cat-file blob :3:Makefile

to get the contents of "Makefile" from their version during a
conflicted merge.

This does not do trees like <ent>:<path> version does.  We could
do that by writing out a temporary tree object if we wanted to,
but that would smudge the object database, so I refrained from
doing that as part of this patch.  If we did that,

	git diff-tree :2: :3:

would be an inefficient equivalent to "git diff-stages 2 3".

---
 sha1_name.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 345935b..ec5cd2c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -458,17 +458,55 @@ int get_sha1(const char *name, unsigned 
 {
 	int ret;
 	unsigned unused;
+	int namelen = strlen(name);
+	const char *cp;
 
 	prepare_alt_odb();
-	ret = get_sha1_1(name, strlen(name), sha1);
-	if (ret < 0) {
-		const char *cp = strchr(name, ':');
-		if (cp) {
-			unsigned char tree_sha1[20];
-			if (!get_sha1_1(name, cp-name, tree_sha1))
-				return get_tree_entry(tree_sha1, cp+1, sha1,
-						      &unused);
+	ret = get_sha1_1(name, namelen, sha1);
+	if (!ret)
+		return ret;
+	/* sha1:path --> object name of path in ent sha1
+	 * :path -> object name of path in index
+	 * :[0-3]:path -> object name of path in index at stage
+	 */
+	if (name[0] == ':') {
+		int stage = 0;
+		struct cache_entry *ce;
+		int pos;
+		if (namelen < 3 ||
+		    name[2] != ':' ||
+		    name[1] < '0' || '3' < name[1])
+			cp = name + 1;
+		else {
+			stage = name[1] - '0';
+			cp = name + 3;
 		}
+		namelen = namelen - (cp - name);
+		if (!active_cache)
+			read_cache();
+		if (active_nr < 0)
+			return -1;
+		pos = cache_name_pos(cp, namelen);
+		if (pos < 0)
+			pos = -pos - 1;
+		while (pos < active_nr) {
+			ce = active_cache[pos];
+			if (ce_namelen(ce) != namelen ||
+			    memcmp(ce->name, cp, namelen))
+				break;
+			if (ce_stage(ce) == stage) {
+				memcpy(sha1, ce->sha1, 20);
+				return 0;
+			}
+		}
+		return -1;
+	}
+	cp = strchr(name, ':');
+	if (cp) {
+		unsigned char tree_sha1[20];
+		if (!get_sha1_1(name, cp-name, tree_sha1))
+			return get_tree_entry(tree_sha1, cp+1, sha1,
+					      &unused);
 	}
 	return ret;
 }
-- 
1.3.0.g6082
