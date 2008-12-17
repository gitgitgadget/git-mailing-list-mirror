From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/5] Make 'prepare_temp_file()' ignore st_size for symlinks
Date: Wed, 17 Dec 2008 10:45:50 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171044110.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain> <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 19:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD1Qs-0005bM-Tf
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 19:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbYLQSqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 13:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbYLQSqY
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 13:46:24 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55306 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751487AbYLQSqX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 13:46:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIjpcr031601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 10:45:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIjoZ3011298;
	Wed, 17 Dec 2008 10:45:50 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103370>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Dec 2008 10:31:36 -0800

The code was already set up to not really need it, so this just massages
it a bit to remove the use entirely.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

There's a few raw 'readlink()' calls left, but they all seem to just have 
a big buffer and rely on the return value of readlink() rather than look 
too closely at st_size. But it would probably be good if somebody 
double-checked it all. 

Even so, this should all be better than what we used to have, though.

 diff.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 4b2029c..f160c1a 100644
--- a/diff.c
+++ b/diff.c
@@ -1881,13 +1881,12 @@ static void prepare_temp_file(const char *name,
 		if (S_ISLNK(st.st_mode)) {
 			int ret;
 			char buf[PATH_MAX + 1]; /* ought to be SYMLINK_MAX */
-			size_t sz = xsize_t(st.st_size);
-			if (sizeof(buf) <= st.st_size)
-				die("symlink too long: %s", name);
-			ret = readlink(name, buf, sz);
+			ret = readlink(name, buf, sizeof(buf));
 			if (ret < 0)
 				die("readlink(%s)", name);
-			prep_temp_blob(temp, buf, sz,
+			if (ret == sizeof(buf))
+				die("symlink too long: %s", name);
+			prep_temp_blob(temp, buf, ret,
 				       (one->sha1_valid ?
 					one->sha1 : null_sha1),
 				       (one->sha1_valid ?
-- 
1.6.1.rc3.3.gcc3e3
