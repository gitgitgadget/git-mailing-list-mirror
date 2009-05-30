From: Jeff Epler <jepler@unpythonic.net>
Subject: [PATCH v3] add --abbrev to 'git cherry'
Date: Sat, 30 May 2009 11:53:06 -0500
Message-ID: <20090530165306.GA1142@unpythonic.net>
References: <20090530140349.GA25265@unpythonic.net> <200905301826.11924.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 18:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MARo4-00050T-2A
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 18:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760105AbZE3QxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 12:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759979AbZE3QxG
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 12:53:06 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:60497 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752270AbZE3QxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 12:53:05 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 69D4D1146F7; Sat, 30 May 2009 11:53:06 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <200905301826.11924.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120359>

Abbreviating ids makes 'git cherry -v' more useful, since you can see more
of the commit message summary:
    git cherry -v --abbrev | less -S

Signed-off-by: Jeff Epler <jepler@unpythonic.net>
---

Compared to the last patch, this adds to the bash completion, improves
doc consistency, and uses find_unique_abbrev to shorten commit ids.
Thanks to Markus Heidelberg for feedback.

 Documentation/git-cherry.txt           |    6 +++++-
 builtin-log.c                          |   24 +++++++++++++++++++-----
 contrib/completion/git-completion.bash |   10 +++++++++-
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 7deefda..c8cbbcc 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -7,7 +7,7 @@ git-cherry - Find commits not merged upstream
 
 SYNOPSIS
 --------
-'git cherry' [-v] [<upstream> [<head> [<limit>]]]
+'git cherry' [-v] [--abbrev[=<n>]] [<upstream> [<head> [<limit>]]]
 
 DESCRIPTION
 -----------
@@ -49,6 +49,10 @@ OPTIONS
 -v::
 	Verbose.
 
+--abbrev[=<n>]::
+	Alter the sha1's minimum display length in the output listing.
+	The default value is 7.
+
 <upstream>::
 	Upstream branch to compare against.
 	Defaults to the first tracked remote branch, if available.
diff --git a/builtin-log.c b/builtin-log.c
index f10cfeb..c115a8e 100644
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
@@ -1219,12 +1233,12 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
 			                    &buf, 0, NULL, NULL, 0, 0);
 			printf("%c %s %s\n", sign,
-			       sha1_to_hex(commit->object.sha1), buf.buf);
+			       find_unique_abbrev(commit->object.sha1, abbrev), buf.buf);
 			strbuf_release(&buf);
 		}
 		else {
 			printf("%c %s\n", sign,
-			       sha1_to_hex(commit->object.sha1));
+			       find_unique_abbrev(commit->object.sha1, abbrev));
 		}
 
 		list = list->next;
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c84d765..536a769 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -804,7 +804,15 @@ _git_checkout ()
 
 _git_cherry ()
 {
-	__gitcomp "$(__git_refs)"
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	-*)
+		__gitcomp "-v --abbrev --abbrev="
+		;;
+	*)
+		__gitcomp "$(__git_refs)"
+		;;
+	esac
 }
 
 _git_cherry_pick ()
-- 
1.5.4.3
