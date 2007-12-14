From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use the pager when running "git diff --check"
Date: Thu, 13 Dec 2007 23:33:30 -0800
Message-ID: <7vy7bxu3w5.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-2-git-send-email-win@wincent.com>
	<1197575138-58070-1-git-send-email-win@wincent.com>
	<20071214045127.GC10169@sigill.intra.peff.net>
	<7vmysdx3la.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:34:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3545-0000nT-4W
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbXLNHeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 02:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbXLNHeK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:34:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbXLNHeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 02:34:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 720B387BF;
	Fri, 14 Dec 2007 02:34:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 816F587BD;
	Fri, 14 Dec 2007 02:33:37 -0500 (EST)
In-Reply-To: <7vmysdx3la.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 13 Dec 2007 21:11:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68255>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, there is no reason to make --check and --exit-code mutually
> exclusive either.

Perhaps something like this.  Regardless of the exclusivity issue, I
think the "diff_result_code()" helper function is a good clean-up.

---
 builtin-diff-files.c       |    6 +-----
 builtin-diff-index.c       |    6 +-----
 builtin-diff-tree.c        |    6 ++----
 builtin-diff.c             |   11 ++++-------
 diff.c                     |   19 ++++++++++++++-----
 diff.h                     |    2 ++
 t/t4015-diff-whitespace.sh |    4 ++--
 7 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 4afc872..9c04111 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -31,9 +31,5 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	result = run_diff_files_cmd(&rev, argc, argv);
-	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
-		return DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
-	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
-		return DIFF_OPT_TST(&rev.diffopt, CHECK_FAILED) != 0;
-	return result;
+	return diff_result_code(&rev.diffopt, result);
 }
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 532b284..0f2390a 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -44,9 +44,5 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		return -1;
 	}
 	result = run_diff_index(&rev, cached);
-	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
-		return DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
-	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
-		return DIFF_OPT_TST(&rev.diffopt, CHECK_FAILED) != 0;
-	return result;
+	return diff_result_code(&rev.diffopt, result);
 }
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 9ab90cb..ebc50ef 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -132,8 +132,6 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 				diff_tree_stdin(line);
 		}
 	}
-	if (opt->diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
-		return DIFF_OPT_TST(&opt->diffopt, CHECK_FAILED) != 0;
-	return DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS)
-		&& DIFF_OPT_TST(&opt->diffopt, HAS_CHANGES);
+
+	return diff_result_code(&opt->diffopt, 0);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index 9d878f6..29365a0 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -244,11 +244,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
-	/* If the user asked for our exit code then don't start a
+	/*
+	 * If the user asked for our exit code then don't start a
 	 * pager or we would end up reporting its exit code instead.
 	 */
-	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS) &&
-	    (!(rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)))
+	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
 		setup_pager();
 
 	/* Do we have --cached and not have a pending object, then
@@ -352,10 +352,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	else
 		result = builtin_diff_combined(&rev, argc, argv,
 					     ent, ents);
-	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
-		result = DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
-	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
-		return DIFF_OPT_TST(&rev.diffopt, CHECK_FAILED) != 0;
+	result = diff_result_code(&rev.diffopt, result);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	return result;
diff --git a/diff.c b/diff.c
index 8237075..3e46ff8 100644
--- a/diff.c
+++ b/diff.c
@@ -2125,12 +2125,7 @@ int diff_setup_done(struct diff_options *options)
 	if (options->output_format & DIFF_FORMAT_NAME_STATUS)
 		count++;
 	if (options->output_format & DIFF_FORMAT_CHECKDIFF)
-	{
 		count++;
-		if (DIFF_OPT_TST(options, QUIET) ||
-		    DIFF_OPT_TST(options, EXIT_WITH_STATUS))
-			die("--check may not be used with --quiet or --exit-code");
-	}
 	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
 		count++;
 	if (count > 1)
@@ -3180,6 +3175,20 @@ void diffcore_std(struct diff_options *options)
 		DIFF_OPT_CLR(options, HAS_CHANGES);
 }
 
+int diff_result_code(struct diff_options *opt, int status)
+{
+	int result = 0;
+	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
+	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
+		return status;
+	if (DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
+	    DIFF_OPT_TST(opt, HAS_CHANGES))
+		result |= 01;
+	if ((opt->output_format & DIFF_FORMAT_CHECKDIFF) &&
+	    DIFF_OPT_TST(opt, CHECK_FAILED))
+		result |= 02;
+	return result;
+}
 
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
diff --git a/diff.h b/diff.h
index 5d50d93..7e8000a 100644
--- a/diff.h
+++ b/diff.h
@@ -247,4 +247,6 @@ extern int run_diff_index(struct rev_info *revs, int cached);
 extern int do_diff_cache(const unsigned char *, struct diff_options *);
 extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
 
+extern int diff_result_code(struct diff_options *, int);
+
 #endif /* DIFF_H */
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index dc538b3..757a27a 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -148,14 +148,14 @@ test_expect_failure 'check with space before tab in indent' '
 
 '
 
-test_expect_failure '--check and --exit-code are exclusive' '
+test_expect_success '--check and --exit-code are not exclusive' '
 
 	git checkout x &&
 	git diff --check --exit-code
 
 '
 
-test_expect_failure '--check and --quiet are exclusive' '
+test_expect_success '--check and --quiet are not exclusive' '
 
 	git diff --check --quiet
 
