From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Fri, 14 Nov 2008 17:15:26 -0800
Message-ID: <7v7i7594cx.fsf@gitster.siamese.dyndns.org>
References: <1226708064-19432-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 02:18:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L19oP-0000u4-GG
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 02:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbYKOBRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 20:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbYKOBRl
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 20:17:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbYKOBRl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 20:17:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A9B9016B42;
	Fri, 14 Nov 2008 20:17:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2D54016B4F; Fri, 14 Nov 2008 20:15:28 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 314A3D2A-B2B3-11DD-89D3-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101040>

> @@ -637,9 +638,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		remote = remote_get(argv[0]);
>  
>  	transport = transport_get(remote, remote->url[0]);
> -	if (verbose >= 2)
> +	if (verbosity == VERBOSE)
>  		transport->verbose = 1;
> -	if (quiet)
> +	if (verbosity == QUIET)
>  		transport->verbose = -1;
>  	if (upload_pack)
>  		set_option(TRANS_OPT_UPLOADPACK, upload_pack);

In the original code, the variable verbose can be ">= 2" when "-v -v" is
given, so transport->verbose is not turned on with a single "-v" alone
(this correctly mimics the original behaviour in the scripted version).

The approach with enum { Q, N, V } cannot express this, unfortunately.

So let's do something like the attached patch, instead.

The patch adds OPT__VERBOSITY() that allows you to say "-v -v" to increase
verbosity (and "-q -q" to make it really quiet, although we do not use it
anywhere yet).

 builtin-fetch.c |   19 +++++++++----------
 builtin-merge.c |   21 ++++++++++++++-------
 parse-options.c |   22 ++++++++++++++++++++++
 parse-options.h |    6 ++++++
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git c/builtin-fetch.c w/builtin-fetch.c
index f151cfa..7568163 100644
--- c/builtin-fetch.c
+++ w/builtin-fetch.c
@@ -22,7 +22,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int append, force, keep, update_head_ok, verbose, quiet;
+static int append, force, keep, update_head_ok, verbosity;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -30,8 +30,7 @@ static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
 
 static struct option builtin_fetch_options[] = {
-	OPT__QUIET(&quiet),
-	OPT__VERBOSE(&verbose),
+	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN('a', "append", &append,
 		    "append to .git/FETCH_HEAD instead of overwriting"),
 	OPT_STRING(0, "upload-pack", &upload_pack, "PATH",
@@ -192,7 +191,6 @@ static int s_update_ref(const char *action,
 
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
-			    int verbose,
 			    char *display)
 {
 	struct commit *current = NULL, *updated;
@@ -210,7 +208,7 @@ static int update_local_ref(struct ref *ref,
 		die("object %s not found", sha1_to_hex(ref->new_sha1));
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
-		if (verbose)
+		if (verbosity > 0)
 			sprintf(display, "= %-*s %-*s -> %s", SUMMARY_WIDTH,
 				"[up to date]", REFCOL_WIDTH, remote,
 				pretty_ref);
@@ -366,18 +364,19 @@ static int store_updated_refs(const char *url, const char *remote_name,
 			note);
 
 		if (ref)
-			rc |= update_local_ref(ref, what, verbose, note);
+			rc |= update_local_ref(ref, what, note);
 		else
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
 				SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
-			if (!shown_url) {
+			if (verbosity >= 0 && !shown_url) {
 				fprintf(stderr, "From %.*s\n",
 						url_len, url);
 				shown_url = 1;
 			}
-			fprintf(stderr, " %s\n", note);
+			if (verbosity >= 0)
+				fprintf(stderr, " %s\n", note);
 		}
 	}
 	fclose(fp);
@@ -637,9 +636,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		remote = remote_get(argv[0]);
 
 	transport = transport_get(remote, remote->url[0]);
-	if (verbose >= 2)
+	if (verbosity >= 2)
 		transport->verbose = 1;
-	if (quiet)
+	if (verbosity < 0)
 		transport->verbose = -1;
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
diff --git c/builtin-merge.c w/builtin-merge.c
index 5e7910b..7c2b90c 100644
--- c/builtin-merge.c
+++ w/builtin-merge.c
@@ -50,6 +50,7 @@ static unsigned char head[20], stash[20];
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char *branch;
+static int verbosity;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -171,6 +172,7 @@ static struct option builtin_merge_options[] = {
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
 		"message to be used for the merge commit (if any)",
 		option_parse_message),
+	OPT__VERBOSITY(&verbosity),
 	OPT_END()
 };
 
@@ -250,7 +252,8 @@ static void restore_state(void)
 /* This is called when no merge was necessary. */
 static void finish_up_to_date(const char *msg)
 {
-	printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
+	if (verbosity >= 0)
+		printf("%s%s\n", squash ? " (nothing to squash)" : "", msg);
 	drop_save();
 }
 
@@ -331,14 +334,15 @@ static void finish(const unsigned char *new_head, const char *msg)
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
 	else {
-		printf("%s\n", msg);
+		if (verbosity >= 0)
+			printf("%s\n", msg);
 		strbuf_addf(&reflog_message, "%s: %s",
 			getenv("GIT_REFLOG_ACTION"), msg);
 	}
 	if (squash) {
 		squash_message();
 	} else {
-		if (!merge_msg.len)
+		if (verbosity >= 0 && !merge_msg.len)
 			printf("No merge message -- not updating HEAD\n");
 		else {
 			const char *argv_gc_auto[] = { "gc", "--auto", NULL };
@@ -872,6 +876,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_merge_options,
 			builtin_merge_usage, 0);
+	if (verbosity < 0)
+		show_diffstat = 0;
 
 	if (squash) {
 		if (!allow_fast_forward)
@@ -1013,10 +1019,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
 
-		printf("Updating %s..%s\n",
-			hex,
-			find_unique_abbrev(remoteheads->item->object.sha1,
-			DEFAULT_ABBREV));
+		if (verbosity >= 0)
+			printf("Updating %s..%s\n",
+				hex,
+				find_unique_abbrev(remoteheads->item->object.sha1,
+				DEFAULT_ABBREV));
 		strbuf_addstr(&msg, "Fast forward");
 		if (have_message)
 			strbuf_addstr(&msg,
diff --git c/parse-options.c w/parse-options.c
index fd08bb4..9eb55cc 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -484,6 +484,28 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+int parse_opt_verbosity_cb(const struct option *opt, const char *arg,
+			   int unset)
+{
+	int *target = opt->value;
+
+	if (unset)
+		/* --no-quiet, --no-verbose */
+		*target = 0;
+	else if (opt->short_name == 'v') {
+		if (*target >= 0)
+			(*target)++;
+		else
+			*target = 1;
+	} else {
+		if (*target <= 0)
+			(*target)--;
+		else
+			*target = -1;
+	}
+	return 0;
+}
+
 /*
  * This should really be OPTION_FILENAME type as a part of
  * parse_options that take prefix to do this while parsing.
diff --git c/parse-options.h w/parse-options.h
index 5199950..034162e 100644
--- c/parse-options.h
+++ w/parse-options.h
@@ -150,9 +150,15 @@ extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
+extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
 #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
+#define OPT__VERBOSITY(var) \
+	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, "be more verbose", \
+	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
+	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, "be more quiet", \
+	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
 #define OPT__DRY_RUN(var)  OPT_BOOLEAN('n', "dry-run", (var), "dry run")
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), "n", \
