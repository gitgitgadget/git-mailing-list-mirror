From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-log: added --none-match option
Date: Tue, 06 Jan 2015 15:02:41 -0800
Message-ID: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
References: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
	<1420349268-13479-1-git-send-email-ottxor@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Junghans <ottxor@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 00:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8d9F-0008Fl-0J
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 00:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbbAFXCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 18:02:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750818AbbAFXCo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 18:02:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7850F2D11E;
	Tue,  6 Jan 2015 18:02:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCgHMyCUmd05qwhpCpSRpcUvZBs=; b=HLcCME
	AYtAHh4X7kTWYlJQEcwgxzFOBYAA1lRWOOwkw3IOoDZknVZH2XM73DJUV3sjpDQ/
	NfYgA495OMxZn/xtSTL7IK7UHvhZRIHi69Y9QssNWpuIYLwOhBK+wlzClYWlBfM0
	597mY/4Q2JPrKSWIukWwPWYFfvtDD+lPL4Qx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YdiK94NsKx5tu0twh/E5f0zvNWlySmGX
	+MSZFsi/NIIg5k9fHVWcl3rXLzn/ym5GDco0JtYhRmDdQdtQ+nkaaZGItemz5ZNw
	Tej7rap+QlpU6n6RCrmyrwKB32ed24Y0dBOs+ZHf0Q5hlHhkABWJF+HZu0BcF5wu
	Jzpm6y3wDis=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FE1B2D11D;
	Tue,  6 Jan 2015 18:02:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAE3B2D11C;
	Tue,  6 Jan 2015 18:02:42 -0500 (EST)
In-Reply-To: <1420349268-13479-1-git-send-email-ottxor@gentoo.org> (Christoph
	Junghans's message of "Sat, 3 Jan 2015 22:27:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1ECBEA84-95F8-11E4-96E9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262109>

Christoph Junghans <ottxor@gentoo.org> writes:

> Implements a inverted match for "git log", like in the case of
> "git grep -v", which is useful from time to time to e.g. filter
> FIXUP message out of "git log".
>
> Internally, a new bol 'none_match' has been introduces as
> revs->grep_filter.invert inverts the match line-wise, which cannot
> work as i.e. empty line always not match the pattern given.
>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---

The patch itself looks like a good start, except that the above
description no longer matches the implementation.

I further suspect it would be better to rename all_match to
all_or_none and then you can lose the "these two are mutually
incompatible" check that is placed together with a wrong existing
comment.  I also notice that you forgot to update the "git grep"
where the original "--all-match" came from.

A partial fix-up may start like this on top of your version.  By
renaming the variable used in the existing code, the compiler will
remind you that there are a few more places that your patch did not
touch that does something special for --all-match, which are a good
candidates you need to think if doing something similarly special
for the --none-match case is necessary.

Thanks.

diff --git a/builtin/grep.c b/builtin/grep.c
index 4063882..9ba4254 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -727,8 +727,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		  close_callback },
 		OPT__QUIET(&opt.status_only,
 			   N_("indicate hit with exit status without output")),
-		OPT_BOOL(0, "all-match", &opt.all_match,
-			N_("show only matches from files that match all patterns")),
+		OPT_SET_INT(0, "all-match", &opt.all_or_none,
+			    N_("show only matches from files that match all patterns"),
+			    GREP_ALL_MATCH),
+		OPT_SET_INT(0, "none-match", &opt.all_or_none,
+			    N_("show only matches from files that match no patterns"),
+			    GREP_NONE_MATCH),
 		{ OPTION_SET_INT, 0, "debug", &opt.debug, NULL,
 		  N_("show parse tree for grep expression"),
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1 },
diff --git a/grep.c b/grep.c
index f486ee5..1ff5dea 100644
--- a/grep.c
+++ b/grep.c
@@ -1622,14 +1622,18 @@ static int chk_hit_marker(struct grep_expr *x)
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs)
 {
-	if(opt->none_match)
-		return !grep_source_1(opt, gs, 0);
 	/*
 	 * we do not have to do the two-pass grep when we do not check
-	 * buffer-wide "all-match".
+	 * buffer-wide "all-match" or "none-match".
 	 */
-	if (!opt->all_match)
+	switch (opt->all_or_none) {
+	case GREP_ALL_MATCH:
 		return grep_source_1(opt, gs, 0);
+	case GREP_NONE_MATCH:
+		return !grep_source_1(opt, gs, 0);
+	default:
+		break;
+	}
 
 	/* Otherwise the toplevel "or" terms hit a bit differently.
 	 * We first clear hit markers from them.
diff --git a/grep.h b/grep.h
index 8e50c95..2cdabf2 100644
--- a/grep.h
+++ b/grep.h
@@ -101,8 +101,9 @@ struct grep_opt {
 	int count;
 	int word_regexp;
 	int fixed;
-	int all_match;
-	int none_match;
+#define GREP_ALL_MATCH 1
+#define GREP_NONE_MATCH 2
+	int all_or_none;
 	int debug;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
diff --git a/revision.c b/revision.c
index d43779e..b955848 100644
--- a/revision.c
+++ b/revision.c
@@ -2010,9 +2010,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--perl-regexp")) {
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
-		revs->grep_filter.all_match = 1;
+		revs->grep_filter.all_or_none = GREP_ALL_MATCH;
 	} else if (!strcmp(arg, "--none-match")) {
-		revs->grep_filter.none_match = 1;
+		revs->grep_filter.all_or_none = GREP_NONE_MATCH;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding = xstrdup(optarg);
@@ -2335,8 +2335,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		die("cannot combine --walk-reflogs with --graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
 		die("cannot use --grep-reflog without --walk-reflogs");
-	if (revs->grep_filter.all_match && revs->grep_filter.none_match)
-		die("cannot combine --all-match with --none-match");
 
 	return left;
 }
