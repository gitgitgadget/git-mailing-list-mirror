From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 12:45:39 +0200
Message-ID: <20050914104539.GP15165MdfPADPa@greensroom.kotnet.org>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
 <20050913211444.GA27029@mars.ravnborg.org>
 <7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
 <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 12:47:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFUmJ-0005Tv-Gk
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 12:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbVINKqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 06:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbVINKqI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 06:46:08 -0400
Received: from smtp18.wxs.nl ([195.121.6.14]:53454 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S932713AbVINKqH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 06:46:07 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IMS0098EZ83IN@smtp18.wxs.nl> for git@vger.kernel.org; Wed,
 14 Sep 2005 12:45:40 +0200 (CEST)
Received: (qmail 27618 invoked by uid 500); Wed, 14 Sep 2005 10:45:39 +0000
In-reply-to: <7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>,
 Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8516>

On Tue, Sep 13, 2005 at 03:11:42PM -0700, Junio C Hamano wrote:
> The file $GIT_DIR/info/refs was introduced to solve this by
> listing the available refs for discovery, and hooks/post-update,
> when enabled, runs update-server-info to update the file (among
> other things) whenever you push into the repository.  

It doesn't help that update-server-info crashes if you run
it for the first time on an old repo.
Maybe it should create the appropriate directory structure on the fly,
but the patch below at least checks whether new rev-cache could
be created.

skimo
--

write_rev_cache: check whether new cache could be created.

---
commit d30b87459c690ff68e65dfe8ecdc585dab64323a
tree 51127c1af00f8fd63e7b996384e86d7d31ad5562
parent 2ba6c47be1762726ad0c1d5779064c489150d789
author Sven Verdoolaege <skimo@liacs.nl> Wed, 14 Sep 2005 12:40:28 +0200
committer Sven Verdoolaege <skimo@liacs.nl> Wed, 14 Sep 2005 12:40:28 +0200

 rev-cache.c   |    8 +++++++-
 rev-cache.h   |    2 +-
 server-info.c |    7 ++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/rev-cache.c b/rev-cache.c
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -103,7 +103,7 @@ static void write_one_rev_cache(FILE *re
 		write_one_rev_cache(rev_cache_file, rle->ri);
 }
 
-void write_rev_cache(const char *newpath, const char *oldpath)
+int write_rev_cache(const char *newpath, const char *oldpath)
 {
 	/* write the following commit ancestry information in
 	 * $GIT_DIR/info/rev-cache.
@@ -131,6 +131,11 @@ void write_rev_cache(const char *newpath
 		size_t sz;
 		FILE *oldfp = fopen(oldpath, "r");
 		rev_cache_file = fopen(newpath, "w");
+		if (!rev_cache_file) {
+			if (oldfp)
+				fclose(oldfp);
+			return error("cannot open %s", newpath);
+		}
 		if (oldfp) {
 			while (1) {
 				sz = fread(buf, 1, sizeof(buf), oldfp);
@@ -161,6 +166,7 @@ void write_rev_cache(const char *newpath
 		write_one_rev_cache(rev_cache_file, ri);
 	}
 	fclose(rev_cache_file);
+	return 0;
 }
 
 static void add_parent(struct rev_cache *child,
diff --git a/rev-cache.h b/rev-cache.h
--- a/rev-cache.h
+++ b/rev-cache.h
@@ -24,6 +24,6 @@ struct rev_list_elem {
 extern int find_rev_cache(const unsigned char *);
 extern int read_rev_cache(const char *, FILE *, int);
 extern int record_rev_cache(const unsigned char *, FILE *);
-extern void write_rev_cache(const char *new, const char *old);
+extern int write_rev_cache(const char *new, const char *old);
 
 #endif
diff --git a/server-info.c b/server-info.c
--- a/server-info.c
+++ b/server-info.c
@@ -536,6 +536,7 @@ static int update_info_revs(int force)
 	char *path0 = strdup(git_path("info/rev-cache"));
 	int len = strlen(path0);
 	char *path1 = xmalloc(len + 2);
+	int errs = 0;
 
 	strcpy(path1, path0);
 	strcpy(path1 + len, "+");
@@ -548,11 +549,11 @@ static int update_info_revs(int force)
 	for_each_ref(record_rev_cache_ref);
 
 	/* update the rev-cache database */
-	write_rev_cache(path1, force ? "/dev/null" : path0);
-	rename(path1, path0);
+	errs = errs || write_rev_cache(path1, force ? "/dev/null" : path0);
+	errs = errs || rename(path1, path0);
 	free(path1);
 	free(path0);
-	return 0;
+	return errs;
 }
 
 /* public */
