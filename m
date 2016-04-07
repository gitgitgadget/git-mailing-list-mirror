From: David Turner <dturner@twopensource.com>
Subject: [PATCH 15/24] read_raw_ref(): manage own scratch space
Date: Thu,  7 Apr 2016 15:03:02 -0400
Message-ID: <1460055791-23313-16-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDW-0007CX-V7
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbcDGTDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:44 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34280 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932342AbcDGTDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:37 -0400
Received: by mail-qg0-f50.google.com with SMTP id c6so71716009qga.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=iHEl0e2QMTe8Z8J4DCcuFfBmUvpCGagpvEOq4vw1YTg=;
        b=gnnc59CDkUVvlh0VX2DNYwmx0xduPQimFTUxBC0b+rpEoTbK+bLH/8Of7+Bjzipl+7
         Y7jX5XnQ/5ErfcFWvHafYf4KaalabjgzhImKsqgNlcbao708kE//ty8lprt9sGsvJ1x1
         aLgAAaC2UZATHen9BAAm9OPZCA1fKFOP0SzAOM66NO2EUKXEPeofHuN5WEgfeazNBn1v
         EycXYeiRJp9tHTmdHnyCaHBD8erV59munhJDVLI+75nheYJWgsBr/aV8/TFGNIStGatX
         8lZyl0f8CLTka2vq96Wj/XWlIzCmjd7UExMoSaaUflFCkAqeUrcyNCaHnllWXkPLsk0J
         MpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=iHEl0e2QMTe8Z8J4DCcuFfBmUvpCGagpvEOq4vw1YTg=;
        b=TFmMy+hkoP3SRre9pzSXZiuyWHadx9ZM7xfib6bvQSd4YwYj6YYqp9oo77Qw3iMknX
         wOMJxPRPCW/88uY/n2PgWkYtGNEWDxUJRoYJDZ78Cb785ZFz8lgY53VOrWuSDnYveQXQ
         cKJHbZqyuWhWfhbNbwHmcWvMunfP8A6nbysfSb46iiyExoAY5Hd0zAhaIRawLXllvxkq
         Wb1C5EJtzCw+gY6ri6axLioJbDmbOduBXikwSqK5Vu9eZkT3fcvL6NJ+CVQzeczt4Zk1
         Qvu4DadBSC2tWcrxLZA0LbXWpmFLbLTUml2iys1S6/itF88k7SBmEiFfrzstQKegGAd+
         Rz+A==
X-Gm-Message-State: AD7BkJJ0foZAZ6ieLfo9FQmCOCrV3zQ8/iIumIeLxIud68ybMGcIDpVfrDnv62RRU90oTg==
X-Received: by 10.140.37.113 with SMTP id q104mr5968834qgq.104.1460055816700;
        Thu, 07 Apr 2016 12:03:36 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290958>

From: Michael Haggerty <mhagger@alum.mit.edu>

Instead of creating scratch space in resolve_ref_unsafe() and passing it
down through resolve_ref_1 to read_raw_ref(), teach read_raw_ref() to
manage its own scratch space. This reduces coupling across the functions
at the cost of some extra allocations. Also, when read_raw_ref() is
implemented for different reference backends, the other implementations
might have different scratch space requirements.

Note that we now preserve errno across the calls to strbuf_release(),
which calls free() and can thus theoretically overwrite errno.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 76 ++++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d51e778..f752568 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1421,17 +1421,20 @@ static int resolve_missing_loose_ref(const char *refname,
  *   refname will still be valid and unchanged.
  */
 static int read_raw_ref(const char *refname, unsigned char *sha1,
-			struct strbuf *symref, struct strbuf *sb_path,
-			struct strbuf *sb_contents, int *flags)
+			struct strbuf *symref, int *flags)
 {
+	struct strbuf sb_contents = STRBUF_INIT;
+	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
 	const char *buf;
 	struct stat st;
 	int fd;
+	int ret = -1;
+	int save_errno;
 
-	strbuf_reset(sb_path);
-	strbuf_git_path(sb_path, "%s", refname);
-	path = sb_path->buf;
+	strbuf_reset(&sb_path);
+	strbuf_git_path(&sb_path, "%s", refname);
+	path = sb_path.buf;
 
 stat_ref:
 	/*
@@ -1446,36 +1449,38 @@ stat_ref:
 
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
-			return -1;
+			goto out;
 		if (resolve_missing_loose_ref(refname, sha1, flags)) {
 			errno = ENOENT;
-			return -1;
+			goto out;
 		}
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	/* Follow "normalized" - ie "refs/.." symlinks by hand */
 	if (S_ISLNK(st.st_mode)) {
-		strbuf_reset(sb_contents);
-		if (strbuf_readlink(sb_contents, path, 0) < 0) {
+		strbuf_reset(&sb_contents);
+		if (strbuf_readlink(&sb_contents, path, 0) < 0) {
 			if (errno == ENOENT || errno == EINVAL)
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
 			else
-				return -1;
+				goto out;
 		}
-		if (starts_with(sb_contents->buf, "refs/") &&
-		    !check_refname_format(sb_contents->buf, 0)) {
-			strbuf_swap(sb_contents, symref);
+		if (starts_with(sb_contents.buf, "refs/") &&
+		    !check_refname_format(sb_contents.buf, 0)) {
+			strbuf_swap(&sb_contents, symref);
 			*flags |= REF_ISSYMREF;
-			return 0;
+			ret = 0;
+			goto out;
 		}
 	}
 
 	/* Is it a directory? */
 	if (S_ISDIR(st.st_mode)) {
 		errno = EISDIR;
-		return -1;
+		goto out;
 	}
 
 	/*
@@ -1488,18 +1493,18 @@ stat_ref:
 			/* inconsistent with lstat; retry */
 			goto stat_ref;
 		else
-			return -1;
+			goto out;
 	}
-	strbuf_reset(sb_contents);
-	if (strbuf_read(sb_contents, fd, 256) < 0) {
+	strbuf_reset(&sb_contents);
+	if (strbuf_read(&sb_contents, fd, 256) < 0) {
 		int save_errno = errno;
 		close(fd);
 		errno = save_errno;
-		return -1;
+		goto out;
 	}
 	close(fd);
-	strbuf_rtrim(sb_contents);
-	buf = sb_contents->buf;
+	strbuf_rtrim(&sb_contents);
+	buf = sb_contents.buf;
 	if (starts_with(buf, "ref:")) {
 		buf += 4;
 		while (isspace(*buf))
@@ -1508,7 +1513,8 @@ stat_ref:
 		strbuf_reset(symref);
 		strbuf_addstr(symref, buf);
 		*flags |= REF_ISSYMREF;
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	/*
@@ -1519,10 +1525,17 @@ stat_ref:
 	    (buf[40] != '\0' && !isspace(buf[40]))) {
 		*flags |= REF_ISBROKEN;
 		errno = EINVAL;
-		return -1;
+		goto out;
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	save_errno = errno;
+	strbuf_release(&sb_path);
+	strbuf_release(&sb_contents);
+	errno = save_errno;
+	return ret;
 }
 
 /* This function needs to return a meaningful errno on failure */
@@ -1530,9 +1543,7 @@ static const char *resolve_ref_1(const char *refname,
 				 int resolve_flags,
 				 unsigned char *sha1,
 				 int *flags,
-				 struct strbuf *sb_refname,
-				 struct strbuf *sb_path,
-				 struct strbuf *sb_contents)
+				 struct strbuf *sb_refname)
 {
 	int symref_count;
 
@@ -1559,8 +1570,7 @@ static const char *resolve_ref_1(const char *refname,
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
 		int read_flags = 0;
 
-		if (read_raw_ref(refname, sha1, sb_refname,
-				 sb_path, sb_contents, &read_flags)) {
+		if (read_raw_ref(refname, sha1, sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
@@ -1604,8 +1614,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
-	struct strbuf sb_contents = STRBUF_INIT;
-	struct strbuf sb_path = STRBUF_INIT;
 	int unused_flags;
 	const char *ret;
 
@@ -1613,9 +1621,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 		flags = &unused_flags;
 
 	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname, &sb_path, &sb_contents);
-	strbuf_release(&sb_path);
-	strbuf_release(&sb_contents);
+			    &sb_refname);
 	return ret;
 }
 
-- 
2.4.2.767.g62658d5-twtrsrc
