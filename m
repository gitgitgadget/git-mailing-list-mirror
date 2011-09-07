From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] push -s: skeleton
Date: Wed, 07 Sep 2011 13:57:27 -0700
Message-ID: <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 22:57:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PBr-0003Wd-UR
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 22:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983Ab1IGU5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 16:57:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59990 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756974Ab1IGU5b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 16:57:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80FF13DB9;
	Wed,  7 Sep 2011 16:57:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uRCRuL7su3O6DU3BKthyVVbS+xo=; b=bZLHIH
	+HgIMpPe5nLCFTdc075E6YCRnFuyBTOqvgE8g+odAzq5mJYsdXV+THVk/6UK/t4E
	XU2KGdDHyK1ikdtMnKQZpgmRM2GHWRqtj+TKpoSuO6aEgkpu30+eCVB1CgnnjQ9J
	Xabzuo5cn5BmT0CYHUQI2xnfJD+OZZLvw+0+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yFtB2oCLqqaAdqxBBBFEXL04P9Eqj4Tv
	tDpQIfsvepNHln0mjbqaJakaXnmqEGxXWPhQp1q5AmG4JYwCIVIx6eGLLNkqcVlO
	r0rqX8+vevJi8jSIYGmwIcZh05OKUHMBrGHrO5yyB8dvuuxXMUyJ3fvKBaZHlxXm
	PBwgpzMngFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 787A03DB8;
	Wed,  7 Sep 2011 16:57:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DD813DB6; Wed,  7 Sep 2011
 16:57:29 -0400 (EDT)
In-Reply-To: <7vfwk82hrt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 07 Sep 2011 13:56:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FFBF8A52-D993-11E0-A30E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180906>

If a tag is GPG-signed, and if you trust the cryptographic robustness of
the SHA-1 and GPG, you can guarantee that all the history leading to the
signed commit is not tampered with. However, it would be both cumbersome
and cluttering to sign each and every commit. Especially if you strive to
keep your history clean by tweaking, rewriting and polishing your commits
before pushing the resulting history out, many commits you will create
locally end up not mattering at all, and it is a waste of time to sign
them.

A better alternative could be to sign a "push certificate" (for the lack
of better name) every time you push, asserting that what commits you are
pushing to update which refs. The basic workflow goes like this:

 1. You push out your work with "git push -s";

 2. "git push", as usual, learns where the remote refs are and which refs
    are to be updated with this push. It prepares a text file in memory
    that looks like this using this information:

	Push-Certificate-Version: 1
	Pusher: Junio C Hamano <gitster@pobox.com> 1315427886 -0700
	Update: e83c51633... d4e58965f... refs/heads/master
	Update: 5a144a288... 7931f38a2... refs/heads/next

    An actual push certificate records full 40-char object name, but it is
    ellided for brevity here.

    The user then is asked to sign this push certificate using GPG. The
    result is carried to the other side (i.e. receive-pack). In the
    protocol exchange, this step comes immediately after the sender tells
    what the result of the push should be, before it sends the pack data.

 3. The receiving end will keep the signed push certificate in core,
    receives the pack data and unpacks (or stores and runs index-pack)
    as usual.

 4. A new phase to record the push certificate is introduced in the
    codepath after the receiving end runs receive_hook(). It is envisioned
    that this phase:

    a. parses the updated-to object names, and appends the push
       certificate (still GPG signed) to a note attached to each of the
       objects that will sit at the tip of the refs;

    b. verifies that the push certificate is signed with a GPG key that is
       authorized to push into this repository; and/or

    c. invokes pre-push-verify-signature hook, feeds the push
       certificate to it and asks it to veto the ref updates.

And here is a skeleton to implement it. It has all the necessary protocol
extensions implemented (although I do not know if we need separate
codepath for stateless RPC mode), but does not have subroutines to:

 - Sign the certificate with GPG key;

 - Parse the signed certificate to identify the updated-to objects, and
   add the certificate as notes to them;

 - Verify the certificate and find out what GPG key was used to sign it;
   or

 - Invoke and feed the certificate to pre-push-verify-hook.

all of which should be fairly trivial. The places that needs to implement
these are clearly marked with large comments, so I'll leave it up to other
people who are interested in the topic to fill in the blanks ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c         |    1 +
 builtin/receive-pack.c |   54 +++++++++++++++++++++++++++++++++++++++-
 builtin/send-pack.c    |   65 +++++++++++++++++++++++++++++++++++++++++++++---
 send-pack.h            |    1 +
 transport.c            |    4 +++
 transport.h            |    4 +++
 6 files changed, 124 insertions(+), 5 deletions(-)

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
index ae164da..307fc3b 100644
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
+	 * including feeding it to "pre-push-verify-signature" hook.
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
index 87833f4..3193f34 100644
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
@@ -270,6 +293,19 @@ int send_pack(struct send_pack_args *args,
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
+		const char *committer_info = git_committer_info(0);
+		strbuf_addstr(&push_cert, "Push-Certificate-Version: 1\n");
+		strbuf_addf(&push_cert, "Pusher: %s\n", committer_info);
+	}
+
 	/*
 	 * Finally, tell the other end!
 	 */
@@ -301,15 +337,19 @@ int send_pack(struct send_pack_args *args,
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
+			if (signed_push && hashcmp(ref->old_sha1, ref->new_sha1))
+				strbuf_addf(&push_cert, "Update: %s %s %s\n",
+					    old_hex, new_hex, ref->name);
 			ref->status = status_report ?
 				REF_STATUS_EXPECTING_REPORT :
 				REF_STATUS_OK;
@@ -326,6 +366,23 @@ int send_pack(struct send_pack_args *args,
 		safe_write(out, req_buf.buf, req_buf.len);
 		packet_flush(out);
 	}
+
+	if (signed_push) {
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
1.7.7.rc0.186.g50963
