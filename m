From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v5 2/3] path: add a find_basename() portability function
Date: Fri, 29 May 2009 19:18:09 -0700
Message-ID: <1243649890-4522-2-git-send-email-davvid@gmail.com>
References: <1243649890-4522-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 04:20:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAEBF-0005Vv-VW
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 04:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbZE3CSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 22:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbZE3CST
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 22:18:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:57308 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZE3CSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 22:18:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1967900rvb.1
        for <git@vger.kernel.org>; Fri, 29 May 2009 19:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=eW8/lZjHYEcTqm9zrP85jCJhJIwvrV162Wb1iw8T6Us=;
        b=Toj73groBWUxeq7O1hJfmSRlRjQDFJTQYb4c57VL8ycnHI8+ZIwravIpk91z44FQcF
         VjNo7H24ointZ/PTmZd3wZSalGLwl//gi8VHq8pcyd5YcQpE7h011OcTRfiBmrp/3M9T
         ZchuuNyHjbaiiT5EYVgDRM7rH3VoG+/LhXxS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NfFRkmvV3EcHksS4rseKc8130bNBfItlvpF5MM3Hi3CXOZwEG7B9+Ert556acNTDMA
         d8enHO1IoM42O4DMmZLec+R4ff0tLhrYerfgrSj/vD+AmaPL7MUUUAHko4OcQiePPMNV
         A5/6lU2v+xeNgKnsggr48oheb+Rt8yE3Ncu/s=
Received: by 10.140.247.11 with SMTP id u11mr1883777rvh.247.1243649899620;
        Fri, 29 May 2009 19:18:19 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m31sm3105176wag.31.2009.05.29.19.18.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 19:18:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.178.g4daa97
In-Reply-To: <1243649890-4522-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120335>

find_basename() is a simpler version of basename().
It maintains constness and thus does not require you
to pass in a copy.  It is only concerned with finding
the last directory separator in a string and returning
a pointer.

This function was written because Windows does not
have basename().  It is called "find_basename()"
to avoid name collisions and to provide a hint that
it is not quite the same thing as POSIX basename().

Signed-off-by: David Aguilar <davvid@gmail.com>
---

As suggested by Peff.

 cache.h |    1 +
 path.c  |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index b8503ad..08b6f42 100644
--- a/cache.h
+++ b/cache.h
@@ -640,6 +640,7 @@ static inline int is_absolute_path(const char *path)
 	return path[0] == '/' || has_dos_drive_prefix(path);
 }
 int is_directory(const char *);
+const char *find_basename(const char *path);
 const char *make_absolute_path(const char *path);
 const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
diff --git a/path.c b/path.c
index 8a0a674..7a2fe14 100644
--- a/path.c
+++ b/path.c
@@ -358,6 +358,20 @@ int set_shared_perm(const char *path, int mode)
 	return 0;
 }
 
+/* return the basename of a path */
+const char *find_basename(const char *path)
+{
+	const char *basename = path + strlen(path) - 1;
+	while(*basename && basename > path) {
+		basename--;
+		if (is_dir_sep(*basename)) {
+			basename++;
+			break;
+		}
+	}
+	return basename;
+}
+
 const char *make_relative_path(const char *abs, const char *base)
 {
 	static char buf[PATH_MAX + 1];
-- 
1.6.3.1.178.g4daa97
