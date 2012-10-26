From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] send-pack: move core code to libgit.a
Date: Fri, 26 Oct 2012 22:53:53 +0700
Message-ID: <1351266835-22610-6-git-send-email-pclouds@gmail.com>
References: <20121026120253.GA1455@sigill.intra.peff.net>
 <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:54:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmFD-0000Id-NC
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901Ab2JZPyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 11:54:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59802 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2JZPyd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:54:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2860934pbb.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oN7xVw9sbgvHN0PGb9hCGWOcKk7DYySxae1sVbYpoy8=;
        b=0UX7+uZYkOf2FNFxfMumNmXUZL4HuFDq77LB4HMx7A/xSAbJYY1Nfc/c8UWLugdywC
         lOlGNvEYVgCJwfa3tyMbgiBRPhd+bPP/1SW1XMpIVAq+m6TqI3B2yHqt1aS111znhxdw
         UhBOjlnPucCvlzzE8qbY5ZrY6ZOwR0PzKdiEcSzT9grn9s9ctOcnAKEDYbcVcrFuyJJq
         0Y3yUwD1TosawKKbwb7HiW6KQqsLV7ASBUfLxL1dHeXT8rSc0BttH4XCgictiX5fdmsc
         us7JPPpadAkieVOr3Oti4//I6nGPwycq52IbaYBM8//h7MBsxq6P+Mr/6oBOH7iQhA19
         qZ3g==
Received: by 10.68.131.39 with SMTP id oj7mr69753990pbb.148.1351266872909;
        Fri, 26 Oct 2012 08:54:32 -0700 (PDT)
Received: from lanh ([115.74.33.44])
        by mx.google.com with ESMTPS id m8sm1185997pax.38.2012.10.26.08.54.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 08:54:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Oct 2012 22:54:33 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208461>

send_pack() is used by transport.c, part of libgit.a while it stays in
builtin/send-pack.c. Move it to send-pack.c so that we won't get
undefined reference if a program that uses libgit.a happens to pull it
in.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile            |   1 +
 builtin/send-pack.c | 333 --------------------------------------------=
------
 send-pack.c         | 344 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 transport.h         |   5 +
 4 files changed, 350 insertions(+), 333 deletions(-)
 create mode 100644 send-pack.c

diff --git a/Makefile b/Makefile
index 2c333dc..414f15f 100644
--- a/Makefile
+++ b/Makefile
@@ -797,6 +797,7 @@ LIB_OBJS +=3D rerere.o
 LIB_OBJS +=3D resolve-undo.o
 LIB_OBJS +=3D revision.o
 LIB_OBJS +=3D run-command.o
+LIB_OBJS +=3D send-pack.o
 LIB_OBJS +=3D sequencer.o
 LIB_OBJS +=3D server-info.o
 LIB_OBJS +=3D setup.o
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7d05064..d342013 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -16,164 +16,6 @@ static const char send_pack_usage[] =3D
=20
 static struct send_pack_args args;
=20
-static int feed_object(const unsigned char *sha1, int fd, int negative=
)
-{
-	char buf[42];
-
-	if (negative && !has_sha1_file(sha1))
-		return 1;
-
-	memcpy(buf + negative, sha1_to_hex(sha1), 40);
-	if (negative)
-		buf[0] =3D '^';
-	buf[40 + negative] =3D '\n';
-	return write_or_whine(fd, buf, 41 + negative, "send-pack: send refs")=
;
-}
-
-/*
- * Make a pack stream and spit it out into file descriptor fd
- */
-static int pack_objects(int fd, struct ref *refs, struct extra_have_ob=
jects *extra, struct send_pack_args *args)
-{
-	/*
-	 * The child becomes pack-objects --revs; we feed
-	 * the revision parameters to it via its stdin and
-	 * let its stdout go back to the other end.
-	 */
-	const char *argv[] =3D {
-		"pack-objects",
-		"--all-progress-implied",
-		"--revs",
-		"--stdout",
-		NULL,
-		NULL,
-		NULL,
-		NULL,
-		NULL,
-	};
-	struct child_process po;
-	int i;
-
-	i =3D 4;
-	if (args->use_thin_pack)
-		argv[i++] =3D "--thin";
-	if (args->use_ofs_delta)
-		argv[i++] =3D "--delta-base-offset";
-	if (args->quiet || !args->progress)
-		argv[i++] =3D "-q";
-	if (args->progress)
-		argv[i++] =3D "--progress";
-	memset(&po, 0, sizeof(po));
-	po.argv =3D argv;
-	po.in =3D -1;
-	po.out =3D args->stateless_rpc ? -1 : fd;
-	po.git_cmd =3D 1;
-	if (start_command(&po))
-		die_errno("git pack-objects failed");
-
-	/*
-	 * We feed the pack-objects we just spawned with revision
-	 * parameters by writing to the pipe.
-	 */
-	for (i =3D 0; i < extra->nr; i++)
-		if (!feed_object(extra->array[i], po.in, 1))
-			break;
-
-	while (refs) {
-		if (!is_null_sha1(refs->old_sha1) &&
-		    !feed_object(refs->old_sha1, po.in, 1))
-			break;
-		if (!is_null_sha1(refs->new_sha1) &&
-		    !feed_object(refs->new_sha1, po.in, 0))
-			break;
-		refs =3D refs->next;
-	}
-
-	close(po.in);
-
-	if (args->stateless_rpc) {
-		char *buf =3D xmalloc(LARGE_PACKET_MAX);
-		while (1) {
-			ssize_t n =3D xread(po.out, buf, LARGE_PACKET_MAX);
-			if (n <=3D 0)
-				break;
-			send_sideband(fd, -1, buf, n, LARGE_PACKET_MAX);
-		}
-		free(buf);
-		close(po.out);
-		po.out =3D -1;
-	}
-
-	if (finish_command(&po))
-		return -1;
-	return 0;
-}
-
-static int receive_status(int in, struct ref *refs)
-{
-	struct ref *hint;
-	char line[1000];
-	int ret =3D 0;
-	int len =3D packet_read_line(in, line, sizeof(line));
-	if (len < 10 || memcmp(line, "unpack ", 7))
-		return error("did not receive remote status");
-	if (memcmp(line, "unpack ok\n", 10)) {
-		char *p =3D line + strlen(line) - 1;
-		if (*p =3D=3D '\n')
-			*p =3D '\0';
-		error("unpack failed: %s", line + 7);
-		ret =3D -1;
-	}
-	hint =3D NULL;
-	while (1) {
-		char *refname;
-		char *msg;
-		len =3D packet_read_line(in, line, sizeof(line));
-		if (!len)
-			break;
-		if (len < 3 ||
-		    (memcmp(line, "ok ", 3) && memcmp(line, "ng ", 3))) {
-			fprintf(stderr, "protocol error: %s\n", line);
-			ret =3D -1;
-			break;
-		}
-
-		line[strlen(line)-1] =3D '\0';
-		refname =3D line + 3;
-		msg =3D strchr(refname, ' ');
-		if (msg)
-			*msg++ =3D '\0';
-
-		/* first try searching at our hint, falling back to all refs */
-		if (hint)
-			hint =3D find_ref_by_name(hint, refname);
-		if (!hint)
-			hint =3D find_ref_by_name(refs, refname);
-		if (!hint) {
-			warning("remote reported status on unknown ref: %s",
-					refname);
-			continue;
-		}
-		if (hint->status !=3D REF_STATUS_EXPECTING_REPORT) {
-			warning("remote reported status on unexpected ref: %s",
-					refname);
-			continue;
-		}
-
-		if (line[0] =3D=3D 'o' && line[1] =3D=3D 'k')
-			hint->status =3D REF_STATUS_OK;
-		else {
-			hint->status =3D REF_STATUS_REMOTE_REJECT;
-			ret =3D -1;
-		}
-		if (msg)
-			hint->remote_status =3D xstrdup(msg);
-		/* start our next search from the next ref */
-		hint =3D hint->next;
-	}
-	return ret;
-}
-
 static void print_helper_status(struct ref *ref)
 {
 	struct strbuf buf =3D STRBUF_INIT;
@@ -227,181 +69,6 @@ static void print_helper_status(struct ref *ref)
 	strbuf_release(&buf);
 }
=20
-static int sideband_demux(int in, int out, void *data)
-{
-	int *fd =3D data, ret;
-#ifdef NO_PTHREADS
-	close(fd[1]);
-#endif
-	ret =3D recv_sideband("send-pack", fd[0], out);
-	close(out);
-	return ret;
-}
-
-int send_pack(struct send_pack_args *args,
-	      int fd[], struct child_process *conn,
-	      struct ref *remote_refs,
-	      struct extra_have_objects *extra_have)
-{
-	int in =3D fd[0];
-	int out =3D fd[1];
-	struct strbuf req_buf =3D STRBUF_INIT;
-	struct ref *ref;
-	int new_refs;
-	int allow_deleting_refs =3D 0;
-	int status_report =3D 0;
-	int use_sideband =3D 0;
-	int quiet_supported =3D 0;
-	int agent_supported =3D 0;
-	unsigned cmds_sent =3D 0;
-	int ret;
-	struct async demux;
-
-	/* Does the other end support the reporting? */
-	if (server_supports("report-status"))
-		status_report =3D 1;
-	if (server_supports("delete-refs"))
-		allow_deleting_refs =3D 1;
-	if (server_supports("ofs-delta"))
-		args->use_ofs_delta =3D 1;
-	if (server_supports("side-band-64k"))
-		use_sideband =3D 1;
-	if (server_supports("quiet"))
-		quiet_supported =3D 1;
-	if (server_supports("agent"))
-		agent_supported =3D 1;
-
-	if (!remote_refs) {
-		fprintf(stderr, "No refs in common and none specified; doing nothing=
=2E\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
-		return 0;
-	}
-
-	/*
-	 * Finally, tell the other end!
-	 */
-	new_refs =3D 0;
-	for (ref =3D remote_refs; ref; ref =3D ref->next) {
-		if (!ref->peer_ref && !args->send_mirror)
-			continue;
-
-		/* Check for statuses set by set_ref_status_for_push() */
-		switch (ref->status) {
-		case REF_STATUS_REJECT_NONFASTFORWARD:
-		case REF_STATUS_UPTODATE:
-			continue;
-		default:
-			; /* do nothing */
-		}
-
-		if (ref->deletion && !allow_deleting_refs) {
-			ref->status =3D REF_STATUS_REJECT_NODELETE;
-			continue;
-		}
-
-		if (!ref->deletion)
-			new_refs++;
-
-		if (args->dry_run) {
-			ref->status =3D REF_STATUS_OK;
-		} else {
-			char *old_hex =3D sha1_to_hex(ref->old_sha1);
-			char *new_hex =3D sha1_to_hex(ref->new_sha1);
-			int quiet =3D quiet_supported && (args->quiet || !args->progress);
-
-			if (!cmds_sent && (status_report || use_sideband ||
-					   quiet || agent_supported)) {
-				packet_buf_write(&req_buf,
-						 "%s %s %s%c%s%s%s%s%s",
-						 old_hex, new_hex, ref->name, 0,
-						 status_report ? " report-status" : "",
-						 use_sideband ? " side-band-64k" : "",
-						 quiet ? " quiet" : "",
-						 agent_supported ? " agent=3D" : "",
-						 agent_supported ? git_user_agent_sanitized() : ""
-						);
-			}
-			else
-				packet_buf_write(&req_buf, "%s %s %s",
-						 old_hex, new_hex, ref->name);
-			ref->status =3D status_report ?
-				REF_STATUS_EXPECTING_REPORT :
-				REF_STATUS_OK;
-			cmds_sent++;
-		}
-	}
-
-	if (args->stateless_rpc) {
-		if (!args->dry_run && cmds_sent) {
-			packet_buf_flush(&req_buf);
-			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
-		}
-	} else {
-		safe_write(out, req_buf.buf, req_buf.len);
-		packet_flush(out);
-	}
-	strbuf_release(&req_buf);
-
-	if (use_sideband && cmds_sent) {
-		memset(&demux, 0, sizeof(demux));
-		demux.proc =3D sideband_demux;
-		demux.data =3D fd;
-		demux.out =3D -1;
-		if (start_async(&demux))
-			die("send-pack: unable to fork off sideband demultiplexer");
-		in =3D demux.out;
-	}
-
-	if (new_refs && cmds_sent) {
-		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
-			for (ref =3D remote_refs; ref; ref =3D ref->next)
-				ref->status =3D REF_STATUS_NONE;
-			if (args->stateless_rpc)
-				close(out);
-			if (git_connection_is_socket(conn))
-				shutdown(fd[0], SHUT_WR);
-			if (use_sideband)
-				finish_async(&demux);
-			return -1;
-		}
-	}
-	if (args->stateless_rpc && cmds_sent)
-		packet_flush(out);
-
-	if (status_report && cmds_sent)
-		ret =3D receive_status(in, remote_refs);
-	else
-		ret =3D 0;
-	if (args->stateless_rpc)
-		packet_flush(out);
-
-	if (use_sideband && cmds_sent) {
-		if (finish_async(&demux)) {
-			error("error in sideband demultiplexer");
-			ret =3D -1;
-		}
-		close(demux.out);
-	}
-
-	if (ret < 0)
-		return ret;
-
-	if (args->porcelain)
-		return 0;
-
-	for (ref =3D remote_refs; ref; ref =3D ref->next) {
-		switch (ref->status) {
-		case REF_STATUS_NONE:
-		case REF_STATUS_UPTODATE:
-		case REF_STATUS_OK:
-			break;
-		default:
-			return -1;
-		}
-	}
-	return 0;
-}
-
 int cmd_send_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, nr_refspecs =3D 0;
diff --git a/send-pack.c b/send-pack.c
new file mode 100644
index 0000000..f50dfd9
--- /dev/null
+++ b/send-pack.c
@@ -0,0 +1,344 @@
+#include "builtin.h"
+#include "commit.h"
+#include "refs.h"
+#include "pkt-line.h"
+#include "sideband.h"
+#include "run-command.h"
+#include "remote.h"
+#include "send-pack.h"
+#include "quote.h"
+#include "transport.h"
+#include "version.h"
+
+static int feed_object(const unsigned char *sha1, int fd, int negative=
)
+{
+	char buf[42];
+
+	if (negative && !has_sha1_file(sha1))
+		return 1;
+
+	memcpy(buf + negative, sha1_to_hex(sha1), 40);
+	if (negative)
+		buf[0] =3D '^';
+	buf[40 + negative] =3D '\n';
+	return write_or_whine(fd, buf, 41 + negative, "send-pack: send refs")=
;
+}
+
+/*
+ * Make a pack stream and spit it out into file descriptor fd
+ */
+static int pack_objects(int fd, struct ref *refs, struct extra_have_ob=
jects *extra, struct send_pack_args *args)
+{
+	/*
+	 * The child becomes pack-objects --revs; we feed
+	 * the revision parameters to it via its stdin and
+	 * let its stdout go back to the other end.
+	 */
+	const char *argv[] =3D {
+		"pack-objects",
+		"--all-progress-implied",
+		"--revs",
+		"--stdout",
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+	};
+	struct child_process po;
+	int i;
+
+	i =3D 4;
+	if (args->use_thin_pack)
+		argv[i++] =3D "--thin";
+	if (args->use_ofs_delta)
+		argv[i++] =3D "--delta-base-offset";
+	if (args->quiet || !args->progress)
+		argv[i++] =3D "-q";
+	if (args->progress)
+		argv[i++] =3D "--progress";
+	memset(&po, 0, sizeof(po));
+	po.argv =3D argv;
+	po.in =3D -1;
+	po.out =3D args->stateless_rpc ? -1 : fd;
+	po.git_cmd =3D 1;
+	if (start_command(&po))
+		die_errno("git pack-objects failed");
+
+	/*
+	 * We feed the pack-objects we just spawned with revision
+	 * parameters by writing to the pipe.
+	 */
+	for (i =3D 0; i < extra->nr; i++)
+		if (!feed_object(extra->array[i], po.in, 1))
+			break;
+
+	while (refs) {
+		if (!is_null_sha1(refs->old_sha1) &&
+		    !feed_object(refs->old_sha1, po.in, 1))
+			break;
+		if (!is_null_sha1(refs->new_sha1) &&
+		    !feed_object(refs->new_sha1, po.in, 0))
+			break;
+		refs =3D refs->next;
+	}
+
+	close(po.in);
+
+	if (args->stateless_rpc) {
+		char *buf =3D xmalloc(LARGE_PACKET_MAX);
+		while (1) {
+			ssize_t n =3D xread(po.out, buf, LARGE_PACKET_MAX);
+			if (n <=3D 0)
+				break;
+			send_sideband(fd, -1, buf, n, LARGE_PACKET_MAX);
+		}
+		free(buf);
+		close(po.out);
+		po.out =3D -1;
+	}
+
+	if (finish_command(&po))
+		return -1;
+	return 0;
+}
+
+static int receive_status(int in, struct ref *refs)
+{
+	struct ref *hint;
+	char line[1000];
+	int ret =3D 0;
+	int len =3D packet_read_line(in, line, sizeof(line));
+	if (len < 10 || memcmp(line, "unpack ", 7))
+		return error("did not receive remote status");
+	if (memcmp(line, "unpack ok\n", 10)) {
+		char *p =3D line + strlen(line) - 1;
+		if (*p =3D=3D '\n')
+			*p =3D '\0';
+		error("unpack failed: %s", line + 7);
+		ret =3D -1;
+	}
+	hint =3D NULL;
+	while (1) {
+		char *refname;
+		char *msg;
+		len =3D packet_read_line(in, line, sizeof(line));
+		if (!len)
+			break;
+		if (len < 3 ||
+		    (memcmp(line, "ok ", 3) && memcmp(line, "ng ", 3))) {
+			fprintf(stderr, "protocol error: %s\n", line);
+			ret =3D -1;
+			break;
+		}
+
+		line[strlen(line)-1] =3D '\0';
+		refname =3D line + 3;
+		msg =3D strchr(refname, ' ');
+		if (msg)
+			*msg++ =3D '\0';
+
+		/* first try searching at our hint, falling back to all refs */
+		if (hint)
+			hint =3D find_ref_by_name(hint, refname);
+		if (!hint)
+			hint =3D find_ref_by_name(refs, refname);
+		if (!hint) {
+			warning("remote reported status on unknown ref: %s",
+					refname);
+			continue;
+		}
+		if (hint->status !=3D REF_STATUS_EXPECTING_REPORT) {
+			warning("remote reported status on unexpected ref: %s",
+					refname);
+			continue;
+		}
+
+		if (line[0] =3D=3D 'o' && line[1] =3D=3D 'k')
+			hint->status =3D REF_STATUS_OK;
+		else {
+			hint->status =3D REF_STATUS_REMOTE_REJECT;
+			ret =3D -1;
+		}
+		if (msg)
+			hint->remote_status =3D xstrdup(msg);
+		/* start our next search from the next ref */
+		hint =3D hint->next;
+	}
+	return ret;
+}
+
+static int sideband_demux(int in, int out, void *data)
+{
+	int *fd =3D data, ret;
+#ifdef NO_PTHREADS
+	close(fd[1]);
+#endif
+	ret =3D recv_sideband("send-pack", fd[0], out);
+	close(out);
+	return ret;
+}
+
+int send_pack(struct send_pack_args *args,
+	      int fd[], struct child_process *conn,
+	      struct ref *remote_refs,
+	      struct extra_have_objects *extra_have)
+{
+	int in =3D fd[0];
+	int out =3D fd[1];
+	struct strbuf req_buf =3D STRBUF_INIT;
+	struct ref *ref;
+	int new_refs;
+	int allow_deleting_refs =3D 0;
+	int status_report =3D 0;
+	int use_sideband =3D 0;
+	int quiet_supported =3D 0;
+	int agent_supported =3D 0;
+	unsigned cmds_sent =3D 0;
+	int ret;
+	struct async demux;
+
+	/* Does the other end support the reporting? */
+	if (server_supports("report-status"))
+		status_report =3D 1;
+	if (server_supports("delete-refs"))
+		allow_deleting_refs =3D 1;
+	if (server_supports("ofs-delta"))
+		args->use_ofs_delta =3D 1;
+	if (server_supports("side-band-64k"))
+		use_sideband =3D 1;
+	if (server_supports("quiet"))
+		quiet_supported =3D 1;
+	if (server_supports("agent"))
+		agent_supported =3D 1;
+
+	if (!remote_refs) {
+		fprintf(stderr, "No refs in common and none specified; doing nothing=
=2E\n"
+			"Perhaps you should specify a branch such as 'master'.\n");
+		return 0;
+	}
+
+	/*
+	 * Finally, tell the other end!
+	 */
+	new_refs =3D 0;
+	for (ref =3D remote_refs; ref; ref =3D ref->next) {
+		if (!ref->peer_ref && !args->send_mirror)
+			continue;
+
+		/* Check for statuses set by set_ref_status_for_push() */
+		switch (ref->status) {
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_UPTODATE:
+			continue;
+		default:
+			; /* do nothing */
+		}
+
+		if (ref->deletion && !allow_deleting_refs) {
+			ref->status =3D REF_STATUS_REJECT_NODELETE;
+			continue;
+		}
+
+		if (!ref->deletion)
+			new_refs++;
+
+		if (args->dry_run) {
+			ref->status =3D REF_STATUS_OK;
+		} else {
+			char *old_hex =3D sha1_to_hex(ref->old_sha1);
+			char *new_hex =3D sha1_to_hex(ref->new_sha1);
+			int quiet =3D quiet_supported && (args->quiet || !args->progress);
+
+			if (!cmds_sent && (status_report || use_sideband ||
+					   quiet || agent_supported)) {
+				packet_buf_write(&req_buf,
+						 "%s %s %s%c%s%s%s%s%s",
+						 old_hex, new_hex, ref->name, 0,
+						 status_report ? " report-status" : "",
+						 use_sideband ? " side-band-64k" : "",
+						 quiet ? " quiet" : "",
+						 agent_supported ? " agent=3D" : "",
+						 agent_supported ? git_user_agent_sanitized() : ""
+						);
+			}
+			else
+				packet_buf_write(&req_buf, "%s %s %s",
+						 old_hex, new_hex, ref->name);
+			ref->status =3D status_report ?
+				REF_STATUS_EXPECTING_REPORT :
+				REF_STATUS_OK;
+			cmds_sent++;
+		}
+	}
+
+	if (args->stateless_rpc) {
+		if (!args->dry_run && cmds_sent) {
+			packet_buf_flush(&req_buf);
+			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
+		}
+	} else {
+		safe_write(out, req_buf.buf, req_buf.len);
+		packet_flush(out);
+	}
+	strbuf_release(&req_buf);
+
+	if (use_sideband && cmds_sent) {
+		memset(&demux, 0, sizeof(demux));
+		demux.proc =3D sideband_demux;
+		demux.data =3D fd;
+		demux.out =3D -1;
+		if (start_async(&demux))
+			die("send-pack: unable to fork off sideband demultiplexer");
+		in =3D demux.out;
+	}
+
+	if (new_refs && cmds_sent) {
+		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
+			for (ref =3D remote_refs; ref; ref =3D ref->next)
+				ref->status =3D REF_STATUS_NONE;
+			if (args->stateless_rpc)
+				close(out);
+			if (git_connection_is_socket(conn))
+				shutdown(fd[0], SHUT_WR);
+			if (use_sideband)
+				finish_async(&demux);
+			return -1;
+		}
+	}
+	if (args->stateless_rpc && cmds_sent)
+		packet_flush(out);
+
+	if (status_report && cmds_sent)
+		ret =3D receive_status(in, remote_refs);
+	else
+		ret =3D 0;
+	if (args->stateless_rpc)
+		packet_flush(out);
+
+	if (use_sideband && cmds_sent) {
+		if (finish_async(&demux)) {
+			error("error in sideband demultiplexer");
+			ret =3D -1;
+		}
+		close(demux.out);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	if (args->porcelain)
+		return 0;
+
+	for (ref =3D remote_refs; ref; ref =3D ref->next) {
+		switch (ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_UPTODATE:
+		case REF_STATUS_OK:
+			break;
+		default:
+			return -1;
+		}
+	}
+	return 0;
+}
diff --git a/transport.h b/transport.h
index 3b21c4a..4a61c0c 100644
--- a/transport.h
+++ b/transport.h
@@ -175,4 +175,9 @@ void transport_print_push_status(const char *dest, =
struct ref *refs,
 typedef void alternate_ref_fn(const struct ref *, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
=20
+struct send_pack_args;
+extern int send_pack(struct send_pack_args *args,
+		     int fd[], struct child_process *conn,
+		     struct ref *remote_refs,
+		     struct extra_have_objects *extra_have);
 #endif
--=20
1.8.0.rc2.23.g1fb49df
