From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] diff: deprecate -q option to diff-files
Date: Wed, 17 Jul 2013 17:30:06 -0700
Message-ID: <1374107406-14357-7-git-send-email-gitster@pobox.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
 <1374107406-14357-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 02:30:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzc75-0006bR-E3
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934469Ab3GRAaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 20:30:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934457Ab3GRAaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 20:30:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFAD720ACD;
	Thu, 18 Jul 2013 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gN7o
	1iH72wehppjg7ARaV80bmlk=; b=e0rbzeE16WxIc+4F+EcXE0U8NPrS7Vg0n8oK
	Zc/1WiD5m14FmZcdEz/n20w5u1hhFS6iQ2PpXL0mjx+LY0GL25QbSAp4/Z/ghLsE
	p7n/1aKq9cMlkGg+fDtTVb1tm+HtbuBqrw2EE69tmHrVk2Gll9KVPYut6zURHVri
	cvfLyMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	JRN0x/8xwRTPDQGysIcSsWECNnKHYbGT19BT/sIbUEQLPVNbec5XsCB1C3Cw5SOh
	8R9fQlNGsKAk857rYfbqIKDifRmQe/QnY/1vwl5CnY93fTDk0Pv2H6SYvyLtj7T+
	2Hxb+Q3OFS35qFACXSm0PL0RQJxJ+2Df+D5NOGRf8X4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6A0420ACC;
	Thu, 18 Jul 2013 00:30:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBC5B20AC6;
	Thu, 18 Jul 2013 00:30:21 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-962-gf04df43
In-Reply-To: <1374107406-14357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3B207E66-EF41-11E2-AE2B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230667>

This reimplements the ancient "-q" option to "git diff-files" that
was inherited from "show-diff -q" in terms of "--diff-filter=d", and
issue a warning against the use of the former.

Incidentally this also tentatively fix "git diff --no-index" to
honor "-q" and hide deletions; the use will get the same warning.

We should remove the support for "-q" in Git 2.0.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c      | 8 +++-----
 diff-no-index.c | 7 +++++--
 diff.c          | 8 ++++++++
 diff.h          | 2 ++
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f35de0f..4634b29 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -86,10 +86,12 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
 	int diff_unmerged_stage = revs->max_count;
-	int silent_on_removed = option & DIFF_SILENT_ON_REMOVED;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 
+	if (option & DIFF_SILENT_ON_REMOVED)
+		handle_deprecated_show_diff_q(&revs->diffopt);
+
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
 	if (diff_unmerged_stage < 0)
@@ -136,8 +138,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					perror(ce->name);
 					continue;
 				}
-				if (silent_on_removed)
-					continue;
 				wt_mode = 0;
 			}
 			dpath->mode = wt_mode;
@@ -203,8 +203,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				perror(ce->name);
 				continue;
 			}
-			if (silent_on_removed)
-				continue;
 			diff_addremove(&revs->diffopt, '-', ce->ce_mode,
 				       ce->sha1, !is_null_sha1(ce->sha1),
 				       ce->name, 0);
diff --git a/diff-no-index.c b/diff-no-index.c
index 74da659..a788a5f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -187,7 +187,7 @@ void diff_no_index(struct rev_info *revs,
 {
 	int i, prefixlen;
 	int no_index = 0;
-	unsigned options = 0;
+	unsigned deprecated_show_diff_q_option_used = 0;
 	const char *paths[2];
 
 	/* Were we asked to do --no-index explicitly? */
@@ -225,7 +225,7 @@ void diff_no_index(struct rev_info *revs,
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
 		else if (!strcmp(argv[i], "-q")) {
-			options |= DIFF_SILENT_ON_REMOVED;
+			deprecated_show_diff_q_option_used = 1;
 			i++;
 		}
 		else if (!strcmp(argv[i], "--"))
@@ -260,6 +260,9 @@ void diff_no_index(struct rev_info *revs,
 	revs->max_count = -2;
 	diff_setup_done(&revs->diffopt);
 
+	if (deprecated_show_diff_q_option_used)
+		handle_deprecated_show_diff_q(&revs->diffopt);
+
 	setup_diff_pager(&revs->diffopt);
 	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
 
diff --git a/diff.c b/diff.c
index 2d0b5e3..78819ba 100644
--- a/diff.c
+++ b/diff.c
@@ -3570,6 +3570,14 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 	return 0;
 }
 
+/* Used only by "diff-files" and "diff --no-index" */
+void handle_deprecated_show_diff_q(struct diff_options *opt)
+{
+	warning("'diff -q' and 'diff-files -q' are deprecated.");
+	warning("Use 'diff --diff-filter=d' instead to ignore deleted filepairs.");
+	parse_diff_filter_opt("d", opt);
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
diff --git a/diff.h b/diff.h
index a367207..5237d63 100644
--- a/diff.h
+++ b/diff.h
@@ -341,6 +341,8 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
+extern void handle_deprecated_show_diff_q(struct diff_options *);
+
 extern int print_stat_summary(FILE *fp, int files,
 			      int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
-- 
1.8.3.3-962-gf04df43
