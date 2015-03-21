From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Sat, 21 Mar 2015 14:06:33 -0400 (EDT)
Message-ID: <E1YZNn7-0002Lc-7O@rmm6prod02.runbox.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: "git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 21 19:27:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZO71-00065B-DU
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 19:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbCUS1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 14:27:03 -0400
Received: from aibo.runbox.com ([91.220.196.211]:47641 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbbCUS1B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2015 14:27:01 -0400
X-Greylist: delayed 1226 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Mar 2015 14:27:01 EDT
Received: from [10.9.9.241] (helo=rmm6prod02.runbox.com)
	by bars.runbox.com with esmtp (Exim 4.71)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1YZNn7-0006JK-1W
	for git@vger.kernel.org; Sat, 21 Mar 2015 19:06:33 +0100
Received: from mail by rmm6prod02.runbox.com with local (Exim 4.76)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1YZNn7-0002Lc-7O
	for git@vger.kernel.org; Sat, 21 Mar 2015 19:06:33 +0100
Content-Disposition: inline
Received: from [Authenticated user (258406)] by secure.runbox.com with
 http (RMM6); for <git@vger.kernel.org>; Sat, 21 Mar 2015 18:06:33 GMT
X-Mailer: RMM6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266031>

Warn cloners if there is no LICENSE* or COPYING* file that makes
the license clear.  This is a useful warning, because if there is
no license somewhere, then local copyright laws (which forbid many uses)
and terms of service apply - and the cloner may not be expecting that.
Many projects accidentally omit a license, so this is common enough to note.
For more info on the issue, feel free to see:
http://choosealicense.com/no-license/
http://www.wired.com/2013/07/github-licenses/
https://twitter.com/stephenrwalli/status/247597785069789184

Signed-off-by: David A. Wheeler <dwheeler@dwheeler.com>
---
 builtin/clone.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9572467..9863b04 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -748,6 +748,41 @@ static void dissociate_from_references(void)
 		die_errno(_("cannot unlink temporary alternates file"));
 }
 
+static int starts_with_ignore_case(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 1;
+		else if (tolower(*str) != tolower(*prefix))
+			return 0;
+}
+
+static int contains_license(void)
+{
+	DIR *dir = opendir("."); /* Examine current directory for license. */
+	struct dirent *e;
+	struct stat st;
+	int ret = 0;
+
+	if (!dir)
+		return 0;
+
+	while ((e = readdir(dir)) != NULL)
+		if (starts_with_ignore_case(e->d_name, "license") ||
+		    starts_with_ignore_case(e->d_name, "copyright")) {
+			if (stat(e->d_name, &st))
+				continue;
+			if (st.st_size > 1) {
+				ret = 1;
+				break;
+			}
+		}
+
+	closedir(dir);
+	return ret;
+}
+
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -1016,6 +1051,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout();
 
+	if (!option_no_checkout && !contains_license())
+		warning(_("Repository has no LICENSE or COPYING file with content."));
+
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-- 
2.1.4
