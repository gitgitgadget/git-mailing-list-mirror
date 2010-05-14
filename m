From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 4/4] revlist: Introduce --lrbranches and --locals revision specifiers
Date: Fri, 14 May 2010 20:26:52 +0200
Message-ID: <fdf65c08ac42e4e9123d53a96f2fe49d7bdfd5db.1273861341.git.git@drmicha.warpmail.net>
References: <4BED7574.4070503@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 20:27:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCzbP-00071C-Gg
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 20:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab0ENS1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 14:27:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38628 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754025Ab0ENS1A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 14:27:00 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CD7EFF792E;
	Fri, 14 May 2010 14:26:59 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 14 May 2010 14:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=8elyM0PX+poLV0Njqd7SmHC8UsI=; b=WVE23HcAJHb0uxON32y5obljYtCeg/hb+XUYWFyqflqUPJ0k2EREYzn+UafSxUktwRA0i8n5YJUuikFyG/Gr4cWn89yEHJGTeoTdYripK7QhOZXi1r4fRweFNVRMrWHYR26voCaboX8+eAIJMV6ZL0FuIzfRlsLEyyzsH6+oBAs=
X-Sasl-enc: qKGRvW8946Ly38HUhglcyhNcL0VLpkkQyNGbPpVXT//v 1273861618
Received: from localhost (p5485982A.dip0.t-ipconnect.de [84.133.152.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AC3074C2143;
	Fri, 14 May 2010 14:26:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <4BED7574.4070503@drmicha.warpmail.net>
In-Reply-To: <cover.1273861341.git.git@drmicha.warpmail.net>
References: <cover.1273861341.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147109>

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
 t/t6018-rev-list-glob.sh           |   16 ++++++++++++++++
 5 files changed, 40 insertions(+), 0 deletions(-)

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
index 58428d9..fd77fe5 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -207,4 +207,20 @@ test_expect_success 'rev-list --remotes=foo' '
 
 '
 
+test_expect_success 'rev-list --no-walk --locals' '
+
+	compare "rev-list --no-walk" \
+	"master subspace-x someref other/three subspace/one subspace/two foo/bar" \
+	"--locals"
+
+'
+
+test_expect_success 'rev-list --no-walk --lrbranches' '
+
+	compare "rev-list --no-walk" \
+	"master subspace-x someref other/three subspace/one subspace/two foo/baz" \
+	"--lrbranches"
+
+'
+
 test_done
-- 
1.7.1.240.geeaa4d
