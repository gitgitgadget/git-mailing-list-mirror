From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] Enhance core.logallrefupdates
Date: Sun, 08 Oct 2006 01:02:45 -0700
Message-ID: <7vbqonkzfe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 08 10:03:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWTcl-0008C9-3j
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 10:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWJHICr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 04:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWJHICr
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 04:02:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10647 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750892AbWJHICq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 04:02:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061008080245.SRAH22409.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Oct 2006 04:02:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xk2d1V0061kojtg0000000
	Sun, 08 Oct 2006 04:02:37 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28523>

This enhances core.logallrefupdates by allowing it to take
"heads" as the value as well, which causes git to create missing
reflog files automatically only for branch heads.  Usually tags
are create-once-and-live-forever, and it is irritating to see
reflog files created automatically every time a new tag is made.

As before, boolean "true" means create missing reflog files for
all refs.

---

 * Setting it to "tags" is not supported, as it does not make
   much sense wanting to log only tag updates.

   Come to think of it, it might make sense to change the
   meaning of "true" to do what this patch does.  I do not think
   of reasons to create missing reflog for tags automatically
   anyway.

   Opinions?

 cache.h  |    2 ++
 config.c |    9 ++++++++-
 refs.c   |    7 ++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 0565333..6029a1d 100644
--- a/cache.h
+++ b/cache.h
@@ -186,6 +186,8 @@ extern int use_legacy_headers;
 extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
+#define REF_LOG_ALL 1
+#define REF_LOG_HEADS 2
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
diff --git a/config.c b/config.c
index e8f0caf..c254a57 100644
--- a/config.c
+++ b/config.c
@@ -270,7 +270,14 @@ int git_default_config(const char *var, 
 	}
 
 	if (!strcmp(var, "core.logallrefupdates")) {
-		log_all_ref_updates = git_config_bool(var, value);
+		if (!strcasecmp(value, "heads"))
+			log_all_ref_updates = REF_LOG_HEADS;
+		else if (!strcasecmp(value, "all"))
+			log_all_ref_updates = REF_LOG_ALL;
+		else if (git_config_bool(var, value))
+			log_all_ref_updates = REF_LOG_ALL;
+		else
+			log_all_ref_updates = 0;
 		return 0;
 	}
 
diff --git a/refs.c b/refs.c
index 305c1a9..fa3c3d7 100644
--- a/refs.c
+++ b/refs.c
@@ -720,8 +720,13 @@ static int log_ref_write(struct ref_lock
 	unsigned maxlen, len;
 	char *logrec;
 	const char *committer;
+	int create_missing = log_all_ref_updates;
 
-	if (log_all_ref_updates) {
+	if ((log_all_ref_updates == REF_LOG_HEADS) &&
+	    strncmp(lock->ref_name, "refs/heads/", 11))
+		create_missing = 0;
+
+	if (create_missing) {
 		if (safe_create_leading_directories(lock->log_file) < 0)
 			return error("unable to create directory for %s",
 				lock->log_file);
