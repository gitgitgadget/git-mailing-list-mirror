From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD PATCH] revlist/rev-parse: Introduce --heads and --locals revision specifiers
Date: Sat,  1 May 2010 20:36:33 +0200
Message-ID: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 20:36:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8HYO-0000Zc-Rj
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 20:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272Ab0EASgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 14:36:35 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38613 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755504Ab0EASgf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 14:36:35 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4C29FF1E05
	for <git@vger.kernel.org>; Sat,  1 May 2010 14:36:34 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 01 May 2010 14:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=1NYFxeMz32EYe0HRH6oITFaRUUo=; b=oexvRzOc5K+YJvcXocSxAj78epBfhh/uxe3Q4YhKZwZKcHD23YHaSAjYVJonQoZhTSbIR0DgiVToYfzsk8c+s3keo0V8gdFL1uoojXJjaKWhb2HA08Y3GU5KNceiJL62GA3br4kSlcehaoLOYRsUMR5oeSh7Y4M9KOEPztMCN8c=
X-Sasl-enc: U4P9T8luSxmIIoz8w7c8+t0ZbtgLA4SrYv43n0YYPIoY 1272738993
Received: from localhost (p5DCC08EA.dip0.t-ipconnect.de [93.204.8.234])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 46134188BE;
	Sat,  1 May 2010 14:36:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.328.g9993c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146108>

Due to the increasing usage of the ref namespace (e.g. notes, replace)
the revision specifier "--all" becomes decreasingly useful. But
"something like --all" is ineeded for getting a quick overview of
the development state of a repository.

Introduce --heads and --locals specifiers in order to help with that:

--heads == HEAD --branches --remotes
--locals = HEAD --branches --tags

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
RFD for several reasons:

- It's incredibly useful, I want it - do others? ;)
- names of the options (let the bikeshedding begin)
- should rev-parse include HEAD?
- tests and doc, of course

rev-parse does not include HEAD even with --all, but rev-list does.
The patch keeps with that tradition (the commit message does not quite
convey this). I don't feel it's a good one. Cleaning that up
requires more work, though.

 builtin/rev-list.c  |    2 ++
 builtin/rev-parse.c |   12 ++++++++++++
 revision.c          |   12 ++++++++++++
 3 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 51ceb19..fb8208c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,9 @@ static const char rev_list_usage[] =
 "    --all\n"
 "    --branches\n"
 "    --tags\n"
+"    --locals\n"
 "    --remotes\n"
+"    --heads\n"
 "    --stdin\n"
 "    --quiet\n"
 "  ordering output:\n"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8fbf9d0..c739479 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -44,6 +44,8 @@ static int is_rev_argument(const char *arg)
 		"--branches=",
 		"--branches",
 		"--header",
+		"--heads",
+		"--locals",
 		"--max-age=",
 		"--max-count=",
 		"--min-age=",
@@ -598,6 +600,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_tag_ref(show_reference, NULL);
 				continue;
 			}
+			if (!strcmp(arg, "--locals")) {
+				for_each_branch_ref(show_reference, NULL);
+				for_each_tag_ref(show_reference, NULL);
+				continue;
+			}
 			if (!prefixcmp(arg, "--glob=")) {
 				for_each_glob_ref(show_reference, arg + 7, NULL);
 				continue;
@@ -611,6 +618,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				for_each_remote_ref(show_reference, NULL);
 				continue;
 			}
+			if (!strcmp(arg, "--heads")) {
+				for_each_branch_ref(show_reference, NULL);
+				for_each_remote_ref(show_reference, NULL);
+				continue;
+			}
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = get_git_work_tree();
 				if (work_tree)
diff --git a/revision.c b/revision.c
index f4b8b38..04f9be7 100644
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
+			if (!strcmp(arg, "--heads")) {
+				handle_refs(revs, flags, for_each_remote_ref);
+				handle_refs(revs, flags, for_each_branch_ref);
+				handle_refs(revs, flags, head_ref);
+				continue;
+			}
 			if (!prefixcmp(arg, "--glob=")) {
 				struct all_refs_cb cb;
 				init_all_refs_cb(&cb, revs, flags);
-- 
1.7.1.328.g9993c
