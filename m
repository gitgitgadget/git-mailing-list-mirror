From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] fetch-pack: remove global (static) configuration variable "args"
Date: Fri, 26 Oct 2012 22:53:54 +0700
Message-ID: <1351266835-22610-7-git-send-email-pclouds@gmail.com>
References: <20121026120253.GA1455@sigill.intra.peff.net>
 <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:54:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmFL-0000P5-Jb
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946Ab2JZPym convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 11:54:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59578 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2JZPyk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:54:40 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2016315pad.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pwe4RmeUeZsByS+rU6MNS0QYP8PTAes3W0yGoBdDruE=;
        b=u9DH7H9dZbSlIgWBlIMdWd9/xyy+j5T9O3tCc4uhZ9kV5GqZ0MnA8DnUMWo6Egg7qD
         wu3asDk2PtHyxVrKNkgjcUEDC/nAO5LxNb7LlPTh5flWnhltF5rxmK1q4SKJ+1IsUy+I
         hjLoFwYYGeyutDt8Q6+eXZ5zH7HuY4RDunjXLXOsuZFpygkERFh5DNrHnxDsQOJhegEP
         qHO+UkiLbW8i2wevn9L8DjLZm6TdzO0Gp7uWyELHKxD1hMrhWjKvwAN1dEATd0wEFSVx
         3WApetL2MXKXdPe43Z2MTY74qtMaWTFOsvqTvYSGpxS/Eb1ZcPQAXGb/BlguI31kczfZ
         x7ew==
Received: by 10.68.190.71 with SMTP id go7mr71331292pbc.66.1351266880419;
        Fri, 26 Oct 2012 08:54:40 -0700 (PDT)
Received: from lanh ([115.74.33.44])
        by mx.google.com with ESMTPS id j4sm1189411pax.31.2012.10.26.08.54.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 08:54:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Oct 2012 22:54:40 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208462>

This helps removes the hack in fetch_pack() that copies my_args to args=
=2E

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c | 160 ++++++++++++++++++++++++++-----------------=
--------
 1 file changed, 83 insertions(+), 77 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index e644398..d0fd707 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -20,9 +20,6 @@ static int no_done;
 static int fetch_fsck_objects =3D -1;
 static int transfer_fsck_objects =3D -1;
 static int agent_supported;
-static struct fetch_pack_args args =3D {
-	/* .uploadpack =3D */ "git-upload-pack",
-};
=20
 static const char fetch_pack_usage[] =3D
 "git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
@@ -173,9 +170,9 @@ enum ack_type {
 	ACK_ready
 };
=20
-static void consume_shallow_list(int fd)
+static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 {
-	if (args.stateless_rpc && args.depth > 0) {
+	if (args->stateless_rpc && args->depth > 0) {
 		/* If we sent a depth we will get back "duplicate"
 		 * shallow and unshallow commands every time there
 		 * is a block of have lines exchanged.
@@ -246,9 +243,10 @@ static enum ack_type get_ack(int fd, unsigned char=
 *result_sha1)
 	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
 }
=20
-static void send_request(int fd, struct strbuf *buf)
+static void send_request(struct fetch_pack_args *args,
+			 int fd, struct strbuf *buf)
 {
-	if (args.stateless_rpc) {
+	if (args->stateless_rpc) {
 		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
 	} else
@@ -264,9 +262,9 @@ static void insert_one_alternate_ref(const struct r=
ef *ref, void *unused)
 #define PIPESAFE_FLUSH 32
 #define LARGE_FLUSH 1024
=20
-static int next_flush(int count)
+static int next_flush(struct fetch_pack_args *args, int count)
 {
-	int flush_limit =3D args.stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUSH=
;
+	int flush_limit =3D args->stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUS=
H;
=20
 	if (count < flush_limit)
 		count <<=3D 1;
@@ -275,7 +273,8 @@ static int next_flush(int count)
 	return count;
 }
=20
-static int find_common(int fd[2], unsigned char *result_sha1,
+static int find_common(struct fetch_pack_args *args,
+		       int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
 {
 	int fetching;
@@ -287,7 +286,7 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 	struct strbuf req_buf =3D STRBUF_INIT;
 	size_t state_len =3D 0;
=20
-	if (args.stateless_rpc && multi_ack =3D=3D 1)
+	if (args->stateless_rpc && multi_ack =3D=3D 1)
 		die("--stateless-rpc requires multi_ack_detailed");
 	if (marked)
 		for_each_ref(clear_marks, NULL);
@@ -325,9 +324,9 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 			if (no_done)            strbuf_addstr(&c, " no-done");
 			if (use_sideband =3D=3D 2)  strbuf_addstr(&c, " side-band-64k");
 			if (use_sideband =3D=3D 1)  strbuf_addstr(&c, " side-band");
-			if (args.use_thin_pack) strbuf_addstr(&c, " thin-pack");
-			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
-			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
+			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
+			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
+			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
 			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
 							    git_user_agent_sanitized());
@@ -346,16 +345,16 @@ static int find_common(int fd[2], unsigned char *=
result_sha1,
=20
 	if (is_repository_shallow())
 		write_shallow_commits(&req_buf, 1);
-	if (args.depth > 0)
-		packet_buf_write(&req_buf, "deepen %d", args.depth);
+	if (args->depth > 0)
+		packet_buf_write(&req_buf, "deepen %d", args->depth);
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
-	if (args.depth > 0) {
+	if (args->depth > 0) {
 		char line[1024];
 		unsigned char sha1[20];
=20
-		send_request(fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf);
 		while (packet_read_line(fd[0], line, sizeof(line))) {
 			if (!prefixcmp(line, "shallow ")) {
 				if (get_sha1_hex(line + 8, sha1))
@@ -377,10 +376,10 @@ static int find_common(int fd[2], unsigned char *=
result_sha1,
 			}
 			die("expected shallow/unshallow, got %s", line);
 		}
-	} else if (!args.stateless_rpc)
-		send_request(fd[1], &req_buf);
+	} else if (!args->stateless_rpc)
+		send_request(args, fd[1], &req_buf);
=20
-	if (!args.stateless_rpc) {
+	if (!args->stateless_rpc) {
 		/* If we aren't using the stateless-rpc interface
 		 * we don't need to retain the headers.
 		 */
@@ -392,29 +391,29 @@ static int find_common(int fd[2], unsigned char *=
result_sha1,
 	retval =3D -1;
 	while ((sha1 =3D get_rev())) {
 		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
-		if (args.verbose)
+		if (args->verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
 		in_vain++;
 		if (flush_at <=3D ++count) {
 			int ack;
=20
 			packet_buf_flush(&req_buf);
-			send_request(fd[1], &req_buf);
+			send_request(args, fd[1], &req_buf);
 			strbuf_setlen(&req_buf, state_len);
 			flushes++;
-			flush_at =3D next_flush(count);
+			flush_at =3D next_flush(args, count);
=20
 			/*
 			 * We keep one window "ahead" of the other side, and
 			 * will wait for an ACK only on the next one
 			 */
-			if (!args.stateless_rpc && count =3D=3D INITIAL_FLUSH)
+			if (!args->stateless_rpc && count =3D=3D INITIAL_FLUSH)
 				continue;
=20
-			consume_shallow_list(fd[0]);
+			consume_shallow_list(args, fd[0]);
 			do {
 				ack =3D get_ack(fd[0], result_sha1);
-				if (args.verbose && ack)
+				if (args->verbose && ack)
 					fprintf(stderr, "got ack %d %s\n", ack,
 							sha1_to_hex(result_sha1));
 				switch (ack) {
@@ -430,7 +429,7 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 						lookup_commit(result_sha1);
 					if (!commit)
 						die("invalid commit %s", sha1_to_hex(result_sha1));
-					if (args.stateless_rpc
+					if (args->stateless_rpc
 					 && ack =3D=3D ACK_common
 					 && !(commit->object.flags & COMMON)) {
 						/* We need to replay the have for this object
@@ -455,7 +454,7 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 			} while (ack);
 			flushes--;
 			if (got_continue && MAX_IN_VAIN < in_vain) {
-				if (args.verbose)
+				if (args->verbose)
 					fprintf(stderr, "giving up\n");
 				break; /* give up */
 			}
@@ -464,9 +463,9 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 done:
 	if (!got_ready || !no_done) {
 		packet_buf_write(&req_buf, "done\n");
-		send_request(fd[1], &req_buf);
+		send_request(args, fd[1], &req_buf);
 	}
-	if (args.verbose)
+	if (args->verbose)
 		fprintf(stderr, "done\n");
 	if (retval !=3D 0) {
 		multi_ack =3D 0;
@@ -474,11 +473,11 @@ done:
 	}
 	strbuf_release(&req_buf);
=20
-	consume_shallow_list(fd[0]);
+	consume_shallow_list(args, fd[0]);
 	while (flushes || multi_ack) {
 		int ack =3D get_ack(fd[0], result_sha1);
 		if (ack) {
-			if (args.verbose)
+			if (args->verbose)
 				fprintf(stderr, "got ack (%d) %s\n", ack,
 					sha1_to_hex(result_sha1));
 			if (ack =3D=3D ACK)
@@ -515,10 +514,11 @@ static int mark_complete(const char *refname, con=
st unsigned char *sha1, int fla
 	return 0;
 }
=20
-static void mark_recent_complete_commits(unsigned long cutoff)
+static void mark_recent_complete_commits(struct fetch_pack_args *args,
+					 unsigned long cutoff)
 {
 	while (complete && cutoff <=3D complete->item->date) {
-		if (args.verbose)
+		if (args->verbose)
 			fprintf(stderr, "Marking %s as complete\n",
 				sha1_to_hex(complete->item->object.sha1));
 		pop_most_recent_commit(&complete, COMPLETE);
@@ -535,7 +535,8 @@ static int non_matching_ref(struct string_list_item=
 *item, void *unused)
 		return 1;
 }
=20
-static void filter_refs(struct ref **refs, struct string_list *sought)
+static void filter_refs(struct fetch_pack_args *args,
+			struct ref **refs, struct string_list *sought)
 {
 	struct ref *newlist =3D NULL;
 	struct ref **newtail =3D &newlist;
@@ -564,8 +565,8 @@ static void filter_refs(struct ref **refs, struct s=
tring_list *sought)
 			}
 		}
=20
-		if (! keep && args.fetch_all &&
-		    (!args.depth || prefixcmp(ref->name, "refs/tags/")))
+		if (! keep && args->fetch_all &&
+		    (!args->depth || prefixcmp(ref->name, "refs/tags/")))
 			keep =3D 1;
=20
 		if (keep) {
@@ -586,7 +587,8 @@ static void mark_alternate_complete(const struct re=
f *ref, void *unused)
 	mark_complete(NULL, ref->old_sha1, 0, NULL);
 }
=20
-static int everything_local(struct ref **refs, struct string_list *sou=
ght)
+static int everything_local(struct fetch_pack_args *args,
+			    struct ref **refs, struct string_list *sought)
 {
 	struct ref *ref;
 	int retval;
@@ -612,11 +614,11 @@ static int everything_local(struct ref **refs, st=
ruct string_list *sought)
 		}
 	}
=20
-	if (!args.depth) {
+	if (!args->depth) {
 		for_each_ref(mark_complete, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
 		if (cutoff)
-			mark_recent_complete_commits(cutoff);
+			mark_recent_complete_commits(args, cutoff);
 	}
=20
 	/*
@@ -637,7 +639,7 @@ static int everything_local(struct ref **refs, stru=
ct string_list *sought)
 		}
 	}
=20
-	filter_refs(refs, sought);
+	filter_refs(args, refs, sought);
=20
 	for (retval =3D 1, ref =3D *refs; ref ; ref =3D ref->next) {
 		const unsigned char *remote =3D ref->old_sha1;
@@ -647,7 +649,7 @@ static int everything_local(struct ref **refs, stru=
ct string_list *sought)
 		o =3D lookup_object(remote);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval =3D 0;
-			if (!args.verbose)
+			if (!args->verbose)
 				continue;
 			fprintf(stderr,
 				"want %s (%s)\n", sha1_to_hex(remote),
@@ -656,7 +658,7 @@ static int everything_local(struct ref **refs, stru=
ct string_list *sought)
 		}
=20
 		hashcpy(ref->new_sha1, local);
-		if (!args.verbose)
+		if (!args->verbose)
 			continue;
 		fprintf(stderr,
 			"already have %s (%s)\n", sha1_to_hex(remote),
@@ -674,14 +676,15 @@ static int sideband_demux(int in, int out, void *=
data)
 	return ret;
 }
=20
-static int get_pack(int xd[2], char **pack_lockfile)
+static int get_pack(struct fetch_pack_args *args,
+		    int xd[2], char **pack_lockfile)
 {
 	struct async demux;
 	const char *argv[20];
 	char keep_arg[256];
 	char hdr_arg[256];
 	const char **av;
-	int do_keep =3D args.keep_pack;
+	int do_keep =3D args->keep_pack;
 	struct child_process cmd;
=20
 	memset(&demux, 0, sizeof(demux));
@@ -704,7 +707,7 @@ static int get_pack(int xd[2], char **pack_lockfile=
)
 	cmd.argv =3D argv;
 	av =3D argv;
 	*hdr_arg =3D 0;
-	if (!args.keep_pack && unpack_limit) {
+	if (!args->keep_pack && unpack_limit) {
 		struct pack_header header;
=20
 		if (read_pack_header(demux.out, &header))
@@ -723,11 +726,11 @@ static int get_pack(int xd[2], char **pack_lockfi=
le)
 			cmd.out =3D -1;
 		*av++ =3D "index-pack";
 		*av++ =3D "--stdin";
-		if (!args.quiet && !args.no_progress)
+		if (!args->quiet && !args->no_progress)
 			*av++ =3D "-v";
-		if (args.use_thin_pack)
+		if (args->use_thin_pack)
 			*av++ =3D "--fix-thin";
-		if (args.lock_pack || unpack_limit) {
+		if (args->lock_pack || unpack_limit) {
 			int s =3D sprintf(keep_arg,
 					"--keep=3Dfetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
 			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
@@ -737,7 +740,7 @@ static int get_pack(int xd[2], char **pack_lockfile=
)
 	}
 	else {
 		*av++ =3D "unpack-objects";
-		if (args.quiet || args.no_progress)
+		if (args->quiet || args->no_progress)
 			*av++ =3D "-q";
 	}
 	if (*hdr_arg)
@@ -766,10 +769,11 @@ static int get_pack(int xd[2], char **pack_lockfi=
le)
 	return 0;
 }
=20
-static struct ref *do_fetch_pack(int fd[2],
-		const struct ref *orig_ref,
-		struct string_list *sought,
-		char **pack_lockfile)
+static struct ref *do_fetch_pack(struct fetch_pack_args *args,
+				 int fd[2],
+				 const struct ref *orig_ref,
+				 struct string_list *sought,
+				 char **pack_lockfile)
 {
 	struct ref *ref =3D copy_ref_list(orig_ref);
 	unsigned char sha1[20];
@@ -781,64 +785,64 @@ static struct ref *do_fetch_pack(int fd[2],
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack_detailed")) {
-		if (args.verbose)
+		if (args->verbose)
 			fprintf(stderr, "Server supports multi_ack_detailed\n");
 		multi_ack =3D 2;
 		if (server_supports("no-done")) {
-			if (args.verbose)
+			if (args->verbose)
 				fprintf(stderr, "Server supports no-done\n");
-			if (args.stateless_rpc)
+			if (args->stateless_rpc)
 				no_done =3D 1;
 		}
 	}
 	else if (server_supports("multi_ack")) {
-		if (args.verbose)
+		if (args->verbose)
 			fprintf(stderr, "Server supports multi_ack\n");
 		multi_ack =3D 1;
 	}
 	if (server_supports("side-band-64k")) {
-		if (args.verbose)
+		if (args->verbose)
 			fprintf(stderr, "Server supports side-band-64k\n");
 		use_sideband =3D 2;
 	}
 	else if (server_supports("side-band")) {
-		if (args.verbose)
+		if (args->verbose)
 			fprintf(stderr, "Server supports side-band\n");
 		use_sideband =3D 1;
 	}
 	if (!server_supports("thin-pack"))
-		args.use_thin_pack =3D 0;
+		args->use_thin_pack =3D 0;
 	if (!server_supports("no-progress"))
-		args.no_progress =3D 0;
+		args->no_progress =3D 0;
 	if (!server_supports("include-tag"))
-		args.include_tag =3D 0;
+		args->include_tag =3D 0;
 	if (server_supports("ofs-delta")) {
-		if (args.verbose)
+		if (args->verbose)
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta =3D 0;
=20
 	if ((agent_feature =3D server_feature_value("agent", &agent_len))) {
 		agent_supported =3D 1;
-		if (args.verbose && agent_len)
+		if (args->verbose && agent_len)
 			fprintf(stderr, "Server version is %.*s\n",
 				agent_len, agent_feature);
 	}
=20
-	if (everything_local(&ref, sought)) {
+	if (everything_local(args, &ref, sought)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(fd, sha1, ref) < 0)
-		if (!args.keep_pack)
+	if (find_common(args, fd, sha1, ref) < 0)
+		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
 			 */
 			warning("no common commits");
=20
-	if (args.stateless_rpc)
+	if (args->stateless_rpc)
 		packet_flush(fd[1]);
-	if (get_pack(fd, pack_lockfile))
+	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
  all_done:
@@ -900,9 +904,13 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 	char *pack_lockfile =3D NULL;
 	char **pack_lockfile_ptr =3D NULL;
 	struct child_process *conn;
+	struct fetch_pack_args args;
=20
 	packet_trace_identity("fetch-pack");
=20
+	memset(&args, 0, sizeof(args));
+	args.uploadpack =3D "git-upload-pack";
+
 	for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
 		const char *arg =3D argv[i];
=20
@@ -1039,7 +1047,7 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
 	return ret;
 }
=20
-struct ref *fetch_pack(struct fetch_pack_args *my_args,
+struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
@@ -1050,9 +1058,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my=
_args,
 	struct ref *ref_cpy;
=20
 	fetch_pack_setup();
-	if (&args !=3D my_args)
-		memcpy(&args, my_args, sizeof(args));
-	if (args.depth > 0) {
+	if (args->depth > 0) {
 		if (stat(git_path("shallow"), &st))
 			st.st_mtime =3D 0;
 	}
@@ -1066,9 +1072,9 @@ struct ref *fetch_pack(struct fetch_pack_args *my=
_args,
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy =3D do_fetch_pack(fd, ref, sought, pack_lockfile);
+	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, pack_lockfile);
=20
-	if (args.depth > 0) {
+	if (args->depth > 0) {
 		struct cache_time mtime;
 		struct strbuf sb =3D STRBUF_INIT;
 		char *shallow =3D git_path("shallow");
--=20
1.8.0.rc2.23.g1fb49df
