From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 7/9] submodule: teach unpack_trees() to remove submodule
 contents
Date: Mon, 03 Feb 2014 20:52:49 +0100
Message-ID: <52EFF391.7040503@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:52:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPZg-0001z8-Fm
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbaBCTwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:52:53 -0500
Received: from mout.web.de ([212.227.15.4]:49673 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbaBCTwv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:52:51 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LtFUV-1V7YUM3tLH-012nWu for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:52:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:7fjik1w8CI898GcdqSm7zQ8NA0z/+Fm829ciax5Ojr2N4yImKBK
 pWs4rMimdY621fTtz9L8CVJIOSeG1Tp6RsUujqccw6ByOJ7GnIrJo/T/E3UDOoXSXDD36PM
 FANhA3BJdrQGkCJVmn8Yx/zNhqWMgMYAU3s2vTLbEqF6VzOuq4Ka+n4+yuawr3KyqTqFZTC
 1OQanu0a8zHNYooOWMPPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241463>

Implement the functionality needed to enable work tree manipulating
commands to that a deleted submodule should not only affect the index
(leaving all the files of the submodule in the work tree) but also to
remove the work tree of the superproject (including any untracked
files).

That will only work properly when the submodule uses a gitfile instead of
a .git directory and no untracked files are present. Otherwise the removal
will fail with a warning (which is just what happened until now).

Extend rmdir_or_warn() to remove the directories of those submodules which
are scheduled for removal. Also teach verify_clean_submodule() to check
that a submodule configured to be removed is not modified before scheduling
it for removal.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c    | 37 +++++++++++++++++++++++++++++++++++++
 submodule.h    |  1 +
 unpack-trees.c |  7 ++++---
 wrapper.c      |  3 +++
 4 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 448b645..f292e9e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -447,6 +447,43 @@ int submodule_needs_update(const char *path)
 	return config_update_recurse_submodules != RECURSE_SUBMODULES_OFF;
 }

+int depopulate_submodule(const char *path)
+{
+	struct strbuf dot_git = STRBUF_INIT;
+	struct child_process cp;
+	const char *argv[] = {"rm", "-rf", path, NULL};
+
+	/* Is it populated? */
+	strbuf_addf(&dot_git, "%s/.git", path);
+	if (!resolve_gitdir(dot_git.buf)) {
+		strbuf_release(&dot_git);
+		return 0;
+	}
+	strbuf_release(&dot_git);
+
+	/* Does it have a .git directory? */
+	if (!submodule_uses_gitfile(path)) {
+		warning(_("cannot remove submodule '%s' because it (or one of "
+			  "its nested submodules) uses a .git directory"),
+			  path);
+		return -1;
+	}
+
+	/* Remove the whole submodule directory */
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 0;
+	cp.no_stdin = 1;
+	if (run_command(&cp)) {
+		warning("Could not remove submodule %s", path);
+		strbuf_release(&dot_git);
+		return -1;
+	}
+
+	return 0;
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/submodule.h b/submodule.h
index 5958010..2139e08 100644
--- a/submodule.h
+++ b/submodule.h
@@ -28,6 +28,7 @@ int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int option_parse_update_submodules(const struct option *opt,
 		const char *arg, int unset);
 int submodule_needs_update(const char *path);
+int depopulate_submodule(const char *path);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/unpack-trees.c b/unpack-trees.c
index 164354d..82c99eb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "submodule.h"

 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1266,14 +1267,14 @@ static void invalidate_ce_path(const struct cache_entry *ce,
 /*
  * Check that checking out ce->sha1 in subdir ce->name is not
  * going to overwrite any working files.
- *
- * Currently, git does not checkout subprojects during a superproject
- * checkout, so it is not going to overwrite anything.
  */
 static int verify_clean_submodule(const struct cache_entry *ce,
 				  enum unpack_trees_error_types error_type,
 				  struct unpack_trees_options *o)
 {
+	if (submodule_needs_update(ce->name) &&
+	    is_submodule_modified(ce->name, 0))
+		return 1;
 	return 0;
 }

diff --git a/wrapper.c b/wrapper.c
index 0cc5636..425a3fd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -2,6 +2,7 @@
  * Various trivial helper wrappers around standard functions
  */
 #include "cache.h"
+#include "submodule.h"

 static void do_nothing(size_t size)
 {
@@ -409,6 +410,8 @@ int unlink_or_warn(const char *file)

 int rmdir_or_warn(const char *file)
 {
+	if (submodule_needs_update(file) && depopulate_submodule(file))
+		return -1;
 	return warn_if_unremovable("rmdir", file, rmdir(file));
 }

-- 
1.9.rc0.28.ge3363ff
