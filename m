Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14AD11FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 13:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbcLNNGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 08:06:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:56363 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932180AbcLNNGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 08:06:45 -0500
Received: (qmail 26409 invoked by uid 109); 14 Dec 2016 13:06:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 13:06:42 +0000
Received: (qmail 24903 invoked by uid 111); 14 Dec 2016 13:07:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 08:07:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 08:06:40 -0500
Date:   Wed, 14 Dec 2016 08:06:40 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 28/34] run_command_opt(): optionally hide stderr when
 the command succeeds
Message-ID: <20161214130640.ginadvry7wor3tkc@sigill.intra.peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <1e82aeabb906a35175362418b2b4957fae50c3b0.1481642927.git.johannes.schindelin@gmx.de>
 <2637bed1-c36f-32f6-b255-ea32da76d792@kdbg.org>
 <20161214125322.o3naglvyuzgk2pri@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214125322.o3naglvyuzgk2pri@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 07:53:23AM -0500, Jeff King wrote:

> On Wed, Dec 14, 2016 at 09:34:20AM +0100, Johannes Sixt wrote:
> 
> > I wanted to see what it would look like if we make it the caller's
> > responsibility to throw away stderr. The patch is below, as fixup
> > of patch 29/34. The change is gross, but the end result is not that
> > bad, though not really a delightful read, either, mostly due to the
> > strange cleanup semantics of the start_command/finish_command combo,
> > so... I dunno.
> 
> I don't have a strong opinion on the patches under discussion, but here
> are a few pointers on the run-command interface:
> [...]

And here is a patch representing my suggestions, on top of yours. Not
tested beyond "make test".

I think read_author_script() could be simplified even more by appending
to the env array in the first loop, but I didn't want to refactor the
quote handling.

---
 sequencer.c | 65 +++++++++++------------------------
 1 file changed, 20 insertions(+), 45 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f375880bd..27a9eaf15 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -591,18 +591,17 @@ static int write_author_script(const char *message)
 }
 
 /*
- * Read the author-script file into an environment block, ready for use in
- * run_command(), that can be free()d afterwards.
+ * Read the author-script file into an environment block. Returns -1
+ * on error, 0 otherwise.
  */
-static char **read_author_script(void)
+static int read_author_script(struct argv_array *env)
 {
 	struct strbuf script = STRBUF_INIT;
 	int i, count = 0;
-	char *p, *p2, **env;
-	size_t env_size;
+	char *p, *p2;
 
 	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
-		return NULL;
+		return -1;
 
 	for (p = script.buf; *p; p++)
 		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
@@ -614,19 +613,12 @@ static char **read_author_script(void)
 			count++;
 		}
 
-	env_size = (count + 1) * sizeof(*env);
-	strbuf_grow(&script, env_size);
-	memmove(script.buf + env_size, script.buf, script.len);
-	p = script.buf + env_size;
-	env = (char **)strbuf_detach(&script, NULL);
-
 	for (i = 0; i < count; i++) {
-		env[i] = p;
+		argv_array_push(env, p);
 		p += strlen(p) + 1;
 	}
-	env[count] = NULL;
 
-	return env;
+	return 0;
 }
 
 static const char staged_changes_advice[] =
@@ -659,20 +651,18 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 			  int allow_empty, int edit, int amend,
 			  int cleanup_commit_message)
 {
-	char **env = NULL;
-	int rc;
 	const char *value;
-	struct strbuf errout = STRBUF_INIT;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts)) {
-		if (!edit)
+		if (!edit) {
 			cmd.stdout_to_stderr = 1;
+			cmd.err = -1;
+		}
 
-		env = read_author_script();
-		if (!env) {
+		if (read_author_script(&cmd.env_array)) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
 			return error(_(staged_changes_advice),
@@ -706,35 +696,20 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&cmd.args, "--allow-empty-message");
 
-	cmd.env = (const char *const *)env;
-
-	if (cmd.stdout_to_stderr) {
+	if (cmd.err == -1) {
 		/* hide stderr on success */
-		cmd.err = -1;
-		rc = -1;
-		if (start_command(&cmd) < 0)
-			goto cleanup;
-
-		if (strbuf_read(&errout, cmd.err, 0) < 0) {
-			close(cmd.err);
-			finish_command(&cmd); /* throw away exit code */
-			goto cleanup;
-		}
-
-		close(cmd.err);
-		rc = finish_command(&cmd);
+		struct strbuf errout = STRBUF_INIT;
+		int rc = pipe_command(&cmd,
+				      NULL, 0, /* stdin */
+				      NULL, 0, /* stdout */
+				      &errout, 0);
 		if (rc)
 			fputs(errout.buf, stderr);
-	} else {
-		rc = run_command(&cmd);
+		strbuf_release(&errout);
+		return rc;
 	}
 
-cleanup:
-	child_process_clear(&cmd);
-	strbuf_release(&errout);
-	free(env);
-
-	return rc;
+	return run_command(&cmd);
 }
 
 static int is_original_commit_empty(struct commit *commit)
