From: Jeff Epler <jepler@unpythonic.net>
Subject: [PATCH v2] add --abbrev to 'git cherry'
Date: Sat, 30 May 2009 09:03:49 -0500
Message-ID: <20090530140349.GA25265@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 16:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAPAE-0005kC-JP
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 16:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbZE3ODu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 10:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758889AbZE3ODt
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 10:03:49 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:54692 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758863AbZE3ODs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 10:03:48 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id EB2EB1146F7; Sat, 30 May 2009 09:03:49 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120352>

Abbreviating ids makes 'git cherry -v' more useful, since you can see more
of the commit message summary:
    git cherry -v --abbrev | less -S

Signed-off-by: Jeff Epler <jepler@unpythonic.net>
---

An earlier version of this patch added multiple different flags to 'git
cherry', but --abbrev (was -a) is really the important one.  Thanks to
Jakub Narebski and Michael J Gruber for comments on the first patch.

 Documentation/git-cherry.txt |    5 ++++-
 builtin-log.c                |   24 +++++++++++++++++++-----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 7deefda..5c03da0 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -7,7 +7,7 @@ git-cherry - Find commits not merged upstream
 
 SYNOPSIS
 --------
-'git cherry' [-v] [<upstream> [<head> [<limit>]]]
+'git cherry' [-v] [--abbrev[=<n>]] [<upstream> [<head> [<limit>]]]
 
 DESCRIPTION
 -----------
@@ -49,6 +49,9 @@ OPTIONS
 -v::
 	Verbose.
 
+--abbrev[=<n>]::
+	Abbreviate commit ids to the given number of characters
+
 <upstream>::
 	Upstream branch to compare against.
 	Defaults to the first tracked remote branch, if available.
diff --git a/builtin-log.c b/builtin-log.c
index f10cfeb..1f3093e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1130,7 +1130,7 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 }
 
 static const char cherry_usage[] =
-"git cherry [-v] [<upstream> [<head> [<limit>]]]";
+"git cherry [-v] [--abbrev[=<n>]] [<upstream> [<head> [<limit>]]]";
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1142,9 +1142,23 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	const char *head = "HEAD";
 	const char *limit = NULL;
 	int verbose = 0;
+	int abbrev = 40;
+
+	while(argc > 1 && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "-v")) {
+			verbose = 1;
+		} else if(!strcmp(argv[1], "--abbrev")) {
+			abbrev = DEFAULT_ABBREV;
+		} else if(!prefixcmp(argv[1], "--abbrev=")) {
+			abbrev = strtol(argv[1] + 9, NULL, 10);
+			if(abbrev < MINIMUM_ABBREV)
+				abbrev = MINIMUM_ABBREV;
+			else if(abbrev > 40)
+				abbrev = 40;
+		} else {
+			die("unrecognized argument: %s", argv[1]);
+		}
 
-	if (argc > 1 && !strcmp(argv[1], "-v")) {
-		verbose = 1;
 		argc--;
 		argv++;
 	}
@@ -1218,12 +1232,12 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			struct strbuf buf = STRBUF_INIT;
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
 			                    &buf, 0, NULL, NULL, 0, 0);
-			printf("%c %s %s\n", sign,
+			printf("%c %.*s %s\n", sign, abbrev,
 			       sha1_to_hex(commit->object.sha1), buf.buf);
 			strbuf_release(&buf);
 		}
 		else {
-			printf("%c %s\n", sign,
+			printf("%c %.*s\n", sign, abbrev,
 			       sha1_to_hex(commit->object.sha1));
 		}
 
-- 
1.5.4.3
