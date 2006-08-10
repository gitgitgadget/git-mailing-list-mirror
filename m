From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/9] Add has_extension()
Date: Thu, 10 Aug 2006 17:02:30 +0200
Message-ID: <11552221581171-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:03:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3Z-0007Kf-Pe
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161301AbWHJPCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWHJPCn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:43 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:8645
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161301AbWHJPCj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:39 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 571E27006; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25188>

The little helper has_extension() documents through its name what we are
trying to do and makes sure we don't forget the underrun check.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 git-compat-util.h |    6 ++++++
 help.c            |    2 +-
 http-fetch.c      |    2 +-
 index-pack.c      |    2 +-
 local-fetch.c     |    2 +-
 refs.c            |    2 +-
 sha1_file.c       |    2 +-
 verify-pack.c     |    2 +-
 8 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 3bcf5b1..dd92093 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -139,6 +139,12 @@ static inline ssize_t xwrite(int fd, con
 	}
 }
 
+static inline int has_extension(const char *filename, int len, const char *ext)
+{
+	int extlen = strlen(ext);
+	return len > extlen && !memcmp(filename + len - extlen, ext, extlen);
+}
+
 /* Sane ctype - no locale, and works with signed chars */
 #undef isspace
 #undef isdigit
diff --git a/help.c b/help.c
index fb731cc..7a7f775 100644
--- a/help.c
+++ b/help.c
@@ -140,7 +140,7 @@ static void list_commands(const char *ex
 			continue;
 
 		entlen = strlen(de->d_name);
-		if (4 < entlen && !strcmp(de->d_name + entlen - 4, ".exe"))
+		if (has_extension(de->d_name, entlen, ".exe"))
 			entlen -= 4;
 
 		if (longest < entlen)
diff --git a/http-fetch.c b/http-fetch.c
index 36af3e5..6ea39f0 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -870,7 +870,7 @@ static void process_ls_pack(struct remot
 
 	if (strlen(ls->dentry_name) == 63 &&
 	    !strncmp(ls->dentry_name, "objects/pack/pack-", 18) &&
-	    !strncmp(ls->dentry_name+58, ".pack", 5)) {
+	    has_extension(ls->dentry_name, 63, ".pack")) {
 		get_sha1_hex(ls->dentry_name + 18, sha1);
 		setup_index(ls->repo, sha1);
 	}
diff --git a/index-pack.c b/index-pack.c
index b39953d..a91e39e 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -447,7 +447,7 @@ int main(int argc, char **argv)
 		usage(index_pack_usage);
 	if (!index_name) {
 		int len = strlen(pack_name);
-		if (len < 5 || strcmp(pack_name + len - 5, ".pack"))
+		if (!has_extension(pack_name, len, ".pack"))
 			die("packfile name '%s' does not end with '.pack'",
 			    pack_name);
 		index_name_buf = xmalloc(len);
diff --git a/local-fetch.c b/local-fetch.c
index 4bf86fb..59af57c 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -44,7 +44,7 @@ static int setup_indices(void)
 	while ((de = readdir(dir)) != NULL) {
 		int namelen = strlen(de->d_name);
 		if (namelen != 50 || 
-		    strcmp(de->d_name + namelen - 5, ".pack"))
+		    !has_extension(de->d_name, namelen, ".pack"))
 			continue;
 		get_sha1_hex(de->d_name + 5, sha1);
 		setup_index(sha1);
diff --git a/refs.c b/refs.c
index 02850b6..b01835f 100644
--- a/refs.c
+++ b/refs.c
@@ -147,7 +147,7 @@ static int do_for_each_ref(const char *b
 			namelen = strlen(de->d_name);
 			if (namelen > 255)
 				continue;
-			if (namelen>5 && !strcmp(de->d_name+namelen-5,".lock"))
+			if (has_extension(de->d_name, namelen, ".lock"))
 				continue;
 			memcpy(path + baselen, de->d_name, namelen+1);
 			if (stat(git_path("%s", path), &st) < 0)
diff --git a/sha1_file.c b/sha1_file.c
index 3d7a7d4..f0a4a7e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -608,7 +608,7 @@ static void prepare_packed_git_one(char 
 		int namelen = strlen(de->d_name);
 		struct packed_git *p;
 
-		if (strcmp(de->d_name + namelen - 4, ".idx"))
+		if (!has_extension(de->d_name, namelen, ".idx"))
 			continue;
 
 		/* we have .idx.  Is it a file we can map? */
diff --git a/verify-pack.c b/verify-pack.c
index c99db9d..ef00204 100644
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -10,7 +10,7 @@ static int verify_one_pack(char *arg, in
 		/* Should name foo.idx, but foo.pack may be named;
 		 * convert it to foo.idx
 		 */
-		if (!strcmp(arg + len - 5, ".pack")) {
+		if (has_extension(arg, len, ".pack")) {
 			strcpy(arg + len - 5, ".idx");
 			len--;
 		}
-- 
1.4.2.rc2.g822a
