From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] drop length argument of has_extension
Date: Fri, 11 Aug 2006 14:01:45 +0200
Message-ID: <20060811120145.GA24982@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 11 14:02:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBViU-0007eF-9f
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 14:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWHKMBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 08:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWHKMBu
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 08:01:50 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:64947
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932158AbWHKMBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Aug 2006 08:01:49 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 072E38008; Fri, 11 Aug 2006 14:01:46 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25225>

As Fredrik points out the current interface of has_extension() is
potentially confusing.  Its parameters include both a nul-terminated
string and a length-limited string.

This patch drops the length argument, requiring two nul-terminated
strings; all callsites are updated.  I checked that all of them indeed
provide nul-terminated strings.  Filenames need to be nul-terminated
anyway if they are to be passed to open() etc.  The performance penalty
of the additional strlen() is negligible compared to the system calls
which inevitably surround has_extension() calls.

Additionally, change has_extension() to use size_t inside instead of
int, as that is the exact type strlen() returns and memcmp() expects.

This patch applies to the current next branch (9d8df19).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 builtin-verify-pack.c |    4 ++--
 git-compat-util.h     |    5 +++--
 help.c                |    2 +-
 http-fetch.c          |    2 +-
 index-pack.c          |    2 +-
 local-fetch.c         |    2 +-
 refs.c                |    2 +-
 sha1_file.c           |    2 +-
 8 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index d700761..7d39d9b 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -17,10 +17,10 @@ static int verify_one_pack(const char *p
 	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
 	 * normalize these forms to "foo.idx" for add_packed_git().
 	 */
-	if (has_extension(arg, len, ".pack")) {
+	if (has_extension(arg, ".pack")) {
 		strcpy(arg + len - 5, ".idx");
 		len--;
-	} else if (!has_extension(arg, len, ".idx")) {
+	} else if (!has_extension(arg, ".idx")) {
 		if (len + 4 >= PATH_MAX)
 			return error("name too long: %s.idx", arg);
 		strcpy(arg + len, ".idx");
diff --git a/git-compat-util.h b/git-compat-util.h
index dd92093..b2e1895 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -139,9 +139,10 @@ static inline ssize_t xwrite(int fd, con
 	}
 }
 
-static inline int has_extension(const char *filename, int len, const char *ext)
+static inline int has_extension(const char *filename, const char *ext)
 {
-	int extlen = strlen(ext);
+	size_t len = strlen(filename);
+	size_t extlen = strlen(ext);
 	return len > extlen && !memcmp(filename + len - extlen, ext, extlen);
 }
 
diff --git a/help.c b/help.c
index 7a7f775..6484cb9 100644
--- a/help.c
+++ b/help.c
@@ -140,7 +140,7 @@ static void list_commands(const char *ex
 			continue;
 
 		entlen = strlen(de->d_name);
-		if (has_extension(de->d_name, entlen, ".exe"))
+		if (has_extension(de->d_name, ".exe"))
 			entlen -= 4;
 
 		if (longest < entlen)
diff --git a/http-fetch.c b/http-fetch.c
index 6ea39f0..de5fc44 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -870,7 +870,7 @@ static void process_ls_pack(struct remot
 
 	if (strlen(ls->dentry_name) == 63 &&
 	    !strncmp(ls->dentry_name, "objects/pack/pack-", 18) &&
-	    has_extension(ls->dentry_name, 63, ".pack")) {
+	    has_extension(ls->dentry_name, ".pack")) {
 		get_sha1_hex(ls->dentry_name + 18, sha1);
 		setup_index(ls->repo, sha1);
 	}
diff --git a/index-pack.c b/index-pack.c
index a91e39e..b20659c 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -447,7 +447,7 @@ int main(int argc, char **argv)
 		usage(index_pack_usage);
 	if (!index_name) {
 		int len = strlen(pack_name);
-		if (!has_extension(pack_name, len, ".pack"))
+		if (!has_extension(pack_name, ".pack"))
 			die("packfile name '%s' does not end with '.pack'",
 			    pack_name);
 		index_name_buf = xmalloc(len);
diff --git a/local-fetch.c b/local-fetch.c
index b6ec170..7d01845 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -44,7 +44,7 @@ static int setup_indices(void)
 	while ((de = readdir(dir)) != NULL) {
 		int namelen = strlen(de->d_name);
 		if (namelen != 50 ||
-		    !has_extension(de->d_name, namelen, ".pack"))
+		    !has_extension(de->d_name, ".pack"))
 			continue;
 		get_sha1_hex(de->d_name + 5, sha1);
 		setup_index(sha1);
diff --git a/refs.c b/refs.c
index b01835f..28a9394 100644
--- a/refs.c
+++ b/refs.c
@@ -147,7 +147,7 @@ static int do_for_each_ref(const char *b
 			namelen = strlen(de->d_name);
 			if (namelen > 255)
 				continue;
-			if (has_extension(de->d_name, namelen, ".lock"))
+			if (has_extension(de->d_name, ".lock"))
 				continue;
 			memcpy(path + baselen, de->d_name, namelen+1);
 			if (stat(git_path("%s", path), &st) < 0)
diff --git a/sha1_file.c b/sha1_file.c
index f0a4a7e..ed52d71 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -608,7 +608,7 @@ static void prepare_packed_git_one(char 
 		int namelen = strlen(de->d_name);
 		struct packed_git *p;
 
-		if (!has_extension(de->d_name, namelen, ".idx"))
+		if (!has_extension(de->d_name, ".idx"))
 			continue;
 
 		/* we have .idx.  Is it a file we can map? */
