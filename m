Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B3C1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 17:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754002AbdKMRNm (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 12:13:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:39773 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbdKMRNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 12:13:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E6B2AAB9
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:13:40 +0000 (UTC)
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Subject: [RFC 3/3] log: add an option to generate cover letter from a branch
 tip
To:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
Openpgp: preference=signencrypt
Message-ID: <936c2b33-3432-f113-d84b-0623246ec673@suse.de>
Date:   Mon, 13 Nov 2017 18:13:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TODO: figure out defaults, add a config option, move tip detection to specific function

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 44 +++++++++++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6cbe462a7..0ac9d4b71 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -228,6 +228,10 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--[no-]cover-letter-at-tip::
+	Use the tip of the series as a cover letter if it is an empty commit.
+    If no cover-letter is to be sent, the tip is ignored.
+
 --notes[=<ref>]::
 	Append the notes (see linkgit:git-notes[1]) for the commit
 	after the three-dash line.
diff --git a/builtin/log.c b/builtin/log.c
index 6c1fa896a..292626482 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -986,11 +986,11 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
-			      int quiet)
+			      int quiet,
+			      struct commit *cover_at_tip_commit)
 {
 	const char *committer;
-	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
-	const char *msg;
+	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n\n";
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -1021,17 +1021,21 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (!branch_name)
 		branch_name = find_branch_name(rev);
 
-	msg = body;
 	pp.fmt = CMIT_FMT_EMAIL;
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;
 	pp.print_email_subject = 1;
-	pp_user_info(&pp, NULL, &sb, committer, encoding);
-	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
-	pp_remainder(&pp, &msg, &sb, 0);
-	add_branch_description(&sb, branch_name);
-	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
+	if (!cover_at_tip_commit) {
+		pp_user_info(&pp, NULL, &sb, committer, encoding);
+		pp_title_line(&pp, &body, &sb, encoding, need_8bit_cte);
+		pp_remainder(&pp, &body, &sb, 0);
+	} else {
+		pretty_print_commit(&pp, cover_at_tip_commit, &sb);
+	}
+	add_branch_description(&sb, branch_name);
+	fprintf(rev->diffopt.file, "%s", sb.buf);
+	fprintf(rev->diffopt.file, "---\n", sb.buf);
 	strbuf_release(&sb);
 
 	shortlog_init(&log);
@@ -1409,6 +1413,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int just_numbers = 0;
 	int ignore_if_in_upstream = 0;
 	int cover_letter = -1;
+	int cover_at_tip = -1;
+	struct commit *cover_at_tip_commit = NULL;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
 	int zero_commit = 0;
@@ -1437,6 +1443,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
+		OPT_BOOL(0, "cover-at-tip", &cover_at_tip,
+			    N_("fill the cover letter with the tip of the branch")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
@@ -1698,6 +1706,21 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (ignore_if_in_upstream && has_commit_patch_id(commit, &ids))
 			continue;
 
+		if (!nr && cover_at_tip == 1 && !cover_at_tip_commit) {
+			/* Check that it is a candidate to be a cover at tip
+			 * Meaning:
+			 * - a single parent (merge commits are not eligible)
+			 * - tree oid == parent->tree->oid (no diff to the tree)
+			 */
+			if (commit->parents && !commit->parents->next &&
+			    !oidcmp(&commit->tree->object.oid,
+				    &commit->parents->item->tree->object.oid)) {
+				cover_at_tip_commit = commit;
+				continue;
+			} else {
+				cover_at_tip = 0;
+			}
+		}
 		nr++;
 		REALLOC_ARRAY(list, nr);
 		list[nr - 1] = commit;
@@ -1748,7 +1771,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name, quiet,
+				  cover_at_tip_commit);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
-- 
2.15.0.169.g3d3eebb67.dirty

