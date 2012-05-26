From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] clone: make --local handle URLs
Date: Fri, 25 May 2012 23:45:32 -0400
Message-ID: <20120526034532.GB14332@sigill.intra.peff.net>
References: <20120526034226.GA14287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Emeric Fermas <emeric.fermas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 05:45:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY7wi-0006yt-IR
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 05:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab2EZDpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 23:45:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56346
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab2EZDpf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 23:45:35 -0400
Received: (qmail 16155 invoked by uid 107); 26 May 2012 03:46:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 May 2012 23:46:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2012 23:45:32 -0400
Content-Disposition: inline
In-Reply-To: <20120526034226.GA14287@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198537>

Once upon a time, the --local flag was used to inform git
that it should perform some optimizations when cloning a
local repository. These days, we perform those optimizations
automatically, and --local is largely a no-op. The one
exception is that we will complain when "--local" is given
if hardlinking fails, whereas the default behavior is to
simply fallback to a copy.

Using --local with anything except a local path is also a
no-op, because we never bother to look at the flag. So this:

  git clone --local file:///path/to/repo

silently ignores the local flag, when a more sensible
behavior would be to treat it the same as:

  git clone --local /path/to/repo

Likewise, this:

  git clone --local http://example.com/repo.git

is nonsense, but git silently accepts it.

This patch causes --local to treat file:// URLs as local,
and to flag an error when nonsensical combinations are
requested.

Signed-off-by: Jeff King <peff@peff.net>
---
I had hoped this could just be:

  if (opt_local && !prefixcmp(repo_name, "file://"))
          repo_name += 7;

but we have to handle URL decoding. And did you know that file:// URLs
can have a hostname in them? How useless. I made sure this behaves the
same as the parser in connect.c, though I couldn't find a good way to
share the code without making both sides less readable.

 Documentation/git-clone.txt | 17 ++++++++++-------
 builtin/clone.c             | 26 ++++++++++++++++++++++++++
 t/t5550-http-fetch.sh       |  4 ++++
 t/t5701-clone-local.sh      | 15 +++++++++++++++
 4 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6e22522..589f3ce 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -46,13 +46,16 @@ OPTIONS
 	mechanism and clones the repository by making a copy of
 	HEAD and everything under objects and refs directories.
 	The files under `.git/objects/` directory are hardlinked
-	to save space when possible.  This is now the default when
-	the source repository is specified with `/path/to/repo`
-	syntax, so it essentially is a no-op option.  To force
-	copying instead of hardlinking (which may be desirable
-	if you are trying to make a back-up of your repository),
-	but still avoid the usual "git aware" transport
-	mechanism, `--no-hardlinks` can be used.
+	to save space when possible.
++
+This is the default when the source repository is specified with
+`/path/to/repo`, but not with a `file://` URL; specifying `--local` with
+a file URL will bypass the regular transport mechanism as if a direct
+path had been provided.
++
+To force copying instead of hardlinking (which may be desirable if you
+are trying to make a back-up of your repository), but still avoid the
+usual "git aware" transport mechanism, `--no-hardlinks` can be used.
 
 --no-hardlinks::
 	Optimize the cloning process from a repository on a
diff --git a/builtin/clone.c b/builtin/clone.c
index a4d8d25..05944db 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "url.h"
 
 /*
  * Overall FIXMEs:
@@ -607,6 +608,22 @@ static void write_config(struct string_list *config)
 	}
 }
 
+static const char *url_to_local_path(const char *url)
+{
+	const char *decoded = url_decode(url);
+	const char *p;
+
+	decoded = skip_prefix(decoded, "file://");
+	if (!decoded)
+		return NULL;
+
+	if (has_dos_drive_prefix(decoded))
+		return decoded;
+
+	p = strchr(decoded, '/');
+	return p ? p : decoded;
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -666,6 +683,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		repo = xstrdup(absolute_path(repo_name));
 	else if (!strchr(repo_name, ':'))
 		die(_("repository '%s' does not exist"), repo_name);
+	else if (option_local) {
+		const char *url_path = url_to_local_path(repo_name);
+		if (!url_path)
+			die(_("cannot use --local with a non-local URL"));
+		path = get_repo_path(url_path, &is_bundle);
+		if (!path)
+			die(_("repository '%s' does not exist"), url_path);
+		repo = xstrdup(absolute_path(url_path));
+	}
 	else
 		repo = repo_name;
 	is_local = path && !is_bundle;
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index b06f817..b8d77b6 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -40,6 +40,10 @@ test_expect_success 'clone http repository' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'cloning http with --local fails' '
+	test_must_fail git clone --local $HTTPD_URL/dumb/repo.git local-clone
+'
+
 test_expect_success 'create password-protected repository' '
 	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/auth/" &&
 	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index c6feca4..d2e0165 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -124,4 +124,19 @@ test_expect_success 'cloning non-git directory fails' '
 	test_must_fail git clone not-a-git-repo not-a-git-repo-clone
 '
 
+test_expect_success 'cloning file:// turns off local optimizations' '
+	git clone --bare file://"$PWD"/a non-local &&
+	! repo_is_hardlinked non-local
+'
+
+test_expect_success 'cloning file:// with --local uses hardlinks' '
+	git clone --bare --local file://"$PWD"/a force-local &&
+	repo_is_hardlinked force-local
+'
+
+test_expect_success 'cloning file:// with --local parses URL properly' '
+	git clone --bare --local file://host/"$PWD"/%61 force-local-odd &&
+	repo_is_hardlinked force-local-odd
+'
+
 test_done
-- 
1.7.10.1.21.g62fda49.dirty
