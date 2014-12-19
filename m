From: Christoph Junghans <ottxor@gentoo.org>
Subject: [PATCH] git-log: added --invert-grep option
Date: Thu, 18 Dec 2014 19:14:10 -0700
Message-ID: <1418955250-22402-1-git-send-email-ottxor@gentoo.org>
Cc: git@vger.kernel.org, Christoph Junghans <ottxor@gentoo.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 19 03:15:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1n5o-0007Xv-Si
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 03:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbaLSCOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 21:14:52 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:51444 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbaLSCOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 21:14:48 -0500
Received: from dev.gentoo.org:587 (unknown [199.229.237.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ottxor)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9285F340681;
	Fri, 19 Dec 2014 02:14:45 +0000 (UTC)
Received: by dev.gentoo.org:587 (sSMTP sendmail emulation); Thu, 18 Dec 2014 19:14:47 -0700
X-Mailer: git-send-email 2.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261547>

Implements a inverted match for "git log", like in the case of
"git grep -v", which is useful from time to time to e.g. filter
FIXUP message out of "git log".

Internally, a new bol 'global_invert' has been introduces as
revs->grep_filter.invert inverts the match line-wise, which cannot
work as i.e. empty line always not match the pattern given.

Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
---
 Documentation/rev-list-options.txt     | 4 ++++
 contrib/completion/git-completion.bash | 2 +-
 grep.h                                 | 3 ++-
 revision.c                             | 4 +++-
 4 files changed, 10 insertions(+), 3 deletions(-)

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
index 2fece98..914c317 100644
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
diff --git a/grep.h b/grep.h
index 95f197a..c137103 100644
--- a/grep.h
+++ b/grep.h
@@ -93,7 +93,8 @@ struct grep_opt {
 	int prefix_length;
 	regex_t regexp;
 	int linenum;
-	int invert;
+	int invert; /** line-wise invert match */
+	int global_invert; /** final global invert match */
 	int ignore_case;
 	int status_only;
 	int name_only;
diff --git a/revision.c b/revision.c
index 75dda92..c8d4c49 100644
--- a/revision.c
+++ b/revision.c
@@ -2011,6 +2011,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
+	} else if (!strcmp(arg, "--invert-grep")) {
+		revs->grep_filter.global_invert = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding = xstrdup(optarg);
@@ -2909,7 +2911,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 				     (char *)message, strlen(message));
 	strbuf_release(&buf);
 	unuse_commit_buffer(commit, message);
-	return retval;
+	return opt->grep_filter.global_invert ? !retval : retval;
 }
 
 static inline int want_ancestry(const struct rev_info *revs)
-- 
2.0.4
