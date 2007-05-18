From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-archive: convert archive entries like checkouts do
Date: Sat, 19 May 2007 00:09:41 +0200
Message-ID: <464E2425.2030904@lsrfire.ath.cx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <200705171928.34927.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 00:09:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAe5-000169-14
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbXERWJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbXERWJv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:09:51 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:51449
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754953AbXERWJv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 18:09:51 -0400
Received: from [10.0.1.201] (p508E74AF.dip.t-dialin.net [80.142.116.175])
	by neapel230.server4you.de (Postfix) with ESMTP id B080D39000;
	Sat, 19 May 2007 00:09:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <200705171928.34927.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47666>

As noted by Johan Herland, git-archive is a kind of checkout and needs
to apply any checkout filters that might be configured.

This patch adds the convenience function convert_sha1_file which returns
a buffer containing the object's contents, after converting, if necessary
(i.e. it's a combination of read_sha1_file and convert_to_working_tree).
Direct calls to read_sha1_file in git-archive are then replaced by calls
to convert_sha1_file.

Since convert_sha1_file expects its path argument to be NUL-terminated --
a convention it inherits from convert_to_working_tree -- the patch also
changes the path handling in archive-tar.c to always NUL-terminate the
string.  It used to solely rely on the len field of struct strbuf before.

archive-zip.c already NUL-terminates the path and thus needs no such
change.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---
 archive-tar.c |   12 +++++++-----
 archive-zip.c |    2 +-
 cache.h       |    1 +
 convert.c     |   15 +++++++++++++++
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 56ff356..eb0abc7 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -83,11 +83,12 @@ static void strbuf_append_string(struct strbuf *sb, const char *s)
 	int slen = strlen(s);
 	int total = sb->len + slen;
 	if (total > sb->alloc) {
-		sb->buf = xrealloc(sb->buf, total);
-		sb->alloc = total;
+		sb->buf = xrealloc(sb->buf, total + 1);
+		sb->alloc = total + 1;
 	}
 	memcpy(sb->buf + sb->len, s, slen);
 	sb->len = total;
+	sb->buf[total] = '\0';
 }
 
 /*
@@ -272,18 +273,19 @@ static int write_tar_entry(const unsigned char *sha1,
 	}
 	if (path.alloc < baselen + filenamelen) {
 		free(path.buf);
-		path.buf = xmalloc(baselen + filenamelen);
-		path.alloc = baselen + filenamelen;
+		path.buf = xmalloc(baselen + filenamelen + 1);
+		path.alloc = baselen + filenamelen + 1;
 	}
 	memcpy(path.buf, base, baselen);
 	memcpy(path.buf + baselen, filename, filenamelen);
 	path.len = baselen + filenamelen;
+	path.buf[path.len] = '\0';
 	if (S_ISDIR(mode) || S_ISDIRLNK(mode)) {
 		strbuf_append_string(&path, "/");
 		buffer = NULL;
 		size = 0;
 	} else {
-		buffer = read_sha1_file(sha1, &type, &size);
+		buffer = convert_sha1_file(path.buf, sha1, mode, &type, &size);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 	}
diff --git a/archive-zip.c b/archive-zip.c
index 1eaf262..3cbf6bb 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -195,7 +195,7 @@ static int write_zip_entry(const unsigned char *sha1,
 		if (S_ISREG(mode) && zlib_compression_level != 0)
 			method = 8;
 		result = 0;
-		buffer = read_sha1_file(sha1, &type, &size);
+		buffer = convert_sha1_file(path, sha1, mode, &type, &size);
 		if (!buffer)
 			die("cannot read %s", sha1_to_hex(sha1));
 		crc = crc32(crc, buffer, size);
diff --git a/cache.h b/cache.h
index aaeb04a..4204bc1 100644
--- a/cache.h
+++ b/cache.h
@@ -548,6 +548,7 @@ extern void trace_argv_printf(const char **argv, int count, const char *format,
 /* convert.c */
 extern char *convert_to_git(const char *path, const char *src, unsigned long *sizep);
 extern char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep);
+extern void *convert_sha1_file(const char *path, const unsigned char *sha1, unsigned int mode, enum object_type *type, unsigned long *size);
 
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
diff --git a/convert.c b/convert.c
index 12abdaf..c64880b 100644
--- a/convert.c
+++ b/convert.c
@@ -652,3 +652,18 @@ char *convert_to_working_tree(const char *path, const char *src, unsigned long *
 
 	return buf;
 }
+
+void *convert_sha1_file(const char *path, const unsigned char *sha1,
+                        unsigned int mode, enum object_type *type,
+                        unsigned long *size)
+{
+	void *buffer = read_sha1_file(sha1, type, size);
+	if (S_ISREG(mode) && buffer) {
+		void *converted = convert_to_working_tree(path, buffer, size);
+		if (converted) {
+			free(buffer);
+			buffer = converted;
+		}
+	}
+	return buffer;
+}
