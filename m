From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 11/26] Move WebDAV HTTP push under remote-curl
Date: Wed, 28 Oct 2009 17:00:33 -0700
Message-ID: <1256774448-7625-12-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISk-0000kN-Rs
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbZJ2AA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbZJ2AA6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:00:58 -0400
Received: from george.spearce.org ([209.20.77.23]:36222 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbZJ2AAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:51 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 024F33826B; Thu, 29 Oct 2009 00:00:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 275293821F;
	Thu, 29 Oct 2009 00:00:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131520>

The remote helper interface now supports the push capability,
which can be used to ask the implementation to push one or more
specs to the remote repository.  For remote-curl we implement this
by calling the existing WebDAV based git-http-push executable.

Internally the helper interface uses the push_refs transport hook
so that the complexity of the refspec parsing and matching can be
reused between remote implementations.  When possible however the
helper protocol uses source ref name rather than the source SHA-1,
thereby allowing the helper to access this name if it is useful.

>From Clemens Buchacher <drizzd@aon.at>:
 update http tests according to remote-curl capabilities

 o Pushing packed refs is now fixed.

 o The transport helper fails if refs are already up-to-date. Add
   a test for that.

 o The transport helper will notice if refs are already
   up-to-date. We therefore need to update server info in the
   unpacked-refs test.

 o The transport helper will purge deleted branches automatically.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
CC: Mike Hommey <mh@glandium.org>
---
 Documentation/git-remote-helpers.txt |   33 ++++++++-
 http-push.c                          |   29 +++++++-
 remote-curl.c                        |   97 +++++++++++++++++++++---
 t/t5540-http-push.sh                 |   14 ++-
 transport-helper.c                   |  137 +++++++++++++++++++++++++++++++++-
 transport.c                          |   31 --------
 6 files changed, 287 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 1133f04..8beb42d 100644
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
 
 'option' <name> <value>::
 	Set the transport helper option <name> to <value>.  Outputs a
@@ -59,6 +63,22 @@ suitably updated.
 +
 Supported if the helper has the "fetch" capability.
 
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
@@ -76,10 +96,16 @@ CAPABILITIES
 'option'::
 	This helper supports the option command.
 
+'push'::
+	This helper supports the 'push' command.
+
 REF LIST ATTRIBUTES
 -------------------
 
-None are defined yet, but the caller must accept any which are supplied.
+'for-push'::
+	The caller wants to use the ref list to prepare push
+	commands.  A helper might chose to acquire the ref list by
+	opening a different type of connection to the destination.
 
 OPTIONS
 -------
@@ -106,6 +132,11 @@ OPTIONS
 	ask for the tag specifically.  Some helpers may be able to
 	use this option to avoid a second network connection.
 
+'option dry-run' \{'true'|'false'\}:
+	If true, pretend the operation completed successfully,
+	but don't actually change any repository data.	For most
+	helpers this only applies to the 'push', if supported.
+
 Documentation
 -------------
 Documentation by Daniel Barkalow.
diff --git a/http-push.c b/http-push.c
index cc5d4b8..f10803a 100644
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
@@ -1911,9 +1916,12 @@ int main(int argc, char **argv)
 
 	/* Remove a remote branch if -d or -D was specified */
 	if (delete_branch) {
-		if (delete_remote_branch(refspec[0], force_delete) == -1)
+		if (delete_remote_branch(refspec[0], force_delete) == -1) {
 			fprintf(stderr, "Unable to delete remote branch %s\n",
 				refspec[0]);
+			if (helper_status)
+				printf("error %s cannot remove\n", refspec[0]);
+		}
 		goto cleanup;
 	}
 
@@ -1925,6 +1933,8 @@ int main(int argc, char **argv)
 	}
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
+		if (helper_status)
+			printf("error null no match\n");
 		rc = 0;
 		goto cleanup;
 	}
@@ -1942,8 +1952,12 @@ int main(int argc, char **argv)
 		if (is_null_sha1(ref->peer_ref->new_sha1)) {
 			if (delete_remote_branch(ref->name, 1) == -1) {
 				error("Could not remove %s", ref->name);
+				if (helper_status)
+					printf("error %s cannot remove\n", ref->name);
 				rc = -4;
 			}
+			else if (helper_status)
+				printf("ok %s\n", ref->name);
 			new_refs++;
 			continue;
 		}
@@ -1951,6 +1965,8 @@ int main(int argc, char **argv)
 		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (push_verbosely || 1)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
+			if (helper_status)
+				printf("ok %s up to date\n", ref->name);
 			continue;
 		}
 
@@ -1974,6 +1990,8 @@ int main(int argc, char **argv)
 				      "need to pull first?",
 				      ref->name,
 				      ref->peer_ref->name);
+				if (helper_status)
+					printf("error %s non-fast forward\n", ref->name);
 				rc = -2;
 				continue;
 			}
@@ -1987,14 +2005,19 @@ int main(int argc, char **argv)
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
 			fprintf(stderr, "Unable to lock remote branch %s\n",
 				ref->name);
+			if (helper_status)
+				printf("error %s lock error\n", ref->name);
 			rc = 1;
 			continue;
 		}
@@ -2045,6 +2068,8 @@ int main(int argc, char **argv)
 
 		if (!rc)
 			fprintf(stderr, "    done\n");
+		if (helper_status)
+			printf("%s %s\n", !rc ? "ok" : "error", ref->name);
 		unlock_remote(ref_lock);
 		check_locks();
 	}
diff --git a/remote-curl.c b/remote-curl.c
index 0951f11..5c9dd97 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -4,6 +4,7 @@
 #include "walker.h"
 #include "http.h"
 #include "exec_cmd.h"
+#include "run-command.h"
 
 static struct remote *remote;
 static const char *url;
@@ -13,7 +14,8 @@ struct options {
 	int verbosity;
 	unsigned long depth;
 	unsigned progress : 1,
-		followtags : 1;
+		followtags : 1,
+		dry_run : 1;
 };
 static struct options options;
 
@@ -59,6 +61,15 @@ static int set_option(const char *name, const char *value)
 			return -1;
 		return 1 /* TODO implement later */;
 	}
+	else if (!strcmp(name, "dry-run")) {
+		if (!strcmp(value, "true"))
+			options.dry_run = 1;
+		else if (!strcmp(value, "false"))
+			options.dry_run = 0;
+		else
+			return -1;
+		return 0;
+	}
 	else {
 		return 1 /* unsupported */;
 	}
@@ -136,6 +147,20 @@ static struct ref *get_refs(void)
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
 static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 {
 	char **targets = xmalloc(nr_heads * sizeof(char*));
@@ -211,6 +236,58 @@ static void parse_fetch(struct strbuf *buf)
 	strbuf_reset(buf);
 }
 
+static int push_dav(int nr_spec, char **specs)
+{
+	const char **argv = xmalloc((10 + nr_spec) * sizeof(char*));
+	int argc = 0, i;
+
+	argv[argc++] = "http-push";
+	argv[argc++] = "--helper-status";
+	if (options.dry_run)
+		argv[argc++] = "--dry-run";
+	if (options.verbosity > 1)
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
+
+	do {
+		if (!prefixcmp(buf->buf, "push ")) {
+			ALLOC_GROW(specs, nr_spec + 1, alloc_spec);
+			specs[nr_spec++] = xstrdup(buf->buf + 5);
+		}
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
+	if (push_dav(nr_spec, specs))
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
@@ -239,17 +316,12 @@ int main(int argc, const char **argv)
 		if (!prefixcmp(buf.buf, "fetch ")) {
 			parse_fetch(&buf);
 
-		} else if (!strcmp(buf.buf, "list")) {
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
+		} else if (!strcmp(buf.buf, "list") || !prefixcmp(buf.buf, "list ")) {
+			output_refs(get_refs());
+
+		} else if (!prefixcmp(buf.buf, "push ")) {
+			parse_push(&buf);
+
 		} else if (!prefixcmp(buf.buf, "option ")) {
 			char *name = buf.buf + strlen("option ");
 			char *value = strchr(name, ' ');
@@ -272,6 +344,7 @@ int main(int argc, const char **argv)
 		} else if (!strcmp(buf.buf, "capabilities")) {
 			printf("fetch\n");
 			printf("option\n");
+			printf("push\n");
 			printf("\n");
 			fflush(stdout);
 		} else {
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index f4a2cf6..09edd23 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -36,6 +36,7 @@ test_expect_success 'setup remote repository' '
 	cd test_repo.git &&
 	git --bare update-server-info &&
 	mv hooks/post-update.sample hooks/post-update &&
+	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
 	cd - &&
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
 '
@@ -45,7 +46,7 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/test_repo.git test_repo_clone
 '
 
-test_expect_failure 'push to remote repository with packed refs' '
+test_expect_success 'push to remote repository with packed refs' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
@@ -57,11 +58,15 @@ test_expect_failure 'push to remote repository with packed refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_success ' push to remote repository with unpacked refs' '
+test_expect_failure 'push already up-to-date' '
+	git push
+'
+
+test_expect_success 'push to remote repository with unpacked refs' '
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 rm packed-refs &&
-	 git update-ref refs/heads/master \
-		0c973ae9bd51902a28466f3850b543fa66a6aaf4) &&
+	 git update-ref refs/heads/master $ORIG_HEAD &&
+	 git --bare update-server-info) &&
 	git push &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
@@ -113,7 +118,6 @@ test_expect_success 'create and delete remote branch' '
 	git push origin dev &&
 	git fetch &&
 	git push origin :dev &&
-	git branch -d -r origin/dev &&
 	git fetch &&
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
diff --git a/transport-helper.c b/transport-helper.c
index 577abc6..16c6641 100644
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
@@ -13,7 +13,8 @@ struct helper_data
 	struct child_process *helper;
 	FILE *out;
 	unsigned fetch : 1,
-		option : 1;
+		option : 1,
+		push : 1;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -52,6 +53,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "option"))
 			data->option = 1;
+		if (!strcmp(buf.buf, "push"))
+			data->push = 1;
 	}
 	return data->helper;
 }
@@ -214,6 +217,130 @@ static int fetch(struct transport *transport,
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
+	transport->verbose = flags & TRANSPORT_PUSH_VERBOSE ? 1 : 0;
+	standard_options(transport);
+
+	if (flags & TRANSPORT_PUSH_DRY_RUN) {
+		if (set_helper_option(transport, "dry-run", "true") != 0)
+			die("helper %s does not support dry-run", data->name);
+	}
+
+	strbuf_addch(&buf, '\n');
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
@@ -225,7 +352,10 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	helper = get_helper(transport);
 
-	write_str_in_full(helper->in, "list\n");
+	if (data->push && for_push)
+		write_str_in_full(helper->in, "list for-push\n");
+	else
+		write_str_in_full(helper->in, "list\n");
 
 	while (1) {
 		char *eov, *eon;
@@ -266,6 +396,7 @@ int transport_helper_init(struct transport *transport, const char *name)
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
1.6.5.2.181.gd6f41
