From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make git-update-cache --refresh fail if update/merge
 needed.
Date: Sun, 01 May 2005 14:29:53 -0700
Message-ID: <7vbr7uskha.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwtqjxlrv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505010916510.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:42:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSMCm-0002wk-EL
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVEAVqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVEAVoQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:44:16 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41432 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262730AbVEAV37 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 17:29:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501212952.SYUU7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 17:29:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505010916510.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 1 May 2005 09:18:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Scripts may find it useful if they do not have to parse the
output from the command but just can rely on its exit status.

Earlier both Linus and myself thought this would be necessary to
make git-prune-script safer but it turns out that the issue was
somewhere else and not related to what this patch addresses.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

update-cache.c |   15 ++++++++++-----
1 files changed, 10 insertions(+), 5 deletions(-)

# - date handling: handle "AM"/"PM" on time
# + [PATCH] Make git-prune-script a bit more careful.
--- k/update-cache.c
+++ l/update-cache.c
@@ -212,15 +212,17 @@ static struct cache_entry *refresh_entry
 	return updated;
 }
 
-static void refresh_cache(void)
+static int refresh_cache(void)
 {
 	int i;
+	int has_errors = 0;
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce, *new;
 		ce = active_cache[i];
 		if (ce_stage(ce)) {
 			printf("%s: needs merge\n", ce->name);
+			has_errors = 1;
 			while ((i < active_nr) &&
 			       ! strcmp(active_cache[i]->name, ce->name))
 				i++;
@@ -230,12 +232,15 @@ static void refresh_cache(void)
 
 		new = refresh_entry(ce);
 		if (IS_ERR(new)) {
-			if (!(not_new && PTR_ERR(new) == -ENOENT))
+			if (!(not_new && PTR_ERR(new) == -ENOENT)) {
 				printf("%s: needs update\n", ce->name);
+				has_errors = 1;
+			}
 			continue;
 		}
 		active_cache[i] = new;
 	}
+	return has_errors;
 }
 
 /*
@@ -307,7 +312,7 @@ static void remove_lock_file_on_signal(i
 
 int main(int argc, char **argv)
 {
-	int i, newfd, entries;
+	int i, newfd, entries, has_errors = 0;
 	int allow_options = 1;
 	static char lockfile[MAXPATHLEN+1];
 	const char *indexfile = get_index_file();
@@ -343,7 +348,7 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp(path, "--refresh")) {
-				refresh_cache();
+				has_errors |= refresh_cache();
 				continue;
 			}
 			if (!strcmp(path, "--cacheinfo")) {
@@ -369,5 +374,5 @@ int main(int argc, char **argv)
 		die("Unable to write new cachefile");
 
 	lockfile_name = NULL;
-	return 0;
+	return has_errors;
 }

