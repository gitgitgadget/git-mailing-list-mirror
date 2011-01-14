From: "Tim Abell" <tim@timwise.co.uk>
Subject: [PATCH] handle rename of case only, for windows
Date: Fri, 14 Jan 2011 13:44:04 +0000
Message-ID: <1295012644.7883.1415296115@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 14 14:44:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdjwq-0003fz-6t
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 14:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468Ab1ANNoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 08:44:07 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47424 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757071Ab1ANNoE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 08:44:04 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 854C520E21
	for <git@vger.kernel.org>; Fri, 14 Jan 2011 08:44:04 -0500 (EST)
Received: from web3.messagingengine.com ([10.202.2.213])
  by compute3.internal (MEProxy); Fri, 14 Jan 2011 08:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:subject:date; s=smtpout; bh=pg0Q+MfNyqzCqNHKqhrwsZDmf+M=; b=OSeoieHvAGxhjMMuyUqYXhRjZxfYI3iz1sNr7ik54wX4GbPp9tIoQXYBbF0Gk/nP2HXQJNHVkwXBvpHnyjQQ8JV9isyehqZV1bFDbICL8HLEosAUGQv/V7Dle0mNSCH6XyTVnnKHU3J2fm3JgS6Jd7j8+qiqe03a6gXF4O+9URU=
Received: by web3.messagingengine.com (Postfix, from userid 99)
	id 5AC958E0341; Fri, 14 Jan 2011 08:44:04 -0500 (EST)
X-Sasl-Enc: tMfz7SIcFjxz1s12SQfV8BCrD7LTY4g67TcvnfLn+cmo 1295012644
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165099>

Hi folks,

I've never contributed to git before so be gentle :-)

Would someone have the time to help me get this patch into mailine git?

I tripped over a failure to rename files on windows when only the case
has changed. I've created a patch which fixes it for me and doesn't seem
to break on linux or windows. I also created a test to demonstrate the
issue (part of this patch). This test passes on linux and fails on
windows before my patch for mv.c is applied, and passes on both windows
and linux for me after my patch is applied.

The problem with changing the case of a file happens because git mv
checks if the destination filename exists before performing a
move/rename, and on windows lstat reports that the destination file
*does* already exist because it ignores case for this check and
semi-erroneously finds the source file.

The way I've attempted to fix it in my patch is by checking if the inode
of the source and destination are the same before deciding to fail with
a "destination exists" error.

When using "git mv" it is possible to work around the error by using
--force.

I've also seen a problem with windows users pulling from remotes where a
case only rename has been performed which is more problematic as you
have to tell every user how to handle the issue. I'm not sure if I've
managed to fix that case or not.

The fault exists in both the current cygwin git and the current msysgit,
so I figured it would be good to get a patch to upstream (you) so that
it could work everywhere. 

I found an email from Linus relating to this issue here:
http://marc.info/?l=git&m=120612172706823 so it's a known problem.

Thanks

Tim Abell

---
 builtin/mv.c  |   33 ++++++++++++++++++++++-----------
 t/t7001-mv.sh |    9 +++++++++
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 93e8995..6bb262e 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -63,6 +63,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	const char **source, **destination, **dest_path;
 	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
+	struct stat src_st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 
 	git_config(git_default_config, NULL);
@@ -165,17 +166,27 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
+			/* If we are on a case insensitive files= system (windows) http://is.gd/kyxgg
+			 * and we are only changing the case of the file then lstat for the
+			 * destination will return != 0 because it sees the source file.
+			 * To prevent this causing failure, lstat is used to get the inode of the src
+			 * and see if it's actually the same file.
+			 */
+			lstat(src, &src_st); //get file serial number (inode) for source
+			#warning("src inode: %s, dst inode: %s", src_st.st_ino, st.st_ino);
+			if (src_st.st_ino != st.st_ino) {
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
index a845b15..95146bf 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -255,4 +255,13 @@ test_expect_success SYMLINKS 'git mv should overwrite file with a symlink' '
 
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
 test_done
-- 
1.5.6.5
