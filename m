Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BED1C43217
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5408861B3B
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhKRQxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:53:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57648 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhKRQwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:52:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 814AD1FD41
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637254188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaYKDs8+9+ozm+tdGvsQ+qbV3Ysqldseial9pSanCWs=;
        b=awg9NBFbRAZPojr9oyhueBvnqxVgNtCXMPI++4zPDlbiJXWj6UkrUJJ5sKd9FWhqkWrrPC
        jbTPhbi97D6N4Cji1H0eQ7f/t5zVMla5pJkIhInr2KBTC7QDKTfrLFUAXRP74Qh5ftINay
        q82TlulMZsJoPhst+bdTiTm4zZZi8Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637254188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaYKDs8+9+ozm+tdGvsQ+qbV3Ysqldseial9pSanCWs=;
        b=NFPJ2cS60v7Uf/pNbSckoRsuLvAaBJTVWT8gxt9qJiS4ckhOv7wHMNkFjhMdVm0mRRgf9S
        74IFjhkcodkahVDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 6BC0DA3B95;
        Thu, 18 Nov 2021 16:49:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 99D9F1F2CAB; Thu, 18 Nov 2021 17:49:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     git@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 12/27] bisect: Accept and store confidence with each decision
Date:   Thu, 18 Nov 2021 17:49:25 +0100
Message-Id: <20211118164940.8818-13-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211118164940.8818-1-jack@suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With each decision whether a commit is good or bad, accept an optional
confidence argument and store it in bisect log and special file with
probabilities a test is recording a 'bad' result. We will later use
these probabilities to alter decisions about the next bisection point.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 bisect.c                 |  51 ++++++++++++++++
 builtin/bisect--helper.c | 129 ++++++++++++++++++++++++++++++++-------
 fixedpoint.h             |  29 +++++++++
 3 files changed, 186 insertions(+), 23 deletions(-)
 create mode 100644 fixedpoint.h

diff --git a/bisect.c b/bisect.c
index ab264b8ca879..0773a872c82b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -16,8 +16,10 @@
 #include "commit-reach.h"
 #include "object-store.h"
 #include "dir.h"
+#include "fixedpoint.h"
 
 static struct oid_array good_revs;
+static struct oid_array ptest_revs;
 static struct oid_array skipped_revs;
 
 static struct object_id *current_bad_oid;
@@ -444,12 +446,17 @@ static int register_ref(const char *refname, const struct object_id *oid,
 			int flags, void *cb_data)
 {
 	struct strbuf good_prefix = STRBUF_INIT;
+	struct strbuf ptest_prefix = STRBUF_INIT;
+
 	strbuf_addstr(&good_prefix, term_good);
 	strbuf_addstr(&good_prefix, "-");
+	strbuf_addstr(&ptest_prefix, "ptest-");
 
 	if (!strcmp(refname, term_bad)) {
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		oidcpy(current_bad_oid, oid);
+	} else if (starts_with(refname, ptest_prefix.buf)) {
+		oid_array_append(&ptest_revs, oid);
 	} else if (starts_with(refname, good_prefix.buf)) {
 		oid_array_append(&good_revs, oid);
 	} else if (starts_with(refname, "skip-")) {
@@ -474,8 +481,46 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_confidences, "BISECT_CONFIDENCES")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
+static void read_bisect_confidences(void)
+{
+	struct strbuf str = STRBUF_INIT;
+	const char *filename = git_path_bisect_confidences();
+	FILE *fp = fopen(filename, "r");
+
+	/* Just a regular bisection? */
+	if (!fp)
+		return;
+
+	while (strbuf_getline_lf(&str, fp) != EOF) {
+		fpnum_t prob;
+		char *spc;
+		char state;
+		struct object_id oid;
+
+		strbuf_trim(&str);
+		spc = strchr(str.buf, ' ');
+		if (!spc)
+			die(_("Badly formatted content in file '%s': %s"),
+			    filename, str.buf);
+		*spc = 0;
+		if (sscanf(spc + 1, "%c %" FPNUM_FMT, &state, &prob) != 2)
+			die(_("Cannot parse confidence in file '%s': %s"),
+			    filename, spc+1);
+		if (state != 'g' && state != 'b')
+			die(_("Unknown test state in file '%s': '%c'"),
+			    filename, state);
+		if (get_oid(str.buf, &oid))
+			die(_("Cannot get oid of rev '%s' from file '%s'"),
+			    str.buf, filename);
+		/* We'll use parsed data later */
+	}
+	strbuf_release(&str);
+	fclose(fp);
+}
+
 static void read_bisect_paths(struct strvec *array)
 {
 	struct strbuf str = STRBUF_INIT;
@@ -661,6 +706,10 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
 	strvec_push(&rev_argv, "bisect_rev_setup");
+	/*
+	 * We use only revision certainly known to be good or bad for limiting
+	 * a search.
+	 */
 	strvec_pushf(&rev_argv, bad_format, oid_to_hex(current_bad_oid));
 	for (i = 0; i < good_revs.nr; i++)
 		strvec_pushf(&rev_argv, good_format,
@@ -1023,6 +1072,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
+	read_bisect_confidences();
 
 	if (file_exists(git_path_bisect_first_parent()))
 		bisect_flags |= FIND_BISECTION_FIRST_PARENT_ONLY;
@@ -1172,6 +1222,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
+	unlink_or_warn(git_path_bisect_confidences());
 	/* Cleanup head-name if it got left by an old version of git-bisect */
 	unlink_or_warn(git_path_head_name());
 	/*
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750b..f88feb8da949 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -9,6 +9,7 @@
 #include "prompt.h"
 #include "quote.h"
 #include "revision.h"
+#include "fixedpoint.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -19,6 +20,7 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
+static GIT_PATH_FUNC(git_path_bisect_confidences, "BISECT_CONFIDENCES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
@@ -26,8 +28,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	N_("git bisect--helper --bisect-next"),
-	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
-	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper --bisect-state (bad|new) [--confidence <conf>] [<rev>]"),
+	N_("git bisect--helper --bisect-state (good|old) [--confidence <conf>] [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	N_("git bisect--helper --bisect-visualize"),
@@ -254,18 +256,24 @@ static void log_commit(FILE *fp, char *fmt, const char *state,
 	free(label);
 }
 
-static int bisect_write(const char *state, const char *rev,
+static int bisect_write(const char *state, const char *rev, fpnum_t confidence,
 			const struct bisect_terms *terms, int nolog)
 {
+	const char *logstate = state;
 	struct strbuf tag = STRBUF_INIT;
 	struct object_id oid;
 	struct commit *commit;
 	FILE *fp = NULL;
 	int res = 0;
 
+	/* Uncertain result? */
+	if (one_of(state, terms->term_bad, terms->term_good, NULL) &&
+	    confidence != FP_ONE)
+		state = "ptest";
+
 	if (!strcmp(state, terms->term_bad)) {
 		strbuf_addf(&tag, "refs/bisect/%s", state);
-	} else if (one_of(state, terms->term_good, "skip", NULL)) {
+	} else if (one_of(state, terms->term_good, "skip", "ptest", NULL)) {
 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
 	} else {
 		res = error(_("Bad bisect_write argument: %s"), state);
@@ -283,6 +291,24 @@ static int bisect_write(const char *state, const char *rev,
 		goto finish;
 	}
 
+	/* Store confidence if it is non-trivial */
+	if (!strcmp(state, "ptest")) {
+		char cstate;
+
+		fp = fopen(git_path_bisect_confidences(), "a");
+		if (!fp) {
+			res = error_errno(_("couldn't open the file '%s'"),
+				git_path_bisect_confidences());
+			goto finish;
+		}
+		if (!strcmp(logstate, terms->term_bad))
+			cstate = 'b';
+		else
+			cstate = 'g';
+		fprintf(fp, "%s %c %" FPNUM_FMT "\n", rev, cstate, confidence);
+		fclose(fp);
+	}
+
 	fp = fopen(git_path_bisect_log(), "a");
 	if (!fp) {
 		res = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
@@ -290,10 +316,16 @@ static int bisect_write(const char *state, const char *rev,
 	}
 
 	commit = lookup_commit_reference(the_repository, &oid);
-	log_commit(fp, "%s", state, commit);
+	log_commit(fp, "%s", logstate, commit);
 
-	if (!nolog)
-		fprintf(fp, "git bisect %s %s\n", state, rev);
+	if (!nolog) {
+		if (!strcmp(state, "ptest")) {
+			fprintf(fp, "git bisect %s --confidence %lf %s\n",
+				logstate, fp_to_double(confidence), rev);
+		} else {
+			fprintf(fp, "git bisect %s %s\n", logstate, rev);
+		}
+	}
 
 finish:
 	if (fp)
@@ -612,6 +644,16 @@ static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char
 	return bisect_next(terms, prefix);
 }
 
+static int parse_confidence(const char *str, fpnum_t *confidence)
+{
+	double confd;
+
+	if (sscanf(str, "%lf", &confd) != 1 || confd < 0 || confd > 1)
+		return error(_("invalid confidence '%s'"), str);
+	*confidence = double_to_fp(confd);
+	return 0;
+}
+
 static enum bisect_error bisect_start(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int no_checkout = 0;
@@ -784,8 +826,8 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 	write_file(git_path_bisect_names(), "%s\n", bisect_names.buf);
 
 	for (i = 0; i < states.nr; i++)
-		if (bisect_write(states.items[i].string,
-				 revs.items[i].string, terms, 1)) {
+		if (bisect_write(states.items[i].string, revs.items[i].string,
+		    FP_ONE, terms, 1)) {
 			res = BISECT_FAILED;
 			goto finish;
 		}
@@ -854,6 +896,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	struct object_id oid, expected;
 	struct strbuf buf = STRBUF_INIT;
 	struct oid_array revs = OID_ARRAY_INIT;
+	fpnum_t confidence = FP_ONE;
 
 	if (!argc)
 		return error(_("Please call `--bisect-state` with at least one argument"));
@@ -868,6 +911,15 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 
 	argv++;
 	argc--;
+
+	if (argc > 0 && !strcmp(argv[0], "--confidence")) {
+		if (argc < 2)
+			return error(_("missing confidence argument"));
+		if (parse_confidence(argv[1], &confidence))
+			return -1;
+		argv += 2;
+		argc -= 2;
+	}
 	if (argc > 1 && !strcmp(state, terms->term_bad))
 		return error(_("'git bisect %s' can take only one argument."), terms->term_bad);
 
@@ -912,7 +964,8 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	strbuf_release(&buf);
 
 	for (i = 0; i < revs.nr; i++) {
-		if (bisect_write(state, oid_to_hex(&revs.oid[i]), terms, 0)) {
+		if (bisect_write(state, oid_to_hex(&revs.oid[i]), confidence,
+				 terms, 0)) {
 			oid_array_clear(&revs);
 			return BISECT_FAILED;
 		}
@@ -946,39 +999,69 @@ static enum bisect_error bisect_log(void)
 
 static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 {
-	const char *p = line->buf + strspn(line->buf, " \t");
-	char *word_end, *rev;
+	char *p = line->buf + strspn(line->buf, " \t");
+	char *word_end, *cmd;
 
-	if ((!skip_prefix(p, "git bisect", &p) &&
-	!skip_prefix(p, "git-bisect", &p)) || !isspace(*p))
+	if ((!skip_prefix(p, "git bisect", (const char **)&p) &&
+	!skip_prefix(p, "git-bisect", (const char **)&p)) || !isspace(*p))
 		return 0;
 	p += strspn(p, " \t");
 
+	cmd = p;
 	word_end = (char *)p + strcspn(p, " \t");
-	rev = word_end + strspn(word_end, " \t");
+	p = word_end + strspn(word_end, " \t");
 	*word_end = '\0'; /* NUL-terminate the word */
 
 	get_terms(terms);
-	if (check_and_set_terms(terms, p))
+	if (check_and_set_terms(terms, cmd))
 		return -1;
 
-	if (!strcmp(p, "start")) {
+	if (!strcmp(cmd, "start")) {
 		struct strvec argv = STRVEC_INIT;
 		int res;
-		sq_dequote_to_strvec(rev, &argv);
+		sq_dequote_to_strvec(p, &argv);
 		res = bisect_start(terms, argv.v, argv.nr);
 		strvec_clear(&argv);
 		return res;
 	}
 
-	if (one_of(p, terms->term_good,
-	   terms->term_bad, "skip", NULL))
-		return bisect_write(p, rev, terms, 0);
+	if (one_of(cmd, terms->term_good,
+	   terms->term_bad, "skip", NULL)) {
+		fpnum_t confidence = FP_ONE;
+		char *arg;
+
+		arg = p;
+		word_end = (char *)p + strcspn(p, " \t");
+		p = word_end + strspn(word_end, " \t");
+		*word_end = '\0';
+		if (!strcmp(arg, "--confidence")) {
+			if (!strcmp(cmd, "skip")) {
+				error(_("skipping does not take confidence"));
+				return -1;
+			}
+			if (!*p) {
+				error(_("missing bisect confidence argument"));
+				return -1;
+			}
+			arg = p;
+			word_end = (char *)p + strcspn(p, " \t");
+			p = word_end + strspn(word_end, " \t");
+			*word_end = '\0';
+			if (parse_confidence(arg, &confidence))
+				return -1;
+			arg = p;
+		}
+		if (!*arg) {
+			error(_("missing bisect revision"));
+			return -1;
+		}
+		return bisect_write(cmd, arg, confidence, terms, 0);
+	}
 
-	if (!strcmp(p, "terms")) {
+	if (!strcmp(cmd, "terms")) {
 		struct strvec argv = STRVEC_INIT;
 		int res;
-		sq_dequote_to_strvec(rev, &argv);
+		sq_dequote_to_strvec(p, &argv);
 		res = bisect_terms(terms, argv.nr == 1 ? argv.v[0] : NULL);
 		strvec_clear(&argv);
 		return res;
diff --git a/fixedpoint.h b/fixedpoint.h
new file mode 100644
index 000000000000..addef223be2b
--- /dev/null
+++ b/fixedpoint.h
@@ -0,0 +1,29 @@
+#ifndef FIXEDPOINT_H
+#define FIXEDPOINT_H
+
+#include <inttypes.h>
+
+#define FIXEDPOINT_SHIFT 32
+
+typedef uint64_t fpnum_t;
+
+#define FPNUM_FMT PRIu64
+
+static inline const fpnum_t frac_to_fp(unsigned int n, unsigned int d)
+{
+	return (((fpnum_t)n) << FIXEDPOINT_SHIFT) / d;
+}
+
+static inline const fpnum_t double_to_fp(double n)
+{
+	return (n * (1ULL << FIXEDPOINT_SHIFT));
+}
+
+static inline const double fp_to_double(fpnum_t n)
+{
+	return ((double)n) / (1ULL << FIXEDPOINT_SHIFT);
+}
+
+#define FP_ONE frac_to_fp(1, 1)
+
+#endif
-- 
2.26.2

