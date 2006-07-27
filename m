From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/4] Make pull() support fetching multiple targets at once
Date: Thu, 27 Jul 2006 23:56:17 +0200
Message-ID: <20060727215617.24240.4753.stgit@machine>
References: <20060727215326.24240.20118.stgit@machine>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 23:56:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6DqI-0006lX-0Z
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWG0V4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWG0V4V
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:56:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28622 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751324AbWG0V4U (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 17:56:20 -0400
Received: (qmail 24868 invoked from network); 27 Jul 2006 23:56:17 +0200
Received: from localhost (HELO ?62.24.88.241?) (xpasky@127.0.0.1)
  by localhost with SMTP; 27 Jul 2006 23:56:17 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060727215326.24240.20118.stgit@machine>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24352>

pull() now takes an array of arguments instead of just one of each kind.
Currently, no users use the new capability, but that'll change.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 fetch.c       |   78 +++++++++++++++++++++++++++++++++------------------------
 fetch.h       |    2 +
 http-fetch.c  |    2 +
 local-fetch.c |    2 +
 ssh-fetch.c   |    2 +
 5 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/fetch.c b/fetch.c
index 3255cc6..281df61 100644
--- a/fetch.c
+++ b/fetch.c
@@ -210,55 +210,67 @@ static int mark_complete(const char *pat
 	return 0;
 }
 
-int pull(char *target, const char *write_ref,
+int pull(int targets, char **target, const char **write_ref,
          const char *write_ref_log_details)
 {
-	struct ref_lock *lock = NULL;
-	unsigned char sha1[20];
+	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
+	unsigned char *sha1 = xmalloc(targets * 20);
 	char *msg;
 	int ret;
+	int i;
 
 	save_commit_buffer = 0;
 	track_object_refs = 0;
-	if (write_ref) {
-		lock = lock_ref_sha1(write_ref, NULL, 0);
-		if (!lock) {
-			error("Can't lock ref %s", write_ref);
-			return -1;
+
+	for (i = 0; i < targets; i++) {
+		if (!write_ref[i])
+			continue;
+
+		lock[i] = lock_ref_sha1(write_ref[i], NULL, 0);
+		if (!lock[i]) {
+			error("Can't lock ref %s", write_ref[i]);
+			goto unlock_and_fail;
 		}
 	}
 
 	if (!get_recover)
 		for_each_ref(mark_complete);
 
-	if (interpret_target(target, sha1)) {
-		error("Could not interpret %s as something to pull", target);
-		if (lock)
-			unlock_ref(lock);
-		return -1;
+	for (i = 0; i < targets; i++) {
+		if (interpret_target(target[i], &sha1[20 * i])) {
+			error("Could not interpret %s as something to pull", target[i]);
+			goto unlock_and_fail;
+		}
+		if (process(lookup_unknown_object(&sha1[20 * i])))
+			goto unlock_and_fail;
 	}
-	if (process(lookup_unknown_object(sha1))) {
-		if (lock)
-			unlock_ref(lock);
-		return -1;
+
+	if (loop())
+		goto unlock_and_fail;
+
+	if (write_ref_log_details) {
+		msg = xmalloc(strlen(write_ref_log_details) + 12);
+		sprintf(msg, "fetch from %s", write_ref_log_details);
+	} else {
+		msg = NULL;
 	}
-	if (loop()) {
-		if (lock)
-			unlock_ref(lock);
-		return -1;
+	for (i = 0; i < targets; i++) {
+		if (!write_ref[i])
+			continue;
+		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
+		lock[i] = NULL;
+		if (ret)
+			goto unlock_and_fail;
 	}
+	if (msg)
+		free(msg);
 
-	if (write_ref) {
-		if (write_ref_log_details) {
-			msg = xmalloc(strlen(write_ref_log_details) + 12);
-			sprintf(msg, "fetch from %s", write_ref_log_details);
-		}
-		else
-			msg = NULL;
-		ret = write_ref_sha1(lock, sha1, msg ? msg : "fetch (unknown)");
-		if (msg)
-			free(msg);
-		return ret;
-	}
 	return 0;
+
+
+unlock_and_fail:
+	for (i = 0; i < targets; i++)
+		if (lock[i])
+			unlock_ref(lock[i]);
+	return -1;
 }
diff --git a/fetch.h b/fetch.h
index 7bda355..75e48af 100644
--- a/fetch.h
+++ b/fetch.h
@@ -42,7 +42,7 @@ extern void pull_say(const char *, const
 
 /* If write_ref is set, the ref filename to write the target value to. */
 /* If write_ref_log_details is set, additional text will appear in the ref log. */
-extern int pull(char *target, const char *write_ref,
+extern int pull(int targets, char **target, const char **write_ref,
 		const char *write_ref_log_details);
 
 #endif /* PULL_H */
diff --git a/http-fetch.c b/http-fetch.c
index 963d439..bc67db1 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1268,7 +1268,7 @@ int main(int argc, char **argv)
 			alt->path_len = strlen(path);
 	}
 
-	if (pull(commit_id, write_ref, url))
+	if (pull(1, &commit_id, &write_ref, url))
 		rc = 1;
 
 	http_cleanup();
diff --git a/local-fetch.c b/local-fetch.c
index 308ed00..eb19f1a 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -242,7 +242,7 @@ int main(int argc, char **argv)
 	commit_id = argv[arg];
 	path = argv[arg + 1];
 
-	if (pull(commit_id, write_ref, path))
+	if (pull(1, &commit_id, &write_ref, path))
 		return 1;
 
 	return 0;
diff --git a/ssh-fetch.c b/ssh-fetch.c
index aef3aa4..6e16568 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -167,7 +167,7 @@ int main(int argc, char **argv)
 	if (get_version())
 		return 1;
 
-	if (pull(commit_id, write_ref, url))
+	if (pull(1, &commit_id, &write_ref, url))
 		return 1;
 
 	return 0;
