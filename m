From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 07/10] push: use same rules as git-rev-parse to resolve refspecs
Date: Sun, 28 Oct 2007 18:46:18 +0100
Message-ID: <11935935823045-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de>
 <1193593581486-git-send-email-prohaska@zib.de>
 <11935935812185-git-send-email-prohaska@zib.de>
 <11935935822846-git-send-email-prohaska@zib.de>
 <11935935821136-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCI7-0000ou-2z
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbXJ1RuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbXJ1RuB
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:50:01 -0400
Received: from mailer.zib.de ([130.73.108.11]:63841 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMQL016200
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsb019730;
	Sun, 28 Oct 2007 18:46:22 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935935821136-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62583>

This commit changes the rules for resolving refspecs to match the
rules for resolving refs in rev-parse. git-rev-parse uses clear rules
to resolve a short ref to its full name, which are well documented.
The rules for resolving refspecs documented in git-send-pack were
less strict and harder to understand. This commit replaces them by
the rules of git-rev-parse.

The unified rules are easier to understand and better resolve ambiguous
cases. You can now push from a repository containing several branches
ending on the same short name.

Note, this may break existing setups. For example "master" will no longer
resolve to "origin/master".

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-send-pack.txt |    4 +++-
 remote.c                        |    5 +----
 t/t5516-fetch-push.sh           |   12 +++++++++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 01495df..08bcc25 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -91,7 +91,9 @@ Each pattern pair consists of the source side (before the colon)
 and the destination side (after the colon).  The ref to be
 pushed is determined by finding a match that matches the source
 side, and where it is pushed is determined by using the
-destination side.
+destination side. The rules used to match a ref are the same
+rules used by gitlink:git-rev-parse[1] to resolve a symbolic ref
+name.
 
  - It is an error if <src> does not match exactly one of the
    local refs.
diff --git a/remote.c b/remote.c
index 59e6485..9c33fcf 100644
--- a/remote.c
+++ b/remote.c
@@ -519,10 +519,7 @@ static int count_refspec_match(const char *pattern,
 		char *name = refs->name;
 		int namelen = strlen(name);
 
-		if (namelen < patlen ||
-		    memcmp(name + namelen - patlen, pattern, patlen))
-			continue;
-		if (namelen != patlen && name[namelen - patlen - 1] != '/')
+		if (ref_abbrev_matches_full_with_rev_parse_rules(pattern, name))
 			continue;
 
 		/* A match is "weak" if it is with refs outside
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2650e36..6708ec1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -183,11 +183,21 @@ test_expect_success 'push with no ambiguity (1)' '
 test_expect_success 'push with no ambiguity (2)' '
 
 	mk_test remotes/origin/master &&
-	git push testrepo master:master &&
+	git push testrepo master:origin/master &&
 	check_push_result $the_commit remotes/origin/master
 
 '
 
+test_expect_success 'push with colon-less refspec, no ambiguity' '
+
+	mk_test heads/master heads/t/master &&
+	git branch -f t/master master &&
+	git push testrepo master &&
+	check_push_result $the_commit heads/master &&
+	check_push_result $the_first_commit heads/t/master
+
+'
+
 test_expect_success 'push with weak ambiguity (1)' '
 
 	mk_test heads/master remotes/origin/master &&
-- 
1.5.3.4.439.ge8b49
