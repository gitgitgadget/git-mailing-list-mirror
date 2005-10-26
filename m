From: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: [PATCH 1/4] git-init-db should error out with a message
Date: Wed, 26 Oct 2005 21:45:20 +0200
Message-ID: <20051026194520.GC8030@steel.home>
References: <Pine.LNX.4.63.0510260139000.30576@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 21:48:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUrDO-0004vp-NJ
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 21:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVJZTpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 15:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVJZTpg
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 15:45:36 -0400
Received: from devrace.com ([198.63.210.113]:36367 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964890AbVJZTpf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 15:45:35 -0400
Received: from tigra.home (p54A0C833.dip.t-dialin.net [84.160.200.51])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j9QJjNbe092139;
	Wed, 26 Oct 2005 14:45:24 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EUrD6-00083K-00; Wed, 26 Oct 2005 21:45:20 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EUrD6-00056r-1E; Wed, 26 Oct 2005 21:45:20 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510260139000.30576@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=-0.2 required=4.5 tests=AWL,BAYES_20,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10687>

Johannes Schindelin, Wed, Oct 26, 2005 01:39:24 +0200:
> When the HEAD symref could not be created, it is helpful for the user to 
> know that.
> 

Not just that. It would be interesting to give the user an option to
use the file references ("ref: refs/heads/master").
Something like that:

Add --no-symref (make init-db use file references)

---

 cache.h   |    1 +
 init-db.c |   11 +++++++++--
 refs.c    |    7 ++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

applies-to: dba443573167bb9b0023613428e6d1a69477fac6
097ca1bf9b21d19d425e8151986eb36f82cbeff3
diff --git a/cache.h b/cache.h
index d776016..e410ce2 100644
--- a/cache.h
+++ b/cache.h
@@ -239,6 +239,7 @@ extern char *sha1_to_hex(const unsigned 
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int);
 extern int create_symref(const char *git_HEAD, const char *refs_heads_master);
+extern int create_file_symref(const char *git_HEAD, const char *refs_heads_master);
 extern int validate_symref(const char *git_HEAD);
 
 /* General helper functions */
diff --git a/init-db.c b/init-db.c
index aabc09f..2d2b705 100644
--- a/init-db.c
+++ b/init-db.c
@@ -161,6 +161,8 @@ static void copy_templates(const char *g
 	closedir(dir);
 }
 
+static int try_symref = 1;
+
 static void create_default_files(const char *git_dir,
 				 char *template_path)
 {
@@ -191,8 +193,11 @@ static void create_default_files(const c
 	 */
 	strcpy(path + len, "HEAD");
 	if (read_ref(path, sha1) < 0) {
-		if (create_symref(path, "refs/heads/master") < 0)
-			exit(1);
+		int err = 0;
+		if ( try_symref )
+			err = create_symref(path, "refs/heads/master");
+		if ( !err && create_file_symref(path, "refs/heads/master") < 0 )
+			die("cannot create %s", path);
 	}
 	path[len] = 0;
 	copy_templates(path, len, template_path);
@@ -220,6 +225,8 @@ int main(int argc, char **argv)
 			break;
 		else if (!strncmp(arg, "--template=", 11))
 			template_dir = arg+11;
+		else if (!strcmp(arg, "--no-symref"))
+			try_symref = 0;
 		else
 			die(init_db_usage);
 	}
diff --git a/refs.c b/refs.c
index 97506a4..8029667 100644
--- a/refs.c
+++ b/refs.c
@@ -120,6 +120,12 @@ int create_symref(const char *git_HEAD, 
 	unlink(git_HEAD);
 	return symlink(refs_heads_master, git_HEAD);
 #else
+	return create_file_symref(git_HEAD, refs_heads_master);
+#endif
+}
+
+int create_file_symref(const char *git_HEAD, const char *refs_heads_master)
+{
 	const char *lockpath;
 	char ref[1000];
 	int fd, len, written;
@@ -144,7 +150,6 @@ int create_symref(const char *git_HEAD, 
 		return -3;
 	}
 	return 0;
-#endif
 }
 
 int read_ref(const char *filename, unsigned char *sha1)
---
0.99.8.GIT
