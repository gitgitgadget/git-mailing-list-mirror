From: Christoph Junghans <ottxor@gentoo.org>
Subject: [PATCH v2] log: teach --invert-grep option
Date: Mon, 12 Jan 2015 18:33:32 -0700
Message-ID: <1421112812-13578-1-git-send-email-ottxor@gentoo.org>
References: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Christoph Junghans <ottxor@gentoo.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 13 02:33:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAqMZ-0004Mk-2i
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbbAMBdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:33:39 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:53892 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbbAMBdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:33:38 -0500
Received: from dev.gentoo.org:587 (unknown [50.130.223.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ottxor)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4BB05340688;
	Tue, 13 Jan 2015 01:33:36 +0000 (UTC)
Received: by dev.gentoo.org:587 (sSMTP sendmail emulation); Mon, 12 Jan 2015 18:33:34 -0700
X-Mailer: git-send-email 2.0.5
In-Reply-To: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262313>

"git log --grep=<string>" shows only commits with messages that
match the given string, but sometimes it is useful to be able to
show only commits that do *not* have certain messages (e.g. "show
me ones that are not FIXUP commits").

Originally, we had the invert-grep flag in grep_opt, but because
"git grep --invert-grep" does not make sense except in conjunction
with "--files-with-matches", which is already covered by
"--files-without-matches", it was moved it to revisions structure.
To have the flag there expresses the function to the feature better.

When the newly inserted two tests run, the history would have commits
with messages "initial", "second", "third", "fourth", "fifth", "sixth"
and "Second", committed in this order.  The commits that does not match
either "th" or "Sec" is "second" and "initial". For the case insensitive
case only "initial" matches.

Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
---
 Documentation/rev-list-options.txt     |  4 ++++
 contrib/completion/git-completion.bash |  2 +-
 gitk-git/gitk                          |  1 +
 revision.c                             |  4 +++-
 revision.h                             |  2 ++
 t/t4202-log.sh                         | 15 +++++++++++++++
 6 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index afccfdc..6d4671f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -66,6 +66,10 @@ if it is part of the log message.
 	Limit the commits output to ones that match all given `--grep`,
 	instead of ones that match at least one.
 
+--invert-grep::
+	Limit the commits output to ones with log message that do not
+	match the pattern specified with `--grep=<pattern>`.
+
 -i::
 --regexp-ignore-case::
 	Match the regular expression limiting patterns without regard to letter
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cd76579..aaeac50 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1425,7 +1425,7 @@ __git_log_gitk_options="
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
 	--author= --committer= --grep=
-	--all-match
+	--all-match --invert-grep
 "
 
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 78358a7..5a78432 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3977,6 +3977,7 @@ set known_view_options {
     {committer t15  .  "--committer=*"  {mc "Committer:"}}
     {loginfo   t15  .. "--grep=*"       {mc "Commit Message:"}}
     {allmatch  b    .. "--all-match"    {mc "Matches all Commit Info criteria"}}
+    {igrep     b    .. "--invert-grep"  {mc "Matches none Commit Info criteria"}}
     {changes_l l    +  {}               {mc "Changes to Files:"}}
     {pickaxe_s r0   .  {}               {mc "Fixed String"}}
     {pickaxe_t r1   .  "--pickaxe-regex"  {mc "Regular Expression"}}
diff --git a/revision.c b/revision.c
index 14e0e03..4d03338 100644
--- a/revision.c
+++ b/revision.c
@@ -2011,6 +2011,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
+	} else if (!strcmp(arg, "--invert-grep")) {
+		revs->invert_grep = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding = xstrdup(optarg);
@@ -2909,7 +2911,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 				     (char *)message, strlen(message));
 	strbuf_release(&buf);
 	unuse_commit_buffer(commit, message);
-	return retval;
+	return opt->invert_grep ? !retval : retval;
 }
 
 static inline int want_ancestry(const struct rev_info *revs)
diff --git a/revision.h b/revision.h
index 9cb5adc..bc27098 100644
--- a/revision.h
+++ b/revision.h
@@ -168,6 +168,8 @@ struct rev_info {
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
+	/* Negate the match of grep_filter */
+	int invert_grep;
 
 	/* Display history graph */
 	struct git_graph *graph;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 99ab7ca..5f2b290 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -212,6 +212,21 @@ test_expect_success 'log --grep' '
 	test_cmp expect actual
 '
 
+cat > expect << EOF
+second
+initial
+EOF
+test_expect_success 'log --invert-grep --grep' '
+	git log --pretty="tformat:%s" --invert-grep --grep=th --grep=Sec >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --invert-grep --grep -i' '
+	echo initial >expect &&
+	git log --pretty="tformat:%s" --invert-grep -i --grep=th --grep=Sec >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --grep option parsing' '
 	echo second >expect &&
 	git log -1 --pretty="tformat:%s" --grep sec >actual &&
-- 
2.0.5
