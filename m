From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 11:16:56 -0700
Message-ID: <7vk3lj9xwn.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
	<7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
	<vpq7ghjtpv1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:17:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBK7-0001jh-GM
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab3FXSRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:17:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab3FXSQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:16:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72DE42B5E7;
	Mon, 24 Jun 2013 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yK2DDt4F8TCnp4DHECfN+DkQCJ8=; b=roSt/r
	GEZPvyv26fL1M1gbL1qCn54TFppBS4OhFxEYx3Rrn1faFsR1db/OxjJhfodFMF0n
	UdvI3p1Lmv6yO3q8sfETAWuHf3a95m6xZRUkjPbINS+epKRY0Jpt1HNe14dEk1jY
	qGJIsvuIQZgWGHaAueex9VYCpuw7poGPKVqg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YT1LmG0s1RO4Uiv8Xtir/q5CSys8TBks
	j490d/kz5iZ4i/VkubqlU4w2dYur8xOgrjaO8HL775Br5l5G7UYfG0f8RvyLZ5AK
	P+CjRzwWdrbehSAb62kTx2gHovcalHQzv4BzhPmniK92h2XoUKmGkgMLZ3LSDVC2
	eWtTFeqQV7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 672E42B5E6;
	Mon, 24 Jun 2013 18:16:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A62082B5E5;
	Mon, 24 Jun 2013 18:16:57 +0000 (UTC)
In-Reply-To: <vpq7ghjtpv1.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	24 Jun 2013 18:50:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41B593FA-DCFA-11E2-BC6B-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228887>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> "First read config, override with command line" is what we always
>> do.  One recent workaround with selective exception I can think of
>> offhand is in diff config parser 6c374008 (diff_opt: track whether
>> flags have been set explicitly, 2013-05-10), but I am fairly sure
>> there are others.
>
> That was the one I had in mind.

If we want to continue that tried-and-proven approach as a
short-term fix, a patch may look like this.

We use "unspecified" value to initialize the main variables
(status_format global and s->show_branch), and also prepare
"from-config" counterpart variables.  After we read both, we figure
out which one should be used, while resetting the main variables to
their default if neither mechanism touched them.

 builtin/commit.c  | 55 ++++++++++++++++++++++++++++++++++++++++++++++---------
 t/t7508-status.sh |  5 +++++
 wt-status.c       |  1 +
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0da944f..a535eb2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -111,12 +111,14 @@ static int show_ignored_in_status;
 static const char *only_include_assumed;
 static struct strbuf message = STRBUF_INIT;
 
-static enum {
+static enum status_format {
 	STATUS_FORMAT_NONE = 0,
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
-	STATUS_FORMAT_PORCELAIN
-} status_format;
+	STATUS_FORMAT_PORCELAIN,
+
+	STATUS_FORMAT_UNSPECIFIED
+} status_format = STATUS_FORMAT_UNSPECIFIED;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -457,6 +459,9 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s);
 		break;
+	case STATUS_FORMAT_UNSPECIFIED:
+		die("BUG: finalize_deferred_config() should have been called");
+		break;
 	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
@@ -958,6 +963,33 @@ static const char *read_commit_message(const char *name)
 	return logmsg_reencode(commit, NULL, out_enc);
 }
 
+/*
+ * Enumerate what needs to be propagated when --porcelain
+ * is not in effect here.
+ */
+static struct status_deferred_config {
+	enum status_format status_format;
+	int show_branch;
+} status_deferred_config = {
+	STATUS_FORMAT_UNSPECIFIED,
+	-1 /* unspecified */
+};
+
+static void finalize_deferred_config(struct wt_status *s)
+{
+	int use_deferred_config = (status_format != STATUS_FORMAT_PORCELAIN);
+
+	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
+		status_format = status_deferred_config.status_format;
+	if (status_format == STATUS_FORMAT_UNSPECIFIED)
+		status_format = STATUS_FORMAT_NONE;
+
+	if (use_deferred_config && s->show_branch < 0)
+		s->show_branch = status_deferred_config.show_branch;
+	if (s->show_branch < 0)
+		s->show_branch = 0;
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -968,6 +1000,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	int f = 0;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	finalize_deferred_config(s);
 
 	if (force_author && !strchr(force_author, '>'))
 		force_author = find_author_by_nickname(force_author);
@@ -1112,13 +1145,13 @@ static int git_status_config(const char *k, const char *v, void *cb)
 	}
 	if (!strcmp(k, "status.short")) {
 		if (git_config_bool(k, v))
-			status_format = STATUS_FORMAT_SHORT;
+			status_deferred_config.status_format = STATUS_FORMAT_SHORT;
 		else
-			status_format = STATUS_FORMAT_NONE;
+			status_deferred_config.status_format = STATUS_FORMAT_NONE;
 		return 0;
 	}
 	if (!strcmp(k, "status.branch")) {
-		s->show_branch = git_config_bool(k, v);
+		status_deferred_config.show_branch = git_config_bool(k, v);
 		return 0;
 	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
@@ -1163,8 +1196,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_SET_INT('s', "short", &status_format,
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
-		OPT_BOOLEAN('b', "branch", &s.show_branch,
-			    N_("show branch information")),
+		OPT_BOOL('b', "branch", &s.show_branch,
+			 N_("show branch information")),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"),
 			    STATUS_FORMAT_PORCELAIN),
@@ -1197,6 +1230,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_options,
 			     builtin_status_usage, 0);
 	finalize_colopts(&s.colopts, -1);
+	finalize_deferred_config(&s);
 
 	if (s.null_termination) {
 		if (status_format == STATUS_FORMAT_NONE)
@@ -1232,6 +1266,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s);
 		break;
+	case STATUS_FORMAT_UNSPECIFIED:
+		die("BUG: finalize_deferred_config() should have been called");
+		break;
 	case STATUS_FORMAT_NONE:
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
@@ -1400,7 +1437,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "dry-run", &dry_run, N_("show what would be committed")),
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
-		OPT_BOOLEAN(0, "branch", &s.show_branch, N_("show branch information")),
+		OPT_BOOL(0, "branch", &s.show_branch, N_("show branch information")),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"), STATUS_FORMAT_PORCELAIN),
 		OPT_SET_INT(0, "long", &status_format,
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 498332c..ac3d0fe 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1378,6 +1378,11 @@ test_expect_success '"status.branch=true" weaker than "--no-branch"' '
 	test_cmp expected_nobranch actual
 '
 
+test_expect_success '"status.branch=true" weaker than "--porcelain"' '
+       git -c status.branch=true status --porcelain >actual &&
+       test_cmp expected_nobranch actual
+'
+
 test_expect_success '"status.branch=false" same as "--no-branch"' '
 	git -c status.branch=false status -s >actual &&
 	test_cmp expected_nobranch actual
diff --git a/wt-status.c b/wt-status.c
index bf84a86..6778755 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -127,6 +127,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->change.strdup_strings = 1;
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
+	s->show_branch = -1;  /* unspecified */
 }
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
