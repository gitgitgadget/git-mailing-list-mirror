From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/3] config.c: Fix a static buffer overwrite bug by avoiding
 mkpath()
Date: Sat, 19 Nov 2011 19:42:00 +0000
Message-ID: <4EC80688.609@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 21:03:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRr82-0000dE-Iv
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab1KSUDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:03:05 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:34231 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753234Ab1KSUDE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2011 15:03:04 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RRr7u-0006oR-dN; Sat, 19 Nov 2011 20:03:02 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185702>


On cygwin, test number 21 of t3200-branch.sh (git branch -m q q2
without config should succeed) fails. The failure involves the
functions from path.c which parcel out internal static buffers
from the git_path() and mkpath() functions.

In particular, the rename_ref() function calls safe_create_leading\
_directories() with a filename returned by git_path("logs/%s", ref).
safe_create_leading_directories(), in turn, calls stat() on each
element of the path it is given. On cygwin, this leads to a call
to git_config() for each component of the path, since this test
explicitly removes the config file. git_config() calls mkpath(), so
on the fourth component of the path, the original buffer passed
into the function is overwritten with the config filename.

Note that this bug is specific to cygwin and it's schizophrenic
stat() functions (see commits adbc0b6, 7faee6b and 7974843). The
lack of a config file and a path with at least four elements is
also important to trigger the bug.

In order to fix the problem, we replace the call to mkpath() with
a call to mksnpath() and provide our own buffer.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index edf9914..5a9ca84 100644
--- a/config.c
+++ b/config.c
@@ -851,6 +851,7 @@ int git_config_system(void)
 
 int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 {
+	char buf[4096];
 	int ret = 0, found = 0;
 	const char *home = NULL;
 
@@ -865,12 +866,11 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	home = getenv("HOME");
 	if (home) {
-		char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
+		char *user_config = mksnpath(buf, sizeof(buf), "%s/.gitconfig", home);
 		if (!access(user_config, R_OK)) {
 			ret += git_config_from_file(fn, user_config, data);
 			found += 1;
 		}
-		free(user_config);
 	}
 
 	if (repo_config && !access(repo_config, R_OK)) {
-- 
1.7.7
