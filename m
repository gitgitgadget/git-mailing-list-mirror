Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560E52018F
	for <e@80x24.org>; Fri, 15 Jul 2016 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbcGOKao (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 06:30:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:45305 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932302AbcGOKan (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 06:30:43 -0400
Received: (qmail 18086 invoked by uid 102); 15 Jul 2016 10:30:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:30:42 -0400
Received: (qmail 14307 invoked by uid 107); 15 Jul 2016 10:31:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 06:31:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 06:30:40 -0400
Date:	Fri, 15 Jul 2016 06:30:40 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 04/12] check_everything_connected: use a struct with named
 options
Message-ID: <20160715103039.GD19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160715102506.GA23164@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The number of variants of check_everything_connected has
grown over the years, so that the "real" function takes
several possibly-zero, possibly-NULL arguments. We hid the
complexity behind some wrapper functions, but this doesn't
scale well when we want to add new options.

If we add more wrapper variants to handle the new options,
then we can get a combinatorial explosion when those options
might be used together (right now nobody wants to use both
"shallow" and "transport" together, so we get by with just a
few wrappers).

If instead we add new parameters to each function, each of
which can have a default value, then callers who want the
defaults end up with confusing invocations like:

  check_everything_connected(fn, 0, data, -1, 0, NULL);

where it is unclear which parameter is which (and every
caller needs updated when we add new options).

Instead, let's add a struct to hold all of the optional
parameters. This is a little more verbose for the callers
(who have to declare the struct and fill it in), but it
makes their code much easier to follow, because every option
is named as it is set (and unused options do not have to be
mentioned at all).

Note that we could also stick the iteration function and its
callback data into the option struct, too. But since those
are required for each call, by avoiding doing so, we can let
very simple callers just pass "NULL" for the options and not
worry about the struct at all.

While we're touching each site, let's also rename the
function to check_connected(). The existing name was quite
long, and not all of the wrappers even used the full name.

Signed-off-by: Jeff King <peff@peff.net>
---
The diffstat claims +2 lines, but 3 of those are documentation that
should have existed before but didn't. :)

But the real gain comes in the later patches. They were pretty nasty
before I went back and did this cleanup.

 builtin/clone.c        |  7 +++++--
 builtin/fetch.c        |  6 ++++--
 builtin/receive-pack.c | 13 ++++++-------
 connected.c            | 39 +++++++++++----------------------------
 connected.h            | 27 +++++++++++++++++++++------
 5 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 31ea247..32fe606 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -624,10 +624,13 @@ static void update_remote_refs(const struct ref *refs,
 	const struct ref *rm = mapped_refs;
 
 	if (check_connectivity) {
+		struct check_connected_options opt = CHECK_CONNECTED_INIT;
+
+		opt.transport = transport;
+
 		if (transport->progress)
 			fprintf(stderr, _("Checking connectivity... "));
-		if (check_everything_connected_with_transport(iterate_ref_map,
-							      0, &rm, transport))
+		if (check_connected(iterate_ref_map, &rm, &opt))
 			die(_("remote did not send all necessary objects"));
 		if (transport->progress)
 			fprintf(stderr, _("done.\n"));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f896aa1..3bf895f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -615,7 +615,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = xstrdup("foreign");
 
 	rm = ref_map;
-	if (check_everything_connected(iterate_ref_map, 0, &rm)) {
+	if (check_connected(iterate_ref_map, &rm, NULL)) {
 		rc = error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
@@ -751,6 +751,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 static int quickfetch(struct ref *ref_map)
 {
 	struct ref *rm = ref_map;
+	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
 	/*
 	 * If we are deepening a shallow clone we already have these
@@ -761,7 +762,8 @@ static int quickfetch(struct ref *ref_map)
 	 */
 	if (depth)
 		return -1;
-	return check_everything_connected(iterate_ref_map, 1, &rm);
+	opt.quiet = 1;
+	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 15c323a..ce81920 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -737,7 +737,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 {
 	static struct lock_file shallow_lock;
 	struct sha1_array extra = SHA1_ARRAY_INIT;
-	const char *alt_file;
+	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	uint32_t mask = 1 << (cmd->index % 32);
 	int i;
 
@@ -749,9 +749,8 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		    !delayed_reachability_test(si, i))
 			sha1_array_append(&extra, si->shallow->sha1[i]);
 
-	setup_alternate_shallow(&shallow_lock, &alt_file, &extra);
-	if (check_shallow_connected(command_singleton_iterator,
-				    0, cmd, alt_file)) {
+	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
+	if (check_connected(command_singleton_iterator, cmd, &opt)) {
 		rollback_lock_file(&shallow_lock);
 		sha1_array_clear(&extra);
 		return -1;
@@ -1160,8 +1159,8 @@ static void set_connectivity_errors(struct command *commands,
 		if (shallow_update && si->shallow_ref[cmd->index])
 			/* to be checked in update_shallow_ref() */
 			continue;
-		if (!check_everything_connected(command_singleton_iterator,
-						0, &singleton))
+		if (!check_connected(command_singleton_iterator, &singleton,
+				     NULL))
 			continue;
 		cmd->error_string = "missing necessary objects";
 	}
@@ -1330,7 +1329,7 @@ static void execute_commands(struct command *commands,
 
 	data.cmds = commands;
 	data.si = si;
-	if (check_everything_connected(iterate_receive_command_list, 0, &data))
+	if (check_connected(iterate_receive_command_list, &data, NULL))
 		set_connectivity_errors(commands, si);
 
 	reject_updates_to_hidden(commands);
diff --git a/connected.c b/connected.c
index a3bfc4e..2a51eac 100644
--- a/connected.c
+++ b/connected.c
@@ -4,10 +4,6 @@
 #include "connected.h"
 #include "transport.h"
 
-int check_everything_connected(sha1_iterate_fn fn, int quiet, void *cb_data)
-{
-	return check_everything_connected_with_transport(fn, quiet, cb_data, NULL);
-}
 /*
  * If we feed all the commits we want to verify to this command
  *
@@ -19,19 +15,22 @@ int check_everything_connected(sha1_iterate_fn fn, int quiet, void *cb_data)
  *
  * Returns 0 if everything is connected, non-zero otherwise.
  */
-static int check_everything_connected_real(sha1_iterate_fn fn,
-					   int quiet,
-					   void *cb_data,
-					   struct transport *transport,
-					   const char *shallow_file)
+int check_connected(sha1_iterate_fn fn, void *cb_data,
+		    struct check_connected_options *opt)
 {
 	struct child_process rev_list = CHILD_PROCESS_INIT;
+	struct check_connected_options defaults = CHECK_CONNECTED_INIT;
 	char commit[41];
 	unsigned char sha1[20];
 	int err = 0;
 	struct packed_git *new_pack = NULL;
+	struct transport *transport;
 	size_t base_len;
 
+	if (!opt)
+		opt = &defaults;
+	transport = opt->transport;
+
 	if (fn(cb_data, sha1))
 		return err;
 
@@ -46,9 +45,9 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 		strbuf_release(&idx_file);
 	}
 
-	if (shallow_file) {
+	if (opt->shallow_file) {
 		argv_array_push(&rev_list.args, "--shallow-file");
-		argv_array_push(&rev_list.args, shallow_file);
+		argv_array_push(&rev_list.args, opt->shallow_file);
 	}
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
@@ -60,7 +59,7 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 	rev_list.git_cmd = 1;
 	rev_list.in = -1;
 	rev_list.no_stdout = 1;
-	rev_list.no_stderr = quiet;
+	rev_list.no_stderr = opt->quiet;
 	if (start_command(&rev_list))
 		return error(_("Could not run 'git rev-list'"));
 
@@ -94,19 +93,3 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 	sigchain_pop(SIGPIPE);
 	return finish_command(&rev_list) || err;
 }
-
-int check_everything_connected_with_transport(sha1_iterate_fn fn,
-					      int quiet,
-					      void *cb_data,
-					      struct transport *transport)
-{
-	return check_everything_connected_real(fn, quiet, cb_data,
-					       transport, NULL);
-}
-
-int check_shallow_connected(sha1_iterate_fn fn, int quiet, void *cb_data,
-			    const char *shallow_file)
-{
-	return check_everything_connected_real(fn, quiet, cb_data,
-					       NULL, shallow_file);
-}
diff --git a/connected.h b/connected.h
index 071d408..12594ef 100644
--- a/connected.h
+++ b/connected.h
@@ -10,18 +10,33 @@ struct transport;
  */
 typedef int (*sha1_iterate_fn)(void *, unsigned char [20]);
 
+/*
+ * Named-arguments struct for check_connected. All arguments are
+ * optional, and can be left to defaults as set by CHECK_CONNECTED_INIT.
+ */
+struct check_connected_options {
+	/* Avoid printing any errors to stderr. */
+	int quiet;
+
+	/* --shallow-file to pass to rev-list sub-process */
+	const char *shallow_file;
+
+	/* Transport whose objects we are checking, if available. */
+	struct transport *transport;
+};
+
+#define CHECK_CONNECTED_INIT { 0 }
+
 /*
  * Make sure that our object store has all the commits necessary to
  * connect the ancestry chain to some of our existing refs, and all
  * the trees and blobs that these commits use.
  *
  * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
+ *
+ * If "opt" is NULL, behaves as if CHECK_CONNECTED_INIT was passed.
  */
-extern int check_everything_connected(sha1_iterate_fn, int quiet, void *cb_data);
-extern int check_shallow_connected(sha1_iterate_fn, int quiet, void *cb_data,
-				   const char *shallow_file);
-extern int check_everything_connected_with_transport(sha1_iterate_fn, int quiet,
-						     void *cb_data,
-						     struct transport *transport);
+int check_connected(sha1_iterate_fn fn, void *cb_data,
+		    struct check_connected_options *opt);
 
 #endif /* CONNECTED_H */
-- 
2.9.1.434.g748be50

