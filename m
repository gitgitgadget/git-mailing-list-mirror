From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] grep: turn off gitlink detection for --no-index
Date: Sat, 5 Mar 2016 17:15:51 -0500
Message-ID: <20160305221551.GE31508@sigill.intra.peff.net>
References: <20160305220829.GA31316@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 23:15:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acKUQ-0001dM-RA
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 23:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbcCEWPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 17:15:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:55331 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750801AbcCEWPy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 17:15:54 -0500
Received: (qmail 13300 invoked by uid 102); 5 Mar 2016 22:15:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:15:53 -0500
Received: (qmail 12195 invoked by uid 107); 5 Mar 2016 22:16:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 17:16:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 17:15:51 -0500
Content-Disposition: inline
In-Reply-To: <20160305220829.GA31316@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288333>

If we are running "git grep --no-index" outside of a git
repository, we behave roughly like "grep -r", examining all
files in the current directory and its subdirectories.
However, because we use fill_directory() to do the
recursion, it will skip over any directories which look like
sub-repositories.

For a normal git operation (like "git grep" in a repository)
this makes sense; we do not want to cross the boundary out
of our current repository into a submodule. But for
"--no-index" without a repository, we should look at all
files, including embedded repositories.

There is one exception, though: we probably should _not_
descend into ".git" directories. Doing so is inefficient and
unlikely to turn up useful hits.

This patch drops our use of dir.c's gitlink-detection, but
we do still avoid ".git". That makes us more like tools such
as "ack" or "ag", which also know to avoid cruft in .git.

As a bonus, this also drops our usage of the ref code
when we are outside of a repository, making the transition
to pluggable ref backends cleaner.

Based-on-a-patch-by: David Turner <dturner@twopensource.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I hope the reasoning above makes sense. My ulterior motive is the
"bonus", but I really think the new behavior is what people would expect
(i.e., that "git grep --no-index" is basically a replacement for "ack",
etc).

 builtin/grep.c  |  1 +
 t/t7810-grep.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index aa7435f..0636cd7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -528,6 +528,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 	int i, hit = 0;
 
 	memset(&dir, 0, sizeof(dir));
+	dir.flags |= DIR_NO_GITLINKS;
 	if (exc_std)
 		setup_standard_excludes(&dir);
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index b540944..1e72971 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -905,6 +905,33 @@ test_expect_success 'inside git repository but with --no-index' '
 	)
 '
 
+test_expect_success 'grep --no-index descends into repos, but not .git' '
+	rm -fr non &&
+	mkdir -p non/git &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+
+		echo magic >file &&
+		git init repo &&
+		(
+			cd repo &&
+			echo magic >file &&
+			git add file &&
+			git commit -m foo &&
+			echo magic >.git/file
+		) &&
+
+		cat >expect <<-\EOF &&
+		file
+		repo/file
+		EOF
+		git grep -l --no-index magic >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'setup double-dash tests' '
 cat >double-dash <<EOF &&
 --
-- 
2.8.0.rc1.318.g2193183
