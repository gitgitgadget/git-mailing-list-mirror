From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] branch --merged/--not-merged: allow specifying arbitrary
 commit
Date: Tue, 08 Jul 2008 18:22:10 -0700
Message-ID: <7vmykronr1.fsf_-_@gitster.siamese.dyndns.org>
References: <7v8wwcx446.fsf@gitster.siamese.dyndns.org>
 <20080708101452.GB19202@artemis.madism.org>
 <20080708103408.GC19202@artemis.madism.org>
 <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 03:24:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGOPd-0002jl-FM
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 03:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbYGIBWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 21:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbYGIBWY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 21:22:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYGIBWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 21:22:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F3F8C16E29;
	Tue,  8 Jul 2008 21:22:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9866A16E26; Tue,  8 Jul 2008 21:22:18 -0400 (EDT)
In-Reply-To: <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 08 Jul 2008 18:15:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7B75FDF8-4D55-11DD-B2A5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87828>

"git-branch --merged" is a handy way to list all the branches that have
already been merged to the current branch, but it did not allow checking
against anything but the current branch.  Having to check out only for
that purpose made the command practically useless.

This updates the option parser so that "git branch --merged next" is
accepted when you are on 'master' branch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This does have an issue.  --no-<option>=<value> is often nonsense and
   parse-options does not accept it (and I do not think we would want to
   change it).  The use of "--no-merged" was a mistake, but nobody has
   perfect foresight.

   This adds --not-merged <commit> and allows the <commit> to default to
   HEAD if not given to work it around.  This and the previous one are not
   for application but primarily meant for discussion on what further
   flexibility we may want to have in parse-options.

 builtin-branch.c |   50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 375e5e0..151f519 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -46,7 +46,12 @@ enum color_branch {
 	COLOR_BRANCH_CURRENT = 4,
 };
 
-static int mergefilter = -1;
+static enum merge_filter {
+	NO_FILTER = 0,
+	SHOW_NOT_MERGED,
+	SHOW_MERGED,
+} merge_filter;
+static unsigned char merge_filter_ref[20];
 
 static int parse_branch_color_slot(const char *var, int ofs)
 {
@@ -234,13 +239,15 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	if (mergefilter > -1) {
+	if (merge_filter != NO_FILTER) {
 		branch.item = lookup_commit_reference_gently(sha1, 1);
 		if (!branch.item)
 			die("Unable to lookup tip of branch %s", refname);
-		if (mergefilter == 0 && has_commit(head_sha1, &branch))
+		if (merge_filter == SHOW_NOT_MERGED &&
+		    has_commit(merge_filter_ref, &branch))
 			return 0;
-		if (mergefilter == 1 && !has_commit(head_sha1, &branch))
+		if (merge_filter == SHOW_MERGED &&
+		    !has_commit(merge_filter_ref, &branch))
 			return 0;
 	}
 
@@ -421,6 +428,20 @@ static int opt_parse_with_commit(const struct option *opt, const char *arg, int
 	return 0;
 }
 
+static int opt_parse_merge_filter(const struct option *opt, const char *arg, int unset)
+{
+	merge_filter = ((opt->long_name[0] == 'n')
+			? SHOW_NOT_MERGED
+			: SHOW_MERGED);
+	if (unset)
+		merge_filter = SHOW_NOT_MERGED; /* b/c for --no-merged */
+	if (!arg)
+		arg = "HEAD";
+	if (get_sha1(arg, merge_filter_ref))
+		die("malformed object name %s", arg);
+	return 0;
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
@@ -461,7 +482,18 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT_BOOLEAN('f', NULL, &force_create, "force creation (when already exists)"),
-		OPT_SET_INT(0, "merged", &mergefilter, "list only merged branches", 1),
+		{
+			OPTION_CALLBACK, 0, "merged", &merge_filter_ref,
+			"commit", "print only merged branches",
+			PARSE_OPT_FAKELASTARG,
+			opt_parse_merge_filter, (intptr_t) "HEAD",
+		},
+		{
+			OPTION_CALLBACK, 0, "not-merged", &merge_filter_ref,
+			"commit", "print only not merged branches",
+			PARSE_OPT_FAKELASTARG,
+			opt_parse_merge_filter, (intptr_t) "HEAD",
+		},
 		OPT_END(),
 	};
 
@@ -471,9 +503,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		branch_use_color = git_use_color_default;
 
 	track = git_branch_track;
-	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
-	if (!!delete + !!rename + !!force_create > 1)
-		usage_with_options(builtin_branch_usage, options);
 
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
 	if (!head)
@@ -486,6 +515,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die("HEAD not found below refs/heads!");
 		head += 11;
 	}
+	hashcpy(merge_filter_ref, head_sha1);
+
+	argc = parse_options(argc, argv, options, builtin_branch_usage, 0);
+	if (!!delete + !!rename + !!force_create > 1)
+		usage_with_options(builtin_branch_usage, options);
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-- 
1.5.6.2.255.gbed62
