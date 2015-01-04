From: Christoph Junghans <ottxor@gentoo.org>
Subject: [PATCH] git-log: added --none-match option
Date: Sat,  3 Jan 2015 22:27:48 -0700
Message-ID: <1420349268-13479-1-git-send-email-ottxor@gentoo.org>
References: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Christoph Junghans <ottxor@gentoo.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 04 06:28:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7dkH-0000iI-UA
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 06:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbbADF2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 00:28:52 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:55415 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbbADF2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 00:28:51 -0500
Received: from dev.gentoo.org:587 (unknown [50.130.223.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ottxor)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 99DEB3402C3;
	Sun,  4 Jan 2015 05:28:44 +0000 (UTC)
Received: by dev.gentoo.org:587 (sSMTP sendmail emulation); Sat, 03 Jan 2015 22:28:41 -0700
X-Mailer: git-send-email 2.0.5
In-Reply-To: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262002>

Implements a inverted match for "git log", like in the case of
"git grep -v", which is useful from time to time to e.g. filter
FIXUP message out of "git log".

Internally, a new bol 'none_match' has been introduces as
revs->grep_filter.invert inverts the match line-wise, which cannot
work as i.e. empty line always not match the pattern given.

Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
---
 Documentation/rev-list-options.txt     | 4 ++++
 contrib/completion/git-completion.bash | 2 +-
 grep.c                                 | 2 ++
 grep.h                                 | 1 +
 revision.c                             | 4 ++++
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index afccfdc..08e4ed8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -66,6 +66,10 @@ if it is part of the log message.
 	Limit the commits output to ones that match all given `--grep`,
 	instead of ones that match at least one.
 
+--none-match::
+	Limit the commits output to ones that do not match any of the 
+	given `--grep`, instead of ones that match at least one.
+
 -i::
 --regexp-ignore-case::
 	Match the regular expression limiting patterns without regard to letter
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 23988ec..b0720e9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1425,7 +1425,7 @@ __git_log_gitk_options="
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
 	--author= --committer= --grep=
-	--all-match
+	--all-match --none-match
 "
 
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
diff --git a/grep.c b/grep.c
index 6e085f8..eadf8d9 100644
--- a/grep.c
+++ b/grep.c
@@ -1622,6 +1622,8 @@ static int chk_hit_marker(struct grep_expr *x)
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs)
 {
+  	if(opt->none_match)
+		return !grep_source_1(opt, gs, 0);	
 	/*
 	 * we do not have to do the two-pass grep when we do not check
 	 * buffer-wide "all-match".
diff --git a/grep.h b/grep.h
index 95f197a..8e50c95 100644
--- a/grep.h
+++ b/grep.h
@@ -102,6 +102,7 @@ struct grep_opt {
 	int word_regexp;
 	int fixed;
 	int all_match;
+	int none_match;
 	int debug;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
diff --git a/revision.c b/revision.c
index 75dda92..d43779e 100644
--- a/revision.c
+++ b/revision.c
@@ -2011,6 +2011,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
+	} else if (!strcmp(arg, "--none-match")) {
+		revs->grep_filter.none_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding = xstrdup(optarg);
@@ -2333,6 +2335,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die("cannot combine --walk-reflogs with --graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
+	if (revs->grep_filter.all_match && revs->grep_filter.none_match)
+		die("cannot combine --all-match with --none-match");
 
 	return left;
 }
-- 
2.0.5
