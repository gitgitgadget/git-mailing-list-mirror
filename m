From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/6] Teach git-describe --exact-match to avoid expensive tag searches
Date: Sun, 24 Feb 2008 03:07:31 -0500
Message-ID: <20080224080731.GE22587@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTBua-0004Lv-R8
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbYBXIH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYBXIH4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:07:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42981 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbYBXIHe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:07:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTBtT-0001g0-KU; Sun, 24 Feb 2008 03:07:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 70DEA20FBAE; Sun, 24 Feb 2008 03:07:31 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74910>

Sometimes scripts want (or need) the annotated tag name that exactly
matches a specific commit, or no tag at all.  In such cases it can be
difficult to determine if the output of `git describe $commit` is a
real tag name or a tag+abbreviated commit.  A common idiom is to run
git-describe twice:

  if test $(git describe $commit) = $(git describe --abbrev=0 $commit)
  ...

but this is a huge waste of time if the caller is just going to pick a
different method to describe $commit or abort because it is not exactly
an annotated tag.

Setting the maximum number of candidates to 0 allows the caller to ask
for only a tag that directly points at the supplied commit, or to have
git-describe abort if no such item exists.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-describe.txt |    5 +++++
 builtin-describe.c             |    8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 1c3dfb4..fbb40a2 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -45,6 +45,11 @@ OPTIONS
 	candidates to describe the input committish consider
 	up to <n> candidates.  Increasing <n> above 10 will take
 	slightly longer but may produce a more accurate result.
+	An <n> of 0 will cause only exact matches to be output.
+
+--exact-match::
+	Only output exact matches (a tag directly references the
+	supplied commit).  This is a synonym for --candidates=0.
 
 --debug::
 	Verbosely display information about the searching strategy
diff --git a/builtin-describe.c b/builtin-describe.c
index 9c958bd..05e309f 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -174,6 +174,8 @@ static void describe(const char *arg, int last_one)
 		return;
 	}
 
+	if (!max_candidates)
+		die("no tag exactly matches '%s'", sha1_to_hex(cmit->object.sha1));
 	if (debug)
 		fprintf(stderr, "searching to describe %s\n", arg);
 
@@ -270,6 +272,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all",        &all, "use any ref in .git/refs"),
 		OPT_BOOLEAN(0, "tags",       &tags, "use any tag in .git/refs/tags"),
 		OPT__ABBREV(&abbrev),
+		OPT_SET_INT(0, "exact-match", &max_candidates,
+			    "only output exact matches", 0),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    "consider <n> most recent tags (default: 10)"),
 		OPT_STRING(0, "match",       &pattern, "pattern",
@@ -278,8 +282,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, options, describe_usage, 0);
-	if (max_candidates < 1)
-		max_candidates = 1;
+	if (max_candidates < 0)
+		max_candidates = 0;
 	else if (max_candidates > MAX_TAGS)
 		max_candidates = MAX_TAGS;
 
-- 
1.5.4.3.295.g6b554
