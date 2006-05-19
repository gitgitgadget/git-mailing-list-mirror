From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 4/5] Log ref updates made by fetch.
Date: Fri, 19 May 2006 03:29:26 -0400
Message-ID: <20060519072926.GE22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 09:29:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzQT-0005WR-1M
	for gcvg-git@gmane.org; Fri, 19 May 2006 09:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWESH3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 03:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWESH3a
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 03:29:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37827 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751104AbWESH3a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 03:29:30 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgzQM-0002kT-EJ; Fri, 19 May 2006 03:29:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BC2F0212691; Fri, 19 May 2006 03:29:26 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20332>

If a ref is changed by http-fetch, local-fetch or ssh-fetch
record the change and the remote URL/name in the log for the ref.
This requires loading the config file to check logAllRefUpdates.

Also fixed a bug in the ref lock generation; the log file name was
not being produced right due to a bad prefix length.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 fetch.c       |   17 +++++++++++++++--
 fetch.h       |    3 +++
 http-fetch.c  |    2 ++
 local-fetch.c |    2 ++
 refs.c        |    5 +++--
 ssh-fetch.c   |    2 ++
 6 files changed, 27 insertions(+), 4 deletions(-)

b929e2a5a8f80c8635cf3c54a6d766902cf87434
diff --git a/fetch.c b/fetch.c
index 8bdaacb..fd57684 100644
--- a/fetch.c
+++ b/fetch.c
@@ -8,6 +8,7 @@ #include "blob.h"
 #include "refs.h"
 
 const char *write_ref = NULL;
+const char *write_ref_log_details = NULL;
 
 const unsigned char *current_ref = NULL;
 
@@ -206,13 +207,17 @@ int pull(char *target)
 {
 	struct ref_lock *lock;
 	unsigned char sha1[20];
+	char *msg;
+	int ret;
 
 	save_commit_buffer = 0;
 	track_object_refs = 0;
 	if (write_ref) {
 		lock = lock_ref_sha1(write_ref, current_ref, 1);
-		if (!lock)
+		if (!lock) {
+			error("Can't lock ref %s", write_ref);
 			return -1;
+		}
 	}
 
 	if (!get_recover) {
@@ -234,7 +239,15 @@ int pull(char *target)
 	}
 
 	if (write_ref) {
-		return write_ref_sha1(lock, sha1, "git fetch");
+		if (write_ref_log_details) {
+			msg = xmalloc(strlen(write_ref_log_details) + 12);
+			sprintf(msg, "fetch from %s", write_ref_log_details);
+		} else
+			msg = NULL;
+		ret = write_ref_sha1(lock, sha1, msg ? msg : "fetch (unknown)");
+		if (msg)
+			free(msg);
+		return ret;
 	}
 	return 0;
 }
diff --git a/fetch.h b/fetch.h
index 9837a3d..0011548 100644
--- a/fetch.h
+++ b/fetch.h
@@ -25,6 +25,9 @@ extern int fetch_ref(char *ref, unsigned
 /* If set, the ref filename to write the target value to. */
 extern const char *write_ref;
 
+/* If set additional text will appear in the ref log. */
+extern const char *write_ref_log_details;
+
 /* If set, the hash that the current value of write_ref must be. */
 extern const unsigned char *current_ref;
 
diff --git a/http-fetch.c b/http-fetch.c
index 861644b..cc7bd1f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1223,6 +1223,7 @@ int main(int argc, char **argv)
 	int rc = 0;
 
 	setup_git_directory();
+	git_config(git_default_config);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -1249,6 +1250,7 @@ int main(int argc, char **argv)
 	}
 	commit_id = argv[arg];
 	url = argv[arg + 1];
+	write_ref_log_details = url;
 
 	http_init();
 
diff --git a/local-fetch.c b/local-fetch.c
index fa9e697..ffa4887 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -208,6 +208,7 @@ int main(int argc, char **argv)
 	int arg = 1;
 
 	setup_git_directory();
+	git_config(git_default_config);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't')
@@ -239,6 +240,7 @@ int main(int argc, char **argv)
 		usage(local_pull_usage);
 	commit_id = argv[arg];
 	path = argv[arg + 1];
+	write_ref_log_details = path;
 
 	if (pull(commit_id))
 		return 1;
diff --git a/refs.c b/refs.c
index 31cf276..d3ddc82 100644
--- a/refs.c
+++ b/refs.c
@@ -142,6 +142,8 @@ static int do_for_each_ref(const char *b
 			namelen = strlen(de->d_name);
 			if (namelen > 255)
 				continue;
+			if (namelen>5 && !strcmp(de->d_name+namelen-5,".lock"))
+				continue;
 			memcpy(path + baselen, de->d_name, namelen+1);
 			if (stat(git_path("%s", path), &st) < 0)
 				continue;
@@ -296,7 +298,6 @@ static struct ref_lock* lock_ref_sha1_ba
 	plen = strlen(path) - plen;
 	path = resolve_ref(path, lock->old_sha1, mustexist);
 	if (!path) {
-		error("Can't read ref %s", path);
 		unlock_ref(lock);
 		return NULL;
 	}
@@ -326,7 +327,7 @@ struct ref_lock* lock_ref_sha1(const cha
 	if (check_ref_format(ref))
 		return NULL;
 	return lock_ref_sha1_basic(git_path("refs/%s", ref),
-		strlen(ref), old_sha1, mustexist);
+		5 + strlen(ref), old_sha1, mustexist);
 }
 
 struct ref_lock* lock_any_ref_for_update(const char *ref,
diff --git a/ssh-fetch.c b/ssh-fetch.c
index 4eb9e04..e3067b8 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -132,6 +132,7 @@ int main(int argc, char **argv)
 	if (!prog) prog = "git-ssh-upload";
 
 	setup_git_directory();
+	git_config(git_default_config);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -158,6 +159,7 @@ int main(int argc, char **argv)
 	}
 	commit_id = argv[arg];
 	url = argv[arg + 1];
+	write_ref_log_details = url;
 
 	if (setup_connection(&fd_in, &fd_out, prog, url, arg, argv + 1))
 		return 1;
-- 
1.3.2.g7278
