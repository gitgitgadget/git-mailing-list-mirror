From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Don't smash stack when $GIT_ALTERNATE_OBJECT_DIRECTORIES is too long
Date: Tue, 03 Jul 2007 12:40:20 +0200
Message-ID: <87k5thdb3f.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 13:46:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5gq4-0003eh-4u
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 13:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbXGCLqN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 07:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbXGCLqM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 07:46:12 -0400
Received: from server1.f7.net ([64.34.169.74]:50529 "EHLO f7.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756013AbXGCLqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 07:46:10 -0400
X-Greylist: delayed 3948 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2007 07:46:10 EDT
X-Envelope-From: jim@meyering.net
Received: from mx.meyering.net (server1.f7.net [64.34.169.74])
	by f7.net (8.11.7-20030920/8.11.7) with ESMTP id l63AeLP15829
	for <git@vger.kernel.org>; Tue, 3 Jul 2007 05:40:21 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id CD5B928757; Tue,  3 Jul 2007 12:40:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51478>

There is no restriction on the length of the name returned by
get_object_directory, other than the fact that it must be a stat'able
git object directory.  That means its name may have length up to
PATH_MAX-1 (i.e., often 4095) not counting the trailing NUL.

Combine that with the assumption that the concatenation of that name and
suffixes like "/info/alternates" and "/pack/---long-name---.idx" will fit
in a buffer of length PATH_MAX, and you see the problem.  Here's a fix:

    sha1_file.c (prepare_packed_git_one): Lengthen "path" buffer
    so we are guaranteed to be able to append "/pack/" without checking.
    Skip any directory entry that is too long to be appended.
    (read_info_alternates): Protect against a similar buffer overrun.

Before this change, using the following admittedly contrived environment
setting would cause many git commands to clobber their stack and segfault
on a system with PATH_MAX == 4096:

  t=$(perl -e '$s=".git/objects";$n=(4096-6-length($s))/2;print "./"x$n . $s')
  export GIT_ALTERNATE_OBJECT_DIRECTORIES=$t
  touch g
  ./git-update-index --add g

If you run the above commands, you'll soon notice that many
git commands now segfault, so you'll want to do this:

  unset GIT_ALTERNATE_OBJECT_DIRECTORIES

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 sha1_file.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f2b1ae0..1efd9ae 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -352,10 +352,14 @@ static void read_info_alternates(const char * relative_base, int depth)
 	char *map;
 	size_t mapsz;
 	struct stat st;
-	char path[PATH_MAX];
+	const char alt_file_name[] = "info/alternates";
+	/* Given that relative_base is no longer than PATH_MAX,
+	   ensure that "path" has enough space to append "/", the
+	   file name, "info/alternates", and a trailing NUL.  */
+	char path[PATH_MAX + 1 + sizeof alt_file_name];
 	int fd;

-	sprintf(path, "%s/info/alternates", relative_base);
+	sprintf(path, "%s/%s", relative_base, alt_file_name);
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return;
@@ -836,7 +840,10 @@ void install_packed_git(struct packed_git *pack)

 static void prepare_packed_git_one(char *objdir, int local)
 {
-	char path[PATH_MAX];
+	/* Ensure that this buffer is large enough so that we can
+	   append "/pack/" without clobbering the stack even if
+	   strlen(objdir) were PATH_MAX.  */
+	char path[PATH_MAX + 1 + 4 + 1 + 1];
 	int len;
 	DIR *dir;
 	struct dirent *de;
@@ -858,6 +865,9 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (!has_extension(de->d_name, ".idx"))
 			continue;

+		if (len + namelen + 1 > sizeof(path))
+			continue;
+
 		/* Don't reopen a pack we already have. */
 		strcpy(path + len, de->d_name);
 		for (p = packed_git; p; p = p->next) {
--
1.5.2.2.646.g71e55-dirty
