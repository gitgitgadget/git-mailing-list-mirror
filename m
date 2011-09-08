From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/7] push -s: skeleton
Date: Thu,  8 Sep 2011 13:01:38 -0700
Message-ID: <1315512102-19022-4-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:57:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nXL-0005F6-4c
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab1IHW46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:56:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38612 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab1IHW4p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF76B4646
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=XdJC
	gKS5djo0y3XnPFHwLOTD9Z0=; b=N8/cNv/t6s51+/bsS5HnjK3oOi4tt93NG1+W
	rZrNHyH63LYloO084/8tmnYcxB4hgewzhItPaQRzpCpGwDzlO5BfxTZl6BLx8Fdl
	oGSA4aAvDJGBLaaMquV1cTyvuM8BCSEp+C7D/c9lSGHwaR9F74usgiWEPwegv6T0
	H7cUVg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TmMqJj
	AC7YOBaMRuOwHY8M3OW19ESJcRJxnoPGh2STOnTWPLypD9dAJ2n90vTsu9wVx0JV
	fm/jg5aCaN2nALCRM2n8FlETYKwN2vR5kkPO/Tc0xHV0AxRlQ9BSGKgHXyijoFGq
	V5Q8oAlXT5jFgXJ4IAUJTlh4qIJ84wuU0lrqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6D774645
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BADA44644 for
 <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315512102-19022-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 63835480-DA55-11E0-B7E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180988>

If a tag is GPG-signed, and if you trust the cryptographic robustness of
the SHA-1 hash and GPG, you can sleep well knowing that all the history
leading to the signed commit cannot be tampered with. However, it would be
both cumbersome and cluttering to sign each and every commit. Especially
if you strive to keep your history clean by tweaking, rewriting and
polishing your commits before pushing the resulting history out, many
commits you will create locally end up not mattering at all, and it is a
waste of time to sign them all.

A better alternative could be to sign a "push certificate" (for the lack
of better name) every time you push, asserting that what commits you are
pushing to update which refs.

The basic workflow based on this idea would go like this:

 1. You push out your work with "git push -s";

 2. "git push", as usual, learns where the remote refs are and which refs
    are to be updated with this push. It prepares a text file in core,
    that looks like the following:

	Push-Certificate-Version: 0
	Pusher: Junio C Hamano <gitster@pobox.com> 1315427886 -0700
	Update: 3793ac56b4c4f9bf0bddc306a0cec21118683728 refs/heads/master
	Update: 12850bec0c24b529c9a9df6a95ad4bdeea39373e refs/heads/next

    Each "Update" line shows the new object name at the tip of the ref
    this push tries to update.

    The user then is asked to sign this push certificate using GPG. The
    result is carried to the other side (i.e. receive-pack). In the
    protocol exchange, this step comes immediately after the sender tells
    what the result of the push should be, before it sends the pack data.

 3. The receiving end keeps the signed push certificate in core, receives
    the pack data and unpacks (or stores and indexes) it as usual.

 4. A new phase to record the push certificate is introduced in the
    codepath after the receiving end runs receive_hook(). It is envisioned
    that this phase:

    a. parses the updated-to object names, and appends the push
       certificate (still GPG signed) to a note attached to each of the
       objects that will sit at the tip of the refs;

    b. verifies that the push certificate is signed with a GPG key that is
       authorized to push into this repository; and/or

    c. invokes pre-receive-signature hook, feeds the push certificate to it
       and asks it to veto the ref updates.

And here is a skeleton to implement this. The patch has the necessary
protocol extensions implemented (although I do not know if we need
separate codepath for stateless RPC mode), but does not have subroutines
to:

 - Sign the certificate with GPG key;

 - Parse the signed certificate to identify the updated-to objects, and
   add the certificate as notes to them;

 - Verify the certificate and find out what GPG key was used to sign it;
   or

 - Invoke and feed the certificate to pre-receive-signature hook.

all of which should be fairly trivial. The places that needs to implement
these are clearly marked with large comments, so I'll leave it up to other
people who are interested in the topic to fill in the blanks ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c         |    1 +
 builtin/receive-pack.c |   54 +++++++++++++++++++++++++++++++++++++++-
 builtin/send-pack.c    |   64 +++++++++++++++++++++++++++++++++++++++++++++---
 send-pack.h            |    1 +
 transport.c            |    4 +++
 transport.h            |    4 +++
 6 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..2238f4e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -261,6 +261,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
 			TRANSPORT_PUSH_SET_UPSTREAM),
 		OPT_BOOLEAN(0, "progress", &progress, "force progress reporting"),
+		OPT_BIT('s', "signed", &flags, "GPG sign the push", TRANSPORT_PUSH_SIGNED),
 		OPT_END()
 	};
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ae164da..20b6799 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -30,12 +30,14 @@ static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
+static int signed_push;
 static int use_sideband;
 static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static const char *head_name;
 static int sent_capabilities;
+static char *push_certificate;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -114,7 +116,7 @@ static int show_ref(const char *path, const unsigned char *sha1, int flag, void
 	else
 		packet_write(1, "%s %s%c%s%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k",
+			     " report-status delete-refs side-band-64k signed-push",
 			     prefer_ofs_delta ? " ofs-delta" : "");
 	sent_capabilities = 1;
 	return 0;
@@ -579,6 +581,31 @@ static void check_aliased_updates(struct command *commands)
 	string_list_clear(&ref_list, 0);
 }
 
+static int record_signed_push(char *cert)
+{
+	/*
+	 * This is the place for you to parse the signed push
+	 * certificate, grab the commit object names the push updates
+	 * refs to, and append the certificate to the notes to these
+	 * commits.
+	 *
+	 * You could also feed the signed push certificate to GPG,
+	 * verify the signer identity, and all the other fun stuff,
+	 * including feeding it to "pre-receive-signature" hook.
+	 *
+	 * Here we just throw it to stderr to demonstrate that the
+	 * codepath is being exercised.
+	 */
+	char *cp, *ep;
+	for (cp = cert; *cp; cp = ep) {
+		ep = strchrnul(cp, '\n');
+		if (*ep == '\n')
+			ep++;
+		fprintf(stderr, "RSP: %.*s", (int)(ep - cp), cp);
+	}
+	return 0;
+}
+
 static void execute_commands(struct command *commands, const char *unpacker_error)
 {
 	struct command *cmd;
@@ -596,6 +623,12 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 		return;
 	}
 
+	if (push_certificate && record_signed_push(push_certificate)) {
+		for (cmd = commands; cmd; cmd = cmd->next)
+			cmd->error_string = "n/a (push signature error)";
+		return;
+	}
+
 	check_aliased_updates(commands);
 
 	head_name = resolve_ref("HEAD", sha1, 0, NULL);
@@ -636,6 +669,8 @@ static struct command *read_head_info(void)
 				report_status = 1;
 			if (strstr(refname + reflen + 1, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
+			if (strstr(refname + reflen + 1, "signed-push"))
+				signed_push = 1;
 		}
 		cmd = xcalloc(1, sizeof(struct command) + len - 80);
 		hashcpy(cmd->old_sha1, old_sha1);
@@ -731,6 +766,21 @@ static const char *unpack(void)
 	}
 }
 
+static char *receive_push_certificate(void)
+{
+	struct strbuf cert = STRBUF_INIT;
+	for (;;) {
+		char line[1000];
+		int len;
+
+		len = packet_read_line(0, line, sizeof(line));
+		if (!len)
+			break;
+		strbuf_add(&cert, line, len);
+	}
+	return strbuf_detach(&cert, NULL);
+}
+
 static void report(struct command *commands, const char *unpack_status)
 {
 	struct command *cmd;
@@ -846,6 +896,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	if ((commands = read_head_info()) != NULL) {
 		const char *unpack_status = NULL;
 
+		if (signed_push)
+			push_certificate = receive_push_certificate();
 		if (!delete_only(commands))
 			unpack_status = unpack();
 		execute_commands(commands, unpack_status);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 87833f4..7f4778c 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -237,6 +237,27 @@ static int sideband_demux(int in, int out, void *data)
 	return ret;
 }
 
+static void sign_push_certificate(struct strbuf *cert)
+{
+	/*
+	 * Here, take the contents of cert->buf, and have the user GPG
+	 * sign it, and read it back in the strbuf.
+	 *
+	 * You may want to append some extra info to cert before giving
+	 * it to GPG, possibly via a hook.
+	 *
+	 * Here we upcase them just to demonstrate that the codepath
+	 * is being exercised.
+	 */
+	char *cp;
+	for (cp = cert->buf; *cp; cp++) {
+		int ch = *cp;
+		if ('a' <= ch && ch <= 'z')
+			*cp = toupper(ch);
+	}
+	return;
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
@@ -250,9 +271,11 @@ int send_pack(struct send_pack_args *args,
 	int allow_deleting_refs = 0;
 	int status_report = 0;
 	int use_sideband = 0;
+	int signed_push = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
+	struct strbuf push_cert = STRBUF_INIT;
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
@@ -270,6 +293,18 @@ int send_pack(struct send_pack_args *args,
 		return 0;
 	}
 
+	if (args->signed_push) {
+		if (server_supports("signed-push"))
+			signed_push = !args->dry_run;
+		else
+			warning("The receiving side does not support signed-push");
+	}
+
+	if (signed_push) {
+		strbuf_addstr(&push_cert, "Push-Certificate-Version: 0\n");
+		strbuf_addf(&push_cert, "Pusher: %s\n", git_committer_info(0));
+	}
+
 	/*
 	 * Finally, tell the other end!
 	 */
@@ -301,15 +336,19 @@ int send_pack(struct send_pack_args *args,
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 
-			if (!cmds_sent && (status_report || use_sideband)) {
-				packet_buf_write(&req_buf, "%s %s %s%c%s%s",
+			if (!cmds_sent &&
+			    (status_report || use_sideband || signed_push))
+				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s",
 					old_hex, new_hex, ref->name, 0,
 					status_report ? " report-status" : "",
-					use_sideband ? " side-band-64k" : "");
-			}
+					use_sideband ? " side-band-64k" : "",
+					signed_push ? " signed-push" : "");
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
 					old_hex, new_hex, ref->name);
+			if (signed_push)
+				strbuf_addf(&push_cert, "Update: %s %s\n",
+					    new_hex, ref->name);
 			ref->status = status_report ?
 				REF_STATUS_EXPECTING_REPORT :
 				REF_STATUS_OK;
@@ -326,6 +365,23 @@ int send_pack(struct send_pack_args *args,
 		safe_write(out, req_buf.buf, req_buf.len);
 		packet_flush(out);
 	}
+
+	if (signed_push && cmds_sent) {
+		char *cp, *ep;
+
+		sign_push_certificate(&push_cert);
+		strbuf_reset(&req_buf);
+		for (cp = push_cert.buf; *cp; cp = ep) {
+			ep = strchrnul(cp, '\n');
+			if (*ep == '\n')
+				ep++;
+			packet_buf_write(&req_buf, "%.*s",
+					 (int)(ep - cp), cp);
+		}
+		/* Do we need anything funky for stateless rpc? */
+		safe_write(out, req_buf.buf, req_buf.len);
+		packet_flush(out);
+	}
 	strbuf_release(&req_buf);
 
 	if (use_sideband && cmds_sent) {
diff --git a/send-pack.h b/send-pack.h
index 05d7ab1..754943e 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -11,6 +11,7 @@ struct send_pack_args {
 		use_thin_pack:1,
 		use_ofs_delta:1,
 		dry_run:1,
+		signed_push:1,
 		stateless_rpc:1;
 };
 
diff --git a/transport.c b/transport.c
index fa279d5..7a7ffe4 100644
--- a/transport.c
+++ b/transport.c
@@ -476,6 +476,9 @@ static int set_git_option(struct git_transport_options *opts,
 		else
 			opts->depth = atoi(value);
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_SIGNED_PUSH)) {
+		opts->signed_push = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -793,6 +796,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.progress = transport->progress;
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
+	args.signed_push = !!(flags & TRANSPORT_PUSH_SIGNED);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
diff --git a/transport.h b/transport.h
index 059b330..d2fa478 100644
--- a/transport.h
+++ b/transport.h
@@ -8,6 +8,7 @@ struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
 	unsigned followtags : 1;
+	unsigned signed_push : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
@@ -102,6 +103,7 @@ struct transport {
 #define TRANSPORT_PUSH_PORCELAIN 16
 #define TRANSPORT_PUSH_SET_UPSTREAM 32
 #define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
+#define TRANSPORT_PUSH_SIGNED 128
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
@@ -128,6 +130,8 @@ struct transport *transport_get(struct remote *, const char *);
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
 
+#define TRANS_OPT_SIGNED_PUSH "signedpush"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
1.7.7.rc0.188.g3793ac
