From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/4] builtin/am: passthrough -t and --trailer flags
Date: Thu, 7 Apr 2016 18:23:16 +0300
Message-ID: <1460042563-32741-5-git-send-email-mst@redhat.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 17:23:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoBmM-00054B-2H
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 17:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560AbcDGPX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 11:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39145 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755688AbcDGPXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 11:23:25 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E25DD9B;
	Thu,  7 Apr 2016 15:23:19 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37FNHwK032581;
	Thu, 7 Apr 2016 11:23:18 -0400
Content-Disposition: inline
In-Reply-To: <1460042563-32741-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290919>

Pass -t and --trailer flags to git-reinterpret-trailers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 builtin/am.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 4180b04..480c4c2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -122,6 +122,7 @@ struct am_state {
 	int message_id;
 	int scissors; /* enum scissors_type */
 	struct argv_array git_apply_opts;
+	struct argv_array git_interpret_trailers_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
 	int ignore_date;
@@ -157,6 +158,8 @@ static void am_state_init(struct am_state *state, const char *dir)
 
 	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
 		state->sign_commit = gpgsign ? "" : NULL;
+
+	argv_array_init(&state->git_interpret_trailers_opts);
 }
 
 /**
@@ -170,6 +173,7 @@ static void am_state_release(struct am_state *state)
 	free(state->author_date);
 	free(state->msg);
 	argv_array_clear(&state->git_apply_opts);
+	argv_array_clear(&state->git_interpret_trailers_opts);
 }
 
 /**
@@ -472,6 +476,11 @@ static void am_load(struct am_state *state)
 	if (sq_dequote_to_argv_array(sb.buf, &state->git_apply_opts) < 0)
 		die(_("could not parse %s"), am_path(state, "apply-opt"));
 
+	read_state_file(&sb, state, "interpret-trailers-opt", 1);
+	argv_array_clear(&state->git_interpret_trailers_opts);
+	if (sq_dequote_to_argv_array(sb.buf, &state->git_interpret_trailers_opts) < 0)
+		die(_("could not parse %s"), am_path(state, "interpret-trailers-opt"));
+
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
 	strbuf_release(&sb);
@@ -988,6 +997,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	unsigned char curr_head[GIT_SHA1_RAWSZ];
 	const char *str;
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf tsb = STRBUF_INIT;
 
 	if (!patch_format)
 		patch_format = detect_patch_format(paths);
@@ -1048,6 +1058,9 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
 	write_state_text(state, "apply-opt", sb.buf);
 
+	sq_quote_argv(&tsb, state->git_interpret_trailers_opts.argv, 0);
+	write_state_text(state, "interpret-trailers-opt", tsb.buf);
+
 	if (state->rebasing)
 		write_state_text(state, "rebasing", "");
 	else
@@ -1072,6 +1085,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	write_state_count(state, "next", state->cur);
 	write_state_count(state, "last", state->last);
 
+	strbuf_release(&tsb);
 	strbuf_release(&sb);
 }
 
@@ -1233,6 +1247,34 @@ static void am_append_signoff(struct am_state *state)
 }
 
 /**
+ * Processes the supplied message file in-place with git-interpret-trailers.
+ * Returns 0 on success, -1 otherwise.
+ */
+static int run_interpret_trailers(const struct am_state *state, const char *msg)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	if (!state->git_interpret_trailers_opts.argc)
+		return 0;
+
+	cp.git_cmd = 1;
+
+	argv_array_push(&cp.args, "interpret-trailers");
+
+	argv_array_push(&cp.args, "--in-place");
+	argv_array_push(&cp.args, "--suppress-blank-line");
+
+	argv_array_pushv(&cp.args, state->git_interpret_trailers_opts.argv);
+
+	argv_array_push(&cp.args, msg);
+
+	if (run_command(&cp))
+		return -1;
+
+	return 0;
+}
+
+/**
  * Parses `mail` using git-mailinfo, extracting its patch and authorship info.
  * state->msg will be set to the patch message. state->author_name,
  * state->author_email and state->author_date will be set to the patch author's
@@ -1301,6 +1343,9 @@ static int parse_mail(struct am_state *state, const char *mail)
 	fclose(mi.input);
 	fclose(mi.output);
 
+	if (run_interpret_trailers(state, am_path(state, "msg")) < 0)
+		die("could not interpret trailers");
+
 	/* Extract message and author information */
 	fp = xfopen(am_path(state, "info"), "r");
 	while (!strbuf_getline_lf(&sb, fp)) {
@@ -2299,6 +2344,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_PASSTHRU_ARGV('p', NULL, &state.git_apply_opts, N_("num"),
 			N_("pass it through git-apply"),
 			0),
+		OPT_PASSTHRU_ARGV('t', "trailer", &state.git_interpret_trailers_opts, N_("trailer"),
+			N_("pass it through git-interpret-trailers"),
+			0),
 		OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
 			N_("format the patch(es) are in"),
 			parse_opt_patchformat),
-- 
MST
