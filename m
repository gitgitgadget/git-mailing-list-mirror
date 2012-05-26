From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] clone: allow --no-local to turn off local optimizations
Date: Fri, 25 May 2012 23:45:50 -0400
Message-ID: <20120526034550.GC14332@sigill.intra.peff.net>
References: <20120526034226.GA14287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Emeric Fermas <emeric.fermas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 05:46:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY7x0-0007ov-2f
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 05:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804Ab2EZDpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 23:45:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56349
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755360Ab2EZDpx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 23:45:53 -0400
Received: (qmail 16184 invoked by uid 107); 26 May 2012 03:46:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 23:46:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 23:45:50 -0400
Content-Disposition: inline
In-Reply-To: <20120526034226.GA14287@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198538>

This is basically the same as using "file://", but is a
little less subtle for the end user.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-clone.txt |  4 +++-
 builtin/clone.c             | 12 ++++++------
 t/t5701-clone-local.sh      |  5 +++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 589f3ce..f388374 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -51,7 +51,9 @@ OPTIONS
 This is the default when the source repository is specified with
 `/path/to/repo`, but not with a `file://` URL; specifying `--local` with
 a file URL will bypass the regular transport mechanism as if a direct
-path had been provided.
+path had been provided. Specifying `--no-local` will cancel any previous
+`--local`, and will override the default when `/path/to/repo` is given,
+using the regular git transport instead.
 +
 To force copying instead of hardlinking (which may be desirable if you
 are trying to make a back-up of your repository), but still avoid the
diff --git a/builtin/clone.c b/builtin/clone.c
index 05944db..d004abb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -39,7 +39,7 @@ static const char * const builtin_clone_usage[] = {
 };
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
-static int option_local, option_no_hardlinks, option_shared, option_recursive;
+static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
 static char *option_template, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
@@ -71,8 +71,8 @@ static struct option builtin_clone_options[] = {
 		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 	OPT_BOOLEAN(0, "mirror", &option_mirror,
 		    "create a mirror repository (implies bare)"),
-	OPT_BOOLEAN('l', "local", &option_local,
-		    "to clone from a local repository"),
+	OPT_BOOL('l', "local", &option_local,
+		"to clone from a local repository"),
 	OPT_BOOLEAN(0, "no-hardlinks", &option_no_hardlinks,
 		    "don't use local hardlinks, always copy"),
 	OPT_BOOLEAN('s', "shared", &option_shared,
@@ -343,7 +343,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
-			if (option_local)
+			if (option_local > 0)
 				die_errno(_("failed to create link '%s'"), dest->buf);
 			option_no_hardlinks = 1;
 		}
@@ -683,7 +683,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		repo = xstrdup(absolute_path(repo_name));
 	else if (!strchr(repo_name, ':'))
 		die(_("repository '%s' does not exist"), repo_name);
-	else if (option_local) {
+	else if (option_local > 0) {
 		const char *url_path = url_to_local_path(repo_name);
 		if (!url_path)
 			die(_("cannot use --local with a non-local URL"));
@@ -694,7 +694,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	else
 		repo = repo_name;
-	is_local = path && !is_bundle;
+	is_local = option_local != 0 && path && !is_bundle;
 	if (is_local && option_depth)
 		warning(_("--depth is ignored in local clones; use file:// instead."));
 
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index d2e0165..64faff1 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -139,4 +139,9 @@ test_expect_success 'cloning file:// with --local parses URL properly' '
 	repo_is_hardlinked force-local-odd
 '
 
+test_expect_success 'cloning a local path with --no-local does not hardlink' '
+	git clone --bare --no-local a force-nonlocal &&
+	! repo_is_hardlinked force-nonlocal
+'
+
 test_done
-- 
1.7.10.1.21.g62fda49.dirty
