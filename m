From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] prune-packed: new option --min-age=N
Date: Thu, 18 Jan 2007 18:18:30 +0100
Message-ID: <20070118171830.GA13521@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 18 18:18:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7auN-0007bk-I9
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 18:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbXARRSi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 12:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbXARRSh
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 12:18:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:38884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752068AbXARRSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 12:18:37 -0500
Received: (qmail invoked by alias); 18 Jan 2007 17:18:32 -0000
Received: from pD9EBA48D.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.164.141]
  by mail.gmx.net (mp020) with SMTP; 18 Jan 2007 18:18:32 +0100
X-Authenticated: #5358227
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37125>

This option makes prune-packed ignore all packs younger than N seconds
(using mtime).

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
This option allows to remove the unpacked version of an object only if
it has been packed for a minimum time.  It is intended to work around
the problem of freshly packed objects which should not be deleted
because someone might still try to open the unpacked version.

if [ $(git count-objects | cut -d ' ' -f 3) -gt 10240 ]; then
    git repack
fi
git prune-packed --min-age=$((24*60*60))
---
 builtin-prune-packed.c |   48 +++++++++++++++++++++++++++++++++++++++++++-----
 builtin-prune.c        |    2 +-
 builtin.h              |    2 +-
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index a57b76d..4359a41 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -7,7 +7,8 @@ static const char prune_packed_usage[] =
 #define DRY_RUN 01
 #define VERBOSE 02
 
-static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
+static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts,
+		      char **ignore_packed)
 {
 	struct dirent *de;
 	char hex[40];
@@ -20,7 +21,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 		memcpy(hex+2, de->d_name, 38);
 		if (get_sha1_hex(hex, sha1))
 			continue;
-		if (!has_sha1_pack(sha1, NULL))
+		if (!has_sha1_pack(sha1, ignore_packed))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
 		if (opts & DRY_RUN)
@@ -32,12 +33,46 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 	rmdir(pathname);
 }
 
-void prune_packed_objects(int opts)
+static char **prune_ignore(int min_age, int opts)
+{
+	int ignore_max = 10;
+	int ignore_count = 0;
+	char **ignore_packed = xcalloc(ignore_max, sizeof(char*));
+	int now = time(NULL);
+	struct packed_git *p;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		struct stat s;
+		if (stat(p->pack_name, &s)) {
+			warn("unable to stat %s", p->pack_name);
+			continue;
+		}
+		if (now-s.st_mtime >= min_age)
+			continue;
+		if (opts & VERBOSE)
+			fprintf(stderr, "ignoring pack %s\n", p->pack_name);
+		if (ignore_count >= ignore_max-1) {
+			ignore_max += 10;
+			ignore_packed = xrealloc(ignore_packed,
+				ignore_max*sizeof(char*));
+		}
+		ignore_packed[ignore_count++] = p->pack_name;
+	}
+	ignore_packed[ignore_count] = NULL;
+	return ignore_packed;
+}
+
+void prune_packed_objects(int opts, int min_age)
 {
 	int i;
 	static char pathname[PATH_MAX];
 	const char *dir = get_object_directory();
 	int len = strlen(dir);
+	char **ignore_packed = NULL;
+
+	if (min_age > 0)
+		ignore_packed = prune_ignore(min_age, opts);
 
 	if (len > PATH_MAX - 42)
 		die("impossible object directory");
@@ -54,7 +89,7 @@ void prune_packed_objects(int opts)
 				((i+1) * 100) / 256);
 		if (!d)
 			continue;
-		prune_dir(i, d, pathname, len + 3, opts);
+		prune_dir(i, d, pathname, len + 3, opts, ignore_packed);
 		closedir(d);
 	}
 	if (opts == VERBOSE)
@@ -65,6 +100,7 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int opts = VERBOSE;
+	int min_age = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -74,6 +110,8 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 				opts |= DRY_RUN;
 			else if (!strcmp(arg, "-q"))
 				opts &= ~VERBOSE;
+			else if (!strncmp(arg, "--min-age=", 10))
+				min_age = atoi(arg+10);
 			else
 				usage(prune_packed_usage);
 			continue;
@@ -82,6 +120,6 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 		usage(prune_packed_usage);
 	}
 	sync();
-	prune_packed_objects(opts);
+	prune_packed_objects(opts, min_age);
 	return 0;
 }
diff --git a/builtin-prune.c b/builtin-prune.c
index 6f0ba0d..46a0fe5 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -100,6 +100,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	prune_object_dir(get_object_directory());
 
 	sync();
-	prune_packed_objects(show_only);
+	prune_packed_objects(show_only, 0);
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index 818c7bf..e9929da 100644
--- a/builtin.h
+++ b/builtin.h
@@ -11,7 +11,7 @@ extern int mailinfo(FILE *in, FILE *out, int ks, const char *encoding, const cha
 extern int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip);
 extern void stripspace(FILE *in, FILE *out);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
-extern void prune_packed_objects(int);
+extern void prune_packed_objects(int, int);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
-- 
1.4.4.4
