From: Jeff King <peff@peff.net>
Subject: [PATCH] clean: respect pathspecs with "-d"
Date: Mon, 10 Mar 2014 13:20:02 -0400
Message-ID: <20140310172002.GB29801@sigill.intra.peff.net>
References: <CABN9-fcpyDogh45WPwuS1qgkE1jLuOAtejuW=fGCKNNyNm3DEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Pedersen <robinp@snap.tv>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:20:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN3s3-0003Tl-Dv
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbaCJRUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:20:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:36568 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753508AbaCJRUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 13:20:04 -0400
Received: (qmail 9089 invoked by uid 102); 10 Mar 2014 17:20:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 12:20:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 13:20:02 -0400
Content-Disposition: inline
In-Reply-To: <CABN9-fcpyDogh45WPwuS1qgkE1jLuOAtejuW=fGCKNNyNm3DEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243776>

git-clean uses read_directory to fill in a `struct dir` with
potential hits. However, read_directory does not actually
check against our pathspec. It uses a simplified version
that may turn up false positives. As a result, we need to
check that any hits match our pathspec. We do so reliably
for non-directories. For directories, if "-d" is not given
we check that the pathspec matched exactly (i.e., we are
even stricter, and require an explicit "git clean foo" to
clean "foo/"). But if "-d" is given, rather than relaxing
the exact match to allow a recursive match, we do not check
the pathspec at all.

This regression was introduced in 113f10f (Make git-clean a
builtin, 2007-11-11).

Signed-off-by: Jeff King <peff@peff.net>
---
On Mon, Mar 10, 2014 at 11:31:37AM +0100, Robin Pedersen wrote:

> I accidentially deleted a directory using git clean. I would think
> this is a bug, but I'm not sure. Was using 1.8.1, but upgraded to
> 1.9.0 just to see if it was still reproducable, and it was.

Definitely a bug, and it dates back quite a while.  Thanks for a very
clear bug report.

-- >8 --
 builtin/clean.c  | 5 +++--
 t/t7300-clean.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 114d7bf..31c1488 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -947,14 +947,15 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (pathspec.nr)
 			matches = dir_path_match(ent, &pathspec, 0, NULL);
 
+		if (pathspec.nr && !matches)
+			continue;
+
 		if (S_ISDIR(st.st_mode)) {
 			if (remove_directories || (matches == MATCHED_EXACTLY)) {
 				rel = relative_path(ent->name, prefix, &buf);
 				string_list_append(&del_list, rel);
 			}
 		} else {
-			if (pathspec.nr && !matches)
-				continue;
 			rel = relative_path(ent->name, prefix, &buf);
 			string_list_append(&del_list, rel);
 		}
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 710be90..0c602de 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -511,4 +511,12 @@ test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
 	! test -d foo
 '
 
+test_expect_success 'git clean -d respects pathspecs' '
+	mkdir foo &&
+	mkdir foobar &&
+	git clean -df foobar &&
+	test_path_is_dir foo &&
+	test_path_is_missing foobar
+'
+
 test_done
-- 
1.9.0.403.g7a2f4b0
