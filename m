From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 09/16] Move WebDAV HTTP push under remote-curl
Date: Mon, 12 Oct 2009 19:25:08 -0700
Message-ID: <1255400715-10508-10-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXDG-0004cs-6M
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbZJMC1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbZJMC07
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:26:59 -0400
Received: from george.spearce.org ([209.20.77.23]:56211 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758829AbZJMC0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:26:35 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DEC053826E; Tue, 13 Oct 2009 02:25:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 17CA738215;
	Tue, 13 Oct 2009 02:25:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130117>

The remote helper interface now supports the push capability,
which can be used to ask the implementation to push one or more
specs to the remote repository.  For remote-curl we implement this
by calling the existing WebDAV based git-http-push executable.

Internally the helper interface uses the push_refs transport hook
so that the complexity of the refspec parsing and matching can be
reused between remote implementations.  When possible however the
helper protocol uses source ref name rather than the source SHA-1,
thereby allowing the helper to access this name if it is useful.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
CC: Tay Ray Chuan <rctay89@gmail.com>
CC: Mike Hommey <mh@glandium.org>
---
 Documentation/git-remote-helpers.txt |   43 ++++++++++-
 http-push.c                          |   43 ++++++++---
 remote-curl.c                        |  101 ++++++++++++++++++++++---
 transport-helper.c                   |  140 +++++++++++++++++++++++++++++++++-
 transport.c                          |   31 --------
 5 files changed, 302 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 334ab30..f8234d0 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -34,6 +34,10 @@ Commands are given by the caller on the helper's standard input, one per line.
 	value of the ref. A space-separated list of attributes follows
 	the name; unrecognized attributes are ignored. After the
 	complete list, outputs a blank line.
++
+If 'push' is supported this may be called as 'list for-push'
+to obtain the current refs prior to sending one or more 'push'
+commands to the helper.
 
 'fetch' <sha1> <name>::
 	Fetches the given object, writing the necessary objects to the
@@ -53,6 +57,22 @@ Supported if the helper has the "fetch" capability.
 	file under GIT_DIR/objects/pack which is keeping a pack
 	until refs can be suitably updated.
 
+'push' +<src>:<dst>::
+	Pushes the given <src> commit or branch locally to the
+	remote branch described by <dst>.  A batch sequence of
+	one or more push commands is terminated with a blank line.
++
+Zero or more protocol options may be entered after the last 'push'
+command, before the batch's terminating blank line.
++
+When the push is complete, outputs one or more 'ok <dst>' or
+'error <dst> <why>?' lines to indicate success or failure of
+each pushed ref.  The status report output is terminated by
+a blank line.  The option field <why> may be quoted in a C
+style string if it contains an LF.
++
+Supported if the helper has the "push" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
@@ -70,8 +90,12 @@ CAPABILITIES
 'fetch-multiple'::
 	This helper supports the 'fetch-multiple' command.
 
+'push'::
+	This helper supports the 'push' command.
+
 'option' <name>::
-	This helper supports the option <name> under fetch-multiple.
+	This helper supports the option <name> under fetch-multiple
+	and push.
 
 REF LIST ATTRIBUTES
 -------------------
@@ -100,6 +124,23 @@ To enable an option the helper must list it in 'capabilities'.
 'option thin'::
 	Transfer the data as a thin pack if possible.
 
+PUSH OPTIONS
+------------
+
+'option dry-run':
+	Pretend like the push update will take place, but don't
+	actually perform actions which would modify the state of
+	the remote side.
+
+'option verbose':
+	Be more verbose in progress output to stderr.
+
+'option thin'::
+	Transfer the data as a thin pack if possible.
+
+'option receivepack' <command>::
+	The program to use on the remote side to receive a pack.
+
 Documentation
 -------------
 Documentation by Daniel Barkalow.
diff --git a/http-push.c b/http-push.c
index 00e83dc..9010ccc 100644
--- a/http-push.c
+++ b/http-push.c
@@ -78,6 +78,7 @@ static int push_verbosely;
 static int push_all = MATCH_REFS_NONE;
 static int force_all;
 static int dry_run;
+static int helper_status;
 
 static struct object_list *objects;
 
@@ -1813,6 +1814,10 @@ int main(int argc, char **argv)
 				dry_run = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--helper-status")) {
+				helper_status = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--verbose")) {
 				push_verbosely = 1;
 				http_is_verbose = 1;
@@ -1941,9 +1946,14 @@ int main(int argc, char **argv)
 
 		if (is_null_sha1(ref->peer_ref->new_sha1)) {
 			if (delete_remote_branch(ref->name, 1) == -1) {
-				error("Could not remove %s", ref->name);
+				if (helper_status)
+					printf("error %s cannot remove\n", ref->name);
+				else
+					error("Could not remove %s", ref->name);
 				rc = -4;
 			}
+			else if (helper_status)
+				printf("ok %s\n", ref->name);
 			new_refs++;
 			continue;
 		}
@@ -1951,6 +1961,8 @@ int main(int argc, char **argv)
 		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (push_verbosely || 1)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
+			if (helper_status)
+				printf("ok %s up to date\n", ref->name);
 			continue;
 		}
 
@@ -1968,12 +1980,15 @@ int main(int argc, char **argv)
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
-				error("remote '%s' is not an ancestor of\n"
-				      "local '%s'.\n"
-				      "Maybe you are not up-to-date and "
-				      "need to pull first?",
-				      ref->name,
-				      ref->peer_ref->name);
+				if (helper_status)
+					printf("error %s non-fast forward\n", ref->name);
+				else
+					error("remote '%s' is not an ancestor of\n"
+						  "local '%s'.\n"
+						  "Maybe you are not up-to-date and "
+						  "need to pull first?",
+						  ref->name,
+						  ref->peer_ref->name);
 				rc = -2;
 				continue;
 			}
@@ -1987,14 +2002,20 @@ int main(int argc, char **argv)
 		if (strcmp(ref->name, ref->peer_ref->name))
 			fprintf(stderr, " using '%s'", ref->peer_ref->name);
 		fprintf(stderr, "\n  from %s\n  to   %s\n", old_hex, new_hex);
-		if (dry_run)
+		if (dry_run) {
+			if (helper_status)
+				printf("ok %s\n", ref->name);
 			continue;
+		}
 
 		/* Lock remote branch ref */
 		ref_lock = lock_remote(ref->name, LOCK_TIME);
 		if (ref_lock == NULL) {
-			fprintf(stderr, "Unable to lock remote branch %s\n",
-				ref->name);
+			if (helper_status)
+				printf("error %s lock error\n", ref->name);
+			else
+				fprintf(stderr, "Unable to lock remote branch %s\n",
+					ref->name);
 			rc = 1;
 			continue;
 		}
@@ -2045,6 +2066,8 @@ int main(int argc, char **argv)
 
 		if (!rc)
 			fprintf(stderr, "    done\n");
+		if (helper_status)
+			printf("%s %s\n", !rc ? "ok" : "error", ref->name);
 		unlock_remote(ref_lock);
 		check_locks();
 	}
diff --git a/remote-curl.c b/remote-curl.c
index e5d9768..000bb52 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,8 +1,11 @@
 #include "cache.h"
+#include "exec_cmd.h"
 #include "remote.h"
 #include "strbuf.h"
 #include "walker.h"
 #include "http.h"
+#include "run-command.h"
+
 
 static struct remote *remote;
 static const char *url;
@@ -86,6 +89,20 @@ static struct ref *get_refs(void)
 	return refs;
 }
 
+static void output_refs(struct ref *refs)
+{
+	struct ref *posn;
+	for (posn = refs; posn; posn = posn->next) {
+		if (posn->symref)
+			printf("@%s %s\n", posn->symref, posn->name);
+		else
+			printf("%s %s\n", sha1_to_hex(posn->old_sha1), posn->name);
+	}
+	printf("\n");
+	fflush(stdout);
+	free_refs(refs);
+}
+
 struct fetch_args {
 	unsigned verbose : 1;
 };
@@ -173,10 +190,74 @@ static void parse_fetch(struct strbuf *buf, int multiple)
 	strbuf_reset(buf);
 }
 
+struct push_args {
+	unsigned dry_run : 1,
+		verbose : 1;
+};
+
+static int push_dav(struct push_args *args, int nr_spec, char **specs)
+{
+	const char **argv = xmalloc((10 + nr_spec) * sizeof(char*));
+	int argc = 0, i;
+
+	argv[argc++] = "http-push";
+	argv[argc++] = "--helper-status";
+	if (args->dry_run)
+		argv[argc++] = "--dry-run";
+	if (args->verbose)
+		argv[argc++] = "--verbose";
+	argv[argc++] = url;
+	for (i = 0; i < nr_spec; i++)
+		argv[argc++] = specs[i];
+	argv[argc++] = NULL;
+
+	if (run_command_v_opt(argv, RUN_GIT_CMD))
+		die("git-%s failed", argv[0]);
+	free(argv);
+	return 0;
+}
+
+static void parse_push(struct strbuf *buf)
+{
+	char **specs = NULL;
+	int alloc_spec = 0, nr_spec = 0, i;
+	struct push_args args;
+
+	memset(&args, 0, sizeof(args));
+	do {
+		if (!prefixcmp(buf->buf, "push ")) {
+			ALLOC_GROW(specs, nr_spec + 1, alloc_spec);
+			specs[nr_spec++] = xstrdup(buf->buf + 5);
+
+		} else if (!strcmp(buf->buf, "option dry-run"))
+			args.dry_run = 1;
+		else if (!strcmp(buf->buf, "option verbose"))
+			args.verbose = 1;
+		else
+			die("http transport does not support %s", buf->buf);
+
+		strbuf_reset(buf);
+		if (strbuf_getline(buf, stdin, '\n') == EOF)
+			return;
+		if (!*buf->buf)
+			break;
+	} while (1);
+
+	if (push_dav(&args, nr_spec, specs))
+		exit(128); /* error already reported */
+	for (i = 0; i < nr_spec; i++)
+		free(specs[i]);
+	free(specs);
+
+	printf("\n");
+	fflush(stdout);
+}
+
 int main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT;
 
+	git_extract_argv0_path(argv[0]);
 	setup_git_directory();
 	if (argc < 2) {
 		fprintf(stderr, "Remote needed\n");
@@ -204,19 +285,19 @@ int main(int argc, const char **argv)
 			parse_fetch(&buf, 1);
 
 		} else if (!strcmp(buf.buf, "list")) {
-			struct ref *refs = get_refs();
-			struct ref *posn;
-			for (posn = refs; posn; posn = posn->next) {
-				if (posn->symref)
-					printf("@%s %s\n", posn->symref, posn->name);
-				else
-					printf("%s %s\n", sha1_to_hex(posn->old_sha1), posn->name);
-			}
-			printf("\n");
-			fflush(stdout);
+			output_refs(get_refs());
+
+		} else if (!strcmp(buf.buf, "list for-push")) {
+			output_refs(get_refs());
+
+		} else if (!prefixcmp(buf.buf, "push ")) {
+			parse_push(&buf);
+
 		} else if (!strcmp(buf.buf, "capabilities")) {
 			printf("fetch\n");
 			printf("fetch-multiple\n");
+			printf("push\n");
+			printf("option dry-run\n");
 			printf("option verbose\n");
 			printf("\n");
 			fflush(stdout);
diff --git a/transport-helper.c b/transport-helper.c
index bb6cd1b..60fdb16 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 #include "transport.h"
-
+#include "quote.h"
 #include "run-command.h"
 #include "commit.h"
 #include "diff.h"
@@ -15,7 +15,8 @@ struct helper_data
 	FILE *out;
 	struct string_list options;
 	unsigned fetch : 1,
-		fetch_multiple : 1;
+		fetch_multiple : 1,
+		push : 1;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -54,6 +55,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "fetch-multiple"))
 			data->fetch_multiple = 1;
+		if (!strcmp(buf.buf, "push"))
+			data->push = 1;
 		if (!prefixcmp(buf.buf, "option ")) {
 			const char *name = buf.buf + strlen("option ");
 			if (!string_list_lookup(name, &data->options))
@@ -103,7 +106,7 @@ static int set_helper_option(struct transport *transport,
 
 	get_helper(transport);
 
-	if (!data->fetch_multiple)
+	if (!data->fetch_multiple && !data->push)
 		return 1;
 
 	if (!strcmp(name, TRANS_OPT_THIN))
@@ -211,6 +214,131 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
+static int push_refs(struct transport *transport,
+		struct ref *remote_refs, int flags)
+{
+	int force_all = flags & TRANSPORT_PUSH_FORCE;
+	int mirror = flags & TRANSPORT_PUSH_MIRROR;
+	struct helper_data *data = transport->data;
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process *helper;
+	struct ref *ref;
+
+	if (!remote_refs)
+		return 0;
+
+	helper = get_helper(transport);
+	if (!data->push)
+		return 1;
+
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (ref->peer_ref)
+			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+		else if (!mirror)
+			continue;
+
+		ref->deletion = is_null_sha1(ref->new_sha1);
+		if (!ref->deletion &&
+			!hashcmp(ref->old_sha1, ref->new_sha1)) {
+			ref->status = REF_STATUS_UPTODATE;
+			continue;
+		}
+
+		if (force_all)
+			ref->force = 1;
+
+		strbuf_addstr(&buf, "push ");
+		if (!ref->deletion) {
+			if (ref->force)
+				strbuf_addch(&buf, '+');
+			if (ref->peer_ref)
+				strbuf_addstr(&buf, ref->peer_ref->name);
+			else
+				strbuf_addstr(&buf, sha1_to_hex(ref->new_sha1));
+		}
+		strbuf_addch(&buf, ':');
+		strbuf_addstr(&buf, ref->name);
+		strbuf_addch(&buf, '\n');
+	}
+
+	standard_options(transport);
+	if (flags & TRANSPORT_PUSH_DRY_RUN) {
+		if (save_option(transport, "dry-run", ""))
+			die("helper %s does not support dry-run", data->name);
+	}
+	if (flags & TRANSPORT_PUSH_VERBOSE)
+		save_option(transport, "verbose", "");
+	for_each_string_list(print_options, &data->options, &buf);
+	strbuf_addch(&buf, '\n');
+
+	if (write_in_full(helper->in, buf.buf, buf.len) != buf.len)
+		exit(128);
+
+	ref = remote_refs;
+	while (1) {
+		char *refname, *msg;
+		int status;
+
+		strbuf_reset(&buf);
+		if (strbuf_getline(&buf, data->out, '\n') == EOF)
+			exit(128); /* child died, message supplied already */
+		if (!buf.len)
+			break;
+
+		if (!prefixcmp(buf.buf, "ok ")) {
+			status = REF_STATUS_OK;
+			refname = buf.buf + 3;
+		} else if (!prefixcmp(buf.buf, "error ")) {
+			status = REF_STATUS_REMOTE_REJECT;
+			refname = buf.buf + 6;
+		} else
+			die("expected ok/error, helper said '%s'\n", buf.buf);
+
+		msg = strchr(refname, ' ');
+		if (msg) {
+			struct strbuf msg_buf = STRBUF_INIT;
+			const char *end;
+
+			*msg++ = '\0';
+			if (!unquote_c_style(&msg_buf, msg, &end))
+				msg = strbuf_detach(&msg_buf, NULL);
+			else
+				msg = xstrdup(msg);
+			strbuf_release(&msg_buf);
+
+			if (!strcmp(msg, "no match")) {
+				status = REF_STATUS_NONE;
+				free(msg);
+				msg = NULL;
+			}
+			else if (!strcmp(msg, "up to date")) {
+				status = REF_STATUS_UPTODATE;
+				free(msg);
+				msg = NULL;
+			}
+			else if (!strcmp(msg, "non-fast forward")) {
+				status = REF_STATUS_REJECT_NONFASTFORWARD;
+				free(msg);
+				msg = NULL;
+			}
+		}
+
+		if (ref)
+			ref = find_ref_by_name(ref, refname);
+		if (!ref)
+			ref = find_ref_by_name(remote_refs, refname);
+		if (!ref) {
+			warning("helper reported unexpected status of %s", refname);
+			continue;
+		}
+
+		ref->status = status;
+		ref->remote_status = msg;
+	}
+	strbuf_release(&buf);
+	return 0;
+}
+
 static struct ref *get_refs_list(struct transport *transport, int for_push)
 {
 	struct helper_data *data = transport->data;
@@ -222,7 +350,10 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	helper = get_helper(transport);
 
-	write_str_in_full(helper->in, "list\n");
+	if (data->push && for_push)
+		write_str_in_full(helper->in, "list for-push\n");
+	else
+		write_str_in_full(helper->in, "list\n");
 
 	while (1) {
 		char *eov, *eon;
@@ -263,6 +394,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 	transport->set_option = set_helper_option;
 	transport->get_refs_list = get_refs_list;
 	transport->fetch = fetch;
+	transport->push_refs = push_refs;
 	transport->disconnect = disconnect_helper;
 	return 0;
 }
diff --git a/transport.c b/transport.c
index 644a30a..6d9652d 100644
--- a/transport.c
+++ b/transport.c
@@ -349,35 +349,6 @@ static int rsync_transport_push(struct transport *transport,
 	return result;
 }
 
-#ifndef NO_CURL
-static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
-{
-	const char **argv;
-	int argc;
-
-	if (flags & TRANSPORT_PUSH_MIRROR)
-		return error("http transport does not support mirror mode");
-
-	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
-	argv[0] = "http-push";
-	argc = 1;
-	if (flags & TRANSPORT_PUSH_ALL)
-		argv[argc++] = "--all";
-	if (flags & TRANSPORT_PUSH_FORCE)
-		argv[argc++] = "--force";
-	if (flags & TRANSPORT_PUSH_DRY_RUN)
-		argv[argc++] = "--dry-run";
-	if (flags & TRANSPORT_PUSH_VERBOSE)
-		argv[argc++] = "--verbose";
-	argv[argc++] = transport->url;
-	while (refspec_nr--)
-		argv[argc++] = *refspec++;
-	argv[argc] = NULL;
-	return !!run_command_v_opt(argv, RUN_GIT_CMD);
-}
-
-#endif
-
 struct bundle_transport_data {
 	int fd;
 	struct bundle_header header;
@@ -826,8 +797,6 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		transport_helper_init(ret, "curl");
 #ifdef NO_CURL
 		error("git was compiled without libcurl support.");
-#else
-		ret->push = curl_transport_push;
 #endif
 
 	} else if (is_local(url) && is_file(url)) {
-- 
1.6.5.52.g0ff2e
