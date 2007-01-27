From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/4] If abbrev is set to zero in git-describe, don't add the unique suffix
Date: Sat, 27 Jan 2007 01:53:51 -0500
Message-ID: <20070127065351.GB10380@spearce.org>
References: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 07:54:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAhRn-0001kK-Sl
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 07:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbXA0Gx5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 01:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbXA0Gx4
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 01:53:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49359 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbXA0Gx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 01:53:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAhRh-00081x-2Y; Sat, 27 Jan 2007 01:53:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 998DE20FBAE; Sat, 27 Jan 2007 01:53:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <a23c4e55ca5c09f742fa2a047e45613e7797e720.1169880681.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37925>

From: Andy Parkins <andyparkins@gmail.com>

When on a non-tag commit, git-describe normally outputs descriptions of
the form
  v1.0.0-g1234567890
Some scripts (for example the update hook script) might just want to
know the name of the nearest tag, so they then have to do
 x=$(git-describe HEAD | sed 's/-g*//')
This is costly, but more importantly is fragile as it is relying on the
output format of git-describe, which we would then have to maintain
forever.

This patch adds support for setting the --abbrev option to zero.  In
that case git-describe does as it always has, but outputs only the
nearest found tag instead of a completely unique name.  This means that
scripts would not have to parse the output format and won't need
changing if the git-describe suffix is ever changed.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is a resend of Andy's original patch.  I added documentation
 updates and slighlty modified the code so it conformed to our
 conventions.  Reason is, my next patch alters the same lines...

 Documentation/git-describe.txt |    7 ++++++-
 builtin-describe.c             |    9 ++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index b87783c..a615996 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -33,7 +33,9 @@ OPTIONS
 
 --abbrev=<n>::
 	Instead of using the default 8 hexadecimal digits as the
-	abbreviated object name, use <n> digits.
+	abbreviated object name, use <n> digits.  If set to 0
+	then abbreviated object name will not be displayed on
+	a non-exact match.
 
 --candidates=<n>::
 	Instead of considering only the 10 most recent tags as
@@ -70,6 +72,9 @@ the output shows the reference path as well:
 	[torvalds@g5 git]$ git describe --all --abbrev=4 v1.0.5^2
 	tags/v1.0.0-g975b
 
+	[torvalds@g5 git]$ git describe --all --abbrev=0 v1.0.5^2
+	tags/v1.0.0
+
 	[torvalds@g5 git]$ git describe --all HEAD^
 	heads/lt/describe-g975b
 
diff --git a/builtin-describe.c b/builtin-describe.c
index f8afb9c..70578dc 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -188,8 +188,11 @@ static void describe(const char *arg, int last_one)
 				sha1_to_hex(gave_up_on->object.sha1));
 		}
 	}
-	printf("%s-g%s\n", all_matches[0].name->path,
-		   find_unique_abbrev(cmit->object.sha1, abbrev));
+	if (!abbrev)
+		printf("%s\n", all_matches[0].name->path);
+	else
+		printf("%s-g%s\n", all_matches[0].name->path,
+			find_unique_abbrev(cmit->object.sha1, abbrev));
 
 	if (!last_one)
 		clear_commit_marks(cmit, -1);
@@ -212,7 +215,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			tags = 1;
 		else if (!strncmp(arg, "--abbrev=", 9)) {
 			abbrev = strtoul(arg + 9, NULL, 10);
-			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
+			if (abbrev && (abbrev < MINIMUM_ABBREV || 40 < abbrev))
 				abbrev = DEFAULT_ABBREV;
 		}
 		else if (!strncmp(arg, "--candidates=", 13)) {
-- 
1.5.0.rc2.g8a816
