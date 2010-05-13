From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/4] revlist: Introduce --lrbranches and --locals revision specifiers
Date: Thu, 13 May 2010 16:24:38 +0200
Message-ID: <5902e4803a6dcd7cc5911c142dc8c0bca5d2dc55.1273760226.git.git@drmicha.warpmail.net>
References: <20100505033536.GB8779@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 16:25:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZLQ-0006Qf-Dd
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325Ab0EMOYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:24:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49104 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758310Ab0EMOYs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 10:24:48 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DFD03F5FF6;
	Thu, 13 May 2010 10:24:47 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 13 May 2010 10:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=UOnQYuwuywMOq18fQLtzLavGRPs=; b=gz88er3Lw64wxCev43VA6cm9fQSz7Fu3k5yV/imTbaW/bPd8I/4N/L1N+MYXY5Cez09HmhtR9GBPLiq0kyTj0V5InTJhb30KJW7sbwSFswWpEj2n17VNYoFz3BDHYy4ltmvw88PhmIFpJT011//fjvoIDNICoGWqhztNXq8C6nQ=
X-Sasl-enc: jafJnb2TqC99XE9BNAoeZKdGidzgDXIYldvIqZcqhv9J 1273760686
Received: from localhost (p54859DBB.dip0.t-ipconnect.de [84.133.157.187])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AB6C354683;
	Thu, 13 May 2010 10:24:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <20100505033536.GB8779@coredump.intra.peff.net>
In-Reply-To: <cover.1273760226.git.git@drmicha.warpmail.net>
References: <cover.1273760226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147013>

Due to the increasing usage of the ref namespace (e.g. notes, replace)
the revision specifier "--all" becomes decreasingly useful. But
"something like --all" is needed for getting a quick overview of
the development state of a repository.

Introduce --lrbranches and --locals specifiers in order to help with that:

--lrbranches == HEAD --branches --remotes
--locals = HEAD --branches --tags

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-rev-list.txt     |    2 ++
 Documentation/rev-list-options.txt |    8 ++++++++
 builtin/rev-list.c                 |    2 ++
 revision.c                         |   12 ++++++++++++
 t/t6018-rev-list-glob.sh           |   12 ++++++++----
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 173f3fc..81d67da 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -25,6 +25,8 @@ SYNOPSIS
 	     [ \--tags[=pattern] ]
 	     [ \--remotes[=pattern] ]
 	     [ \--glob=glob-pattern ]
+	     [ \--locals ]
+	     [ \--lrbranches ]
 	     [ \--stdin ]
 	     [ \--quiet ]
 	     [ \--topo-order ]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b9fb7a8..21c0c93 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -264,6 +264,14 @@ endif::git-rev-list[]
 	is automatically prepended if missing. If pattern lacks '?', '*',
 	or '[', '/*' at the end is implied.
 
+--locals::
+	This is an abbreviation for `HEAD --branches --tags`, i.e. all
+	local refs.
+
+--lrbranches::
+
+	This is an abbreviation for `HEAD --branches --remotes`, i.e. all
+	local and remote branch heads plus HEAD.
 
 ifndef::git-rev-list[]
 --bisect::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 51ceb19..50664b7 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,9 @@ static const char rev_list_usage[] =
 "    --all\n"
 "    --branches\n"
 "    --tags\n"
+"    --locals\n"
 "    --remotes\n"
+"    --lrbranches\n"
 "    --stdin\n"
 "    --quiet\n"
 "  ordering output:\n"
diff --git a/revision.c b/revision.c
index f4b8b38..5067fce 100644
--- a/revision.c
+++ b/revision.c
@@ -1399,10 +1399,22 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				handle_refs(revs, flags, for_each_tag_ref);
 				continue;
 			}
+			if (!strcmp(arg, "--locals")) {
+				handle_refs(revs, flags, for_each_branch_ref);
+				handle_refs(revs, flags, for_each_tag_ref);
+				handle_refs(revs, flags, head_ref);
+				continue;
+			}
 			if (!strcmp(arg, "--remotes")) {
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
+			if (!strcmp(arg, "--lrbranches")) {
+				handle_refs(revs, flags, for_each_remote_ref);
+				handle_refs(revs, flags, for_each_branch_ref);
+				handle_refs(revs, flags, head_ref);
+				continue;
+			}
 			if (!prefixcmp(arg, "--glob=")) {
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index a1320aa..fd77fe5 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -207,15 +207,19 @@ test_expect_success 'rev-list --remotes=foo' '
 
 '
 
-test_expect_success 'rev-list --locals' '
+test_expect_success 'rev-list --no-walk --locals' '
 
-	compare rev-list "master subspace-x someref other/three subspace/one subspace/two" "--localss"
+	compare "rev-list --no-walk" \
+	"master subspace-x someref other/three subspace/one subspace/two foo/bar" \
+	"--locals"
 
 '
 
-test_expect_success 'rev-list --lrbranches' '
+test_expect_success 'rev-list --no-walk --lrbranches' '
 
-	compare rev-list "master subspace-x someref other/three subspace/one subspace/two" "--lrbranches"
+	compare "rev-list --no-walk" \
+	"master subspace-x someref other/three subspace/one subspace/two foo/baz" \
+	"--lrbranches"
 
 '
 
-- 
1.7.1.240.geeaa4d
