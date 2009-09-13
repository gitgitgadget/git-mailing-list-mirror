From: Owen Taylor <otaylor@redhat.com>
Subject: [PATCH 1/4] push: add --confirm option to ask before sending updates
Date: Sun, 13 Sep 2009 19:31:22 -0400
Message-ID: <1252884685-9169-2-git-send-email-otaylor@redhat.com>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
Cc: "Owen W. Taylor" <otaylor@fishsoup.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 01:31:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmyXm-0001Gx-Dh
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 01:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbZIMXb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 19:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbZIMXb1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 19:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbZIMXbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 19:31:24 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVRRO026018;
	Sun, 13 Sep 2009 19:31:27 -0400
Received: from localhost.localdomain (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVPJ0026475;
	Sun, 13 Sep 2009 19:31:26 -0400
In-Reply-To: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128429>

From: Owen W. Taylor <otaylor@fishsoup.net>

When --confirm is specified, the refs being updated are displayed
to the user first, and the user is prompted whether to proceed
or not.

Signed-off-by: Owen W. Taylor <otaylor@fishsoup.net>
---
 Documentation/git-push.txt |    9 ++++-
 builtin-push.c             |    8 +++--
 builtin-send-pack.c        |    4 ++-
 send-pack.h                |    3 +-
 transport.c                |   87 ++++++++++++++++++++++++++++++++++++++++----
 transport.h                |    3 +-
 6 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 58d2bd5..c0bbf16 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,8 +9,9 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [-v | --verbose]
+'git push' [--all | --mirror | --tags] [--dry-run] [--confirm]
+	   [--receive-pack=<git-receive-pack>]  [--repo=<repository>]
+	   [-f | --force] [-v | --verbose]
 	   [<repository> <refspec>...]
 
 DESCRIPTION
@@ -85,6 +86,10 @@ nor in any Push line of the corresponding remotes file---see below).
 --dry-run::
 	Do everything except actually send the updates.
 
+--confirm::
+	Print a summary of what will be done, and then ask the user
+	interactively before actually sending the updates.
+
 --porcelain::
 	Produce machine-readable output.  The output status line for each ref
 	will be tab-separated and sent to stdout instead of stderr.  The full
diff --git a/builtin-push.c b/builtin-push.c
index 6eda372..231be5d 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--dry-run] [--confirm] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -141,6 +141,7 @@ static int do_push(const char *repo, int flags)
 			transport_get(remote, url[i]);
 		int err;
 		int nonfastforward;
+		int disconfirmed;
 		if (receivepack)
 			transport_set_option(transport,
 					     TRANS_OPT_RECEIVEPACK, receivepack);
@@ -150,10 +151,10 @@ static int do_push(const char *repo, int flags)
 		if (flags & TRANSPORT_PUSH_VERBOSE)
 			fprintf(stderr, "Pushing to %s\n", url[i]);
 		err = transport_push(transport, refspec_nr, refspec, flags,
-				     &nonfastforward);
+				     &nonfastforward, &disconfirmed);
 		err |= transport_disconnect(transport);
 
-		if (!err)
+		if (!err || disconfirmed)
 			continue;
 
 		error("failed to push some refs to '%s'", url[i]);
@@ -182,6 +183,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
+		OPT_BIT( 0 , "confirm", &flags, "ask before pushing", TRANSPORT_PUSH_CONFIRM),
 		OPT_BIT( 0 , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 37e528e..0264180 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -406,7 +406,9 @@ int send_pack(struct send_pack_args *args,
 			REF_STATUS_OK;
 	}
 
-	packet_flush(out);
+	/* Don't flush until the second pass of 'git push --confirm' */
+	if (!(args->dry_run && args->confirm))
+		packet_flush(out);
 	if (new_refs && !args->dry_run) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
diff --git a/send-pack.h b/send-pack.h
index 8b3cf02..f2b9292 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -8,7 +8,8 @@ struct send_pack_args {
 		force_update:1,
 		use_thin_pack:1,
 		use_ofs_delta:1,
-		dry_run:1;
+		dry_run:1,
+		confirm:1;
 };
 
 int send_pack(struct send_pack_args *args,
diff --git a/transport.c b/transport.c
index 4cb8077..aa1852d 100644
--- a/transport.c
+++ b/transport.c
@@ -766,14 +766,18 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
 	args.quiet = !!(flags & TRANSPORT_PUSH_QUIET);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
+	args.confirm = !!(flags & TRANSPORT_PUSH_CONFIRM);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
 
-	close(data->fd[1]);
-	close(data->fd[0]);
-	ret |= finish_connect(data->conn);
-	data->conn = NULL;
+	/* On the first dry-run pass of --confirm, we need to leave the connection open */
+	if (!((flags & TRANSPORT_PUSH_CONFIRM) && (flags & TRANSPORT_PUSH_DRY_RUN))) {
+		close(data->fd[1]);
+		close(data->fd[0]);
+		ret |= finish_connect(data->conn);
+		data->conn = NULL;
+	}
 
 	return ret;
 }
@@ -867,14 +871,37 @@ int transport_set_option(struct transport *transport,
 	return 1;
 }
 
+static int prompt_yesno(const char *prompt)
+{
+	while (1) {
+		char buf[128];
+
+		fprintf(stderr, prompt);
+		if (!fgets(buf, sizeof(buf), stdin))
+			return 0;
+		if (buf[0] == 'y' || buf[0] == 'Y')
+			return 1;
+		else if (buf[0] == 'n' || buf[0] == 'N')
+			return 0;
+	}
+}
+
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
-		   int * nonfastforward)
+		   int * nonfastforward, int * disconfirmed)
 {
+	*disconfirmed = 0;
+
 	verify_remote_names(refspec_nr, refspec);
 
-	if (transport->push)
+	if (transport->push) {
+		if (flags & TRANSPORT_PUSH_CONFIRM) {
+			fprintf(stderr, "--confirm cannot be used with remote URL %s\n", transport->url);
+			return -1;
+		}
+
 		return transport->push(transport, refspec_nr, refspec, flags);
+	}
 	if (transport->push_refs) {
 		struct ref *remote_refs =
 			transport->get_refs_list(transport, 1);
@@ -883,6 +910,8 @@ int transport_push(struct transport *transport,
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
 		int quiet = flags & TRANSPORT_PUSH_QUIET;
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
+		int dry_run = flags & TRANSPORT_PUSH_DRY_RUN;
+		int confirm = flags & TRANSPORT_PUSH_CONFIRM;
 		int ret;
 
 		if (flags & TRANSPORT_PUSH_ALL)
@@ -895,14 +924,56 @@ int transport_push(struct transport *transport,
 			return -1;
 		}
 
+		/* --confirm is a no-op when --dry-run is also specified */
+		if (confirm && (dry_run || !isatty(0))) {
+			confirm = 0;
+			flags &= ~TRANSPORT_PUSH_CONFIRM;
+		}
+
+		if (confirm) {
+			struct ref *ref;
+			int proceed = 0;
+
+			ret = transport->push_refs(transport, remote_refs,
+						   flags | TRANSPORT_PUSH_DRY_RUN);
+
+			/* Interaction with --porcelain: we do the first pass interactively
+			 * to stderr with normal formatting, and then once the user has
+			 * confirmed, send the porcelain-formatted output to stdout.
+			 */
+			print_push_status(transport->url, remote_refs,
+					  verbose, 0,
+					  nonfastforward);
+
+			if (ret)
+				return ret;
+
+			if (!refs_pushed(remote_refs)) {
+				fprintf(stderr, "Everything up-to-date\n");
+				return 0;
+			}
+
+			proceed = prompt_yesno("Proceed [y/n]? ");
+			if (!proceed) {
+				*disconfirmed = 1;
+				return -1;
+			}
+
+			for (ref = remote_refs; ref; ref = ref->next)
+				ref->status = REF_STATUS_NONE;
+		}
+
 		ret = transport->push_refs(transport, remote_refs, flags);
 
-		if (!quiet || push_had_errors(remote_refs))
+		/* For --confirm, we don't need to print the details again unless
+		 * something unexpected happened (denyNonFastforwards=true perhaps)
+		 */
+		if (!(quiet || (confirm && !porcelain)) || push_had_errors(remote_refs))
 			print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
 					nonfastforward);
 
-		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
+		if (!dry_run) {
 			struct ref *ref;
 			for (ref = remote_refs; ref; ref = ref->next)
 				update_tracking_ref(transport->remote, ref, verbose);
diff --git a/transport.h b/transport.h
index c14da6f..1d691d7 100644
--- a/transport.h
+++ b/transport.h
@@ -37,6 +37,7 @@ struct transport {
 #define TRANSPORT_PUSH_VERBOSE 16
 #define TRANSPORT_PUSH_PORCELAIN 32
 #define TRANSPORT_PUSH_QUIET 64
+#define TRANSPORT_PUSH_CONFIRM 128
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
@@ -70,7 +71,7 @@ int transport_set_option(struct transport *transport, const char *name,
 
 int transport_push(struct transport *connection,
 		   int refspec_nr, const char **refspec, int flags,
-		   int * nonfastforward);
+		   int * nonfastforward, int * disconfirmed);
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-- 
1.6.2.5
