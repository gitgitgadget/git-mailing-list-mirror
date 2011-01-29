From: "Tim Abell" <tim@timwise.co.uk>
Subject: [PATCH] Handle rename of case only, for Windows
Date: Sat, 29 Jan 2011 23:45:17 +0000
Message-ID: <1296344717.25999.1417928123@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"msysGit" <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 30 00:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjKTt-0000JL-1e
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 00:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab1A2XpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 18:45:19 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36465 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751878Ab1A2XpS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 18:45:18 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0E7BB20322;
	Sat, 29 Jan 2011 18:45:18 -0500 (EST)
Received: from web2.messagingengine.com ([10.202.2.212])
  by compute3.internal (MEProxy); Sat, 29 Jan 2011 18:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:subject:date; s=smtpout; bh=Pu/JWAOVShUgzN3pPtWqeuiqQoo=; b=GdAdld/qR9AF0GBQQ8GUN9lH/m9cPX1rE4++YbL+7HK/RarDNI24BnuHfFpjVOLO2zlkkwwgVGBBge1UMKPVxcroCeIV7Sa/8ozDgw0tpRDbFisQ8cfxRk5ADqbAKYdUE8KO4BUY+RHHtlXqvQ2JONAavQMtlLrRcNVCdSPPGmA=
Received: by web2.messagingengine.com (Postfix, from userid 99)
	id DCA4DB3B5CC; Sat, 29 Jan 2011 18:45:17 -0500 (EST)
X-Sasl-Enc: LSrTMSjOl6TVBsjcteTyQ/enVcGzS9AwtEFFv1xvFUd2 1296344717
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165676>

>From ddab003ede9f25d93f4e7eea833523a0aa29d16d Mon Sep 17 00:00:00 2001
From: Tim Abell <tim@timwise.co.uk>
Date: Thu, 27 Jan 2011 22:53:31 +0000
Subject: [PATCH] Handle rename of case only, for Windows

Added test to show rename failing in windows.
Added test to show that this patch doesn't break protection against overwriting
an existing file, and another to show that "mv --force" still works.

Altered mv.c to check whether the source and destination file are actually
the same file based on inode number before failing.
If the inode is zero then the data is no use so old behaviour is maintained.

A message from Linus on the subject:
 http://kerneltrap.org/mailarchive/git/2008/3/21/1220814
 (apparently he never got the energy :-)

Signed-off-by: Tim Abell <tim@timwise.co.uk>
---

Hi folks, this is my second attempt at providing a useful patch for this issue.
Thanks for all the great feedback from my first attempt. I've attempted to address the problems raised.

Hopefully my commit message is more like what is needed this time.
I hadn't realised before that you can split the commit message from this bit with the "---".

>Hmm, not so good. st_ino is always 0 on Windows, so this would make
>false positives, no?

I tested this on windows 7 under cygwin (which is what I have available) and st_ino reports real numbers for me, I also tested that attempting to overwrite another file without --force still fails and added a new test case for this scenario. I have now made sure that if zero is returned then git won't accidentally overwrite other files as I hadn't thought of this before. So this patch shouldn't be regressive even if other versions of windows or other filesystems don't provide valid inode data.

Adding the following line after "lstat(src, &src_st);" shows the inode numbers when calling git mv:
 printf("src inode: %lu, dst inode: %lu", (unsigned long) src_st.st_ino, (unsigned long) st.st_ino);
And here is my ouput showing it in action:

$ git mv foo.txt bar.txt
  fatal: destination exists, source=foo.txt, destination=bar.txt
  src inode: 67064, dst inode: 229369
$ git mv foo.txt Foo.txt
  src inode: 67064, dst inode: 67064

>I wonder if we can make lstat_case() that would only return 0 if it
>matches exactly the filename, even on FAT. FindFirstFile/FindNextFile
>should return true file name, I think. If not, we can make
>lstat_case() take two paths (src and dst) and move all inode
>comparison code in there. Much cleaner.

I'm afraid this is a bit beyond me at the moment, but I'm fairly happy with the solution I have. Thanks for the feedback though.

>Couldn't this be moved inside the scope around "cache_name_pos"?
>That's the only scope it is valid inside anyway...

Done. I wasn't sure about this initially as I'm not very experienced with C programming. Thanks for the pointer.

>Perhaps you could use the full URL (and maybe put it in the commit
>message insted)? It'd be nice if we could reach this information even
>if is.gd disappears...

Good point. I've put the full url in the commit message instead.

>Uhm, is this debug-leftovers? #warning is a preprocessor-construct,
>and it can't understand varaibles in c. Especially not formatted as
>strings. Can #warning even do varags? :P

Yes, it was a debug line. Doh! Complete chance that it compiled, I've been doing too much bash scripting recently it seems. I've stripped it out. A better version is available above should anyone want to see the inode numbers.

Thanks all, I welcome any more feedback.

Does this now look like something that anyone on the git project would like to pick up as a contribution?

Yours

Tim Abell


 builtin/mv.c  |   32 +++++++++++++++++++++-----------
 t/t7001-mv.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index cdbb094..c2f726a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -165,17 +165,27 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		} else if (cache_name_pos(src, length) < 0)
 			bad = "not under version control";
 		else if (lstat(dst, &st) == 0) {
-			bad = "destination exists";
-			if (force) {
-				/*
-				 * only files can overwrite each other:
-				 * check both source and destination
-				 */
-				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					warning("%s; will overwrite!", bad);
-					bad = NULL;
-				} else
-					bad = "Cannot overwrite";
+			/* If we are on a case insensitive file system (windows) and we are only
+			 * changing the case of the file then lstat for the destination will
+			 * return != 0 because it sees the source file.
+			 * To prevent this causing failure, lstat is used to get the inode of the src
+			 * and see if it's actually the same file as dst. If the inode == 0 then
+			 * we can't tell whether it is the same file so we fail regardless. */
+			struct stat src_st;
+			lstat(src, &src_st);
+			if (src_st.st_ino == 0 || src_st.st_ino != st.st_ino) {
+				bad = "destination exists";
+				if (force) {
+					/*
+					 * only files can overwrite each other:
+					 * check both source and destination
+					 */
+					if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
+						warning("%s; will overwrite!", bad);
+						bad = NULL;
+					} else
+						bad = "Cannot overwrite";
+				}
 			}
 		} else if (string_list_has_string(&src_for_dst, dst))
 			bad = "multiple sources for the same target";
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 65a35d9..abaecb6 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -255,4 +255,39 @@ test_expect_success SYMLINKS 'git mv should overwrite file with a symlink' '
 
 rm -f moved symlink
 
+test_expect_success 'git mv should not fail when only changing case' '
+
+	rm -fr .git &&
+	git init &&
+	>foo.txt &&
+	git add foo.txt &&
+	git mv foo.txt Foo.txt
+'
+
+rm *.txt
+
+test_expect_success 'git mv should not overwrite existing file' '
+
+	rm -fr .git &&
+	git init &&
+	>foo.txt &&
+	>bar.txt &&
+	git add foo.txt &&
+	test_must_fail git mv foo.txt bar.txt
+'
+
+rm *.txt
+
+test_expect_success 'git mv -f should overwrite existing file' '
+
+	rm -fr .git &&
+	git init &&
+	>foo.txt &&
+	>bar.txt &&
+	git add foo.txt &&
+	git mv -f foo.txt bar.txt
+'
+
+rm *.txt
+
 test_done
-- 
1.7.3.5.3.g2b35a
