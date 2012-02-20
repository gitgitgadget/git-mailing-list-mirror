From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/5] diff -i
Date: Sun, 19 Feb 2012 23:36:38 -0800
Message-ID: <7vzkcelzw9.fsf@alter.siamese.dyndns.org>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 08:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzNnr-00064C-FY
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 08:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab2BTHgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 02:36:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab2BTHgl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 02:36:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D070236E2;
	Mon, 20 Feb 2012 02:36:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fb5JSSiraSt3OqKrtOUNffMZYQ8=; b=PKybld
	TI+kjLC9shZmEDUdEAWbZDy3CtWRVhEm5TdMhVyEGTETLrRKAg8UI2BCROEkFQnq
	Av3IlZm421AjGYuTxdx4sAHDCHbFd+V7wnhcAHtj7aIxiW1ICfg+mrlk1oHln+ZE
	oHl+4cMpldtVd6OKmO1mlS8ORwRgIB2PkDfws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lpJiRy2qGVUfpQ0SeaYBix6SqGefexhE
	L/jBhI2vD1ESjrOjVdZpo+gh/JMivb6DRep6Ip0eGmdlDXBfAi4ZrB3N0TDF6eXj
	rJo3UZz0Yj94oUAQ61l0pQsCfWGzsGAMjBM/Sm4leWURJceHvkyvIoa1b0jZJPNP
	svAxY09H7HQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C862836E1;
	Mon, 20 Feb 2012 02:36:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 265D936E0; Mon, 20 Feb 2012
 02:36:40 -0500 (EST)
In-Reply-To: <1329704188-9955-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Sun, 19 Feb 2012 18:16:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0AB696C-5B95-11E1-9AD9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191048>

The previous patch to teach "--ignore-case" option to our "diff" machinery
deliberately omitted a short-and-sweet "-i" that GNU diff uses to ask for
"--ignore-case".  This is because our diff machinery are often used by and
shares the command line options with the commands in the "git log" family,
where the short option already means something entirely different. Namely,
it instructs to use case-insensitive match when looking for commits that
match information that appear in the commit object itself, e.g. --author
and --grep.

Tweak the option parser so that "-i" means both, so that

	$ git log --grep=frotz -i -p

first picks commits that have string "frotz" in any combination of cases,
and then shows patches that ignore case-only changes for the chosen
commits, while "--ignore-case" and "--regexp-ignore-case" can be used to
mean only one, i.e.

	$ git log --grep=frotz --regexp-ignore-case -p

would pick the same set of commits, but the patches shown by it does not
ignore case-only changes while

	$ git log --grep=frotz --ignore-case -p

would pick commits that has "frotz" in all lowercase, but shows patches
that ignore case-only changes for the chosen commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |    1 +
 diff.c                         |    2 +-
 revision.c                     |    6 +++++-
 t/lib-diff-alternative.sh      |    3 ++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 791e07f..9ed78c9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -404,6 +404,7 @@ endif::git-format-patch[]
 	differences even if one line has whitespace where the other
 	line has none.
 
+-i::
 --ignore-case::
 	Ignore changes in case only; only ASCII alphabet is supported for
 	now.
diff --git a/diff.c b/diff.c
index d7604b7..9d1584e 100644
--- a/diff.c
+++ b/diff.c
@@ -3399,7 +3399,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
-	else if (!strcmp(arg, "--ignore-case"))
+	else if (!strcmp(arg, "--ignore-case") || !strcmp(arg, "-i"))
 		DIFF_XDL_SET(options, IGNORE_CASE);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
diff --git a/revision.c b/revision.c
index 8764dde..f1a1354 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "xdiff-interface.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -1557,7 +1558,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return argcount;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		revs->grep_filter.regflags |= REG_EXTENDED;
-	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
+	} else if (!strcmp(arg, "-i")) {
+		DIFF_XDL_SET(&revs->diffopt, IGNORE_CASE);
+		revs->grep_filter.regflags |= REG_ICASE;
+	} else if (!strcmp(arg, "--regexp-ignore-case")) {
 		revs->grep_filter.regflags |= REG_ICASE;
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.fixed = 1;
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 45c665e..81609f8 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -175,9 +175,10 @@ test_diff_ignore () {
 	echo " A quick brownfox" >test-w
 	echo "A quick brown fox " >test--ignore-space-at-eol
 	echo "A Quick Brown Fox" >test--ignore-case
+	echo "A Quick Brown FoX" >test-i
 	echo "A Quick  Brown Fox" >test--ignore-case-b
 	echo "A quick brown fox jumps" >test
-	cases="-b -w --ignore-space-at-eol --ignore-case"
+	cases="-b -w --ignore-space-at-eol --ignore-case -i"
 
 	if test -z "$STRATEGY"
 	then
