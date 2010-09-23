From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] merge-recursive: option to specify rename threshold
Date: Wed, 22 Sep 2010 17:32:42 -0700
Message-ID: <1285201962-46346-1-git-send-email-kevin@sb.org>
References: <1285135419-7503-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 23 02:33:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyZkU-00081w-2B
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 02:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab0IWAdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 20:33:10 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39838 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0IWAdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 20:33:09 -0400
Received: by pxi10 with SMTP id 10so289973pxi.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 17:33:08 -0700 (PDT)
Received: by 10.142.132.11 with SMTP id f11mr834942wfd.35.1285201988725;
        Wed, 22 Sep 2010 17:33:08 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id l42sm174528wfa.9.2010.09.22.17.33.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 17:33:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.237.g22e9
In-Reply-To: <1285135419-7503-1-git-send-email-kevin@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156841>

The recursive merge strategy turns on rename detection but leaves the
rename score at the default. Add a strategy option to allow the user
to specify a rename score to use.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
As near as I can tell, there are no tests that deal with rename score.
Given this, I did not attempt to construct my own, as I fear such a test
would be far more complicated than the change itself.

 Documentation/merge-strategies.txt |    4 ++++
 diff.c                             |    6 +++---
 diff.h                             |    2 ++
 merge-recursive.c                  |    6 ++++++
 merge-recursive.h                  |    1 +
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 91faba5..05eb8f8 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -74,6 +74,10 @@ no-renormalize;;
 	Disables the `renormalize` option.  This overrides the
 	`merge.renormalize` configuration variable.
 
+rename-score=<n>;;
+	Controls the similarity threshold used for rename detection.
+	See also linkgit:git-diff[1] `-M`.
+
 subtree[=path];;
 	This option is a more advanced form of 'subtree' strategy, where
 	the strategy makes a guess on how two trees must be shifted to
diff --git a/diff.c b/diff.c
index a7d15e5..da88704 100644
--- a/diff.c
+++ b/diff.c
@@ -3323,7 +3323,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	return 1;
 }
 
-static int parse_num(const char **cp_p)
+int parse_rename_score(const char **cp_p)
 {
 	unsigned long num, scale;
 	int ch, dot;
@@ -3369,7 +3369,7 @@ static int diff_scoreopt_parse(const char *opt)
 	if (cmd != 'M' && cmd != 'C' && cmd != 'B')
 		return -1; /* that is not a -M, -C nor -B option */
 
-	opt1 = parse_num(&opt);
+	opt1 = parse_rename_score(&opt);
 	if (cmd != 'B')
 		opt2 = 0;
 	else {
@@ -3379,7 +3379,7 @@ static int diff_scoreopt_parse(const char *opt)
 			return -1; /* we expect -B80/99 or -B80 */
 		else {
 			opt++;
-			opt2 = parse_num(&opt);
+			opt2 = parse_rename_score(&opt);
 		}
 	}
 	if (*opt != 0)
diff --git a/diff.h b/diff.h
index e17383c..1a263e9 100644
--- a/diff.h
+++ b/diff.h
@@ -332,4 +332,6 @@ extern void emit_line(struct diff_options *o, const char *set, const char *reset
 
 extern char *quote_two(const char *one, const char *two);
 
+extern int parse_rename_score(const char **cp_p);
+
 #endif /* DIFF_H */
diff --git a/merge-recursive.c b/merge-recursive.c
index bf611ae..4d131da 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -334,6 +334,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
 			    500;
+	opts.rename_score = o->rename_score;
 	opts.warn_on_too_large_rename = 1;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
@@ -1576,6 +1577,11 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize = 0;
+	else if (!prefixcmp(s, "rename-score=")) {
+		const char *score = s + strlen("rename-score=");
+		if ((o->rename_score = parse_rename_score(&score)) == -1 || *score != 0)
+			return -1;
+	}
 	else
 		return -1;
 	return 0;
diff --git a/merge-recursive.h b/merge-recursive.h
index 2eb5d1a..c8135b0 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -19,6 +19,7 @@ struct merge_options {
 	int verbosity;
 	int diff_rename_limit;
 	int merge_rename_limit;
+	int rename_score;
 	int call_depth;
 	struct strbuf obuf;
 	struct string_list current_file_set;
-- 
1.7.3.237.g22e9
