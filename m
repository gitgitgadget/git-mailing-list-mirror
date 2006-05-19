From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 5/5] Change 'master@noon' syntax to 'master@{noon}'.
Date: Fri, 19 May 2006 03:29:43 -0400
Message-ID: <20060519072943.GF22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 09:29:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzQk-0005Xe-Pw
	for gcvg-git@gmane.org; Fri, 19 May 2006 09:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWESH3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 03:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWESH3s
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 03:29:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40643 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751111AbWESH3r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 03:29:47 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgzQd-0002l6-QA; Fri, 19 May 2006 03:29:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 229C5212691; Fri, 19 May 2006 03:29:44 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20333>

Its ambiguous to parse "master@2006-05-17 18:30:foo" when foo is
meant as a file name and ":30" is meant as 30 minutes past 6 pm.
Therefore all date specifications in a sha1 expression must now
appear within brackets and the ':' splitter used for the path name
in a sha1 expression ignores ':' appearing within brackets.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 Documentation/git-rev-parse.txt |   11 ++++----
 sha1_name.c                     |   27 ++++++++++++-------
 t/t1400-update-ref.sh           |   55 ++++++++++++++++++++++++++++-----------
 3 files changed, 62 insertions(+), 31 deletions(-)

eea4ae092b92129ef09e9caf6f6f2b523cd193cb
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index df308c3..b894694 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -124,11 +124,12 @@ syntax.
   happen to have both heads/master and tags/master, you can
   explicitly say 'heads/master' to tell git which one you mean.
 
-* A suffix '@' followed by a date specification such as 'yesterday'
-  (24 hours ago) or '1 month 2 weeks 3 days 1 hour 1 second ago'
-  to specify the value of the ref at a prior point in time.
-  This suffix may only be used immediately following a ref name
-  and the ref must have an existing log ($GIT_DIR/logs/<ref>).
+* A suffix '@' followed by a date specification enclosed in a brace
+  pair (e.g. '\{yesterday\}', '\{1 month 2 weeks 3 days 1 hour 1
+  second ago\}' or '\{1979-02-26 18:30:00\}') to specify the value
+  of the ref at a prior point in time.  This suffix may only be
+  used immediately following a ref name and the ref must have an
+  existing log ($GIT_DIR/logs/<ref>).
 
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
diff --git a/sha1_name.c b/sha1_name.c
index 4376cb3..fbbde1c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -249,7 +249,7 @@ static int get_sha1_basic(const char *st
 	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
 	const char **p, *pathname;
 	char *real_path = NULL;
-	int refs_found = 0, at_mark;
+	int refs_found = 0, am;
 	unsigned long at_time = (unsigned long)-1;
 	unsigned char *this_result;
 	unsigned char sha1_from_ref[20];
@@ -257,16 +257,16 @@ static int get_sha1_basic(const char *st
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
 
-	/* At a given period of time? "@2 hours ago" */
-	for (at_mark = 1; at_mark < len; at_mark++) {
-		if (str[at_mark] == '@') {
-			int date_len = len - at_mark - 1;
+	/* At a given period of time? "@{2 hours ago}" */
+	for (am = 1; am < len - 1; am++) {
+		if (str[am] == '@' && str[am+1] == '{' && str[len-1] == '}') {
+			int date_len = len - am - 3;
 			char *date_spec = xmalloc(date_len + 1);
-			strncpy(date_spec, str + at_mark + 1, date_len);
+			strncpy(date_spec, str + am + 2, date_len);
 			date_spec[date_len] = 0;
 			at_time = approxidate(date_spec);
 			free(date_spec);
-			len = at_mark;
+			len = am;
 			break;
 		}
 	}
@@ -482,7 +482,7 @@ static int get_sha1_1(const char *name, 
  */
 int get_sha1(const char *name, unsigned char *sha1)
 {
-	int ret;
+	int ret, bracket_depth;
 	unsigned unused;
 	int namelen = strlen(name);
 	const char *cp;
@@ -528,8 +528,15 @@ int get_sha1(const char *name, unsigned 
 		}
 		return -1;
 	}
-	cp = strchr(name, ':');
-	if (cp) {
+	for (cp = name, bracket_depth = 0; *cp; cp++) {
+		if (*cp == '{')
+			bracket_depth++;
+		else if (bracket_depth && *cp == '}')
+			bracket_depth--;
+		else if (!bracket_depth && *cp == ':')
+			break;
+	}
+	if (*cp == ':') {
 		unsigned char tree_sha1[20];
 		if (!get_sha1_1(name, cp-name, tree_sha1))
 			return get_tree_entry(tree_sha1, cp+1, sha1,
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7858d86..f6b076b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -125,52 +125,75 @@ ed="Thu, 26 May 2005 18:32:00 -0500"
 gd="Thu, 26 May 2005 18:33:00 -0500"
 ld="Thu, 26 May 2005 18:43:00 -0500"
 test_expect_success \
-	'Query "master@May 25 2005" (before history)' \
+	'Query "master@{May 25 2005}" (before history)' \
 	'rm -f o e
-	 git-rev-parse --verify "master@May 25 2005" >o 2>e &&
+	 git-rev-parse --verify "master@{May 25 2005}" >o 2>e &&
 	 test $C = $(cat o) &&
 	 test "warning: Log .git/logs/$m only goes back to $ed." = "$(cat e)"'
 test_expect_success \
-	"Query master@2005-05-25 (before history)" \
+	"Query master@{2005-05-25} (before history)" \
 	'rm -f o e
-	 git-rev-parse --verify master@2005-05-25 >o 2>e &&
+	 git-rev-parse --verify master@{2005-05-25} >o 2>e &&
 	 test $C = $(cat o) &&
 	 echo test "warning: Log .git/logs/$m only goes back to $ed." = "$(cat e)"'
 test_expect_success \
-	'Query "master@May 26 2005 23:31:59" (1 second before history)' \
+	'Query "master@{May 26 2005 23:31:59}" (1 second before history)' \
 	'rm -f o e
-	 git-rev-parse --verify "master@May 26 2005 23:31:59" >o 2>e &&
+	 git-rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
 	 test $C = $(cat o) &&
 	 test "warning: Log .git/logs/$m only goes back to $ed." = "$(cat e)"'
 test_expect_success \
-	'Query "master@May 26 2005 23:32:00" (exactly history start)' \
+	'Query "master@{May 26 2005 23:32:00}" (exactly history start)' \
 	'rm -f o e
-	 git-rev-parse --verify "master@May 26 2005 23:32:00" >o 2>e &&
+	 git-rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
 	 test $A = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
-	'Query "master@2005-05-26 23:33:01" (middle of history with gap)' \
+	'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' \
 	'rm -f o e
-	 git-rev-parse --verify "master@2005-05-26 23:33:01" >o 2>e &&
+	 git-rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
 	 test $B = $(cat o) &&
 	 test "warning: Log .git/logs/$m has gap after $gd." = "$(cat e)"'
 test_expect_success \
-	'Query "master@2005-05-26 23:33:01" (middle of history)' \
+	'Query "master@{2005-05-26 23:38:00}" (middle of history)' \
 	'rm -f o e
-	 git-rev-parse --verify "master@2005-05-26 23:38:00" >o 2>e &&
+	 git-rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
 	 test $Z = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
-	'Query "master@2005-05-26 23:43:00" (exact end of history)' \
+	'Query "master@{2005-05-26 23:43:00}" (exact end of history)' \
 	'rm -f o e
-	 git-rev-parse --verify "master@2005-05-26 23:43:00" >o 2>e &&
+	 git-rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
 	 test $E = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
-	'Query "master@2005-05-28" (past end of history)' \
+	'Query "master@{2005-05-28}" (past end of history)' \
 	'rm -f o e
-	 git-rev-parse --verify "master@2005-05-28" >o 2>e &&
+	 git-rev-parse --verify "master@{2005-05-28}" >o 2>e &&
 	 test $D = $(cat o) &&
 	 test "warning: Log .git/logs/$m unexpectedly ended on $ld." = "$(cat e)"'
 
+
+rm -f .git/$m .git/logs/$m expect
+
+test_expect_success \
+    'creating initial files' \
+    'cp ../../COPYING COPYING &&
+     git-add COPYING &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:30" git-commit -m add -a &&
+	 cp ../../Makefile COPYING &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:41" git-commit -m change -a'
+
+test_expect_success \
+	'git-cat-file blob master:COPYING (expect Makefile)' \
+	'git-cat-file blob master:COPYING | diff - ../../Makefile'
+test_expect_success \
+	'git-cat-file blob master@{2005-05-26 23:30}:COPYING (expect COPYING)' \
+	'git-cat-file blob "master@{2005-05-26 23:30}:COPYING" \
+	  | diff - ../../COPYING'
+test_expect_success \
+	'git-cat-file blob master@{2005-05-26 23:42}:COPYING (expect Makefile)' \
+	'git-cat-file blob "master@{2005-05-26 23:42}:COPYING" \
+	  | diff - ../../Makefile'
+
 test_done
-- 
1.3.2.g7278
