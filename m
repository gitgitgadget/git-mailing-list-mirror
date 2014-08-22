From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/19] signed push: fortify against replay attacks
Date: Fri, 22 Aug 2014 13:30:24 -0700
Message-ID: <1408739424-31429-20-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:34:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvX8-0000bT-P0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbaHVUdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:33:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51142 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbaHVUdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:33:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFBC333287;
	Fri, 22 Aug 2014 16:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=XQxP
	XvAY46Ly/sX9b1oCWJ+CW+4=; b=ro+KlC9L4xbLvbdiQzvDJ62ih7ygFwEzjFWI
	6Xwr6eGTXmbAFa52iHud7n8UWk8QvaTq20krXFx38bSkKDGaIpJ+eHq1AKEodhMy
	lKwbttUf0/JiUSQ+iUDhFGMx13Z/lIVbylw4pkL1tD/M69OjChbYlnrUsifyk3ND
	z7wPCuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=x/+1H5
	XxZqPwL8TERfpaC++6gApu7qbFa2WK0gAnBuQ66TqTzGXSxoGqrGXg353WzSi4BQ
	ZgJmMxeYa2oTCGFxHAGLb6ZOhFGYGaHsLrlyFPTeNih2dkwFfEuuVCHCFmYLEc3d
	KzOpFrqTQIPo+aij9ofUT8bL6wPlbYKpRAQy8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6ACC33286;
	Fri, 22 Aug 2014 16:33:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE6DE3327E;
	Fri, 22 Aug 2014 16:33:43 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9C134132-2A3B-11E4-9185-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255718>

In order to prevent a valid push certificate for pushing into an
repository from getting replayed to push to an unrelated one, send a
nonce string from the receive-pack process and have the signer
include it in the push certificate.  The original nonce is exported
as GIT_PUSH_CERT_NONCE for the hooks to examine and match against
the value on the "nonce" header in the certificate to notice a replay.

Because the built-in nonce generation may not be suitable for all
situations, allow the server to invoke receive-pack with pregenerated
nonce from the command line argument.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-receive-pack.txt                |  8 +++++
 Documentation/technical/pack-protocol.txt         |  5 +--
 Documentation/technical/protocol-capabilities.txt |  7 ++--
 builtin/receive-pack.c                            | 42 ++++++++++++++++++++---
 send-pack.c                                       | 19 +++++++---
 t/t5534-push-signed.sh                            | 17 +++++----
 6 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 60151a6..983b24e 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -72,6 +72,13 @@ GIT_PUSH_CERT_STATUS::
 	using the same mnemonic as used in `%G?` format of `git log`
 	family of commands (see linkgit:git-log[1]).
 
+GIT_PUSH_CERT_NONCE::
+	The nonce string the process asked the signer to include
+	in the push certificate.  If this does not match the value
+	recorded on the "nonce" header in the push certificate, it
+	may indicate that the certificate is a valid one that is
+	being replayed from a separate "git push" session.
+
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
 
@@ -147,6 +154,7 @@ service:
 	if test -n "${GIT_PUSH_CERT-}" && test ${GIT_PUSH_CERT_STATUS} = G
 	then
 		(
+			echo expected nonce is ${GIT_PUSH_NONCE}
 			git cat-file blob ${GIT_PUSH_CERT}
 		) | mail -s "push from $GIT_PUSH_CERT_SIGNER" push-log@mydomain
 	fi
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index b86580b..67dd3c9 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -483,10 +483,11 @@ references.
 
   push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
 		      PKT-LINE("certificate version 0.1" LF)
-		      PKT-LINE("pusher" ident LF)
+		      PKT-LINE("pusher" SP ident LF)
+		      PKT-LINE("nonce" SP nonce LF)
 		      PKT-LINE(LF)
 		      *PKT-LINE(command LF)
-		      *PKT-LINE(GPG signature lines LF)
+		      *PKT-LINE(detached GPG signature lines LF)
 		      PKT-LINE("push-cert-end" LF)
 
   pack-file         = "PACK" 28*(OCTET)
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index a478cc4..0c92dee 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -251,10 +251,11 @@ If the upload-pack server advertises this capability, fetch-pack may
 send "want" lines with SHA-1s that exist at the server but are not
 advertised by upload-pack.
 
-push-cert
----------
+push-cert=<nonce>
+-----------------
 
 The receive-pack server that advertises this capability is willing
-to accept a signed push certificate.  A send-pack client MUST NOT
+to accept a signed push certificate, and asks the <nonce> to be
+included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 991e417..8ad4d9b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -51,6 +51,7 @@ static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
 static unsigned char push_cert_sha1[20];
 static struct signature_check sigcheck;
+static const char *push_cert_nonce;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -142,15 +143,18 @@ static void show_ref(const char *path, const unsigned char *sha1)
 	if (ref_is_hidden(path))
 		return;
 
-	if (sent_capabilities)
+	if (sent_capabilities) {
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
-	else
-		packet_write(1, "%s %s%c%s%s agent=%s\n",
+	} else {
+		packet_write(1, "%s %s%c%s%s%s%s agent=%s\n",
 			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k quiet push-cert",
+			     " report-status delete-refs side-band-64k quiet",
 			     prefer_ofs_delta ? " ofs-delta" : "",
+			     push_cert_nonce ? " push-cert=" : "",
+			     push_cert_nonce ? push_cert_nonce : "",
 			     git_user_agent_sanitized());
-	sent_capabilities = 1;
+		sent_capabilities = 1;
+	}
 }
 
 static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *unused)
@@ -294,6 +298,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		argv_array_pushf(&env, "GIT_PUSH_CERT_SIGNER=%s", sigcheck.signer);
 		argv_array_pushf(&env, "GIT_PUSH_CERT_KEY=%s", sigcheck.key);
 		argv_array_pushf(&env, "GIT_PUSH_CERT_STATUS=%c", sigcheck.result);
+		if (push_cert_nonce)
+			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE=%s", push_cert_nonce);
 
 		proc->env = env.argv;
 	}
@@ -1226,12 +1232,28 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
+static char *prepare_push_cert_nonce(const char *sitename, const char *dir)
+{
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+
+	if (!sitename) {
+		static char buf[1024];
+		gethostname(buf, sizeof(buf));
+		sitename = buf;
+	}
+	strbuf_addf(&buf, "%s:%s:%lu", sitename, dir, time(NULL));
+	hash_sha1_file(buf.buf, buf.len, "blob", sha1);
+	return xstrdup(sha1_to_hex(sha1));
+}
+
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
 	int stateless_rpc = 0;
 	int i;
 	const char *dir = NULL;
+	const char *sitename = NULL;
 	struct command *commands;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
 	struct sha1_array ref = SHA1_ARRAY_INIT;
@@ -1261,6 +1283,13 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 				fix_thin = 0;
 				continue;
 			}
+			if (skip_prefix(arg, "--sitename=", &sitename)) {
+				continue;
+			}
+			if (skip_prefix(arg, "--push-cert-nonce=", &push_cert_nonce)) {
+				push_cert_nonce = xstrdup(push_cert_nonce);
+				continue;
+			}
 
 			usage(receive_pack_usage);
 		}
@@ -1277,6 +1306,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(receive_pack_config, NULL);
+	if (!push_cert_nonce)
+		push_cert_nonce = prepare_push_cert_nonce(sitename, dir);
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
@@ -1321,5 +1352,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
+	free((void *)push_cert_nonce);
 	return 0;
 }
diff --git a/send-pack.c b/send-pack.c
index 61f321d..349393a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -228,7 +228,8 @@ static const char *next_line(const char *line, size_t len)
 static int generate_push_cert(struct strbuf *req_buf,
 			      const struct ref *remote_refs,
 			      struct send_pack_args *args,
-			      const char *cap_string)
+			      const char *cap_string,
+			      const char *push_cert_nonce)
 {
 	const struct ref *ref;
 	char stamp[60];
@@ -240,6 +241,8 @@ static int generate_push_cert(struct strbuf *req_buf,
 	datestamp(stamp, sizeof(stamp));
 	strbuf_addf(&cert, "certificate version 0.1\n");
 	strbuf_addf(&cert, "pusher %s %s\n", signing_key, stamp);
+	if (push_cert_nonce[0])
+		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
 	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {
@@ -290,6 +293,8 @@ int send_pack(struct send_pack_args *args,
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
+	const char *push_cert_nonce = NULL;
+
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
@@ -306,8 +311,14 @@ int send_pack(struct send_pack_args *args,
 		agent_supported = 1;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
-	if (args->push_cert && !server_supports("push-cert"))
-		die(_("the receiving end does not support --signed push"));
+	if (args->push_cert) {
+		int len;
+
+		push_cert_nonce = server_feature_value("push-cert", &len);
+		if (!push_cert_nonce)
+			die(_("the receiving end does not support --signed push"));
+		push_cert_nonce = xmemdupz(push_cert_nonce, len);
+	}
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -338,7 +349,7 @@ int send_pack(struct send_pack_args *args,
 
 	if (!args->dry_run && args->push_cert)
 		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
-					       cap_buf.buf);
+					       cap_buf.buf, push_cert_nonce);
 
 	/*
 	 * Clear the status for each ref and see if we need to send
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 659bca0..6db59ce 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -58,17 +58,22 @@ test_expect_success GPG 'signed push sends push certificate' '
 	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
 	KEY=${GIT_PUSH_CERT_KEY-nokey}
 	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
+	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
 	E_O_F
 
 	EOF
 
-	cat >expect <<-\EOF &&
-	SIGNER=C O Mitter <committer@example.com>
-	KEY=13B6F51ECDDE430D
-	STATUS=G
-	EOF
-
 	git push --signed dst noop ff +noff &&
+
+	(
+		cat <<-\EOF &&
+		SIGNER=C O Mitter <committer@example.com>
+		KEY=13B6F51ECDDE430D
+		STATUS=G
+		EOF
+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
+	) >expect &&
+
 	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
 	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
 	test_cmp expect dst/push-cert-status
-- 
2.1.0-304-g950f846
