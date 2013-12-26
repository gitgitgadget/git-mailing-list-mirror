From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] submodule: teach unpack_trees() to remove submodule
 contents
Date: Thu, 26 Dec 2013 08:12:02 -0800
Message-ID: <20131226161202.GN20443@google.com>
References: <20131226155857.GL20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 17:12:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwDXp-0004RF-Hv
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 17:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab3LZQMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 11:12:08 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:35995 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab3LZQMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 11:12:07 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so1808046yha.37
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 08:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BQuFg9RWX34ohHkTNUFRlR3+Y49e3WbUKrobUy1UvRU=;
        b=rKJlRURTkAzq74gJsegQdmy5Nl6PRIurfZT7dRCw1rgPNRslZ2/eYztUxPAY0uR5rF
         VBnENt99hDybN+wsWrGzaBeCnikKqRBtKimxYPIO5G60ejXMJ6UrbfsJ5Sux0H6TZxtX
         cy3UWJDHNMw7NbGnc4LuhOM8HUTV6YMGIHEsC+5Dtq0GjR20LqxjeHt9NUv89pLDFyXW
         TX/TIoSnNu0cM5O7A8IzjiJHx9KLf5dBlkpnKvHZFJJSiC5Auxfqbi76bU60Cb+hwFrL
         pO5Y3qoiA8+tvXfUDLREKpE66ihOwKjfKyJYeoKIrbHcVoGitPWGwT/d3BN3nbp+QtWs
         xHjg==
X-Received: by 10.236.47.162 with SMTP id t22mr2516010yhb.123.1388074325705;
        Thu, 26 Dec 2013 08:12:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id b30sm42286195yhm.5.2013.12.26.08.12.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 08:12:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131226155857.GL20443@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239697>

From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Tue, 19 Jun 2012 20:55:45 +0200

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
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Should this share some code (or just the error message) with the 'git
rm' code that checks whether a submodule is safe to remove?

rmdir_or_warn is a pretty low-level function --- it feels odd to be
relying on the git repository layout here.  On the other hand, that
function only has two callers, so it is possible to check quickly
whether it is safe.

I assume this is mostly for the sake of the caller in unpack-trees?

In builtin/apply.c, remove_file is used for deletion and rename
patches.  Do we want this logic take effect there, too?

 submodule.c    | 37 +++++++++++++++++++++++++++++++++++++
 submodule.h    |  1 +
 unpack-trees.c |  6 +++---
 wrapper.c      |  3 +++
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3f18d4d..a25db46 100644
--- a/submodule.c
+++ b/submodule.c
@@ -412,6 +412,43 @@ int submodule_needs_update(const char *path)
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
index 055918c..df291cf 100644
--- a/submodule.h
+++ b/submodule.h
@@ -24,6 +24,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int submodule_needs_update(const char *path);
+int depopulate_submodule(const char *path);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
diff --git a/unpack-trees.c b/unpack-trees.c
index ad3e9a0..89b506a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "submodule.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
@@ -1263,14 +1264,13 @@ static void invalidate_ce_path(const struct cache_entry *ce,
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
+	if (submodule_needs_update(ce->name) && is_submodule_modified(ce->name, 0))
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
1.8.5.1
