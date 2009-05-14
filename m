From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/3] dir.c: clean up handling of 'path' parameter in
 read_directory_recursive()
Date: Thu, 14 May 2009 13:42:47 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:44:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4hmT-0005Kf-QS
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 22:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbZENUnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbZENUnp
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 16:43:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48342 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877AbZENUno (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 16:43:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EKgmsv030652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 May 2009 13:42:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4EKglYo028020;
	Thu, 14 May 2009 13:42:47 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.962 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119222>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 May 2009 13:05:03 -0700

Right now we pass two different pathnames ('path' and 'base') down to
read_directory_recursive(), and the only real reason for that is that we
want to allow an empty 'base' parameter, but when we do so, we need the
pathname to "opendir()" to be "." rather than the empty string.

And rather than handle that confusion in the caller, we can just fix
read_directory_recursive() to handle the case of an empty path itself,
by just passing opendir() a "." ourselves if the path is empty.

This would allow us to then drop one of the pathnames entirely from the
calling convention, but rather than do that, we'll start separating them
out as a "filesystem pathname" (the one we use for filesystem accesses)
and a "git internal base name" (which is the name that we use for git
internally).

That will eventually allow us to do things like handle different
encodings (eg the filesystem pathnames might be Latin1, while git itself
would use UTF-8 for filename information).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is a truly trivial diff, but it's independent from the other changes 
I have, and simplifies the next ones, so I've made it a patch of its own.

 dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 6aae09a..0e6b752 100644
--- a/dir.c
+++ b/dir.c
@@ -576,7 +576,7 @@ static int get_dtype(struct dirent *de, const char *path)
  */
 static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen, int check_only, const struct path_simplify *simplify)
 {
-	DIR *fdir = opendir(path);
+	DIR *fdir = opendir(*path ? path : ".");
 	int contents = 0;
 
 	if (fdir) {
-- 
1.6.3.1.11.g97114
