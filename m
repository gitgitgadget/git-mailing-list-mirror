From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/7] fetch-pack: move core code to libgit.a
Date: Fri, 26 Oct 2012 22:53:55 +0700
Message-ID: <1351266835-22610-8-git-send-email-pclouds@gmail.com>
References: <20121026120253.GA1455@sigill.intra.peff.net>
 <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:55:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmFX-0000V5-O7
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983Ab2JZPyt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 11:54:49 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59578 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2JZPyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:54:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2016315pad.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yS21eiFoqrQkSsRr+VBAuGPXAa8umTyCfbqGYHyFtAA=;
        b=rN0+qcs6CnSEEeihN6d2n/oW8F5dsni+YqRyoXxzeTEqVpo4Vu45lYXxE4v8DXUdOY
         3DxDbynuQQEcwSNFLSJhEPwZQUqJTxUQRJkoYgMPttmUa6SJ5TOwLOmZXzIHIre3jOgh
         xH5fow7+eQBVYx9W/XJlqKFGsCoQPBUHV34H1T3643pg6ceb8XLBX738WO4qZsxkdDwP
         to3yfR1YUdIC1FPeYgAU5ufclt2ASF8+AmJZgeZ/17UBueo3QLBxcf1p85yNTavendOt
         g0yalwyoCNlwTfImJ+V+3CyMRbQHchZZnYkz9Eh4uEsxl3Pz8H1+t+taBaD0u43AXRC2
         cSXg==
Received: by 10.68.217.201 with SMTP id pa9mr70719174pbc.45.1351266887461;
        Fri, 26 Oct 2012 08:54:47 -0700 (PDT)
Received: from lanh ([115.74.33.44])
        by mx.google.com with ESMTPS id ju7sm1348725pbb.60.2012.10.26.08.54.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 08:54:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Oct 2012 22:54:47 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208463>

fetch_pack() is used by transport.c, part of libgit.a while it stays
in builtin/fetch-pack.c. Move it to fetch-pack.c so that we won't get
undefined reference if a program that uses libgit.a happens to pull it
in.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile             |   1 +
 builtin/fetch-pack.c | 949 -------------------------------------------=
-------
 fetch-pack.c         | 951 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 952 insertions(+), 949 deletions(-)
 create mode 100644 fetch-pack.c

diff --git a/Makefile b/Makefile
index 414f15f..2997908 100644
--- a/Makefile
+++ b/Makefile
@@ -745,6 +745,7 @@ LIB_OBJS +=3D editor.o
 LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
+LIB_OBJS +=3D fetch-pack.o
 LIB_OBJS +=3D fsck.o
 LIB_OBJS +=3D gettext.o
 LIB_OBJS +=3D gpg-interface.o
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index d0fd707..570d26f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,899 +1,11 @@
 #include "builtin.h"
-#include "refs.h"
-#include "pkt-line.h"
-#include "commit.h"
-#include "tag.h"
-#include "exec_cmd.h"
-#include "pack.h"
-#include "sideband.h"
 #include "fetch-pack.h"
-#include "remote.h"
-#include "run-command.h"
-#include "transport.h"
-#include "version.h"
-
-static int transfer_unpack_limit =3D -1;
-static int fetch_unpack_limit =3D -1;
-static int unpack_limit =3D 100;
-static int prefer_ofs_delta =3D 1;
-static int no_done;
-static int fetch_fsck_objects =3D -1;
-static int transfer_fsck_objects =3D -1;
-static int agent_supported;
=20
 static const char fetch_pack_usage[] =3D
 "git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
 "[--include-tag] [--upload-pack=3D<git-upload-pack>] [--depth=3D<n>] "
 "[--no-progress] [-v] [<host>:]<directory> [<refs>...]";
=20
-#define COMPLETE	(1U << 0)
-#define COMMON		(1U << 1)
-#define COMMON_REF	(1U << 2)
-#define SEEN		(1U << 3)
-#define POPPED		(1U << 4)
-
-static int marked;
-
-/*
- * After sending this many "have"s if we do not get any new ACK , we
- * give up traversing our history.
- */
-#define MAX_IN_VAIN 256
-
-static struct commit_list *rev_list;
-static int non_common_revs, multi_ack, use_sideband;
-
-static void rev_list_push(struct commit *commit, int mark)
-{
-	if (!(commit->object.flags & mark)) {
-		commit->object.flags |=3D mark;
-
-		if (!(commit->object.parsed))
-			if (parse_commit(commit))
-				return;
-
-		commit_list_insert_by_date(commit, &rev_list);
-
-		if (!(commit->object.flags & COMMON))
-			non_common_revs++;
-	}
-}
-
-static int rev_list_insert_ref(const char *refname, const unsigned cha=
r *sha1, int flag, void *cb_data)
-{
-	struct object *o =3D deref_tag(parse_object(sha1), refname, 0);
-
-	if (o && o->type =3D=3D OBJ_COMMIT)
-		rev_list_push((struct commit *)o, SEEN);
-
-	return 0;
-}
-
-static int clear_marks(const char *refname, const unsigned char *sha1,=
 int flag, void *cb_data)
-{
-	struct object *o =3D deref_tag(parse_object(sha1), refname, 0);
-
-	if (o && o->type =3D=3D OBJ_COMMIT)
-		clear_commit_marks((struct commit *)o,
-				   COMMON | COMMON_REF | SEEN | POPPED);
-	return 0;
-}
-
-/*
-   This function marks a rev and its ancestors as common.
-   In some cases, it is desirable to mark only the ancestors (for exam=
ple
-   when only the server does not yet know that they are common).
-*/
-
-static void mark_common(struct commit *commit,
-		int ancestors_only, int dont_parse)
-{
-	if (commit !=3D NULL && !(commit->object.flags & COMMON)) {
-		struct object *o =3D (struct object *)commit;
-
-		if (!ancestors_only)
-			o->flags |=3D COMMON;
-
-		if (!(o->flags & SEEN))
-			rev_list_push(commit, SEEN);
-		else {
-			struct commit_list *parents;
-
-			if (!ancestors_only && !(o->flags & POPPED))
-				non_common_revs--;
-			if (!o->parsed && !dont_parse)
-				if (parse_commit(commit))
-					return;
-
-			for (parents =3D commit->parents;
-					parents;
-					parents =3D parents->next)
-				mark_common(parents->item, 0, dont_parse);
-		}
-	}
-}
-
-/*
-  Get the next rev to send, ignoring the common.
-*/
-
-static const unsigned char *get_rev(void)
-{
-	struct commit *commit =3D NULL;
-
-	while (commit =3D=3D NULL) {
-		unsigned int mark;
-		struct commit_list *parents;
-
-		if (rev_list =3D=3D NULL || non_common_revs =3D=3D 0)
-			return NULL;
-
-		commit =3D rev_list->item;
-		if (!commit->object.parsed)
-			parse_commit(commit);
-		parents =3D commit->parents;
-
-		commit->object.flags |=3D POPPED;
-		if (!(commit->object.flags & COMMON))
-			non_common_revs--;
-
-		if (commit->object.flags & COMMON) {
-			/* do not send "have", and ignore ancestors */
-			commit =3D NULL;
-			mark =3D COMMON | SEEN;
-		} else if (commit->object.flags & COMMON_REF)
-			/* send "have", and ignore ancestors */
-			mark =3D COMMON | SEEN;
-		else
-			/* send "have", also for its ancestors */
-			mark =3D SEEN;
-
-		while (parents) {
-			if (!(parents->item->object.flags & SEEN))
-				rev_list_push(parents->item, mark);
-			if (mark & COMMON)
-				mark_common(parents->item, 1, 0);
-			parents =3D parents->next;
-		}
-
-		rev_list =3D rev_list->next;
-	}
-
-	return commit->object.sha1;
-}
-
-enum ack_type {
-	NAK =3D 0,
-	ACK,
-	ACK_continue,
-	ACK_common,
-	ACK_ready
-};
-
-static void consume_shallow_list(struct fetch_pack_args *args, int fd)
-{
-	if (args->stateless_rpc && args->depth > 0) {
-		/* If we sent a depth we will get back "duplicate"
-		 * shallow and unshallow commands every time there
-		 * is a block of have lines exchanged.
-		 */
-		char line[1000];
-		while (packet_read_line(fd, line, sizeof(line))) {
-			if (!prefixcmp(line, "shallow "))
-				continue;
-			if (!prefixcmp(line, "unshallow "))
-				continue;
-			die("git fetch-pack: expected shallow list");
-		}
-	}
-}
-
-struct write_shallow_data {
-	struct strbuf *out;
-	int use_pack_protocol;
-	int count;
-};
-
-static int write_one_shallow(const struct commit_graft *graft, void *c=
b_data)
-{
-	struct write_shallow_data *data =3D cb_data;
-	const char *hex =3D sha1_to_hex(graft->sha1);
-	data->count++;
-	if (data->use_pack_protocol)
-		packet_buf_write(data->out, "shallow %s", hex);
-	else {
-		strbuf_addstr(data->out, hex);
-		strbuf_addch(data->out, '\n');
-	}
-	return 0;
-}
-
-static int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol)
-{
-	struct write_shallow_data data;
-	data.out =3D out;
-	data.use_pack_protocol =3D use_pack_protocol;
-	data.count =3D 0;
-	for_each_commit_graft(write_one_shallow, &data);
-	return data.count;
-}
-
-static enum ack_type get_ack(int fd, unsigned char *result_sha1)
-{
-	static char line[1000];
-	int len =3D packet_read_line(fd, line, sizeof(line));
-
-	if (!len)
-		die("git fetch-pack: expected ACK/NAK, got EOF");
-	if (line[len-1] =3D=3D '\n')
-		line[--len] =3D 0;
-	if (!strcmp(line, "NAK"))
-		return NAK;
-	if (!prefixcmp(line, "ACK ")) {
-		if (!get_sha1_hex(line+4, result_sha1)) {
-			if (strstr(line+45, "continue"))
-				return ACK_continue;
-			if (strstr(line+45, "common"))
-				return ACK_common;
-			if (strstr(line+45, "ready"))
-				return ACK_ready;
-			return ACK;
-		}
-	}
-	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
-}
-
-static void send_request(struct fetch_pack_args *args,
-			 int fd, struct strbuf *buf)
-{
-	if (args->stateless_rpc) {
-		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
-		packet_flush(fd);
-	} else
-		safe_write(fd, buf->buf, buf->len);
-}
-
-static void insert_one_alternate_ref(const struct ref *ref, void *unus=
ed)
-{
-	rev_list_insert_ref(NULL, ref->old_sha1, 0, NULL);
-}
-
-#define INITIAL_FLUSH 16
-#define PIPESAFE_FLUSH 32
-#define LARGE_FLUSH 1024
-
-static int next_flush(struct fetch_pack_args *args, int count)
-{
-	int flush_limit =3D args->stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUS=
H;
-
-	if (count < flush_limit)
-		count <<=3D 1;
-	else
-		count +=3D flush_limit;
-	return count;
-}
-
-static int find_common(struct fetch_pack_args *args,
-		       int fd[2], unsigned char *result_sha1,
-		       struct ref *refs)
-{
-	int fetching;
-	int count =3D 0, flushes =3D 0, flush_at =3D INITIAL_FLUSH, retval;
-	const unsigned char *sha1;
-	unsigned in_vain =3D 0;
-	int got_continue =3D 0;
-	int got_ready =3D 0;
-	struct strbuf req_buf =3D STRBUF_INIT;
-	size_t state_len =3D 0;
-
-	if (args->stateless_rpc && multi_ack =3D=3D 1)
-		die("--stateless-rpc requires multi_ack_detailed");
-	if (marked)
-		for_each_ref(clear_marks, NULL);
-	marked =3D 1;
-
-	for_each_ref(rev_list_insert_ref, NULL);
-	for_each_alternate_ref(insert_one_alternate_ref, NULL);
-
-	fetching =3D 0;
-	for ( ; refs ; refs =3D refs->next) {
-		unsigned char *remote =3D refs->old_sha1;
-		const char *remote_hex;
-		struct object *o;
-
-		/*
-		 * If that object is complete (i.e. it is an ancestor of a
-		 * local ref), we tell them we have it but do not have to
-		 * tell them about its ancestors, which they already know
-		 * about.
-		 *
-		 * We use lookup_object here because we are only
-		 * interested in the case we *know* the object is
-		 * reachable and we have already scanned it.
-		 */
-		if (((o =3D lookup_object(remote)) !=3D NULL) &&
-				(o->flags & COMPLETE)) {
-			continue;
-		}
-
-		remote_hex =3D sha1_to_hex(remote);
-		if (!fetching) {
-			struct strbuf c =3D STRBUF_INIT;
-			if (multi_ack =3D=3D 2)     strbuf_addstr(&c, " multi_ack_detailed"=
);
-			if (multi_ack =3D=3D 1)     strbuf_addstr(&c, " multi_ack");
-			if (no_done)            strbuf_addstr(&c, " no-done");
-			if (use_sideband =3D=3D 2)  strbuf_addstr(&c, " side-band-64k");
-			if (use_sideband =3D=3D 1)  strbuf_addstr(&c, " side-band");
-			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
-			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
-			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
-			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
-			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
-							    git_user_agent_sanitized());
-			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
-			strbuf_release(&c);
-		} else
-			packet_buf_write(&req_buf, "want %s\n", remote_hex);
-		fetching++;
-	}
-
-	if (!fetching) {
-		strbuf_release(&req_buf);
-		packet_flush(fd[1]);
-		return 1;
-	}
-
-	if (is_repository_shallow())
-		write_shallow_commits(&req_buf, 1);
-	if (args->depth > 0)
-		packet_buf_write(&req_buf, "deepen %d", args->depth);
-	packet_buf_flush(&req_buf);
-	state_len =3D req_buf.len;
-
-	if (args->depth > 0) {
-		char line[1024];
-		unsigned char sha1[20];
-
-		send_request(args, fd[1], &req_buf);
-		while (packet_read_line(fd[0], line, sizeof(line))) {
-			if (!prefixcmp(line, "shallow ")) {
-				if (get_sha1_hex(line + 8, sha1))
-					die("invalid shallow line: %s", line);
-				register_shallow(sha1);
-				continue;
-			}
-			if (!prefixcmp(line, "unshallow ")) {
-				if (get_sha1_hex(line + 10, sha1))
-					die("invalid unshallow line: %s", line);
-				if (!lookup_object(sha1))
-					die("object not found: %s", line);
-				/* make sure that it is parsed as shallow */
-				if (!parse_object(sha1))
-					die("error in object: %s", line);
-				if (unregister_shallow(sha1))
-					die("no shallow found: %s", line);
-				continue;
-			}
-			die("expected shallow/unshallow, got %s", line);
-		}
-	} else if (!args->stateless_rpc)
-		send_request(args, fd[1], &req_buf);
-
-	if (!args->stateless_rpc) {
-		/* If we aren't using the stateless-rpc interface
-		 * we don't need to retain the headers.
-		 */
-		strbuf_setlen(&req_buf, 0);
-		state_len =3D 0;
-	}
-
-	flushes =3D 0;
-	retval =3D -1;
-	while ((sha1 =3D get_rev())) {
-		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
-		if (args->verbose)
-			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
-		in_vain++;
-		if (flush_at <=3D ++count) {
-			int ack;
-
-			packet_buf_flush(&req_buf);
-			send_request(args, fd[1], &req_buf);
-			strbuf_setlen(&req_buf, state_len);
-			flushes++;
-			flush_at =3D next_flush(args, count);
-
-			/*
-			 * We keep one window "ahead" of the other side, and
-			 * will wait for an ACK only on the next one
-			 */
-			if (!args->stateless_rpc && count =3D=3D INITIAL_FLUSH)
-				continue;
-
-			consume_shallow_list(args, fd[0]);
-			do {
-				ack =3D get_ack(fd[0], result_sha1);
-				if (args->verbose && ack)
-					fprintf(stderr, "got ack %d %s\n", ack,
-							sha1_to_hex(result_sha1));
-				switch (ack) {
-				case ACK:
-					flushes =3D 0;
-					multi_ack =3D 0;
-					retval =3D 0;
-					goto done;
-				case ACK_common:
-				case ACK_ready:
-				case ACK_continue: {
-					struct commit *commit =3D
-						lookup_commit(result_sha1);
-					if (!commit)
-						die("invalid commit %s", sha1_to_hex(result_sha1));
-					if (args->stateless_rpc
-					 && ack =3D=3D ACK_common
-					 && !(commit->object.flags & COMMON)) {
-						/* We need to replay the have for this object
-						 * on the next RPC request so the peer knows
-						 * it is in common with us.
-						 */
-						const char *hex =3D sha1_to_hex(result_sha1);
-						packet_buf_write(&req_buf, "have %s\n", hex);
-						state_len =3D req_buf.len;
-					}
-					mark_common(commit, 0, 1);
-					retval =3D 0;
-					in_vain =3D 0;
-					got_continue =3D 1;
-					if (ack =3D=3D ACK_ready) {
-						rev_list =3D NULL;
-						got_ready =3D 1;
-					}
-					break;
-					}
-				}
-			} while (ack);
-			flushes--;
-			if (got_continue && MAX_IN_VAIN < in_vain) {
-				if (args->verbose)
-					fprintf(stderr, "giving up\n");
-				break; /* give up */
-			}
-		}
-	}
-done:
-	if (!got_ready || !no_done) {
-		packet_buf_write(&req_buf, "done\n");
-		send_request(args, fd[1], &req_buf);
-	}
-	if (args->verbose)
-		fprintf(stderr, "done\n");
-	if (retval !=3D 0) {
-		multi_ack =3D 0;
-		flushes++;
-	}
-	strbuf_release(&req_buf);
-
-	consume_shallow_list(args, fd[0]);
-	while (flushes || multi_ack) {
-		int ack =3D get_ack(fd[0], result_sha1);
-		if (ack) {
-			if (args->verbose)
-				fprintf(stderr, "got ack (%d) %s\n", ack,
-					sha1_to_hex(result_sha1));
-			if (ack =3D=3D ACK)
-				return 0;
-			multi_ack =3D 1;
-			continue;
-		}
-		flushes--;
-	}
-	/* it is no error to fetch into a completely empty repo */
-	return count ? retval : 0;
-}
-
-static struct commit_list *complete;
-
-static int mark_complete(const char *refname, const unsigned char *sha=
1, int flag, void *cb_data)
-{
-	struct object *o =3D parse_object(sha1);
-
-	while (o && o->type =3D=3D OBJ_TAG) {
-		struct tag *t =3D (struct tag *) o;
-		if (!t->tagged)
-			break; /* broken repository */
-		o->flags |=3D COMPLETE;
-		o =3D parse_object(t->tagged->sha1);
-	}
-	if (o && o->type =3D=3D OBJ_COMMIT) {
-		struct commit *commit =3D (struct commit *)o;
-		if (!(commit->object.flags & COMPLETE)) {
-			commit->object.flags |=3D COMPLETE;
-			commit_list_insert_by_date(commit, &complete);
-		}
-	}
-	return 0;
-}
-
-static void mark_recent_complete_commits(struct fetch_pack_args *args,
-					 unsigned long cutoff)
-{
-	while (complete && cutoff <=3D complete->item->date) {
-		if (args->verbose)
-			fprintf(stderr, "Marking %s as complete\n",
-				sha1_to_hex(complete->item->object.sha1));
-		pop_most_recent_commit(&complete, COMPLETE);
-	}
-}
-
-static int non_matching_ref(struct string_list_item *item, void *unuse=
d)
-{
-	if (item->util) {
-		item->util =3D NULL;
-		return 0;
-	}
-	else
-		return 1;
-}
-
-static void filter_refs(struct fetch_pack_args *args,
-			struct ref **refs, struct string_list *sought)
-{
-	struct ref *newlist =3D NULL;
-	struct ref **newtail =3D &newlist;
-	struct ref *ref, *next;
-	int sought_pos;
-
-	sought_pos =3D 0;
-	for (ref =3D *refs; ref; ref =3D next) {
-		int keep =3D 0;
-		next =3D ref->next;
-		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_refname_format(ref->name + 5, 0))
-			; /* trash */
-		else {
-			while (sought_pos < sought->nr) {
-				int cmp =3D strcmp(ref->name, sought->items[sought_pos].string);
-				if (cmp < 0)
-					break; /* definitely do not have it */
-				else if (cmp =3D=3D 0) {
-					keep =3D 1; /* definitely have it */
-					sought->items[sought_pos++].util =3D "matched";
-					break;
-				}
-				else
-					sought_pos++; /* might have it; keep looking */
-			}
-		}
-
-		if (! keep && args->fetch_all &&
-		    (!args->depth || prefixcmp(ref->name, "refs/tags/")))
-			keep =3D 1;
-
-		if (keep) {
-			*newtail =3D ref;
-			ref->next =3D NULL;
-			newtail =3D &ref->next;
-		} else {
-			free(ref);
-		}
-	}
-
-	filter_string_list(sought, 0, non_matching_ref, NULL);
-	*refs =3D newlist;
-}
-
-static void mark_alternate_complete(const struct ref *ref, void *unuse=
d)
-{
-	mark_complete(NULL, ref->old_sha1, 0, NULL);
-}
-
-static int everything_local(struct fetch_pack_args *args,
-			    struct ref **refs, struct string_list *sought)
-{
-	struct ref *ref;
-	int retval;
-	unsigned long cutoff =3D 0;
-
-	save_commit_buffer =3D 0;
-
-	for (ref =3D *refs; ref; ref =3D ref->next) {
-		struct object *o;
-
-		o =3D parse_object(ref->old_sha1);
-		if (!o)
-			continue;
-
-		/* We already have it -- which may mean that we were
-		 * in sync with the other side at some time after
-		 * that (it is OK if we guess wrong here).
-		 */
-		if (o->type =3D=3D OBJ_COMMIT) {
-			struct commit *commit =3D (struct commit *)o;
-			if (!cutoff || cutoff < commit->date)
-				cutoff =3D commit->date;
-		}
-	}
-
-	if (!args->depth) {
-		for_each_ref(mark_complete, NULL);
-		for_each_alternate_ref(mark_alternate_complete, NULL);
-		if (cutoff)
-			mark_recent_complete_commits(args, cutoff);
-	}
-
-	/*
-	 * Mark all complete remote refs as common refs.
-	 * Don't mark them common yet; the server has to be told so first.
-	 */
-	for (ref =3D *refs; ref; ref =3D ref->next) {
-		struct object *o =3D deref_tag(lookup_object(ref->old_sha1),
-					     NULL, 0);
-
-		if (!o || o->type !=3D OBJ_COMMIT || !(o->flags & COMPLETE))
-			continue;
-
-		if (!(o->flags & SEEN)) {
-			rev_list_push((struct commit *)o, COMMON_REF | SEEN);
-
-			mark_common((struct commit *)o, 1, 1);
-		}
-	}
-
-	filter_refs(args, refs, sought);
-
-	for (retval =3D 1, ref =3D *refs; ref ; ref =3D ref->next) {
-		const unsigned char *remote =3D ref->old_sha1;
-		unsigned char local[20];
-		struct object *o;
-
-		o =3D lookup_object(remote);
-		if (!o || !(o->flags & COMPLETE)) {
-			retval =3D 0;
-			if (!args->verbose)
-				continue;
-			fprintf(stderr,
-				"want %s (%s)\n", sha1_to_hex(remote),
-				ref->name);
-			continue;
-		}
-
-		hashcpy(ref->new_sha1, local);
-		if (!args->verbose)
-			continue;
-		fprintf(stderr,
-			"already have %s (%s)\n", sha1_to_hex(remote),
-			ref->name);
-	}
-	return retval;
-}
-
-static int sideband_demux(int in, int out, void *data)
-{
-	int *xd =3D data;
-
-	int ret =3D recv_sideband("fetch-pack", xd[0], out);
-	close(out);
-	return ret;
-}
-
-static int get_pack(struct fetch_pack_args *args,
-		    int xd[2], char **pack_lockfile)
-{
-	struct async demux;
-	const char *argv[20];
-	char keep_arg[256];
-	char hdr_arg[256];
-	const char **av;
-	int do_keep =3D args->keep_pack;
-	struct child_process cmd;
-
-	memset(&demux, 0, sizeof(demux));
-	if (use_sideband) {
-		/* xd[] is talking with upload-pack; subprocess reads from
-		 * xd[0], spits out band#2 to stderr, and feeds us band#1
-		 * through demux->out.
-		 */
-		demux.proc =3D sideband_demux;
-		demux.data =3D xd;
-		demux.out =3D -1;
-		if (start_async(&demux))
-			die("fetch-pack: unable to fork off sideband"
-			    " demultiplexer");
-	}
-	else
-		demux.out =3D xd[0];
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.argv =3D argv;
-	av =3D argv;
-	*hdr_arg =3D 0;
-	if (!args->keep_pack && unpack_limit) {
-		struct pack_header header;
-
-		if (read_pack_header(demux.out, &header))
-			die("protocol error: bad pack header");
-		snprintf(hdr_arg, sizeof(hdr_arg),
-			 "--pack_header=3D%"PRIu32",%"PRIu32,
-			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
-		if (ntohl(header.hdr_entries) < unpack_limit)
-			do_keep =3D 0;
-		else
-			do_keep =3D 1;
-	}
-
-	if (do_keep) {
-		if (pack_lockfile)
-			cmd.out =3D -1;
-		*av++ =3D "index-pack";
-		*av++ =3D "--stdin";
-		if (!args->quiet && !args->no_progress)
-			*av++ =3D "-v";
-		if (args->use_thin_pack)
-			*av++ =3D "--fix-thin";
-		if (args->lock_pack || unpack_limit) {
-			int s =3D sprintf(keep_arg,
-					"--keep=3Dfetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
-			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
-				strcpy(keep_arg + s, "localhost");
-			*av++ =3D keep_arg;
-		}
-	}
-	else {
-		*av++ =3D "unpack-objects";
-		if (args->quiet || args->no_progress)
-			*av++ =3D "-q";
-	}
-	if (*hdr_arg)
-		*av++ =3D hdr_arg;
-	if (fetch_fsck_objects >=3D 0
-	    ? fetch_fsck_objects
-	    : transfer_fsck_objects >=3D 0
-	    ? transfer_fsck_objects
-	    : 0)
-		*av++ =3D "--strict";
-	*av++ =3D NULL;
-
-	cmd.in =3D demux.out;
-	cmd.git_cmd =3D 1;
-	if (start_command(&cmd))
-		die("fetch-pack: unable to fork off %s", argv[0]);
-	if (do_keep && pack_lockfile) {
-		*pack_lockfile =3D index_pack_lockfile(cmd.out);
-		close(cmd.out);
-	}
-
-	if (finish_command(&cmd))
-		die("%s failed", argv[0]);
-	if (use_sideband && finish_async(&demux))
-		die("error in sideband demultiplexer");
-	return 0;
-}
-
-static struct ref *do_fetch_pack(struct fetch_pack_args *args,
-				 int fd[2],
-				 const struct ref *orig_ref,
-				 struct string_list *sought,
-				 char **pack_lockfile)
-{
-	struct ref *ref =3D copy_ref_list(orig_ref);
-	unsigned char sha1[20];
-	const char *agent_feature;
-	int agent_len;
-
-	sort_ref_list(&ref, ref_compare_name);
-
-	if (is_repository_shallow() && !server_supports("shallow"))
-		die("Server does not support shallow clients");
-	if (server_supports("multi_ack_detailed")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports multi_ack_detailed\n");
-		multi_ack =3D 2;
-		if (server_supports("no-done")) {
-			if (args->verbose)
-				fprintf(stderr, "Server supports no-done\n");
-			if (args->stateless_rpc)
-				no_done =3D 1;
-		}
-	}
-	else if (server_supports("multi_ack")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports multi_ack\n");
-		multi_ack =3D 1;
-	}
-	if (server_supports("side-band-64k")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports side-band-64k\n");
-		use_sideband =3D 2;
-	}
-	else if (server_supports("side-band")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports side-band\n");
-		use_sideband =3D 1;
-	}
-	if (!server_supports("thin-pack"))
-		args->use_thin_pack =3D 0;
-	if (!server_supports("no-progress"))
-		args->no_progress =3D 0;
-	if (!server_supports("include-tag"))
-		args->include_tag =3D 0;
-	if (server_supports("ofs-delta")) {
-		if (args->verbose)
-			fprintf(stderr, "Server supports ofs-delta\n");
-	} else
-		prefer_ofs_delta =3D 0;
-
-	if ((agent_feature =3D server_feature_value("agent", &agent_len))) {
-		agent_supported =3D 1;
-		if (args->verbose && agent_len)
-			fprintf(stderr, "Server version is %.*s\n",
-				agent_len, agent_feature);
-	}
-
-	if (everything_local(args, &ref, sought)) {
-		packet_flush(fd[1]);
-		goto all_done;
-	}
-	if (find_common(args, fd, sha1, ref) < 0)
-		if (!args->keep_pack)
-			/* When cloning, it is not unusual to have
-			 * no common commit.
-			 */
-			warning("no common commits");
-
-	if (args->stateless_rpc)
-		packet_flush(fd[1]);
-	if (get_pack(args, fd, pack_lockfile))
-		die("git fetch-pack: fetch failed.");
-
- all_done:
-	return ref;
-}
-
-static int fetch_pack_config(const char *var, const char *value, void =
*cb)
-{
-	if (strcmp(var, "fetch.unpacklimit") =3D=3D 0) {
-		fetch_unpack_limit =3D git_config_int(var, value);
-		return 0;
-	}
-
-	if (strcmp(var, "transfer.unpacklimit") =3D=3D 0) {
-		transfer_unpack_limit =3D git_config_int(var, value);
-		return 0;
-	}
-
-	if (strcmp(var, "repack.usedeltabaseoffset") =3D=3D 0) {
-		prefer_ofs_delta =3D git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "fetch.fsckobjects")) {
-		fetch_fsck_objects =3D git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "transfer.fsckobjects")) {
-		transfer_fsck_objects =3D git_config_bool(var, value);
-		return 0;
-	}
-
-	return git_default_config(var, value, cb);
-}
-
-static struct lock_file lock;
-
-static void fetch_pack_setup(void)
-{
-	static int did_setup;
-	if (did_setup)
-		return;
-	git_config(fetch_pack_config, NULL);
-	if (0 <=3D transfer_unpack_limit)
-		unpack_limit =3D transfer_unpack_limit;
-	else if (0 <=3D fetch_unpack_limit)
-		unpack_limit =3D fetch_unpack_limit;
-	did_setup =3D 1;
-}
-
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret;
@@ -1046,64 +158,3 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
=20
 	return ret;
 }
-
-struct ref *fetch_pack(struct fetch_pack_args *args,
-		       int fd[], struct child_process *conn,
-		       const struct ref *ref,
-		       const char *dest,
-		       struct string_list *sought,
-		       char **pack_lockfile)
-{
-	struct stat st;
-	struct ref *ref_cpy;
-
-	fetch_pack_setup();
-	if (args->depth > 0) {
-		if (stat(git_path("shallow"), &st))
-			st.st_mtime =3D 0;
-	}
-
-	if (sought->nr) {
-		sort_string_list(sought);
-		string_list_remove_duplicates(sought, 0);
-	}
-
-	if (!ref) {
-		packet_flush(fd[1]);
-		die("no matching remote head");
-	}
-	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, pack_lockfile);
-
-	if (args->depth > 0) {
-		struct cache_time mtime;
-		struct strbuf sb =3D STRBUF_INIT;
-		char *shallow =3D git_path("shallow");
-		int fd;
-
-		mtime.sec =3D st.st_mtime;
-		mtime.nsec =3D ST_MTIME_NSEC(st);
-		if (stat(shallow, &st)) {
-			if (mtime.sec)
-				die("shallow file was removed during fetch");
-		} else if (st.st_mtime !=3D mtime.sec
-#ifdef USE_NSEC
-				|| ST_MTIME_NSEC(st) !=3D mtime.nsec
-#endif
-			  )
-			die("shallow file was changed during fetch");
-
-		fd =3D hold_lock_file_for_update(&lock, shallow,
-					       LOCK_DIE_ON_ERROR);
-		if (!write_shallow_commits(&sb, 0)
-		 || write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
-			unlink_or_warn(shallow);
-			rollback_lock_file(&lock);
-		} else {
-			commit_lock_file(&lock);
-		}
-		strbuf_release(&sb);
-	}
-
-	reprepare_packed_git();
-	return ref_cpy;
-}
diff --git a/fetch-pack.c b/fetch-pack.c
new file mode 100644
index 0000000..099ff4d
--- /dev/null
+++ b/fetch-pack.c
@@ -0,0 +1,951 @@
+#include "cache.h"
+#include "refs.h"
+#include "pkt-line.h"
+#include "commit.h"
+#include "tag.h"
+#include "exec_cmd.h"
+#include "pack.h"
+#include "sideband.h"
+#include "fetch-pack.h"
+#include "remote.h"
+#include "run-command.h"
+#include "transport.h"
+#include "version.h"
+
+static int transfer_unpack_limit =3D -1;
+static int fetch_unpack_limit =3D -1;
+static int unpack_limit =3D 100;
+static int prefer_ofs_delta =3D 1;
+static int no_done;
+static int fetch_fsck_objects =3D -1;
+static int transfer_fsck_objects =3D -1;
+static int agent_supported;
+
+#define COMPLETE	(1U << 0)
+#define COMMON		(1U << 1)
+#define COMMON_REF	(1U << 2)
+#define SEEN		(1U << 3)
+#define POPPED		(1U << 4)
+
+static int marked;
+
+/*
+ * After sending this many "have"s if we do not get any new ACK , we
+ * give up traversing our history.
+ */
+#define MAX_IN_VAIN 256
+
+static struct commit_list *rev_list;
+static int non_common_revs, multi_ack, use_sideband;
+
+static void rev_list_push(struct commit *commit, int mark)
+{
+	if (!(commit->object.flags & mark)) {
+		commit->object.flags |=3D mark;
+
+		if (!(commit->object.parsed))
+			if (parse_commit(commit))
+				return;
+
+		commit_list_insert_by_date(commit, &rev_list);
+
+		if (!(commit->object.flags & COMMON))
+			non_common_revs++;
+	}
+}
+
+static int rev_list_insert_ref(const char *refname, const unsigned cha=
r *sha1, int flag, void *cb_data)
+{
+	struct object *o =3D deref_tag(parse_object(sha1), refname, 0);
+
+	if (o && o->type =3D=3D OBJ_COMMIT)
+		rev_list_push((struct commit *)o, SEEN);
+
+	return 0;
+}
+
+static int clear_marks(const char *refname, const unsigned char *sha1,=
 int flag, void *cb_data)
+{
+	struct object *o =3D deref_tag(parse_object(sha1), refname, 0);
+
+	if (o && o->type =3D=3D OBJ_COMMIT)
+		clear_commit_marks((struct commit *)o,
+				   COMMON | COMMON_REF | SEEN | POPPED);
+	return 0;
+}
+
+/*
+   This function marks a rev and its ancestors as common.
+   In some cases, it is desirable to mark only the ancestors (for exam=
ple
+   when only the server does not yet know that they are common).
+*/
+
+static void mark_common(struct commit *commit,
+		int ancestors_only, int dont_parse)
+{
+	if (commit !=3D NULL && !(commit->object.flags & COMMON)) {
+		struct object *o =3D (struct object *)commit;
+
+		if (!ancestors_only)
+			o->flags |=3D COMMON;
+
+		if (!(o->flags & SEEN))
+			rev_list_push(commit, SEEN);
+		else {
+			struct commit_list *parents;
+
+			if (!ancestors_only && !(o->flags & POPPED))
+				non_common_revs--;
+			if (!o->parsed && !dont_parse)
+				if (parse_commit(commit))
+					return;
+
+			for (parents =3D commit->parents;
+					parents;
+					parents =3D parents->next)
+				mark_common(parents->item, 0, dont_parse);
+		}
+	}
+}
+
+/*
+  Get the next rev to send, ignoring the common.
+*/
+
+static const unsigned char *get_rev(void)
+{
+	struct commit *commit =3D NULL;
+
+	while (commit =3D=3D NULL) {
+		unsigned int mark;
+		struct commit_list *parents;
+
+		if (rev_list =3D=3D NULL || non_common_revs =3D=3D 0)
+			return NULL;
+
+		commit =3D rev_list->item;
+		if (!commit->object.parsed)
+			parse_commit(commit);
+		parents =3D commit->parents;
+
+		commit->object.flags |=3D POPPED;
+		if (!(commit->object.flags & COMMON))
+			non_common_revs--;
+
+		if (commit->object.flags & COMMON) {
+			/* do not send "have", and ignore ancestors */
+			commit =3D NULL;
+			mark =3D COMMON | SEEN;
+		} else if (commit->object.flags & COMMON_REF)
+			/* send "have", and ignore ancestors */
+			mark =3D COMMON | SEEN;
+		else
+			/* send "have", also for its ancestors */
+			mark =3D SEEN;
+
+		while (parents) {
+			if (!(parents->item->object.flags & SEEN))
+				rev_list_push(parents->item, mark);
+			if (mark & COMMON)
+				mark_common(parents->item, 1, 0);
+			parents =3D parents->next;
+		}
+
+		rev_list =3D rev_list->next;
+	}
+
+	return commit->object.sha1;
+}
+
+enum ack_type {
+	NAK =3D 0,
+	ACK,
+	ACK_continue,
+	ACK_common,
+	ACK_ready
+};
+
+static void consume_shallow_list(struct fetch_pack_args *args, int fd)
+{
+	if (args->stateless_rpc && args->depth > 0) {
+		/* If we sent a depth we will get back "duplicate"
+		 * shallow and unshallow commands every time there
+		 * is a block of have lines exchanged.
+		 */
+		char line[1000];
+		while (packet_read_line(fd, line, sizeof(line))) {
+			if (!prefixcmp(line, "shallow "))
+				continue;
+			if (!prefixcmp(line, "unshallow "))
+				continue;
+			die("git fetch-pack: expected shallow list");
+		}
+	}
+}
+
+struct write_shallow_data {
+	struct strbuf *out;
+	int use_pack_protocol;
+	int count;
+};
+
+static int write_one_shallow(const struct commit_graft *graft, void *c=
b_data)
+{
+	struct write_shallow_data *data =3D cb_data;
+	const char *hex =3D sha1_to_hex(graft->sha1);
+	data->count++;
+	if (data->use_pack_protocol)
+		packet_buf_write(data->out, "shallow %s", hex);
+	else {
+		strbuf_addstr(data->out, hex);
+		strbuf_addch(data->out, '\n');
+	}
+	return 0;
+}
+
+static int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol)
+{
+	struct write_shallow_data data;
+	data.out =3D out;
+	data.use_pack_protocol =3D use_pack_protocol;
+	data.count =3D 0;
+	for_each_commit_graft(write_one_shallow, &data);
+	return data.count;
+}
+
+static enum ack_type get_ack(int fd, unsigned char *result_sha1)
+{
+	static char line[1000];
+	int len =3D packet_read_line(fd, line, sizeof(line));
+
+	if (!len)
+		die("git fetch-pack: expected ACK/NAK, got EOF");
+	if (line[len-1] =3D=3D '\n')
+		line[--len] =3D 0;
+	if (!strcmp(line, "NAK"))
+		return NAK;
+	if (!prefixcmp(line, "ACK ")) {
+		if (!get_sha1_hex(line+4, result_sha1)) {
+			if (strstr(line+45, "continue"))
+				return ACK_continue;
+			if (strstr(line+45, "common"))
+				return ACK_common;
+			if (strstr(line+45, "ready"))
+				return ACK_ready;
+			return ACK;
+		}
+	}
+	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
+}
+
+static void send_request(struct fetch_pack_args *args,
+			 int fd, struct strbuf *buf)
+{
+	if (args->stateless_rpc) {
+		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
+		packet_flush(fd);
+	} else
+		safe_write(fd, buf->buf, buf->len);
+}
+
+static void insert_one_alternate_ref(const struct ref *ref, void *unus=
ed)
+{
+	rev_list_insert_ref(NULL, ref->old_sha1, 0, NULL);
+}
+
+#define INITIAL_FLUSH 16
+#define PIPESAFE_FLUSH 32
+#define LARGE_FLUSH 1024
+
+static int next_flush(struct fetch_pack_args *args, int count)
+{
+	int flush_limit =3D args->stateless_rpc ? LARGE_FLUSH : PIPESAFE_FLUS=
H;
+
+	if (count < flush_limit)
+		count <<=3D 1;
+	else
+		count +=3D flush_limit;
+	return count;
+}
+
+static int find_common(struct fetch_pack_args *args,
+		       int fd[2], unsigned char *result_sha1,
+		       struct ref *refs)
+{
+	int fetching;
+	int count =3D 0, flushes =3D 0, flush_at =3D INITIAL_FLUSH, retval;
+	const unsigned char *sha1;
+	unsigned in_vain =3D 0;
+	int got_continue =3D 0;
+	int got_ready =3D 0;
+	struct strbuf req_buf =3D STRBUF_INIT;
+	size_t state_len =3D 0;
+
+	if (args->stateless_rpc && multi_ack =3D=3D 1)
+		die("--stateless-rpc requires multi_ack_detailed");
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked =3D 1;
+
+	for_each_ref(rev_list_insert_ref, NULL);
+	for_each_alternate_ref(insert_one_alternate_ref, NULL);
+
+	fetching =3D 0;
+	for ( ; refs ; refs =3D refs->next) {
+		unsigned char *remote =3D refs->old_sha1;
+		const char *remote_hex;
+		struct object *o;
+
+		/*
+		 * If that object is complete (i.e. it is an ancestor of a
+		 * local ref), we tell them we have it but do not have to
+		 * tell them about its ancestors, which they already know
+		 * about.
+		 *
+		 * We use lookup_object here because we are only
+		 * interested in the case we *know* the object is
+		 * reachable and we have already scanned it.
+		 */
+		if (((o =3D lookup_object(remote)) !=3D NULL) &&
+				(o->flags & COMPLETE)) {
+			continue;
+		}
+
+		remote_hex =3D sha1_to_hex(remote);
+		if (!fetching) {
+			struct strbuf c =3D STRBUF_INIT;
+			if (multi_ack =3D=3D 2)     strbuf_addstr(&c, " multi_ack_detailed"=
);
+			if (multi_ack =3D=3D 1)     strbuf_addstr(&c, " multi_ack");
+			if (no_done)            strbuf_addstr(&c, " no-done");
+			if (use_sideband =3D=3D 2)  strbuf_addstr(&c, " side-band-64k");
+			if (use_sideband =3D=3D 1)  strbuf_addstr(&c, " side-band");
+			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
+			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
+			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
+			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
+			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
+							    git_user_agent_sanitized());
+			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
+			strbuf_release(&c);
+		} else
+			packet_buf_write(&req_buf, "want %s\n", remote_hex);
+		fetching++;
+	}
+
+	if (!fetching) {
+		strbuf_release(&req_buf);
+		packet_flush(fd[1]);
+		return 1;
+	}
+
+	if (is_repository_shallow())
+		write_shallow_commits(&req_buf, 1);
+	if (args->depth > 0)
+		packet_buf_write(&req_buf, "deepen %d", args->depth);
+	packet_buf_flush(&req_buf);
+	state_len =3D req_buf.len;
+
+	if (args->depth > 0) {
+		char line[1024];
+		unsigned char sha1[20];
+
+		send_request(args, fd[1], &req_buf);
+		while (packet_read_line(fd[0], line, sizeof(line))) {
+			if (!prefixcmp(line, "shallow ")) {
+				if (get_sha1_hex(line + 8, sha1))
+					die("invalid shallow line: %s", line);
+				register_shallow(sha1);
+				continue;
+			}
+			if (!prefixcmp(line, "unshallow ")) {
+				if (get_sha1_hex(line + 10, sha1))
+					die("invalid unshallow line: %s", line);
+				if (!lookup_object(sha1))
+					die("object not found: %s", line);
+				/* make sure that it is parsed as shallow */
+				if (!parse_object(sha1))
+					die("error in object: %s", line);
+				if (unregister_shallow(sha1))
+					die("no shallow found: %s", line);
+				continue;
+			}
+			die("expected shallow/unshallow, got %s", line);
+		}
+	} else if (!args->stateless_rpc)
+		send_request(args, fd[1], &req_buf);
+
+	if (!args->stateless_rpc) {
+		/* If we aren't using the stateless-rpc interface
+		 * we don't need to retain the headers.
+		 */
+		strbuf_setlen(&req_buf, 0);
+		state_len =3D 0;
+	}
+
+	flushes =3D 0;
+	retval =3D -1;
+	while ((sha1 =3D get_rev())) {
+		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
+		if (args->verbose)
+			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		in_vain++;
+		if (flush_at <=3D ++count) {
+			int ack;
+
+			packet_buf_flush(&req_buf);
+			send_request(args, fd[1], &req_buf);
+			strbuf_setlen(&req_buf, state_len);
+			flushes++;
+			flush_at =3D next_flush(args, count);
+
+			/*
+			 * We keep one window "ahead" of the other side, and
+			 * will wait for an ACK only on the next one
+			 */
+			if (!args->stateless_rpc && count =3D=3D INITIAL_FLUSH)
+				continue;
+
+			consume_shallow_list(args, fd[0]);
+			do {
+				ack =3D get_ack(fd[0], result_sha1);
+				if (args->verbose && ack)
+					fprintf(stderr, "got ack %d %s\n", ack,
+							sha1_to_hex(result_sha1));
+				switch (ack) {
+				case ACK:
+					flushes =3D 0;
+					multi_ack =3D 0;
+					retval =3D 0;
+					goto done;
+				case ACK_common:
+				case ACK_ready:
+				case ACK_continue: {
+					struct commit *commit =3D
+						lookup_commit(result_sha1);
+					if (!commit)
+						die("invalid commit %s", sha1_to_hex(result_sha1));
+					if (args->stateless_rpc
+					 && ack =3D=3D ACK_common
+					 && !(commit->object.flags & COMMON)) {
+						/* We need to replay the have for this object
+						 * on the next RPC request so the peer knows
+						 * it is in common with us.
+						 */
+						const char *hex =3D sha1_to_hex(result_sha1);
+						packet_buf_write(&req_buf, "have %s\n", hex);
+						state_len =3D req_buf.len;
+					}
+					mark_common(commit, 0, 1);
+					retval =3D 0;
+					in_vain =3D 0;
+					got_continue =3D 1;
+					if (ack =3D=3D ACK_ready) {
+						rev_list =3D NULL;
+						got_ready =3D 1;
+					}
+					break;
+					}
+				}
+			} while (ack);
+			flushes--;
+			if (got_continue && MAX_IN_VAIN < in_vain) {
+				if (args->verbose)
+					fprintf(stderr, "giving up\n");
+				break; /* give up */
+			}
+		}
+	}
+done:
+	if (!got_ready || !no_done) {
+		packet_buf_write(&req_buf, "done\n");
+		send_request(args, fd[1], &req_buf);
+	}
+	if (args->verbose)
+		fprintf(stderr, "done\n");
+	if (retval !=3D 0) {
+		multi_ack =3D 0;
+		flushes++;
+	}
+	strbuf_release(&req_buf);
+
+	consume_shallow_list(args, fd[0]);
+	while (flushes || multi_ack) {
+		int ack =3D get_ack(fd[0], result_sha1);
+		if (ack) {
+			if (args->verbose)
+				fprintf(stderr, "got ack (%d) %s\n", ack,
+					sha1_to_hex(result_sha1));
+			if (ack =3D=3D ACK)
+				return 0;
+			multi_ack =3D 1;
+			continue;
+		}
+		flushes--;
+	}
+	/* it is no error to fetch into a completely empty repo */
+	return count ? retval : 0;
+}
+
+static struct commit_list *complete;
+
+static int mark_complete(const char *refname, const unsigned char *sha=
1, int flag, void *cb_data)
+{
+	struct object *o =3D parse_object(sha1);
+
+	while (o && o->type =3D=3D OBJ_TAG) {
+		struct tag *t =3D (struct tag *) o;
+		if (!t->tagged)
+			break; /* broken repository */
+		o->flags |=3D COMPLETE;
+		o =3D parse_object(t->tagged->sha1);
+	}
+	if (o && o->type =3D=3D OBJ_COMMIT) {
+		struct commit *commit =3D (struct commit *)o;
+		if (!(commit->object.flags & COMPLETE)) {
+			commit->object.flags |=3D COMPLETE;
+			commit_list_insert_by_date(commit, &complete);
+		}
+	}
+	return 0;
+}
+
+static void mark_recent_complete_commits(struct fetch_pack_args *args,
+					 unsigned long cutoff)
+{
+	while (complete && cutoff <=3D complete->item->date) {
+		if (args->verbose)
+			fprintf(stderr, "Marking %s as complete\n",
+				sha1_to_hex(complete->item->object.sha1));
+		pop_most_recent_commit(&complete, COMPLETE);
+	}
+}
+
+static int non_matching_ref(struct string_list_item *item, void *unuse=
d)
+{
+	if (item->util) {
+		item->util =3D NULL;
+		return 0;
+	}
+	else
+		return 1;
+}
+
+static void filter_refs(struct fetch_pack_args *args,
+			struct ref **refs, struct string_list *sought)
+{
+	struct ref *newlist =3D NULL;
+	struct ref **newtail =3D &newlist;
+	struct ref *ref, *next;
+	int sought_pos;
+
+	sought_pos =3D 0;
+	for (ref =3D *refs; ref; ref =3D next) {
+		int keep =3D 0;
+		next =3D ref->next;
+		if (!memcmp(ref->name, "refs/", 5) &&
+		    check_refname_format(ref->name + 5, 0))
+			; /* trash */
+		else {
+			while (sought_pos < sought->nr) {
+				int cmp =3D strcmp(ref->name, sought->items[sought_pos].string);
+				if (cmp < 0)
+					break; /* definitely do not have it */
+				else if (cmp =3D=3D 0) {
+					keep =3D 1; /* definitely have it */
+					sought->items[sought_pos++].util =3D "matched";
+					break;
+				}
+				else
+					sought_pos++; /* might have it; keep looking */
+			}
+		}
+
+		if (! keep && args->fetch_all &&
+		    (!args->depth || prefixcmp(ref->name, "refs/tags/")))
+			keep =3D 1;
+
+		if (keep) {
+			*newtail =3D ref;
+			ref->next =3D NULL;
+			newtail =3D &ref->next;
+		} else {
+			free(ref);
+		}
+	}
+
+	filter_string_list(sought, 0, non_matching_ref, NULL);
+	*refs =3D newlist;
+}
+
+static void mark_alternate_complete(const struct ref *ref, void *unuse=
d)
+{
+	mark_complete(NULL, ref->old_sha1, 0, NULL);
+}
+
+static int everything_local(struct fetch_pack_args *args,
+			    struct ref **refs, struct string_list *sought)
+{
+	struct ref *ref;
+	int retval;
+	unsigned long cutoff =3D 0;
+
+	save_commit_buffer =3D 0;
+
+	for (ref =3D *refs; ref; ref =3D ref->next) {
+		struct object *o;
+
+		o =3D parse_object(ref->old_sha1);
+		if (!o)
+			continue;
+
+		/* We already have it -- which may mean that we were
+		 * in sync with the other side at some time after
+		 * that (it is OK if we guess wrong here).
+		 */
+		if (o->type =3D=3D OBJ_COMMIT) {
+			struct commit *commit =3D (struct commit *)o;
+			if (!cutoff || cutoff < commit->date)
+				cutoff =3D commit->date;
+		}
+	}
+
+	if (!args->depth) {
+		for_each_ref(mark_complete, NULL);
+		for_each_alternate_ref(mark_alternate_complete, NULL);
+		if (cutoff)
+			mark_recent_complete_commits(args, cutoff);
+	}
+
+	/*
+	 * Mark all complete remote refs as common refs.
+	 * Don't mark them common yet; the server has to be told so first.
+	 */
+	for (ref =3D *refs; ref; ref =3D ref->next) {
+		struct object *o =3D deref_tag(lookup_object(ref->old_sha1),
+					     NULL, 0);
+
+		if (!o || o->type !=3D OBJ_COMMIT || !(o->flags & COMPLETE))
+			continue;
+
+		if (!(o->flags & SEEN)) {
+			rev_list_push((struct commit *)o, COMMON_REF | SEEN);
+
+			mark_common((struct commit *)o, 1, 1);
+		}
+	}
+
+	filter_refs(args, refs, sought);
+
+	for (retval =3D 1, ref =3D *refs; ref ; ref =3D ref->next) {
+		const unsigned char *remote =3D ref->old_sha1;
+		unsigned char local[20];
+		struct object *o;
+
+		o =3D lookup_object(remote);
+		if (!o || !(o->flags & COMPLETE)) {
+			retval =3D 0;
+			if (!args->verbose)
+				continue;
+			fprintf(stderr,
+				"want %s (%s)\n", sha1_to_hex(remote),
+				ref->name);
+			continue;
+		}
+
+		hashcpy(ref->new_sha1, local);
+		if (!args->verbose)
+			continue;
+		fprintf(stderr,
+			"already have %s (%s)\n", sha1_to_hex(remote),
+			ref->name);
+	}
+	return retval;
+}
+
+static int sideband_demux(int in, int out, void *data)
+{
+	int *xd =3D data;
+
+	int ret =3D recv_sideband("fetch-pack", xd[0], out);
+	close(out);
+	return ret;
+}
+
+static int get_pack(struct fetch_pack_args *args,
+		    int xd[2], char **pack_lockfile)
+{
+	struct async demux;
+	const char *argv[20];
+	char keep_arg[256];
+	char hdr_arg[256];
+	const char **av;
+	int do_keep =3D args->keep_pack;
+	struct child_process cmd;
+
+	memset(&demux, 0, sizeof(demux));
+	if (use_sideband) {
+		/* xd[] is talking with upload-pack; subprocess reads from
+		 * xd[0], spits out band#2 to stderr, and feeds us band#1
+		 * through demux->out.
+		 */
+		demux.proc =3D sideband_demux;
+		demux.data =3D xd;
+		demux.out =3D -1;
+		if (start_async(&demux))
+			die("fetch-pack: unable to fork off sideband"
+			    " demultiplexer");
+	}
+	else
+		demux.out =3D xd[0];
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.argv =3D argv;
+	av =3D argv;
+	*hdr_arg =3D 0;
+	if (!args->keep_pack && unpack_limit) {
+		struct pack_header header;
+
+		if (read_pack_header(demux.out, &header))
+			die("protocol error: bad pack header");
+		snprintf(hdr_arg, sizeof(hdr_arg),
+			 "--pack_header=3D%"PRIu32",%"PRIu32,
+			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
+		if (ntohl(header.hdr_entries) < unpack_limit)
+			do_keep =3D 0;
+		else
+			do_keep =3D 1;
+	}
+
+	if (do_keep) {
+		if (pack_lockfile)
+			cmd.out =3D -1;
+		*av++ =3D "index-pack";
+		*av++ =3D "--stdin";
+		if (!args->quiet && !args->no_progress)
+			*av++ =3D "-v";
+		if (args->use_thin_pack)
+			*av++ =3D "--fix-thin";
+		if (args->lock_pack || unpack_limit) {
+			int s =3D sprintf(keep_arg,
+					"--keep=3Dfetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
+			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
+				strcpy(keep_arg + s, "localhost");
+			*av++ =3D keep_arg;
+		}
+	}
+	else {
+		*av++ =3D "unpack-objects";
+		if (args->quiet || args->no_progress)
+			*av++ =3D "-q";
+	}
+	if (*hdr_arg)
+		*av++ =3D hdr_arg;
+	if (fetch_fsck_objects >=3D 0
+	    ? fetch_fsck_objects
+	    : transfer_fsck_objects >=3D 0
+	    ? transfer_fsck_objects
+	    : 0)
+		*av++ =3D "--strict";
+	*av++ =3D NULL;
+
+	cmd.in =3D demux.out;
+	cmd.git_cmd =3D 1;
+	if (start_command(&cmd))
+		die("fetch-pack: unable to fork off %s", argv[0]);
+	if (do_keep && pack_lockfile) {
+		*pack_lockfile =3D index_pack_lockfile(cmd.out);
+		close(cmd.out);
+	}
+
+	if (finish_command(&cmd))
+		die("%s failed", argv[0]);
+	if (use_sideband && finish_async(&demux))
+		die("error in sideband demultiplexer");
+	return 0;
+}
+
+static struct ref *do_fetch_pack(struct fetch_pack_args *args,
+				 int fd[2],
+				 const struct ref *orig_ref,
+				 struct string_list *sought,
+				 char **pack_lockfile)
+{
+	struct ref *ref =3D copy_ref_list(orig_ref);
+	unsigned char sha1[20];
+	const char *agent_feature;
+	int agent_len;
+
+	sort_ref_list(&ref, ref_compare_name);
+
+	if (is_repository_shallow() && !server_supports("shallow"))
+		die("Server does not support shallow clients");
+	if (server_supports("multi_ack_detailed")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports multi_ack_detailed\n");
+		multi_ack =3D 2;
+		if (server_supports("no-done")) {
+			if (args->verbose)
+				fprintf(stderr, "Server supports no-done\n");
+			if (args->stateless_rpc)
+				no_done =3D 1;
+		}
+	}
+	else if (server_supports("multi_ack")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports multi_ack\n");
+		multi_ack =3D 1;
+	}
+	if (server_supports("side-band-64k")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports side-band-64k\n");
+		use_sideband =3D 2;
+	}
+	else if (server_supports("side-band")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports side-band\n");
+		use_sideband =3D 1;
+	}
+	if (!server_supports("thin-pack"))
+		args->use_thin_pack =3D 0;
+	if (!server_supports("no-progress"))
+		args->no_progress =3D 0;
+	if (!server_supports("include-tag"))
+		args->include_tag =3D 0;
+	if (server_supports("ofs-delta")) {
+		if (args->verbose)
+			fprintf(stderr, "Server supports ofs-delta\n");
+	} else
+		prefer_ofs_delta =3D 0;
+
+	if ((agent_feature =3D server_feature_value("agent", &agent_len))) {
+		agent_supported =3D 1;
+		if (args->verbose && agent_len)
+			fprintf(stderr, "Server version is %.*s\n",
+				agent_len, agent_feature);
+	}
+
+	if (everything_local(args, &ref, sought)) {
+		packet_flush(fd[1]);
+		goto all_done;
+	}
+	if (find_common(args, fd, sha1, ref) < 0)
+		if (!args->keep_pack)
+			/* When cloning, it is not unusual to have
+			 * no common commit.
+			 */
+			warning("no common commits");
+
+	if (args->stateless_rpc)
+		packet_flush(fd[1]);
+	if (get_pack(args, fd, pack_lockfile))
+		die("git fetch-pack: fetch failed.");
+
+ all_done:
+	return ref;
+}
+
+static int fetch_pack_config(const char *var, const char *value, void =
*cb)
+{
+	if (strcmp(var, "fetch.unpacklimit") =3D=3D 0) {
+		fetch_unpack_limit =3D git_config_int(var, value);
+		return 0;
+	}
+
+	if (strcmp(var, "transfer.unpacklimit") =3D=3D 0) {
+		transfer_unpack_limit =3D git_config_int(var, value);
+		return 0;
+	}
+
+	if (strcmp(var, "repack.usedeltabaseoffset") =3D=3D 0) {
+		prefer_ofs_delta =3D git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "fetch.fsckobjects")) {
+		fetch_fsck_objects =3D git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "transfer.fsckobjects")) {
+		transfer_fsck_objects =3D git_config_bool(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
+static struct lock_file lock;
+
+static void fetch_pack_setup(void)
+{
+	static int did_setup;
+	if (did_setup)
+		return;
+	git_config(fetch_pack_config, NULL);
+	if (0 <=3D transfer_unpack_limit)
+		unpack_limit =3D transfer_unpack_limit;
+	else if (0 <=3D fetch_unpack_limit)
+		unpack_limit =3D fetch_unpack_limit;
+	did_setup =3D 1;
+}
+
+struct ref *fetch_pack(struct fetch_pack_args *args,
+		       int fd[], struct child_process *conn,
+		       const struct ref *ref,
+		       const char *dest,
+		       struct string_list *sought,
+		       char **pack_lockfile)
+{
+	struct stat st;
+	struct ref *ref_cpy;
+
+	fetch_pack_setup();
+	if (args->depth > 0) {
+		if (stat(git_path("shallow"), &st))
+			st.st_mtime =3D 0;
+	}
+
+	if (sought->nr) {
+		sort_string_list(sought);
+		string_list_remove_duplicates(sought, 0);
+	}
+
+	if (!ref) {
+		packet_flush(fd[1]);
+		die("no matching remote head");
+	}
+	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, pack_lockfile);
+
+	if (args->depth > 0) {
+		struct cache_time mtime;
+		struct strbuf sb =3D STRBUF_INIT;
+		char *shallow =3D git_path("shallow");
+		int fd;
+
+		mtime.sec =3D st.st_mtime;
+		mtime.nsec =3D ST_MTIME_NSEC(st);
+		if (stat(shallow, &st)) {
+			if (mtime.sec)
+				die("shallow file was removed during fetch");
+		} else if (st.st_mtime !=3D mtime.sec
+#ifdef USE_NSEC
+				|| ST_MTIME_NSEC(st) !=3D mtime.nsec
+#endif
+			  )
+			die("shallow file was changed during fetch");
+
+		fd =3D hold_lock_file_for_update(&lock, shallow,
+					       LOCK_DIE_ON_ERROR);
+		if (!write_shallow_commits(&sb, 0)
+		 || write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
+			unlink_or_warn(shallow);
+			rollback_lock_file(&lock);
+		} else {
+			commit_lock_file(&lock);
+		}
+		strbuf_release(&sb);
+	}
+
+	reprepare_packed_git();
+	return ref_cpy;
+}
--=20
1.8.0.rc2.23.g1fb49df
