From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] clone: fix creation of explicitly named target directory
Date: Wed, 3 Sep 2008 20:55:55 +0200
Message-ID: <20080903185554.GA6738@localhost>
References: <20080902081909.GA2059@localhost> <7vk5dul7f5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaxWi-0000M4-JP
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 20:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbYICSzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 14:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbYICSzR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 14:55:17 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:54186 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbYICSzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 14:55:16 -0400
Received: from darc.dyndns.org ([84.154.106.129]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Sep 2008 20:55:13 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KaxWF-0001Th-43; Wed, 03 Sep 2008 20:55:55 +0200
Content-Disposition: inline
In-Reply-To: <7vk5dul7f5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 03 Sep 2008 18:55:14.0096 (UTC) FILETIME=[993F7B00:01C90DF6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94836>

'git clone <repo> path/' (note the trailing slash) fails, because the
entire path is interpreted as leading directories. So when mkdir tries to
create the actual path, it already exists.

This makes sure trailing slashes are removed.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Tue, Sep 02, 2008 at 11:38:38AM -0700, Junio C Hamano wrote:
> As a "bugfix" patch meant to apply to 'maint', I'd prefer a fix to the
> caller (builtin-clone.c that calls the function), which should be of much
> less impact.  It is fine to include the change to add strerror(errno) in
> that patch, whose title would be "clone: fix creation of explicitly named
> target directory".

 builtin-clone.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index f44ecea..bbfa7d1 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -147,6 +147,17 @@ static int is_directory(const char *path)
 	return !stat(path, &buf) && S_ISDIR(buf.st_mode);
 }
 
+static char *strip_dir_sep(char *dir)
+{
+	char *end = dir + strlen(dir);
+
+	while (dir < end && is_dir_sep(end[-1]))
+		end--;
+	*end = '\0';
+
+	return dir;
+}
+
 static void setup_reference(const char *repo)
 {
 	const char *ref_git;
@@ -394,7 +405,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		repo = repo_name;
 
 	if (argc == 2)
-		dir = xstrdup(argv[1]);
+		dir = strip_dir_sep(xstrdup(argv[1]));
 	else
 		dir = guess_dir_name(repo_name, is_bundle, option_bare);
 
@@ -422,10 +433,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_bare) {
 		junk_work_tree = work_tree;
 		if (safe_create_leading_directories_const(work_tree) < 0)
-			die("could not create leading directories of '%s'",
-					work_tree);
+			die("could not create leading directories of '%s': %s",
+					work_tree, strerror(errno));
 		if (mkdir(work_tree, 0755))
-			die("could not create work tree dir '%s'.", work_tree);
+			die("could not create work tree dir '%s': %s.",
+					work_tree, strerror(errno));
 		set_git_work_tree(work_tree);
 	}
 	junk_git_dir = git_dir;
-- 
1.6.0
