From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH attempt #2] scan reflogs independently from refs
Date: Sat, 03 Feb 2007 13:25:43 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702031321510.3021@xanadu.home>
References: <Pine.LNX.4.64.0702031252330.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 03 19:25:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDPaB-0000M9-PB
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 19:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbXBCSZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 13:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXBCSZq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 13:25:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49833 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbXBCSZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 13:25:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCW00JYWGIVKR80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Feb 2007 13:25:44 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702031252330.3021@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38584>

Currently, the search for all reflogs depends on the existence of
corresponding refs under the .git/refs/ directory.  Let's scan the
.git/logs/ directory directly instead.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Sat, 3 Feb 2007, Nicolas Pitre wrote:

> This applies on top of next.

Well, this was a lie.  My version of 'next' wasn't up to date.  Here's 
an updated patch.

diff --git a/builtin-fsck.c b/builtin-fsck.c
index fec1cbd..848901a 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -477,6 +477,12 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
+static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	for_each_reflog_ent(logname, fsck_handle_reflog_ent, NULL);
+	return 0;
+}
+
 static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *obj;
@@ -495,14 +501,13 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 	obj->used = 1;
 	mark_reachable(obj, REACHABLE);
 
-	for_each_reflog_ent(refname, fsck_handle_reflog_ent, NULL);
-
 	return 0;
 }
 
 static void get_default_heads(void)
 {
 	for_each_ref(fsck_handle_ref, NULL);
+	for_each_reflog(fsck_handle_reflog, NULL);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 7c2443a..7ee5d6f 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -245,14 +245,11 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	char *log_file, *newlog_path = NULL;
 	int status = 0;
 
-	if (strncmp(ref, "refs/", 5))
-		return error("not a ref '%s'", ref);
-
 	memset(&cb, 0, sizeof(cb));
 	/* we take the lock for the ref itself to prevent it from
 	 * getting updated.
 	 */
-	lock = lock_ref_sha1(ref + 5, sha1);
+	lock = lock_any_ref_for_update(ref, sha1);
 	if (!lock)
 		return error("cannot lock ref '%s'", ref);
 	log_file = xstrdup(git_path("logs/%s", ref));
@@ -353,7 +350,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	}
 
 	if (do_all)
-		status |= for_each_ref(expire_reflog, &cb);
+		status |= for_each_reflog(expire_reflog, &cb);
 	while (i < argc) {
 		const char *ref = argv[i++];
 		unsigned char sha1[20];
diff --git a/reachable.c b/reachable.c
index a6a3348..01760d7 100644
--- a/reachable.c
+++ b/reachable.c
@@ -188,9 +188,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog)
 	/* Add all external refs */
 	for_each_ref(add_one_ref, revs);
 
-	/* Add all reflog info from refs */
+	/* Add all reflog info */
 	if (mark_reflog)
-		for_each_ref(add_one_reflog, revs);
+		for_each_reflog(add_one_reflog, revs);
 
 	/*
 	 * Set up the revision walk - this will move all commits
diff --git a/refs.c b/refs.c
index d605da3..03e8dfe 100644
--- a/refs.c
+++ b/refs.c
@@ -1203,3 +1203,53 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 	return ret;
 }
 
+static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
+{
+	DIR *dir = opendir(git_path("logs/%s", base));
+	int retval = errno;
+
+	if (dir) {
+		struct dirent *de;
+		int baselen = strlen(base);
+		char *log = xmalloc(baselen + 257);
+
+		memcpy(log, base, baselen);
+		if (baselen && base[baselen-1] != '/')
+			log[baselen++] = '/';
+
+		while ((de = readdir(dir)) != NULL) {
+			struct stat st;
+			int namelen;
+
+			if (de->d_name[0] == '.')
+				continue;
+			namelen = strlen(de->d_name);
+			if (namelen > 255)
+				continue;
+			if (has_extension(de->d_name, ".lock"))
+				continue;
+			memcpy(log + baselen, de->d_name, namelen+1);
+			if (stat(git_path("logs/%s", log), &st) < 0)
+				continue;
+			if (S_ISDIR(st.st_mode)) {
+				retval = do_for_each_reflog(log, fn, cb_data);
+			} else {
+				unsigned char sha1[20];
+				if (!resolve_ref(log, sha1, 0, NULL))
+					retval = error("bad ref for %s", log);
+				else
+					retval = fn(log, sha1, 0, cb_data);
+			}
+			if (retval)
+				break;
+		}
+		free(log);
+		closedir(dir);
+	}
+	return retval;
+}
+
+int for_each_reflog(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_reflog("", fn, cb_data);
+}
diff --git a/refs.h b/refs.h
index 94a58b4..acedffc 100644
--- a/refs.h
+++ b/refs.h
@@ -48,6 +48,12 @@ extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
 int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
 
+/*
+ * Calls the specified function for each reflog file until it returns nonzero,
+ * and returns the value
+ */
+extern int for_each_reflog(each_ref_fn, void *);
+
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
 
