From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/5] Add generic 'strbuf_readlink()' helper function
Date: Wed, 17 Dec 2008 10:42:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 19:44:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD1O1-0004MY-VI
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 19:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbYLQSna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 13:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbYLQSn3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 13:43:29 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40827 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750910AbYLQSn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 13:43:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIgipL030317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 10:42:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIghWA008973;
	Wed, 17 Dec 2008 10:42:43 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103366>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Dec 2008 09:36:40 -0800

It was already what 'git apply' did in read_old_data(), just export it
as a real function, and make it be more generic.

In particular, this handles the case of the lstat() st_size data not
matching the readlink() return value properly (which apparently happens
at least on NTFS under Linux).  But as a result of this you could also
use the new function without even knowing how big the link is going to
be, and it will allocate an appropriately sized buffer.

So we pass in the st_size of the link as just a hint, rather than a
fixed requirement.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-apply.c |    6 ++----
 strbuf.c        |   28 ++++++++++++++++++++++++++++
 strbuf.h        |    1 +
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 4c4d1e1..07244b0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1559,10 +1559,8 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 {
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
-		strbuf_grow(buf, st->st_size);
-		if (readlink(path, buf->buf, st->st_size) != st->st_size)
-			return -1;
-		strbuf_setlen(buf, st->st_size);
+		if (strbuf_readlink(buf, path, st->st_size) < 0)
+			return error("unable to read symlink %s", path);
 		return 0;
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
diff --git a/strbuf.c b/strbuf.c
index 13be67e..904a2b0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -288,6 +288,34 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 	return sb->len - oldlen;
 }
 
+#define STRBUF_MAXLINK (2*PATH_MAX)
+
+int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
+{
+	if (hint < 32)
+		hint = 32;
+
+	while (hint < STRBUF_MAXLINK) {
+		int len;
+
+		strbuf_grow(sb, hint);
+		len = readlink(path, sb->buf, hint);
+		if (len < 0) {
+			if (errno != ERANGE)
+				break;
+		} else if (len < hint) {
+			strbuf_setlen(sb, len);
+			return 0;
+		}
+
+		/* .. the buffer was too small - try again */
+		hint *= 2;
+		continue;
+	}
+	strbuf_release(sb);
+	return -1;
+}
+
 int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 {
 	int ch;
diff --git a/strbuf.h b/strbuf.h
index b1670d9..89bd36e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -124,6 +124,7 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
+extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 extern int strbuf_getline(struct strbuf *, FILE *, int);
 
-- 
1.6.1.rc3.3.gcc3e3
