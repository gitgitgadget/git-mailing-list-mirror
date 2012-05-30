From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] clone: allow --no-local to turn off local optimizations
Date: Wed, 30 May 2012 07:10:16 -0400
Message-ID: <20120530111016.GB15550@sigill.intra.peff.net>
References: <20120530110305.GA13445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 13:10:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZgnJ-0001OX-19
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687Ab2E3LKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 07:10:21 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36249
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab2E3LKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 07:10:20 -0400
Received: (qmail 3855 invoked by uid 107); 30 May 2012 11:10:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 07:10:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 07:10:16 -0400
Content-Disposition: inline
In-Reply-To: <20120530110305.GA13445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198801>

This is basically the same as using "file://", but is a
little less subtle for the end user. It also allows relative
paths to be specified.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-clone.txt |  4 +++-
 builtin/clone.c             | 10 +++++-----
 t/t5701-clone-local.sh      | 10 ++++++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 1d267f4..c1ddd4c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -51,7 +51,9 @@ OPTIONS
 If the repository is specified as a local path (e.g., `/path/to/repo`),
 this is the default, and --local is essentially a no-op.  If the
 repository is specified as a URL, then this flag is ignored (and we
-never use the local optimizations).
+never use the local optimizations).  Specifying `--no-local` will
+override the default when `/path/to/repo` is given, using the regular
+git transport instead.
 +
 To force copying instead of hardlinking (which may be desirable if you
 are trying to make a back-up of your repository), but still avoid the
diff --git a/builtin/clone.c b/builtin/clone.c
index a4d8d25..7f3b982 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -38,7 +38,7 @@ static const char * const builtin_clone_usage[] = {
 };
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
-static int option_local, option_no_hardlinks, option_shared, option_recursive;
+static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
 static char *option_template, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
@@ -70,8 +70,8 @@ static struct option builtin_clone_options[] = {
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
@@ -342,7 +342,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
-			if (option_local)
+			if (option_local > 0)
 				die_errno(_("failed to create link '%s'"), dest->buf);
 			option_no_hardlinks = 1;
 		}
@@ -668,7 +668,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		die(_("repository '%s' does not exist"), repo_name);
 	else
 		repo = repo_name;
-	is_local = path && !is_bundle;
+	is_local = option_local != 0 && path && !is_bundle;
 	if (is_local && option_depth)
 		warning(_("--depth is ignored in local clones; use file:// instead."));
 
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index c6feca4..2d6121f 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -124,4 +124,14 @@ test_expect_success 'cloning non-git directory fails' '
 	test_must_fail git clone not-a-git-repo not-a-git-repo-clone
 '
 
+test_expect_success 'cloning file:// does not hardlink' '
+	git clone --bare file://"$(pwd)"/a non-local &&
+	! repo_is_hardlinked non-local
+'
+
+test_expect_success 'cloning a local path with --no-local does not hardlink' '
+	git clone --bare --no-local a force-nonlocal &&
+	! repo_is_hardlinked force-nonlocal
+'
+
 test_done
-- 
1.7.11.rc0.12.g6048c92
