From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 12:22:59 -0700
Message-ID: <xmqq60ve67sc.fsf@gitster.mtv.corp.google.com>
References: <1460761306-18794-1-git-send-email-sbeller@google.com>
	<1460761306-18794-3-git-send-email-sbeller@google.com>
	<xmqqd1pq74ys.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xq_Uei_ybEjJ=PPWtruk5uB5Dp2KajA=5G6TSWU0_g2kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 21:23:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asElS-0007Xg-B8
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 21:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbcDRTXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 15:23:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751787AbcDRTXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 15:23:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 67BF61410C;
	Mon, 18 Apr 2016 15:23:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EY518RImRnxKlvzBMLPvftyiCyk=; b=r+UQaA
	e20Yu6UeOduBnKyijwYu4F5tphUgaEIXjCDJpo8TvMnDZafTfOfunwvnk+cgCCFZ
	IaHudB1rho3M9hg3RAejSX4xURlXx6Cu0cs4B9on94wEkTMMHjU0o3cr0zQx2Dvh
	X5/NjdBgIiV/qVjLM0F1VxHsVgrng8FTQ6fnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Eb/21Yn/fTRFF9mf5G85D6ILL46zCXPF
	NL4c0UE8y6TKEId2xcrZyjEoKrznDBpa+HLSj4jZmTNItvDccgGZyidTl3DXJ8bp
	SV0znA3QDSrNH0aCO36BPR7Qzl8Azr9PPwOM3kvHJ8s+qVzTRVUyJiVeqmOMg7nN
	6V/yRVKJR2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EE171410B;
	Mon, 18 Apr 2016 15:23:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BAEA14109;
	Mon, 18 Apr 2016 15:23:00 -0400 (EDT)
In-Reply-To: <CA+P7+xq_Uei_ybEjJ=PPWtruk5uB5Dp2KajA=5G6TSWU0_g2kw@mail.gmail.com>
	(Jacob Keller's message of "Fri, 15 Apr 2016 18:07:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6A69360-059A-11E6-B5DB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291820>

Jacob Keller <jacob.keller@gmail.com> writes:

> I think we're going to make use of xdl_blankline instead of this or
> our own "is_emptyline"

OK, so perhaps either of you two can do a final version people can
start having fun with?

By the way, I really do not want to see something this low-level to
be end-user tweakable with "one bit enable/disable"; the end users
shouldn't have to bother [1].  I left it in but renamed after "what"
it enables/disables, not "how" the enabled thing works, to clarify
that we have this only as a developers' aid.

*1* I am fine with --compaction-heuristic=(shortest|blank|...) that
allows a choice among many as a developers' aid, but I do not think
this topic is there yet.

 Documentation/diff-config.txt  |  9 ++++-----
 Documentation/diff-options.txt | 10 +++++-----
 diff.c                         | 18 +++++++++---------
 xdiff/xdiff.h                  |  2 +-
 xdiff/xdiffi.c                 | 22 ++++++++++------------
 5 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index c62745b..9bf3e92 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -166,11 +166,10 @@ diff.tool::
 
 include::mergetools-diff.txt[]
 
-diff.shortestLineHeuristic::
-	Set this option to true to enable the shortest line chunk heuristic when
-	producing diff output. This heuristic will attempt to shift hunks such
-	that the last shortest common line occurs below the hunk with the rest of
-	the context above it.
+diff.compactionHeuristic::
+	Set this option to enable an experimental heuristic that
+	shifts the hunk boundary in an attempt to make the resulting
+	patch easier to read.
 
 diff.algorithm::
 	Choose a diff algorithm.  The variants are as follows:
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 238f39c..b513023 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,11 +63,11 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
---shortest-line-heuristic::
---no-shortest-line-heuristic::
-	When possible, shift common shortest line in diff hunks below the hunk
-	such that the last common shortest line for each hunk is below, with the
-	rest of the context above the hunk.
+--compaction-heuristic::
+--no-compaction-heuristic::
+	These are to help debugging and tuning an experimental
+	heuristic that shifts the hunk boundary in an attempt to
+	make the resulting patch easier to read.
 
 --minimal::
 	Spend extra time to make sure the smallest possible
diff --git a/diff.c b/diff.c
index 276174c..02c75c3 100644
--- a/diff.c
+++ b/diff.c
@@ -25,7 +25,7 @@
 #endif
 
 static int diff_detect_rename_default;
-static int diff_shortest_line_heuristic = 0;
+static int diff_compaction_heuristic = 1;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
@@ -184,8 +184,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "diff.shortestlineheuristic")) {
-		diff_shortest_line_heuristic = git_config_bool(var, value);
+	if (!strcmp(var, "diff.compactionheuristic")) {
+		diff_compaction_heuristic = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.autorefreshindex")) {
@@ -3240,8 +3240,8 @@ void diff_setup(struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
-	if (diff_shortest_line_heuristic)
-		DIFF_XDL_SET(options, SHORTEST_LINE_HEURISTIC);
+	if (diff_compaction_heuristic)
+		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
 
 	options->orderfile = diff_order_file_cfg;
 
@@ -3719,10 +3719,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--ignore-blank-lines"))
 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--shortest-line-heuristic"))
-		DIFF_XDL_SET(options, SHORTEST_LINE_HEURISTIC);
-	else if (!strcmp(arg, "--no-shortest-line-heuristic"))
-		DIFF_XDL_CLR(options, SHORTEST_LINE_HEURISTIC);
+	else if (!strcmp(arg, "--compaction-heuristic"))
+		DIFF_XDL_SET(options, COMPACTION_HEURISTIC);
+	else if (!strcmp(arg, "--no-compaction-heuristic"))
+		DIFF_XDL_CLR(options, COMPACTION_HEURISTIC);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 968ac62..d1dbb27 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -41,7 +41,7 @@ extern "C" {
 
 #define XDF_IGNORE_BLANK_LINES (1 << 7)
 
-#define XDF_SHORTEST_LINE_HEURISTIC (1 << 8)
+#define XDF_COMPACTION_HEURISTIC (1 << 8)
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 7d15b26..1ec46e0 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,10 +400,9 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
-static int line_length(const char *recs)
+static int is_blank_line(xrecord_t **recs, long ix, long flags)
 {
-	char *s = strchr(recs, '\n');
-	return s ? s - recs : strlen(recs);
+	return xdl_blankline(recs[ix]->ptr, recs[ix]->size, flags);
 }
 
 static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
@@ -417,7 +416,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
-	unsigned int shortest_line;
+	unsigned int blank_lines;
 	xrecord_t **recs = xdf->recs;
 
 	/*
@@ -451,7 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		do {
 			grpsiz = ix - ixs;
-			shortest_line = UINT_MAX;
+			blank_lines = 0;
 
 			/*
 			 * If the line before the current change group, is equal to
@@ -486,9 +485,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the group.
 			 */
 			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
-				int l = line_length(recs[ix]->ptr);
-				if (l < shortest_line)
-					shortest_line = l;
+
+				blank_lines += is_blank_line(recs, ix, flags);
 
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
@@ -519,15 +517,15 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 		/*
 		 * If a group can be moved back and forth, see if there is an
-		 * empty line in the moving space. If there is an empty line,
-		 * make sure the last empty line is the end of the group.
+		 * blank line in the moving space. If there is a blank line,
+		 * make sure the last blank line is the end of the group.
 		 *
 		 * As we shifted the group forward as far as possible, we only
 		 * need to shift it back if at all.
 		 */
-		if ((flags & XDF_SHORTEST_LINE_HEURISTIC)) {
+		if ((flags & XDF_COMPACTION_HEURISTIC)) {
 			while (ixs > 0 &&
-			       line_length(recs[ix - 1]->ptr) > shortest_line &&
+			       !is_blank_line(recs, ix - 1, flags) &&
 			       recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
-- 
2.8.1-399-g96b3b3a
