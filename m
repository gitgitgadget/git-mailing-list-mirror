From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] Make it possible to run git archive --remote without a git directory.
Date: Thu, 5 Apr 2007 10:12:37 +0200
Message-ID: <200704051012.37361.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 10:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZN57-0002E4-UW
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 10:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946089AbXDEIMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 04:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946091AbXDEIMa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 04:12:30 -0400
Received: from verein.lst.de ([213.95.11.210]:50785 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946090AbXDEIM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 04:12:28 -0400
Received: from luria.local (157.80-203-65.nextgentel.com [80.203.65.157])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l358CZLD002860
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 5 Apr 2007 10:12:35 +0200
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-Spam-Score: -0.001 () BAYES_44
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43807>


Try a gentle git directory setup for the archive command that remains fatal 
for the local case but permits operation without a local git repository when 
using --remote. If in the remote case a git directory is present it will then 
still be used for proxy settings, but that is optional now.

Signed-off-by: Simon Hausmann <simon@lst.de>
---
 builtin-archive.c |    6 ++++++
 git.c             |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 2fae885..434fec7 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -243,11 +243,17 @@ int cmd_archive(int argc, const char **argv, const char 
*prefix)
 	struct archiver ar;
 	int tree_idx;
 	const char *remote = NULL;
+	int nongit = 0;
+
+	prefix = setup_git_directory_gently(&nongit);
 
 	remote = extract_remote_arg(&argc, argv);
 	if (remote)
 		return run_remote_archiver(remote, argc, argv);
 
+	if (nongit)
+		die("Not a git repository");
+
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
 	memset(&ar, 0, sizeof(ar));
diff --git a/git.c b/git.c
index 5b1bc2a..33dd4d3 100644
--- a/git.c
+++ b/git.c
@@ -226,7 +226,7 @@ static void handle_internal_command(int argc, const char 
**argv, char **envp)
 		{ "add", cmd_add, RUN_SETUP | NOT_BARE },
 		{ "annotate", cmd_annotate, USE_PAGER },
 		{ "apply", cmd_apply },
-		{ "archive", cmd_archive, RUN_SETUP },
+		{ "archive", cmd_archive },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
-- 
1.5.1
