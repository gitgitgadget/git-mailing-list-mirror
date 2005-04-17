From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] "checkout-cache -m" writes unmerged contents for each
 stage.
Date: Sun, 17 Apr 2005 16:03:55 -0700
Message-ID: <7v1x99vwdg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNIkn-00044Z-7O
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVDQXER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVDQXER
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:04:17 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37586 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261537AbVDQXD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:03:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417230355.PMZC15592.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 19:03:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is the alternative strategy I mentioned in my previous
message.  A new -m option to checkout-cache causes it to store
contents of unmerged paths in path~1~, path~2~, and path~3~.

To be applied on top of the previous patch I re-sent:

    [PATCH] checkout-cache -a should not extract unmerged stages.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 checkout-cache.c |   93 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 76 insertions(+), 17 deletions(-)

checkout-cache.c: 596471a2f98b80a622488cf04edf9e95ce8666b1
--- checkout-cache.c
+++ checkout-cache.c	2005-04-17 15:49:15.000000000 -0700
@@ -34,7 +34,7 @@
  */
 #include "cache.h"
 
-static int force = 0, quiet = 0;
+static int force = 0, merge = 0, quiet = 0;
 
 static void create_directories(const char *path)
 {
@@ -65,6 +65,31 @@ static int create_file(const char *path,
 	return fd;
 }
 
+/* Returns the pathname itself for a merged entry
+ * and pathname~N~ for an unmerged one.
+ * Do not free the value you get from this function.
+ */
+static char *ce_name_with_stage(struct cache_entry *ce)
+{
+	/* (CE_NAMEMASK+1) is the max length of a name.
+	 * We are adding 3 bytes for ~N~ and we need a terminating NUL
+	 * hence +5.
+	 */
+	static char name[CE_NAMEMASK + 5];
+	int stage = ce_stage(ce);
+	if (! stage)
+		return ce->name;
+	else {
+		int pos = ce_namelen(ce);
+		strcpy(name, ce->name);
+		name[pos++] = '~';
+		name[pos++] = '0' + stage;
+		name[pos++] = '~';
+		name[pos] = 0;
+		return name;
+	}
+}
+
 static int write_entry(struct cache_entry *ce)
 {
 	int fd;
@@ -72,13 +97,20 @@ static int write_entry(struct cache_entr
 	unsigned long size;
 	long wrote;
 	char type[20];
+	char *name;
 
 	new = read_sha1_file(ce->sha1, type, &size);
 	if (!new || strcmp(type, "blob")) {
 		return error("checkout-cache: unable to read sha1 file of %s (%s)",
 			ce->name, sha1_to_hex(ce->sha1));
 	}
-	fd = create_file(ce->name, ntohl(ce->ce_mode));
+	name = ce_name_with_stage(ce);
+	if (!quiet && name != ce->name)
+		fprintf(stderr,
+			"checkout-cache: storing stage %d of %s in %s\n",
+			ce_stage(ce), ce->name, name);
+
+	fd = create_file(name, ntohl(ce->ce_mode));
 	if (fd < 0) {
 		free(new);
 		return error("checkout-cache: unable to create %s (%s)",
@@ -117,19 +149,39 @@ static int checkout_entry(struct cache_e
 	return write_entry(ce);
 }
 
+static int checkout_unmerged(int pos)
+{
+	int i, err;
+	struct cache_entry *ce = active_cache[pos];
+
+	for (err = 0, i = pos;
+	     (i < active_nr &&
+	      !strcmp(active_cache[i]->name, ce->name));
+	     i++)
+		err |= checkout_entry(active_cache[i]);
+	return err;
+}
+
 static int checkout_file(const char *name)
 {
 	int pos = cache_name_pos(name, strlen(name));
 	if (pos < 0) {
-		if (!quiet) {
-			pos = -pos - 1;
-			fprintf(stderr,
-				"checkout-cache: %s is %s.\n",
-				name,
-				(pos < active_nr &&
-				 !strcmp(active_cache[pos]->name, name)) ?
-				"unmerged" : "not in the cache");
+		pos = -pos - 1;
+		if (pos < active_nr &&
+		    !strcmp(active_cache[pos]->name, name)) {
+			if (merge)
+				return checkout_unmerged(pos);
+			else if (! quiet) {
+				fprintf(stderr,
+					"checkout-cache: %s is unmerged.\n",
+					name);
+				return -1;
+			}
 		}
+		else if (! quiet)
+			fprintf(stderr,
+				"checkout-cache: %s is not in the cache.\n",
+				name);
 		return -1;
 	}
 	return checkout_entry(active_cache[pos]);
@@ -137,22 +189,25 @@ static int checkout_file(const char *nam
 
 static int checkout_all(void)
 {
-	struct cache_entry *unmerge_skipping = NULL;
 	int i;
 
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce)) {
-			if (!unmerge_skipping ||
-			    strcmp(unmerge_skipping->name, ce->name))
+			if (!merge)
 				fprintf(stderr,
 					"checkout-cache: needs merge %s\n",
 					ce->name);
-			unmerge_skipping = ce;
-			continue;
+			while (i < active_nr &&
+			       !strcmp(ce->name, active_cache[i]->name)) {
+				if (merge) {
+					checkout_entry(active_cache[i]);
+				}
+				i++;
+			}
+			i--;
 		}
-		unmerge_skipping = NULL;
-		if (checkout_entry(ce) < 0)
+		else if (checkout_entry(ce) < 0)
 			return -1;
 	}
 	return 0;
@@ -181,6 +236,10 @@ int main(int argc, char **argv)
 				force = 1;
 				continue;
 			}
+			if (!strcmp(arg, "-m")) {
+				merge = 1;
+				continue;
+			}
 			if (!strcmp(arg, "-q")) {
 				quiet = 1;
 				continue;

