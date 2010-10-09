From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 4/5] lstat_cache: optionally return match_len
Date: Sat,  9 Oct 2010 15:52:59 +0200
Message-ID: <1286632380-7002-5-git-send-email-drizzd@aon.at>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 15:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4ZrW-0003Jt-Nw
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 15:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab0JINxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 09:53:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37275 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0JINxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 09:53:05 -0400
Received: by fxm14 with SMTP id 14so952447fxm.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kXH9QqPoUGsZLDQGCQe20c89rVn7fZ6twD9hgIywSkA=;
        b=tiqaCjd/6jVaqhpsysJSpT/BcRFvVzVEBuTFgPcbptyOkTROBcnlSgD0zCbL13zhw3
         /wyalKe0wbYgQfan/viufVwgCq/aWr3Y5lFX+p/ibDjHUBREGhtIcWM0+LiwkrFrz9k6
         tTWoXi/bKWFEvEC7Hld0vPsPsdqGIPeqV3Vfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=Lgy2Ic7lmX5+XHzFiAjlYcHPS7z+jVUp2k2TUS8FizetBjVi6VlEft25IYvOij661q
         8awYnkQREqecBrxkZCBi/sUCj7a5EtdR9D/i1sfg4G/ZA/NZl9mZC/ATA7xW+qeSN58i
         XHKYxoPY2c4RMZWyPelBYfgaTk//caHzMIiLU=
Received: by 10.223.79.75 with SMTP id o11mr422136fak.135.1286632383921;
        Sat, 09 Oct 2010 06:53:03 -0700 (PDT)
Received: from darc.lan (p549A51C3.dip.t-dialin.net [84.154.81.195])
        by mx.google.com with ESMTPS id u8sm2150277fah.36.2010.10.09.06.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 06:53:02 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4ZrN-0001sg-7Z; Sat, 09 Oct 2010 15:53:13 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158587>

Return match_len so that the caller can know which leading path
component matched.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 symlinks.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 8860120..b7343eb 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -64,11 +64,13 @@ static inline void reset_lstat_cache(struct cache_def *cache)
  * of the prefix, where the cache should use the stat() function
  * instead of the lstat() function to test each path component.
  */
-static int lstat_cache(struct cache_def *cache, const char *name, int len,
-		       int track_flags, int prefix_len_stat_func)
+static int lstat_cache_matchlen(struct cache_def *cache,
+				const char *name, int len,
+				int *ret_flags, int track_flags,
+				int prefix_len_stat_func)
 {
 	int match_len, last_slash, last_slash_dir, previous_slash;
-	int match_flags, ret_flags, save_flags, max_len, ret;
+	int save_flags, max_len, ret;
 	struct stat st;
 
 	if (cache->track_flags != track_flags ||
@@ -90,13 +92,13 @@ static int lstat_cache(struct cache_def *cache, const char *name, int len,
 		match_len = last_slash =
 			longest_path_match(name, len, cache->path, cache->len,
 					   &previous_slash);
-		match_flags = cache->flags & track_flags & (FL_NOENT|FL_SYMLINK);
+		*ret_flags = cache->flags & track_flags & (FL_NOENT|FL_SYMLINK);
 
 		if (!(track_flags & FL_FULLPATH) && match_len == len)
 			match_len = last_slash = previous_slash;
 
-		if (match_flags && match_len == cache->len)
-			return match_flags;
+		if (*ret_flags && match_len == cache->len)
+			return match_len;
 		/*
 		 * If we now have match_len > 0, we would know that
 		 * the matched part will always be a directory.
@@ -105,16 +107,16 @@ static int lstat_cache(struct cache_def *cache, const char *name, int len,
 		 * a substring of the cache on a path component basis,
 		 * we can return immediately.
 		 */
-		match_flags = track_flags & FL_DIR;
-		if (match_flags && len == match_len)
-			return match_flags;
+		*ret_flags = track_flags & FL_DIR;
+		if (*ret_flags && len == match_len)
+			return match_len;
 	}
 
 	/*
 	 * Okay, no match from the cache so far, so now we have to
 	 * check the rest of the path components.
 	 */
-	ret_flags = FL_DIR;
+	*ret_flags = FL_DIR;
 	last_slash_dir = last_slash;
 	max_len = len < PATH_MAX ? len : PATH_MAX;
 	while (match_len < max_len) {
@@ -133,16 +135,16 @@ static int lstat_cache(struct cache_def *cache, const char *name, int len,
 			ret = lstat(cache->path, &st);
 
 		if (ret) {
-			ret_flags = FL_LSTATERR;
+			*ret_flags = FL_LSTATERR;
 			if (errno == ENOENT)
-				ret_flags |= FL_NOENT;
+				*ret_flags |= FL_NOENT;
 		} else if (S_ISDIR(st.st_mode)) {
 			last_slash_dir = last_slash;
 			continue;
 		} else if (S_ISLNK(st.st_mode)) {
-			ret_flags = FL_SYMLINK;
+			*ret_flags = FL_SYMLINK;
 		} else {
-			ret_flags = FL_ERR;
+			*ret_flags = FL_ERR;
 		}
 		break;
 	}
@@ -152,7 +154,7 @@ static int lstat_cache(struct cache_def *cache, const char *name, int len,
 	 * path types, FL_NOENT, FL_SYMLINK and FL_DIR, can be cached
 	 * for the moment!
 	 */
-	save_flags = ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
+	save_flags = *ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
 	if (save_flags && last_slash > 0 && last_slash <= PATH_MAX) {
 		cache->path[last_slash] = '\0';
 		cache->len = last_slash;
@@ -176,7 +178,16 @@ static int lstat_cache(struct cache_def *cache, const char *name, int len,
 	} else {
 		reset_lstat_cache(cache);
 	}
-	return ret_flags;
+	return match_len;
+}
+
+static int lstat_cache(struct cache_def *cache, const char *name, int len,
+		       int track_flags, int prefix_len_stat_func)
+{
+	int flags;
+	(void)lstat_cache_matchlen(cache, name, len, &flags, track_flags,
+			prefix_len_stat_func);
+	return flags;
 }
 
 #define USE_ONLY_LSTAT  0
-- 
1.7.1.571.gba4d01
