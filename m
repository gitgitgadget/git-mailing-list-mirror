From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: [PATCH] clone: Warn if LICENSE or COPYING file lacking and
 !clone.skiplicensecheck
Date: Sat, 21 Mar 2015 20:16:40 -0400 (EDT)
Message-ID: <E1YZTZI-0002QE-3r@rmm6prod02.runbox.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: "git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 01:17:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZTZZ-0005PW-RN
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 01:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbbCVAQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 20:16:42 -0400
Received: from aibo.runbox.com ([91.220.196.211]:35627 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbbCVAQm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2015 20:16:42 -0400
Received: from [10.9.9.241] (helo=rmm6prod02.runbox.com)
	by bars.runbox.com with esmtp (Exim 4.71)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1YZTZH-0000pJ-U1
	for git@vger.kernel.org; Sun, 22 Mar 2015 01:16:39 +0100
Received: from mail by rmm6prod02.runbox.com with local (Exim 4.76)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1YZTZI-0002QE-3r
	for git@vger.kernel.org; Sun, 22 Mar 2015 01:16:40 +0100
Content-Disposition: inline
Received: from [Authenticated user (258406)] by secure.runbox.com with
 http (RMM6); for <git@vger.kernel.org>; Sun, 22 Mar 2015 00:16:40 GMT
X-Mailer: RMM6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266039>

Warn cloners if there is no LICENSE* or COPYING* file that makes
the license clear.  This is a useful warning, because if there is
no license somewhere, then local copyright laws (which forbid many uses)
and terms of service apply - and the cloner may not be expecting that.
Many projects accidentally omit a license, so this is common enough to note.

You can disable this warning by setting "clone.skiplicensecheck" to "true".

For more info on the issue, feel free to see:
http://choosealicense.com/no-license/
http://www.wired.com/2013/07/github-licenses/
https://twitter.com/stephenrwalli/status/247597785069789184

Signed-off-by: David A. Wheeler <dwheeler@dwheeler.com>
---
 builtin/clone.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9572467..a3e8584 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,6 +50,7 @@ static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
+static int skip_license_check;
 
 static int opt_parse_reference(const struct option *opt, const char *arg, int unset)
 {
@@ -748,6 +749,44 @@ static void dissociate_from_references(void)
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
+static int missing_license(void)
+{
+	DIR *dir = opendir("."); /* Examine current directory for license. */
+	struct dirent *e;
+	struct stat st;
+	int ret = 0;
+
+	if (!dir)
+		return 0; /* Empty directory, no need for license. */
+
+	while ((e = readdir(dir)) != NULL) {
+		if (starts_with_ignore_case(e->d_name, "license") ||
+		    starts_with_ignore_case(e->d_name, "copyright")) {
+			if (stat(e->d_name, &st) || st.st_size < 2)
+				continue;
+			ret = 0;
+			break;
+		}
+		if (!strcmp(e->d_name, ".") || !strcmp(e->d_name, "..") ||
+		    !strcmp(e->d_name, ".git"))
+			continue;
+		ret = 1; /* Non-empty directory */
+	}
+
+	closedir(dir);
+	return ret;
+}
+
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -1016,6 +1055,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout();
 
+	git_config_get_bool("clone.skiplicensecheck", &skip_license_check);
+	if (!option_no_checkout && !skip_license_check &&
+	    missing_license())
+		warning(_("Repository has no LICENSE or COPYING file with content."));
+
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-- 
2.3.3.221.g33aa87e.dirty
