From: Jeff King <peff@peff.net>
Subject: [PATCH] clean: simplify dir/not-dir logic
Date: Mon, 10 Mar 2014 13:24:47 -0400
Message-ID: <20140310172447.GD29801@sigill.intra.peff.net>
References: <CABN9-fcpyDogh45WPwuS1qgkE1jLuOAtejuW=fGCKNNyNm3DEQ@mail.gmail.com>
 <20140310172002.GB29801@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Pedersen <robinp@snap.tv>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:24:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN3wd-0000Bm-1l
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbaCJRYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:24:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:36576 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754422AbaCJRYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 13:24:49 -0400
Received: (qmail 9342 invoked by uid 102); 10 Mar 2014 17:24:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 12:24:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 13:24:47 -0400
Content-Disposition: inline
In-Reply-To: <20140310172002.GB29801@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243778>

On Mon, Mar 10, 2014 at 01:20:02PM -0400, Jeff King wrote:

> git-clean uses read_directory to fill in a `struct dir` with
> potential hits. However, read_directory does not actually
> check against our pathspec. It uses a simplified version
> that may turn up false positives. As a result, we need to
> check that any hits match our pathspec. We do so reliably
> for non-directories. For directories, if "-d" is not given
> we check that the pathspec matched exactly (i.e., we are
> even stricter, and require an explicit "git clean foo" to
> clean "foo/"). But if "-d" is given, rather than relaxing
> the exact match to allow a recursive match, we do not check
> the pathspec at all.
> 
> This regression was introduced in 113f10f (Make git-clean a
> builtin, 2007-11-11).

The code has been cleaned up quite a bit from that original version, and
it was pretty easy to see the discrepancy between the two code paths.
However, if the code were structured like the cleanup patch below, I
think it would have been even easier.

This comes on top of my other patch. So the bug is already fixed, but I
think the end result is more readable.

-- >8 --
When we get a list of paths from read_directory, we further
prune it to create the final list of items to remove. The
code paths for directories and non-directories repeat the
same "add to list" code.

This patch restructures the code so that we don't repeat
ourselves. Also, by following a "if (condition) continue"
pattern like the pathspec check above, it makes it more
obvious that the conditional is about excluding directories
under certain circumstances.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clean.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 31c1488..cf76b1f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -950,15 +950,12 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (pathspec.nr && !matches)
 			continue;
 
-		if (S_ISDIR(st.st_mode)) {
-			if (remove_directories || (matches == MATCHED_EXACTLY)) {
-				rel = relative_path(ent->name, prefix, &buf);
-				string_list_append(&del_list, rel);
-			}
-		} else {
-			rel = relative_path(ent->name, prefix, &buf);
-			string_list_append(&del_list, rel);
-		}
+		if (S_ISDIR(st.st_mode) && !remove_directories &&
+		    matches != MATCHED_EXACTLY)
+			continue;
+
+		rel = relative_path(ent->name, prefix, &buf);
+		string_list_append(&del_list, rel);
 	}
 
 	if (interactive && del_list.nr > 0)
-- 
1.9.0.403.g7a2f4b0
