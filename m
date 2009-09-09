From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] preserve mtime of local clone
Date: Wed, 9 Sep 2009 21:51:58 +0200
Message-ID: <20090909195158.GA12968@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 21:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlTDO-000323-Ob
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 21:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbZIITwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 15:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbZIITwR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 15:52:17 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:55582 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbZIITwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 15:52:16 -0400
Received: by fxm17 with SMTP id 17so3636429fxm.37
        for <git@vger.kernel.org>; Wed, 09 Sep 2009 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=GN9/jrf98V2OLrMbkVXiL77BPTgTLsRs7iLH5NwBZj0=;
        b=e21L9AQve65yHxdN6hArnPRC7UOl4fXExc7XJBAWSZpljfhTvPkgvQXNg8kZe2S6xA
         uNmVU6XbXL9UcxyEHxiMCJyDkvUpb1QCyfKon3XAlJ3S7/AUrdJqg7Tqof4SblZXtUtn
         UnRIxJBkA1FHp2CwxfhWxiO9aro5AHBe/9XuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=eU1HzYF93SFLPz9gtPGWdlA1WjJHAIn+SYg7UzXyEdJo6VuqB78ACHXqsbdMOCwlI+
         9zAtoStIN3GfVy4XDPstlOV7Pui9uIjba3veyeu44kVWjQEn9i18g3eHsGYQUqYWdJ1/
         OveTXolhfXuZE1NZQ708k6iTZj0eALgyN37OE=
Received: by 10.204.32.16 with SMTP id a16mr122529bkd.190.1252525938709;
        Wed, 09 Sep 2009 12:52:18 -0700 (PDT)
Received: from darc.lan (p549A38D9.dip.t-dialin.net [84.154.56.217])
        by mx.google.com with ESMTPS id 1sm2318210bwz.56.2009.09.09.12.52.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Sep 2009 12:52:16 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MlTCw-0002We-Qn; Wed, 09 Sep 2009 21:51:58 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128079>

A local clone without hardlinks copies all objects, including dangling
ones, to the new repository. Since the mtimes are renewed, those
dangling objects cannot be pruned by "git gc --prune", even if they
would have been old enough for pruning in the original repository.

Instead, preserve mtime during copy. "git gc --prune" will then work
in the clone just like it would have in the original.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I noticed this problem when I cloned a repo with lots of old dangling
objects onto a windows machine. git-gui immediately recommended running
git-gc, and I did. But each time I restarted git-gui, it recommended git-gc
again, because there were still plenty of dangling objects lying around
which could not be removed due to their recent mtimes.

So there is actually a problem with git-gui's recommendation. Especially on
Windows, where it only checks for 1 or more files in .git/objects/42 (as
opposed to 8 files on other platforms). The probability of that happening if
the repo contains about 100 loose objects is 1-(254/255)^100 = 32%. The
probability for the same to happen with at least 2 files is only 6% [*].
Maybe that would be a good compromise?

Alternatively, git-gc could remember the number of dangling objects, and
git-gui can adjust its recommendation accordingly, taking that number and
the date of the lastest repack into account.

Clemens

[*] The following octave script shows the probability for m or more objects
to be in .git/objects/42 for a total of n objects.

m = [1 2 8];
n = 100:100:3000;

P = zeros(length(n), length(m));
for k = 1:length(n)
	P(n(k), :) = 1-binocdf(m-1, n(k), 1/255);
end
plot(n, P);

n \ m	1	2	8
100	32%	6%	0%
500	86%	58%	0%
1000	98%	90%	5%
2000	100%	100%	55%

---
 builtin-clone.c   |    2 +-
 builtin-init-db.c |    2 +-
 cache.h           |    6 ++++--
 copy.c            |   25 ++++++++++++++++++++++---
 lockfile.c        |    2 +-
 rerere.c          |    2 +-
 6 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index ad04808..cb3c895 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -269,7 +269,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 				die_errno("failed to create link '%s'", dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file(dest->buf, src->buf, 0666))
+		if (copy_file(dest->buf, src->buf, 0666, 1))
 			die_errno("failed to copy file to '%s'", dest->buf);
 	}
 	closedir(dir);
diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..5deb81d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -100,7 +100,7 @@ static void copy_templates_1(char *path, int baselen,
 				die_errno("cannot symlink '%s' '%s'", lnk, path);
 		}
 		else if (S_ISREG(st_template.st_mode)) {
-			if (copy_file(path, template, st_template.st_mode))
+			if (copy_file(path, template, st_template.st_mode, 0))
 				die_errno("cannot copy '%s' to '%s'", template,
 					  path);
 		}
diff --git a/cache.h b/cache.h
index 5fad24c..1875c97 100644
--- a/cache.h
+++ b/cache.h
@@ -921,8 +921,10 @@ extern const char *git_mailmap_file;
 
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
-extern int copy_fd(int ifd, int ofd);
-extern int copy_file(const char *dst, const char *src, int mode);
+extern int copy_fd(int ifd, int ofd, int preserve_times);
+extern int copy_file(const char *dst, const char *src, int mode, int
+		preserve_times);
+extern int copy_times(int ofd, int ifd);
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
 extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
diff --git a/copy.c b/copy.c
index e54d15a..fe0380e 100644
--- a/copy.c
+++ b/copy.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 
-int copy_fd(int ifd, int ofd)
+int copy_fd(int ifd, int ofd, int preserve_times)
 {
 	while (1) {
 		char buffer[8192];
@@ -31,11 +31,18 @@ int copy_fd(int ifd, int ofd)
 			}
 		}
 	}
+	if (preserve_times && copy_times(ofd, ifd)) {
+		int time_error = errno;
+		close(ifd);
+		return error("copy-fd: failed to preserve times: %s",
+				strerror(time_error));
+	}
 	close(ifd);
 	return 0;
 }
 
-int copy_file(const char *dst, const char *src, int mode)
+int copy_file(const char *dst, const char *src, int mode,
+		int preserve_times)
 {
 	int fdi, fdo, status;
 
@@ -46,7 +53,7 @@ int copy_file(const char *dst, const char *src, int mode)
 		close(fdi);
 		return fdo;
 	}
-	status = copy_fd(fdi, fdo);
+	status = copy_fd(fdi, fdo, preserve_times);
 	if (close(fdo) != 0)
 		return error("%s: close error: %s", dst, strerror(errno));
 
@@ -55,3 +62,15 @@ int copy_file(const char *dst, const char *src, int mode)
 
 	return status;
 }
+
+int copy_times(int ofd, int ifd)
+{
+	struct stat st;
+	struct timespec times[2];
+	if (fstat(ifd, &st))
+		return -1;
+	times[0].tv_nsec = UTIME_OMIT;
+	times[1].tv_sec = st.st_mtime;
+	times[1].tv_nsec = ST_MTIME_NSEC(st);
+	return futimens(ofd, times);
+}
diff --git a/lockfile.c b/lockfile.c
index eb931ed..c7bbd4d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -196,7 +196,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 			close(fd);
 			return error("cannot open '%s' for copying", path);
 		}
-	} else if (copy_fd(orig_fd, fd)) {
+	} else if (copy_fd(orig_fd, fd, 0)) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
 		close(fd);
diff --git a/rerere.c b/rerere.c
index 87360dc..d25f5f1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -326,7 +326,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 			continue;
 
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-		copy_file(rerere_path(name, "postimage"), path, 0666);
+		copy_file(rerere_path(name, "postimage"), path, 0666, 0);
 	mark_resolved:
 		rr->items[i].util = NULL;
 	}
-- 
1.6.4.2.266.gbaa17
