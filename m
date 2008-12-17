From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/5] Make 'index_path()' use 'strbuf_readlink()'
Date: Wed, 17 Dec 2008 10:43:40 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 19:45:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD1Oq-0004hh-CW
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 19:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbYLQSoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 13:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbYLQSoS
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 13:44:18 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38412 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116AbYLQSoR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 13:44:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIheT4030711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 10:43:41 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIhefk009684;
	Wed, 17 Dec 2008 10:43:40 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103368>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Dec 2008 09:51:53 -0800

This makes us able to properly index symlinks even on filesystems where
st_size doesn't match the true size of the link.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 sha1_file.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0e021c5..52d1ead 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2523,8 +2523,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object)
 {
 	int fd;
-	char *target;
-	size_t len;
+	struct strbuf sb = STRBUF_INIT;
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
@@ -2537,20 +2536,17 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 				     path);
 		break;
 	case S_IFLNK:
-		len = xsize_t(st->st_size);
-		target = xmalloc(len + 1);
-		if (readlink(path, target, len + 1) != st->st_size) {
+		if (strbuf_readlink(&sb, path, st->st_size)) {
 			char *errstr = strerror(errno);
-			free(target);
 			return error("readlink(\"%s\"): %s", path,
 			             errstr);
 		}
 		if (!write_object)
-			hash_sha1_file(target, len, blob_type, sha1);
-		else if (write_sha1_file(target, len, blob_type, sha1))
+			hash_sha1_file(sb.buf, sb.len, blob_type, sha1);
+		else if (write_sha1_file(sb.buf, sb.len, blob_type, sha1))
 			return error("%s: failed to insert into database",
 				     path);
-		free(target);
+		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
 		return resolve_gitlink_ref(path, "HEAD", sha1);
-- 
1.6.1.rc3.3.gcc3e3
