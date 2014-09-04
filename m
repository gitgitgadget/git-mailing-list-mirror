From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 21/21] signed push: fortify against replay attacks
Date: Thu,  4 Sep 2014 13:04:57 -0700
Message-ID: <1409861097-19151-22-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ5-0001FP-Ja
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbaIDUGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:06:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50146 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419AbaIDUGS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:06:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BE1E38219;
	Thu,  4 Sep 2014 16:06:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Vnmy
	KVfZXrXs1q21AYi6aDVat+Y=; b=dhsemMNskIOxXs+YxeIhMBNBlqUyyQBES8ow
	QCctZi2QEvorjPd525kGEP3ZhOxceqiY5NOrpp/UXdvfcmxRLs2gJjtAIc3Digk6
	hXHkahF0o0vnHbxIm3Vv3m2JJOEg47sYad5D1ZZ3+Ce0JzTtcCc7dwECr1tWsbJM
	Dau204Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gbe3Ts
	+SImrcvaMNRD+MSp2yVswHqUJSZDgNv0UP3D8EJGql6siEaOZUh4rONOtk6WZiEl
	AXIjmLtgbxXoEGKbk4pUKrSQy6Qw5NYBte7VSoBTR3LglMVN8ETdcBFVvG3fx9fT
	rqTuu/1xjPGtErTnexsmN+3ytBC9Dh8vT6j8A=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EE0238218;
	Thu,  4 Sep 2014 16:06:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BD46538200;
	Thu,  4 Sep 2014 16:06:08 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E8FD2750-346E-11E4-AC50-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256478>

In order to prevent a valid push certificate for pushing into an
repository from getting replayed to push to an unrelated one, send a
nonce string from the receive-pack process and have the signer
include it in the push certificate.  The original nonce is exported
as GIT_PUSH_CERT_NONCE for the hooks to examine and match against
the value on the "nonce" header in the certificate to notice a
replay.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-receive-pack.txt                |  8 ++++++++
 Documentation/technical/pack-protocol.txt         |  6 ++++++
 Documentation/technical/protocol-capabilities.txt |  7 ++++---
 builtin/receive-pack.c                            | 21 +++++++++++++++++++--
 send-pack.c                                       | 19 +++++++++++++++----
 t/t5534-push-signed.sh                            | 17 +++++++++++------
 6 files changed, 63 insertions(+), 15 deletions(-)

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
index 7b543dc..dda1206 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -485,6 +485,7 @@ references.
 		      PKT-LINE("certificate version 0.1" LF)
 		      PKT-LINE("pusher" SP ident LF)
 		      PKT-LINE("pushee" SP url LF)
+		      PKT-LINE("nonce" SP nonce LF)
 		      PKT-LINE(LF)
 		      *PKT-LINE(command LF)
 		      *PKT-LINE(gpg-signature-lines LF)
@@ -533,6 +534,11 @@ Currently, the following header fields are defined:
 	authentication material) the user who ran `git push`
 	intended to push into.
 
+`nonce` nonce::
+	The 'nonce' string the receiving repository asked the
+	pushing user to include in the certificate, to prevent
+	replay attacks.
+
 The GPG signature lines are a detached signature for the contents
 recorded in the push certificate before the signature block begins.
 The detached signature is used to certify that the commands were
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
index 2d93c87..9abfc94 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -52,6 +52,7 @@ static int accept_push_cert = 1;
 static struct strbuf push_cert = STRBUF_INIT;
 static unsigned char push_cert_sha1[20];
 static struct signature_check sigcheck;
+static const char *push_cert_nonce;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -157,8 +158,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			      "report-status delete-refs side-band-64k quiet");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
-		if (accept_push_cert)
-			strbuf_addstr(&cap, " push-cert");
+		if (accept_push_cert && push_cert_nonce)
+			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write(1, "%s %s%c%s\n",
 			     sha1_to_hex(sha1), path, 0, cap.buf);
@@ -313,6 +314,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		argv_array_pushf(&env, "GIT_PUSH_CERT_KEY=%s",
 				 sigcheck.key ? sigcheck.key : "");
 		argv_array_pushf(&env, "GIT_PUSH_CERT_STATUS=%c", sigcheck.result);
+		if (push_cert_nonce)
+			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE=%s", push_cert_nonce);
 
 		proc->env = env.argv;
 	}
@@ -1245,6 +1248,17 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
+static char *prepare_push_cert_nonce(const char *dir)
+{
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+
+	strbuf_addf(&buf, "%s:%lu", dir, time(NULL));
+	hash_sha1_file(buf.buf, buf.len, "blob", sha1);
+	strbuf_release(&buf);
+	return xstrdup(sha1_to_hex(sha1));
+}
+
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
@@ -1304,6 +1318,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(receive_pack_config, NULL);
+	if (accept_push_cert && !push_cert_nonce)
+		push_cert_nonce = prepare_push_cert_nonce(dir);
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
@@ -1348,5 +1364,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
+	free((void *)push_cert_nonce);
 	return 0;
 }
diff --git a/send-pack.c b/send-pack.c
index 642ebc8..141a6b2 100644
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
@@ -245,6 +246,8 @@ static int generate_push_cert(struct strbuf *req_buf,
 		strbuf_addf(&cert, "pushee %s\n", anon_url);
 		free(anon_url);
 	}
+	if (push_cert_nonce[0])
+		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
 	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {
@@ -295,6 +298,8 @@ int send_pack(struct send_pack_args *args,
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
+	const char *push_cert_nonce = NULL;
+
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
@@ -311,8 +316,14 @@ int send_pack(struct send_pack_args *args,
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
@@ -343,7 +354,7 @@ int send_pack(struct send_pack_args *args,
 
 	if (!args->dry_run && args->push_cert)
 		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
-					       cap_buf.buf);
+					       cap_buf.buf, push_cert_nonce);
 
 	/*
 	 * Clear the status for each ref and see if we need to send
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 35fe704..66fdaf2 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -72,17 +72,22 @@ test_expect_success GPG 'signed push sends push certificate' '
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
2.1.0-399-g1364b4d
