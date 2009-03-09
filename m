From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2] Move push matching and reporting logic into
 transport.c
Date: Sun, 8 Mar 2009 21:06:07 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903082104490.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:07:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgTyE-0001Tz-Vn
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZCIBGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbZCIBGO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:06:14 -0400
Received: from iabervon.org ([66.92.72.58]:43453 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993AbZCIBGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:06:10 -0400
Received: (qmail 4836 invoked by uid 1000); 9 Mar 2009 01:06:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2009 01:06:07 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112659>

For native-protocol pushes (and other protocols as they are converted
to the new method), this moves the refspec match, tracking update, and
report message out of send-pack() and into transport_push(), where it
can be shared completely with other protocols. This also makes fetch
and push more similar in terms of what code is in what file.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-send-pack.c |  143 +++++++++++++-------------
 send-pack.h         |    6 +-
 transport.c         |  283 +++++++++++++++++++++++++++++++++++++++++++++++----
 transport.h         |    3 +-
 4 files changed, 343 insertions(+), 92 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 43b89ec..91c3651 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -11,7 +11,6 @@ static const char send_pack_usage[] =
 "  --all and explicit <ref> specification are mutually exclusive.";
 
 static struct send_pack_args args = {
-	/* .receivepack = */ "git-receive-pack",
 };
 
 static int feed_object(const unsigned char *sha1, int fd, int negative)
@@ -31,7 +30,7 @@ static int feed_object(const unsigned char *sha1, int fd, int negative)
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
-static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *extra)
+static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *extra, struct send_pack_args *args)
 {
 	/*
 	 * The child becomes pack-objects --revs; we feed
@@ -49,7 +48,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	struct child_process po;
 	int i;
 
-	if (args.use_thin_pack)
+	if (args->use_thin_pack)
 		argv[4] = "--thin";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
@@ -83,8 +82,6 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	return 0;
 }
 
-static struct ref *remote_refs, **remote_tail;
-
 static int receive_status(int in, struct ref *refs)
 {
 	struct ref *hint;
@@ -300,27 +297,19 @@ static int refs_pushed(struct ref *ref)
 	return 0;
 }
 
-static int do_send_pack(int in, int out, struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
+int send_pack(struct send_pack_args *args,
+	      int fd[], struct child_process *conn,
+	      struct ref *remote_refs,
+	      struct extra_have_objects *extra_have)
 {
-	struct ref *ref, *local_refs;
+	int in = fd[0];
+	int out = fd[1];
+	struct ref *ref;
 	int new_refs;
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
-	int flags = MATCH_REFS_NONE;
 	int ret;
-	struct extra_have_objects extra_have;
-
-	memset(&extra_have, 0, sizeof(extra_have));
-	if (args.send_all)
-		flags |= MATCH_REFS_ALL;
-	if (args.send_mirror)
-		flags |= MATCH_REFS_MIRROR;
-
-	/* No funny business with the matcher */
-	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL,
-				       &extra_have);
-	local_refs = get_local_heads();
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
@@ -328,19 +317,9 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
 
-	/* match them up */
-	if (!remote_tail)
-		remote_tail = &remote_refs;
-	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, flags)) {
-		close(out);
-		return -1;
-	}
-
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
 			"Perhaps you should specify a branch such as 'master'.\n");
-		close(out);
 		return 0;
 	}
 
@@ -352,7 +331,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 
 		if (ref->peer_ref)
 			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		else if (!args.send_mirror)
+		else if (!args->send_mirror)
 			continue;
 
 		ref->deletion = is_null_sha1(ref->new_sha1);
@@ -391,7 +370,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		    (!has_sha1_file(ref->old_sha1)
 		      || !ref_newer(ref->new_sha1, ref->old_sha1));
 
-		if (ref->nonfastforward && !ref->force && !args.force_update) {
+		if (ref->nonfastforward && !ref->force && !args->force_update) {
 			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
 			continue;
 		}
@@ -399,7 +378,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		if (!ref->deletion)
 			new_refs++;
 
-		if (!args.dry_run) {
+		if (!args->dry_run) {
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
@@ -420,27 +399,19 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	}
 
 	packet_flush(out);
-	if (new_refs && !args.dry_run) {
-		if (pack_objects(out, remote_refs, &extra_have) < 0)
+	if (new_refs && !args->dry_run) {
+		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
+			for (ref = remote_refs; ref; ref = ref->next)
+				ref->status = REF_STATUS_NONE;
 			return -1;
+		}
 	}
-	else
-		close(out);
 
 	if (expect_status_report)
 		ret = receive_status(in, remote_refs);
 	else
 		ret = 0;
 
-	print_push_status(dest, remote_refs);
-
-	if (!args.dry_run && remote) {
-		for (ref = remote_refs; ref; ref = ref->next)
-			update_tracking_ref(remote, ref);
-	}
-
-	if (!refs_pushed(remote_refs))
-		fprintf(stderr, "Everything up-to-date\n");
 	if (ret < 0)
 		return ret;
 	for (ref = remote_refs; ref; ref = ref->next) {
@@ -489,11 +460,19 @@ static void verify_remote_names(int nr_heads, const char **heads)
 
 int cmd_send_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, nr_heads = 0;
-	const char **heads = NULL;
+	int i, nr_refspecs = 0;
+	const char **refspecs = NULL;
 	const char *remote_name = NULL;
 	struct remote *remote = NULL;
 	const char *dest = NULL;
+	int fd[2];
+	struct child_process *conn;
+	struct extra_have_objects extra_have;
+	struct ref *remote_refs, **remote_tail, *local_refs;
+	int ret;
+	int send_all = 0;
+	const char *receivepack = "git-receive-pack";
+	int flags;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -501,11 +480,11 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 		if (*arg == '-') {
 			if (!prefixcmp(arg, "--receive-pack=")) {
-				args.receivepack = arg + 15;
+				receivepack = arg + 15;
 				continue;
 			}
 			if (!prefixcmp(arg, "--exec=")) {
-				args.receivepack = arg + 7;
+				receivepack = arg + 7;
 				continue;
 			}
 			if (!prefixcmp(arg, "--remote=")) {
@@ -513,7 +492,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				args.send_all = 1;
+				send_all = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--dry-run")) {
@@ -542,8 +521,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 			dest = arg;
 			continue;
 		}
-		heads = (const char **) argv;
-		nr_heads = argc - i;
+		refspecs = (const char **) argv;
+		nr_refspecs = argc - i;
 		break;
 	}
 	if (!dest)
@@ -552,8 +531,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	 * --all and --mirror are incompatible; neither makes sense
 	 * with any refspecs.
 	 */
-	if ((heads && (args.send_all || args.send_mirror)) ||
-					(args.send_all && args.send_mirror))
+	if ((refspecs && (send_all || args.send_mirror)) ||
+	    (send_all && args.send_mirror))
 		usage(send_pack_usage);
 
 	if (remote_name) {
@@ -564,24 +543,50 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	return send_pack(&args, dest, remote, nr_heads, heads);
-}
+	conn = git_connect(fd, dest, receivepack, args.verbose ? CONNECT_VERBOSE : 0);
 
-int send_pack(struct send_pack_args *my_args,
-	      const char *dest, struct remote *remote,
-	      int nr_heads, const char **heads)
-{
-	int fd[2], ret;
-	struct child_process *conn;
+	memset(&extra_have, 0, sizeof(extra_have));
+
+	get_remote_heads(fd[0], &remote_refs, 0, NULL, REF_NORMAL,
+			 &extra_have);
+
+	verify_remote_names(nr_refspecs, refspecs);
+
+	local_refs = get_local_heads();
 
-	memcpy(&args, my_args, sizeof(args));
+	flags = MATCH_REFS_NONE;
+
+	if (send_all)
+		flags |= MATCH_REFS_ALL;
+	if (args.send_mirror)
+		flags |= MATCH_REFS_MIRROR;
+
+	/* match them up */
+	remote_tail = &remote_refs;
+	while (*remote_tail)
+		remote_tail = &((*remote_tail)->next);
+	if (match_refs(local_refs, remote_refs, &remote_tail,
+		       nr_refspecs, refspecs, flags)) {
+		return -1;
+	}
 
-	verify_remote_names(nr_heads, heads);
+	ret = send_pack(&args, fd, conn, remote_refs, &extra_have);
 
-	conn = git_connect(fd, dest, args.receivepack, args.verbose ? CONNECT_VERBOSE : 0);
-	ret = do_send_pack(fd[0], fd[1], remote, dest, nr_heads, heads);
+	close(fd[1]);
 	close(fd[0]);
-	/* do_send_pack always closes fd[1] */
+
 	ret |= finish_connect(conn);
-	return !!ret;
+
+	print_push_status(dest, remote_refs);
+
+	if (!args.dry_run && remote) {
+		struct ref *ref;
+		for (ref = remote_refs; ref; ref = ref->next)
+			update_tracking_ref(remote, ref);
+	}
+
+	if (!ret && !refs_pushed(remote_refs))
+		fprintf(stderr, "Everything up-to-date\n");
+
+	return ret;
 }
diff --git a/send-pack.h b/send-pack.h
index 8ff1dc3..83d76c7 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -2,9 +2,7 @@
 #define SEND_PACK_H
 
 struct send_pack_args {
-	const char *receivepack;
 	unsigned verbose:1,
-		send_all:1,
 		send_mirror:1,
 		force_update:1,
 		use_thin_pack:1,
@@ -12,7 +10,7 @@ struct send_pack_args {
 };
 
 int send_pack(struct send_pack_args *args,
-	      const char *dest, struct remote *remote,
-	      int nr_heads, const char **heads);
+	      int fd[], struct child_process *conn,
+	      struct ref *remote_refs, struct extra_have_objects *extra_have);
 
 #endif
diff --git a/transport.c b/transport.c
index 9ad4a16..73bb9b5 100644
--- a/transport.c
+++ b/transport.c
@@ -138,7 +138,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 	}
 }
 
-static struct ref *get_refs_via_rsync(struct transport *transport)
+static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
 	struct ref dummy, *tail = &dummy;
@@ -146,6 +146,9 @@ static struct ref *get_refs_via_rsync(struct transport *transport)
 	const char *args[5];
 	int temp_dir_len;
 
+	if (for_push)
+		return NULL;
+
 	/* copy the refs to the temporary directory */
 
 	strbuf_addstr(&temp_dir, git_path("rsync-refs-XXXXXX"));
@@ -422,7 +425,7 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	return !!err;
 }
 
-static struct ref *get_refs_via_curl(struct transport *transport)
+static struct ref *get_refs_via_curl(struct transport *transport, int for_push)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	char *data, *start, *mid;
@@ -439,6 +442,9 @@ static struct ref *get_refs_via_curl(struct transport *transport)
 
 	struct walker *walker;
 
+	if (for_push)
+		return NULL;
+
 	if (!transport->data)
 		transport->data = get_http_walker(transport->url,
 						transport->remote);
@@ -525,12 +531,15 @@ struct bundle_transport_data {
 	struct bundle_header header;
 };
 
-static struct ref *get_refs_from_bundle(struct transport *transport)
+static struct ref *get_refs_from_bundle(struct transport *transport, int for_push)
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
 	int i;
 
+	if (for_push)
+		return NULL;
+
 	if (data->fd > 0)
 		close(data->fd);
 	data->fd = read_bundle_header(transport->url, &data->header);
@@ -571,6 +580,7 @@ struct git_transport_data {
 	int fd[2];
 	const char *uploadpack;
 	const char *receivepack;
+	struct extra_have_objects extra_have;
 };
 
 static int set_git_option(struct transport *connection,
@@ -602,20 +612,23 @@ static int set_git_option(struct transport *connection,
 	return 1;
 }
 
-static int connect_setup(struct transport *transport)
+static int connect_setup(struct transport *transport, int for_push, int verbose)
 {
 	struct git_transport_data *data = transport->data;
-	data->conn = git_connect(data->fd, transport->url, data->uploadpack, 0);
+	data->conn = git_connect(data->fd, transport->url,
+				 for_push ? data->receivepack : data->uploadpack,
+				 verbose ? CONNECT_VERBOSE : 0);
 	return 0;
 }
 
-static struct ref *get_refs_via_connect(struct transport *transport)
+static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
 
-	connect_setup(transport);
-	get_remote_heads(data->fd[0], &refs, 0, NULL, 0, NULL);
+	connect_setup(transport, for_push, 0);
+	get_remote_heads(data->fd[0], &refs, 0, NULL,
+			 for_push ? REF_NORMAL : 0, &data->extra_have);
 
 	return refs;
 }
@@ -647,7 +660,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 
 	if (!data->conn) {
-		connect_setup(transport);
+		connect_setup(transport, 0, 0);
 		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
 	}
 
@@ -670,20 +683,216 @@ static int fetch_refs_via_pack(struct transport *transport,
 	return (refs ? 0 : -1);
 }
 
-static int git_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
+static int refs_pushed(struct ref *ref)
+{
+	for (; ref; ref = ref->next) {
+		switch(ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_UPTODATE:
+			break;
+		default:
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
+{
+	struct refspec rs;
+
+	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
+		return;
+
+	rs.src = ref->name;
+	rs.dst = NULL;
+
+	if (!remote_find_tracking(remote, &rs)) {
+		if (verbose)
+			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
+		if (ref->deletion) {
+			delete_ref(rs.dst, NULL, 0);
+		} else
+			update_ref("update by push", rs.dst,
+					ref->new_sha1, NULL, 0, 0);
+		free(rs.dst);
+	}
+}
+
+#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+
+static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
+{
+	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
+	if (from)
+		fprintf(stderr, "%s -> %s", prettify_ref(from), prettify_ref(to));
+	else
+		fputs(prettify_ref(to), stderr);
+	if (msg) {
+		fputs(" (", stderr);
+		fputs(msg, stderr);
+		fputc(')', stderr);
+	}
+	fputc('\n', stderr);
+}
+
+static const char *status_abbrev(unsigned char sha1[20])
+{
+	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
+}
+
+static void print_ok_ref_status(struct ref *ref)
+{
+	if (ref->deletion)
+		print_ref_status('-', "[deleted]", ref, NULL, NULL);
+	else if (is_null_sha1(ref->old_sha1))
+		print_ref_status('*',
+			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
+			  "[new branch]"),
+			ref, ref->peer_ref, NULL);
+	else {
+		char quickref[84];
+		char type;
+		const char *msg;
+
+		strcpy(quickref, status_abbrev(ref->old_sha1));
+		if (ref->nonfastforward) {
+			strcat(quickref, "...");
+			type = '+';
+			msg = "forced update";
+		} else {
+			strcat(quickref, "..");
+			type = ' ';
+			msg = NULL;
+		}
+		strcat(quickref, status_abbrev(ref->new_sha1));
+
+		print_ref_status(type, quickref, ref, ref->peer_ref, msg);
+	}
+}
+
+static int print_one_push_status(struct ref *ref, const char *dest, int count)
+{
+	if (!count)
+		fprintf(stderr, "To %s\n", dest);
+
+	switch(ref->status) {
+	case REF_STATUS_NONE:
+		print_ref_status('X', "[no match]", ref, NULL, NULL);
+		break;
+	case REF_STATUS_REJECT_NODELETE:
+		print_ref_status('!', "[rejected]", ref, NULL,
+				"remote does not support deleting refs");
+		break;
+	case REF_STATUS_UPTODATE:
+		print_ref_status('=', "[up to date]", ref,
+				ref->peer_ref, NULL);
+		break;
+	case REF_STATUS_REJECT_NONFASTFORWARD:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+				"non-fast forward");
+		break;
+	case REF_STATUS_REMOTE_REJECT:
+		print_ref_status('!', "[remote rejected]", ref,
+				ref->deletion ? NULL : ref->peer_ref,
+				ref->remote_status);
+		break;
+	case REF_STATUS_EXPECTING_REPORT:
+		print_ref_status('!', "[remote failure]", ref,
+				ref->deletion ? NULL : ref->peer_ref,
+				"remote failed to report status");
+		break;
+	case REF_STATUS_OK:
+		print_ok_ref_status(ref);
+		break;
+	}
+
+	return 1;
+}
+
+static void print_push_status(const char *dest, struct ref *refs, int verbose)
+{
+	struct ref *ref;
+	int n = 0;
+
+	if (verbose) {
+		for (ref = refs; ref; ref = ref->next)
+			if (ref->status == REF_STATUS_UPTODATE)
+				n += print_one_push_status(ref, dest, n);
+	}
+
+	for (ref = refs; ref; ref = ref->next)
+		if (ref->status == REF_STATUS_OK)
+			n += print_one_push_status(ref, dest, n);
+
+	for (ref = refs; ref; ref = ref->next) {
+		if (ref->status != REF_STATUS_NONE &&
+		    ref->status != REF_STATUS_UPTODATE &&
+		    ref->status != REF_STATUS_OK)
+			n += print_one_push_status(ref, dest, n);
+	}
+}
+
+static void verify_remote_names(int nr_heads, const char **heads)
+{
+	int i;
+
+	for (i = 0; i < nr_heads; i++) {
+		const char *local = heads[i];
+		const char *remote = strrchr(heads[i], ':');
+
+		if (*local == '+')
+			local++;
+
+		/* A matching refspec is okay.  */
+		if (remote == local && remote[1] == '\0')
+			continue;
+
+		remote = remote ? (remote + 1) : local;
+		switch (check_ref_format(remote)) {
+		case 0: /* ok */
+		case CHECK_REF_FORMAT_ONELEVEL:
+			/* ok but a single level -- that is fine for
+			 * a match pattern.
+			 */
+		case CHECK_REF_FORMAT_WILDCARD:
+			/* ok but ends with a pattern-match character */
+			continue;
+		}
+		die("remote part of refspec is not a valid name in %s",
+		    heads[i]);
+	}
+}
+
+static int git_transport_push(struct transport *transport, struct ref *remote_refs, int flags)
 {
 	struct git_transport_data *data = transport->data;
 	struct send_pack_args args;
+	int ret;
+
+	if (!data->conn) {
+		struct ref *tmp_refs;
+		connect_setup(transport, 1, 0);
+
+		get_remote_heads(data->fd[0], &tmp_refs, 0, NULL, REF_NORMAL,
+				 NULL);
+	}
 
-	args.receivepack = data->receivepack;
-	args.send_all = !!(flags & TRANSPORT_PUSH_ALL);
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
 	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
 	args.use_thin_pack = data->thin;
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 
-	return send_pack(&args, transport->url, transport->remote, refspec_nr, refspec);
+	ret = send_pack(&args, data->fd, data->conn, remote_refs,
+			&data->extra_have);
+
+	close(data->fd[1]);
+	close(data->fd[0]);
+	ret |= finish_connect(data->conn);
+	data->conn = NULL;
+
+	return ret;
 }
 
 static int disconnect_git(struct transport *transport)
@@ -753,7 +962,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->set_option = set_git_option;
 		ret->get_refs_list = get_refs_via_connect;
 		ret->fetch = fetch_refs_via_pack;
-		ret->push = git_transport_push;
+		ret->push_refs = git_transport_push;
 		ret->disconnect = disconnect_git;
 
 		data->thin = 1;
@@ -780,15 +989,53 @@ int transport_set_option(struct transport *transport,
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags)
 {
-	if (!transport->push)
-		return 1;
-	return transport->push(transport, refspec_nr, refspec, flags);
+	verify_remote_names(refspec_nr, refspec);
+
+	if (transport->push)
+		return transport->push(transport, refspec_nr, refspec, flags);
+	if (transport->push_refs) {
+		struct ref *remote_refs =
+			transport->get_refs_list(transport, 1);
+		struct ref **remote_tail;
+		struct ref *local_refs = get_local_heads();
+		int match_flags = MATCH_REFS_NONE;
+		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
+		int ret;
+
+		if (flags & TRANSPORT_PUSH_ALL)
+			match_flags |= MATCH_REFS_ALL;
+		if (flags & TRANSPORT_PUSH_MIRROR)
+			match_flags |= MATCH_REFS_MIRROR;
+
+		remote_tail = &remote_refs;
+		while (*remote_tail)
+			remote_tail = &((*remote_tail)->next);
+		if (match_refs(local_refs, remote_refs, &remote_tail,
+			       refspec_nr, refspec, match_flags)) {
+			return -1;
+		}
+
+		ret = transport->push_refs(transport, remote_refs, flags);
+
+		print_push_status(transport->url, remote_refs, verbose);
+
+		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
+			struct ref *ref;
+			for (ref = remote_refs; ref; ref = ref->next)
+				update_tracking_ref(transport->remote, ref, verbose);
+		}
+
+		if (!ret && !refs_pushed(remote_refs))
+			fprintf(stderr, "Everything up-to-date\n");
+		return ret;
+	}
+	return 1;
 }
 
 const struct ref *transport_get_remote_refs(struct transport *transport)
 {
 	if (!transport->remote_refs)
-		transport->remote_refs = transport->get_refs_list(transport);
+		transport->remote_refs = transport->get_refs_list(transport, 0);
 	return transport->remote_refs;
 }
 
diff --git a/transport.h b/transport.h
index 6bbc1a8..b1c2252 100644
--- a/transport.h
+++ b/transport.h
@@ -18,8 +18,9 @@ struct transport {
 	int (*set_option)(struct transport *connection, const char *name,
 			  const char *value);
 
-	struct ref *(*get_refs_list)(struct transport *transport);
+	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
 	int (*fetch)(struct transport *transport, int refs_nr, const struct ref **refs);
+	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
 	int (*push)(struct transport *connection, int refspec_nr, const char **refspec, int flags);
 
 	int (*disconnect)(struct transport *connection);
-- 
1.6.1.286.gd33a4.dirty
