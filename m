From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unable to index file
Date: Fri, 12 Dec 2008 10:15:58 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812121013560.3340@localhost.localdomain>
References: <f25d5ad20812120647m646698d7t9849c8ccb08c465e@mail.gmail.com> <alpine.LFD.2.00.0812120956050.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ramon Tayag <ramon.tayag@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBCaD-0007XF-Hw
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 19:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752AbYLLSQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 13:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbYLLSQc
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 13:16:32 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60948 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756249AbYLLSQb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2008 13:16:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBCIFx8R020485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Dec 2008 10:16:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBCIFwO4032206;
	Fri, 12 Dec 2008 10:15:58 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812120956050.3340@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.425 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102922>



On Fri, 12 Dec 2008, Linus Torvalds wrote:
> 
> Now, admittedly git is probably being really annoyingly anal about this 
> all, and we probably should loosen the restrictions on it a bit, but I'd 
> like to know why it happens. I cannot recall this having been reported 
> before, so it's some specific filesystem or OS that causes this, I think.

Anyway, the "loosen the symlink lstat() requirements" patch would likely 
look something like this. I can't really test it, though, since I only 
have filesystems that have matching lstat()/readlink() sizes.

		Linus
---
 sha1_file.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0e021c5..222c793 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2522,9 +2522,9 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 
 int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object)
 {
-	int fd;
+	int fd, len;
 	char *target;
-	size_t len;
+	size_t bufsize;
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
@@ -2537,9 +2537,10 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
 				     path);
 		break;
 	case S_IFLNK:
-		len = xsize_t(st->st_size);
-		target = xmalloc(len + 1);
-		if (readlink(path, target, len + 1) != st->st_size) {
+		bufsize = 1+xsize_t(st->st_size);
+		target = xmalloc(bufsize);
+		len = readlink(path, target, bufsize);
+		if (len < 0) {
 			char *errstr = strerror(errno);
 			free(target);
 			return error("readlink(\"%s\"): %s", path,
