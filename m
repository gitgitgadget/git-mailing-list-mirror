From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Add --cacheinfo option to update-cache
Date: Thu, 14 Apr 2005 23:03:20 -0700
Message-ID: <7vmzs0o9uf.fsf@assigned-by-dhcp.cox.net>
References: <7vr7hco9z7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 08:00:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMJs5-0004kC-Vd
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 08:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVDOGDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 02:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDOGDa
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 02:03:30 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45541 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261737AbVDOGDX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 02:03:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415060320.TUCI13819.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 02:03:20 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds "--cacheinfo" option to update-cache.  It is needed to
manipulate dircache without actually having such a blob in the working
directory.  To pretend you have a file with mode-sha1 at path, say:

 $ update-cache --cacheinfo mode sha1 path


Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 update-cache.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletion(-)

Index: update-cache.c
===================================================================
--- 6767883b330882bc0e9a7c1e4fd999c0ee97ba3a/update-cache.c  (mode:100644 sha1:6c1d608cff03d2126191c0891cf1d262d6ae7823)
+++ 21e5e9f7d7dfa81c6519f0204d5a467236c7fdd5/update-cache.c  (mode:100644 sha1:8e82862ee66dc339967de558e7a5a9c52ba37259)
@@ -250,6 +250,8 @@
 {
 	int i, newfd, entries;
 	int allow_options = 1;
+	const char *sha1_force = NULL;
+	const char *mode_force = NULL;
 
 	newfd = open(".git/index.lock", O_RDWR | O_CREAT | O_EXCL, 0600);
 	if (newfd < 0)
@@ -282,14 +284,35 @@
 				refresh_cache();
 				continue;
 			}
+			if (!strcmp(path, "--cacheinfo")) {
+				mode_force = argv[++i];
+				sha1_force = argv[++i];
+				continue;
+			}
 			die("unknown option %s", path);
 		}
 		if (!verify_path(path)) {
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
 		}
-		if (add_file_to_cache(path))
+		if (sha1_force && mode_force) {
+			struct cache_entry *ce;
+			int namelen = strlen(path);
+			int mode;
+			int size = cache_entry_size(namelen);
+			sscanf(mode_force, "%o", &mode);
+			ce = malloc(size);
+			memset(ce, 0, size);
+			memcpy(ce->name, path, namelen);
+			ce->namelen = namelen;
+			ce->st_mode = mode;
+			get_sha1_hex(sha1_force, ce->sha1);
+
+			add_cache_entry(ce, 1);
+		}
+		else if (add_file_to_cache(path))
 			die("Unable to add %s to database", path);
+		mode_force = sha1_force = NULL;
 	}
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    rename(".git/index.lock", ".git/index"))

