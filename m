From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] commit: make the error message on unmerged entries user-friendly.
Date: Wed,  6 Jan 2010 14:10:14 +0100
Message-ID: <1262783414-23101-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 14:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSVei-0002tU-0q
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 14:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187Ab0AFNKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 08:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183Ab0AFNKX
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 08:10:23 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38830 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932182Ab0AFNKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 08:10:22 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o06DAGEm031834
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jan 2010 14:10:16 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NSVeS-0002Ie-7I; Wed, 06 Jan 2010 14:10:16 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NSVeS-0003if-4F; Wed, 06 Jan 2010 14:10:16 +0100
X-Mailer: git-send-email 1.6.6.76.gd6b23.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Jan 2010 14:10:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o06DAGEm031834
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1263388216.91689@Zcoe0ILne9ZU0qrcLCZgWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136266>

The error message used to look like this:

$ git commit
foo.txt: needs merge
foo.txt: unmerged (c34a92682e0394bc0d6f4d4a67a8e2d32395c169)
foo.txt: unmerged (3afcd75de8de0bb5076942fcb17446be50451030)
foo.txt: unmerged (c9785d77b76dfe4fb038bf927ee518f6ae45ede4)
error: Error building trees

The "need merge" line is given by refresh_cache. We add the IN_PORCELAIN
option to make the output more consistant with the other porcelain
commands, and catch the error in return, to stop with a clean error
message. The next lines were displayed by a call to cache_tree_update(),
which is not reached anymore if we noticed the conflict.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
As usual, I try to have error messages point to the solution, not just
the origin of the problem.

Two questions:

* Did anyone actually use the 3 "file: unmerged (sha1)" lines?

* Do you like my new message?

Thanks,

 builtin-commit.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 3dfcd77..d491a01 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -235,6 +235,18 @@ static void create_base_index(void)
 		exit(128); /* We've already reported the error, finish dying */
 }
 
+static void refresh_cache_or_die(int refresh_flags)
+{
+	/*
+	 * refresh_flags contains REFRESH_QUIET, so the only errors
+	 * are for unmerged entries.
+	*/
+	if(refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN))
+		die("Commit is not possible because you have unmerged files.\n"
+		    "Please, resolve the conflicts listed above, and then mark them\n"
+		    "as resolved with 'git add <filename>', or use 'git commit -a'.");
+}
+
 static char *prepare_index(int argc, const char **argv, const char *prefix, int is_status)
 {
 	int fd;
@@ -274,7 +286,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	if (all || (also && pathspec && *pathspec)) {
 		int fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
-		refresh_cache(refresh_flags);
+		refresh_cache_or_die(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
 			die("unable to write new_index file");
@@ -293,7 +305,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 */
 	if (!pathspec || !*pathspec) {
 		fd = hold_locked_index(&index_lock, 1);
-		refresh_cache(refresh_flags);
+		refresh_cache_or_die(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(&index_lock))
 			die("unable to write new_index file");
-- 
1.6.6.76.gd6b23.dirty
