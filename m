From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC 3/5] Convert update-ref to use ref_lock API.
Date: Wed, 17 May 2006 05:55:19 -0400
Message-ID: <20060517095519.GD28529@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 17 11:55:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIkZ-0004SJ-QY
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWEQJzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWEQJzY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:55:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57296 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750797AbWEQJzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:55:22 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgIkQ-0000vs-9F
	for git@vger.kernel.org; Wed, 17 May 2006 05:55:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A003F212667; Wed, 17 May 2006 05:55:19 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20182>

This conversion also adds the '-m' switch to update-ref allowing
the caller to record why the ref is changing.  At present this is
merely copied down into the ref_lock API.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 Documentation/git-update-ref.txt |    2 -
 update-ref.c                     |  103 ++++++++++++++------------------------
 2 files changed, 38 insertions(+), 67 deletions(-)

4f017fce63b3cb56065731967a9684cb36ddd12e
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 475237f..f0e710a 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -7,7 +7,7 @@ git-update-ref - update the object name 
 
 SYNOPSIS
 --------
-'git-update-ref' <ref> <newvalue> [<oldvalue>]
+'git-update-ref' <ref> <newvalue> [<oldvalue>] [-m <reason>]
 
 DESCRIPTION
 -----------
diff --git a/update-ref.c b/update-ref.c
index fd48742..a1e6bb9 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -1,85 +1,56 @@
 #include "cache.h"
 #include "refs.h"
 
-static const char git_update_ref_usage[] = "git-update-ref <refname> <value> [<oldval>]";
-
-static int re_verify(const char *path, unsigned char *oldsha1, unsigned char *currsha1)
-{
-	char buf[40];
-	int fd = open(path, O_RDONLY), nr;
-	if (fd < 0)
-		return -1;
-	nr = read(fd, buf, 40);
-	close(fd);
-	if (nr != 40 || get_sha1_hex(buf, currsha1) < 0)
-		return -1;
-	return memcmp(oldsha1, currsha1, 20) ? -1 : 0;
-}
+static const char git_update_ref_usage[] =
+"git-update-ref <refname> <value> [<oldval>] [-m <reason>]";
 
 int main(int argc, char **argv)
 {
-	char *hex;
-	const char *refname, *value, *oldval, *path;
-	char *lockpath;
-	unsigned char sha1[20], oldsha1[20], currsha1[20];
-	int fd, written;
+	const char *refname=NULL, *value=NULL, *oldval=NULL, *msg=NULL;
+	struct ref_lock *lock;
+	unsigned char sha1[20], oldsha1[20];
+	int i;
 
 	setup_git_directory();
 	git_config(git_default_config);
-	if (argc < 3 || argc > 4)
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp("-m", argv[i])) {
+			if (i+1 >= argc)
+				usage(git_update_ref_usage);
+			msg = argv[++i];
+			if (!*msg)
+				die("Refusing to perform update with empty message.");
+			if (strchr(msg, '\n'))
+				die("Refusing to perform update with \\n in message.");
+			continue;
+		}
+		if (!refname) {
+			refname = argv[i];
+			continue;
+		}
+		if (!value) {
+			value = argv[i];
+			continue;
+		}
+		if (!oldval) {
+			oldval = argv[i];
+			continue;
+		}
+	}
+	if (!refname || !value)
 		usage(git_update_ref_usage);
 
-	refname = argv[1];
-	value = argv[2];
-	oldval = argv[3];
 	if (get_sha1(value, sha1))
 		die("%s: not a valid SHA1", value);
 	memset(oldsha1, 0, 20);
 	if (oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);
 
-	path = resolve_ref(git_path("%s", refname), currsha1, !!oldval);
-	if (!path)
-		die("No such ref: %s", refname);
-
-	if (oldval) {
-		if (memcmp(currsha1, oldsha1, 20))
-			die("Ref %s is at %s but expected %s", refname, sha1_to_hex(currsha1), sha1_to_hex(oldsha1));
-		/* Nothing to do? */
-		if (!memcmp(oldsha1, sha1, 20))
-			exit(0);
-	}
-	path = strdup(path);
-	lockpath = mkpath("%s.lock", path);
-	if (safe_create_leading_directories(lockpath) < 0)
-		die("Unable to create all of %s", lockpath);
-
-	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
-	if (fd < 0)
-		die("Unable to create %s", lockpath);
-	hex = sha1_to_hex(sha1);
-	hex[40] = '\n';
-	written = write(fd, hex, 41);
-	close(fd);
-	if (written != 41) {
-		unlink(lockpath);
-		die("Unable to write to %s", lockpath);
-	}
-
-	/*
-	 * Re-read the ref after getting the lock to verify
-	 */
-	if (oldval && re_verify(path, oldsha1, currsha1) < 0) {
-		unlink(lockpath);
-		die("Ref lock failed");
-	}
-
-	/*
-	 * Finally, replace the old ref with the new one
-	 */
-	if (rename(lockpath, path) < 0) {
-		unlink(lockpath);
-		die("Unable to create %s", path);
-	}
+	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL, 0);
+	if (!lock)
+		return 1;
+	if (write_ref_sha1(lock, sha1, msg) < 0)
+		return 1;
 	return 0;
 }
-- 
1.3.2.g7278
