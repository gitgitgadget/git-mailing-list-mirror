From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] preserve mtime of local clone
Date: Sat, 12 Sep 2009 11:03:48 +0200
Message-ID: <20090912090348.GB9654@localhost>
References: <20090909195158.GA12968@localhost> <7vmy50lpfr.fsf@alter.siamese.dyndns.org> <20090912082624.GA9654@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 11:10:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmOck-00025l-SZ
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 11:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbZILJEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 05:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZILJEK
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 05:04:10 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64464 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbZILJEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 05:04:09 -0400
Received: by fxm17 with SMTP id 17so1239278fxm.37
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=LeIMXQCtZPjKXPY+b8Ud6h27QyPKwshBCYO0Gjvzjd4=;
        b=U66F51Sf1LMJjxmn3uKmEWCDgBLIhTXCy4UNpnC8iaF2OeCjINFNJHYe20ykmwbiI3
         uG0tu+cfNvy0KAP+SJ7b3claTtOz8SuBwJvLhylDLCAgFYN/WYwUddGgbVZKZoMQ5RCH
         H+eHWIGnfxA4Th9AVEtkfNxe+N4xZNlBnGPY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=SIN+O6mG8MWzcJTu0gYuxiS5FDzErUEnBK7WC0ME5cGAEYAA9R+WZ8IFVkq/F/QYCy
         /SgPMfIGVTH6Sxwm6/trT42jHlzi7pO3X0lqxMz9pOsdkwpsjjirxXjRt8YCHU3h+iWA
         yfCRDYFMyVBwox1b519Krn7kiUWaF/HRqZIKM=
Received: by 10.204.8.151 with SMTP id h23mr2823168bkh.194.1252746251572;
        Sat, 12 Sep 2009 02:04:11 -0700 (PDT)
Received: from darc.lan (p549A7B9E.dip.t-dialin.net [84.154.123.158])
        by mx.google.com with ESMTPS id 11sm5200275bwz.71.2009.09.12.02.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Sep 2009 02:04:10 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MmOWK-0003ge-Sj; Sat, 12 Sep 2009 11:03:48 +0200
Content-Disposition: inline
In-Reply-To: <20090912082624.GA9654@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128242>

A local clone without hardlinks copies all objects, including dangling
ones, to the new repository. Since the mtimes are renewed, those
dangling objects cannot be pruned by "git gc --prune", even if they
would have been old enough for pruning in the original repository.

Instead, preserve mtime during copy. "git gc --prune" will then work
in the clone just like it did in the original.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sat, Sep 12, 2009 at 10:26:24AM +0200, Clemens Buchacher wrote:

> If it's a problem we can use utime() instead. I was just trying to use the
> file descriptors, since they were available. But the patch would be a little
> smaller if I didn't touch copy_fd().

Here we go.

 builtin-clone.c   |    2 +-
 builtin-init-db.c |    2 +-
 cache.h           |    4 +++-
 copy.c            |   18 +++++++++++++++++-
 rerere.c          |    2 +-
 5 files changed, 23 insertions(+), 5 deletions(-)

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
index 5fad24c..ac692d0 100644
--- a/cache.h
+++ b/cache.h
@@ -922,7 +922,9 @@ extern const char *git_mailmap_file;
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
-extern int copy_file(const char *dst, const char *src, int mode);
+extern int copy_file(const char *dst, const char *src, int mode, int
+		preserve_times);
+extern int copy_times(const char *dst, const char *src);
 extern ssize_t read_in_full(int fd, void *buf, size_t count);
 extern ssize_t write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
diff --git a/copy.c b/copy.c
index e54d15a..fb5e946 100644
--- a/copy.c
+++ b/copy.c
@@ -35,7 +35,21 @@ int copy_fd(int ifd, int ofd)
 	return 0;
 }
 
-int copy_file(const char *dst, const char *src, int mode)
+int copy_times(const char *dst, const char *src)
+{
+	struct stat st;
+	struct utimbuf times;
+	if (stat(src, &st) < 0)
+		return -1;
+	times.actime = st.st_atime;
+	times.modtime = st.st_mtime;
+	if (utime(dst, &times) < 0)
+		return -1;
+	return 0;
+}
+
+int copy_file(const char *dst, const char *src, int mode,
+		int preserve_times)
 {
 	int fdi, fdo, status;
 
@@ -52,6 +66,8 @@ int copy_file(const char *dst, const char *src, int mode)
 
 	if (!status && adjust_shared_perm(dst))
 		return -1;
+	if (!status && preserve_times && copy_times(dst, src))
+		return -1;
 
 	return status;
 }
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
1.6.5.rc0.164.g5f6b0
