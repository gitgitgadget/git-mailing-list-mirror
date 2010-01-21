From: "David Rydh" <dary@math.berkeley.edu>
Subject: [PATCH] git-mv: Fix error with multiple sources.
Date: Thu, 21 Jan 2010 12:39:41 -0800
Message-ID: <718290.769818367-sendEmail@darysmbp>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "David Rydh" <dary@math.berkeley.edu>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 05:15:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYAvQ-0006WF-R7
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 05:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0AVEPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 23:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961Ab0AVEPG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 23:15:06 -0500
Received: from cm03fe.IST.Berkeley.EDU ([169.229.218.144]:48011 "EHLO
	cm03fe.IST.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161Ab0AVEPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 23:15:05 -0500
X-Greylist: delayed 1111 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2010 23:15:05 EST
Received: from [10.136.1.155] (helo=darysmbp.local)
	by cm03fe.ist.berkeley.edu with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(auth login:dary@math.berkeley.edu)
	(envelope-from <dary@math.berkeley.edu>)
	id 1NYAdJ-0006FK-CR; Thu, 21 Jan 2010 19:56:31 -0800
X-Mailer: sendEmail-1.56
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137736>

Commit b8f26269 (fix directory separator treatment on Windows,
30-06-2009) introduced a bug on Mac OS X. The problem is that
basename() may return a pointer to internal static storage space that
will be overwritten by subsequent calls:

> git mv dir/a.txt dir/b.txt other/

  Checking rename of 'dir/a.txt' to 'other/b.txt'
  Checking rename of 'dir/b.txt' to 'other/b.txt'
  fatal: multiple sources for the same target,
  source=dir/b.txt, destination=other/b.txt

This commit also fixed two potentially dangerous uses of
prefix_filename() -- which returns static storage space -- in
builtin-config.c and hash-object.c.

get_pathspec(): If called with an empty pathspec, allocate a new
pathspec with a copy of prefix. This is consistent with the behavior
when called with a non-empty pathspec and prevents potential errors.

Signed-off-by: David Rydh <dary@math.berkeley.edu>
---
This is my first patch submission to git. Perhaps this patch should
be split into two? The one-line change to builtin-mv.c suffices to
fix the bug.

 builtin-config.c |    4 ++--
 builtin-mv.c     |    2 +-
 hash-object.c    |    2 +-
 setup.c          |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 2e3ef91..bf60f93 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -356,9 +356,9 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		config_exclusive_filename = git_etc_gitconfig();
 	else if (given_config_file) {
 		if (!is_absolute_path(given_config_file) && prefix)
-			config_exclusive_filename = prefix_filename(prefix,
+			config_exclusive_filename = xstrdup(prefix_filename(prefix,
 								    strlen(prefix),
-								    argv[2]);
+									argv[2]));
 		else
 			config_exclusive_filename = given_config_file;
 	}
diff --git a/builtin-mv.c b/builtin-mv.c
index 8247186..1c1f8be 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -27,7 +27,7 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 		if (length > 0 && is_dir_sep(result[i][length - 1]))
 			result[i] = xmemdupz(result[i], length - 1);
 		if (base_name)
-			result[i] = basename((char *)result[i]);
+			result[i] = xstrdup(basename((char *)result[i]));
 	}
 	return get_pathspec(prefix, result);
 }
diff --git a/hash-object.c b/hash-object.c
index 9455dd0..3c509aa 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -91,7 +91,7 @@ int main(int argc, const char **argv)
 		prefix = setup_git_directory();
 		prefix_length = prefix ? strlen(prefix) : 0;
 		if (vpath && prefix)
-			vpath = prefix_filename(prefix, prefix_length, vpath);
+			vpath = xstrdup(prefix_filename(prefix, prefix_length, vpath));
 	}
 
 	git_config(git_default_config, NULL);
diff --git a/setup.c b/setup.c
index 710e2f3..80cf535 100644
--- a/setup.c
+++ b/setup.c
@@ -132,8 +132,8 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 		return NULL;
 
 	if (!entry) {
-		static const char *spec[2];
-		spec[0] = prefix;
+		const char **spec = xmalloc(sizeof(char *) * 2);
+		spec[0] = xstrdup(prefix);
 		spec[1] = NULL;
 		return spec;
 	}
-- 
1.6.6.1
