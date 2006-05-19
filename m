From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 3/5] Force writing ref if it doesn't exist.
Date: Fri, 19 May 2006 03:29:05 -0400
Message-ID: <20060519072905.GD22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 09:29:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzQ8-0005Rt-ND
	for gcvg-git@gmane.org; Fri, 19 May 2006 09:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWESH3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 03:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWESH3J
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 03:29:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34499 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751100AbWESH3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 03:29:08 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgzQ1-0002ji-J3; Fri, 19 May 2006 03:29:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DFE3F212691; Fri, 19 May 2006 03:29:05 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20331>

Normally we try to skip writing a ref if its value hasn't changed
but in the special case that the ref doesn't exist but the new
value is going to be 0{40} then force writing the ref anyway.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 refs.c |    4 +++-
 refs.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

13f3c9a2b8959da1947e21c32e58d81d32a83f3e
diff --git a/refs.c b/refs.c
index 9d37a02..31cf276 100644
--- a/refs.c
+++ b/refs.c
@@ -288,6 +288,7 @@ static struct ref_lock* lock_ref_sha1_ba
 	const unsigned char *old_sha1, int mustexist)
 {
 	struct ref_lock *lock;
+	struct stat st;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
@@ -303,6 +304,7 @@ static struct ref_lock* lock_ref_sha1_ba
 	lock->ref_file = strdup(path);
 	lock->lock_file = strdup(mkpath("%s.lock", lock->ref_file));
 	lock->log_file = strdup(git_path("logs/%s", lock->ref_file + plen));
+	lock->force_write = !lstat(lock->ref_file, &st) || errno == ENOENT;
 
 	if (safe_create_leading_directories(lock->lock_file))
 		die("unable to create directory for %s", lock->lock_file);
@@ -405,7 +407,7 @@ int write_ref_sha1(struct ref_lock *lock
 
 	if (!lock)
 		return -1;
-	if (!memcmp(lock->old_sha1, sha1, 20)) {
+	if (!lock->force_write && !memcmp(lock->old_sha1, sha1, 20)) {
 		unlock_ref(lock);
 		return 0;
 	}
diff --git a/refs.h b/refs.h
index 2c854de..6c946ea 100644
--- a/refs.h
+++ b/refs.h
@@ -7,6 +7,7 @@ struct ref_lock {
 	char *log_file;
 	unsigned char old_sha1[20];
 	int lock_fd;
+	int force_write;
 };
 
 /*
-- 
1.3.2.g7278
