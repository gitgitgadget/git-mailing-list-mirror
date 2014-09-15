From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 21/23] signed push: fortify against replay attacks
Date: Mon, 15 Sep 2014 15:24:22 -0700
Message-ID: <1410819864-22967-22-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTei6-0006ZT-5v
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758731AbaIOWZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:25:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55436 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805AbaIOWZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:25:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E4E63B1D8;
	Mon, 15 Sep 2014 18:25:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VaD5
	lGb2/qWK6zgO+s+mYqnrTOo=; b=lBcsfJ/t6dWvGMTY6sHkb7stUvdQJKe06aK8
	NkCUuKqortEKFmhq4cLIhoqH6jLNPBbkXDzKlnCl5cBQu5LEu60qx9hgkXWGCgRM
	wu/9yivSR7ZW0ZHsg7iWAQm+CvC/cRGXZC340YmdThI6ixt7MNBhe3ukYaiTIBga
	9/w8eDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=yYcolA
	TS4fMsiy/dLvR47IGfH7QyPWGNHkvwt/LdpZoAZQ1DRsZJwy6zrPN+hOSRRpAmRA
	Qsg0igB+HmrmEgXIN1pbqsw5qzycLyEkhh/wKCpQ7vHTXc2uqBts6t16CrqCVqeg
	NhZiZqqIEdy+xvJPUYs5mth29tsFdogO+j6LM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 652303B1D7;
	Mon, 15 Sep 2014 18:25:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AA4033B1D6;
	Mon, 15 Sep 2014 18:25:07 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 25E9EB7E-3D27-11E4-8B22-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257104>

In order to prevent a valid push certificate for pushing into an
repository from getting replayed to push to an unrelated one, send a
nonce string from the receive-pack process and have the signer
include it in the push certificate.  The receiving end uses an HMAC
hash of the path to the repository it serves and the current time,
hashed with a secret key (this does not have to be per-repository
but can be defined in /etc/gitconfig) to ensure that a random third
party cannot forge a nonce that looks like it originated from it.

The original nonce is exported as GIT_PUSH_CERT_NONCE for the hooks
to examine and match against the value on the "nonce" header in the
certificate to notice a replay.  Returned "nonce" header is examined
and the validation state is exported as GIT_PUSH_CERT_NONCE_STATUS
to the hooks.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt                          |  12 +--
 Documentation/git-receive-pack.txt                |  19 ++++
 Documentation/technical/pack-protocol.txt         |   6 ++
 Documentation/technical/protocol-capabilities.txt |   7 +-
 builtin/receive-pack.c                            | 123 ++++++++++++++++++++--
 send-pack.c                                       |  18 +++-
 t/t5534-push-signed.sh                            |  20 ++--
 7 files changed, 176 insertions(+), 29 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0d01e32..dd6fd65 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2038,17 +2038,17 @@ rebase.autostash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
 
-receive.acceptpushcert::
-	By default, `git receive-pack` will advertise that it
-	accepts `git push --signed`.  Setting this variable to
-	false disables it (this is a tentative variable that
-	will go away at the end of this series).
-
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
 	it by setting this variable to false.
 
+receive.certnonceseed::
+	By setting this variable to a string, `git receive-pack`
+	will accept a `git push --signed` and verifies it by using
+	a "nonce" protected by HMAC using this string as a secret
+	key.
+
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
 	objects. It will abort in the case of a malformed object or a
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index e6df234..2d4b452 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -72,6 +72,24 @@ the following environment variables:
 	using the same mnemonic as used in `%G?` format of `git log`
 	family of commands (see linkgit:git-log[1]).
 
+`GIT_PUSH_CERT_NONCE`::
+	The nonce string the process asked the signer to include
+	in the push certificate.  If this does not match the value
+	recorded on the "nonce" header in the push certificate, it
+	may indicate that the certificate is a valid one that is
+	being replayed from a separate "git push" session.
+
+`GIT_PUSH_CERT_NONCE_STATUS`::
+`UNSOLICITED`;;
+	"git push --signed" sent a nonce when we did not ask it to
+	send one.
+`MISSING`;;
+	"git push --signed" did not send any nonce header.
+`BAD`;;
+	"git push --signed" sent a bogus nonce.
+`OK`;;
+	"git push --signed" sent the nonce we asked it to send.
+
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
 
@@ -147,6 +165,7 @@ service:
 	if test -n "${GIT_PUSH_CERT-}" && test ${GIT_PUSH_CERT_STATUS} = G
 	then
 		(
+			echo expected nonce is ${GIT_PUSH_NONCE}
 			git cat-file blob ${GIT_PUSH_CERT}
 		) | mail -s "push certificate from $GIT_PUSH_CERT_SIGNER" push-log@mydomain
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
index 431af39..a1823e5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -48,10 +48,17 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
-static int accept_push_cert = 1;
 static struct strbuf push_cert = STRBUF_INIT;
 static unsigned char push_cert_sha1[20];
 static struct signature_check sigcheck;
+static const char *push_cert_nonce;
+static const char *cert_nonce_seed;
+
+static const char *NONCE_UNSOLICITED = "UNSOLICITED";
+static const char *NONCE_BAD = "BAD";
+static const char *NONCE_MISSING = "MISSING";
+static const char *NONCE_OK = "OK";
+static const char *nonce_status;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -135,10 +142,8 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (strcmp(var, "receive.acceptpushcert") == 0) {
-		accept_push_cert = git_config_bool(var, value);
-		return 0;
-	}
+	if (strcmp(var, "receive.certnonceseed") == 0)
+		return git_config_string(&cert_nonce_seed, var, value);
 
 	return git_default_config(var, value, cb);
 }
@@ -157,8 +162,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			      "report-status delete-refs side-band-64k quiet");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
-		if (accept_push_cert)
-			strbuf_addstr(&cap, " push-cert");
+		if (push_cert_nonce)
+			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write(1, "%s %s%c%s\n",
 			     sha1_to_hex(sha1), path, 0, cap.buf);
@@ -271,6 +276,101 @@ static int copy_to_sideband(int in, int out, void *arg)
 	return 0;
 }
 
+#define HMAC_BLOCK_SIZE 64
+
+static void hmac_sha1(unsigned char out[20],
+		      const char *key_in, size_t key_len,
+		      const char *text, size_t text_len)
+{
+	unsigned char key[HMAC_BLOCK_SIZE];
+	unsigned char k_ipad[HMAC_BLOCK_SIZE];
+	unsigned char k_opad[HMAC_BLOCK_SIZE];
+	int i;
+	git_SHA_CTX ctx;
+
+	/* RFC 2104 2. (1) */
+	memset(key, '\0', HMAC_BLOCK_SIZE);
+	if (HMAC_BLOCK_SIZE < key_len) {
+		git_SHA1_Init(&ctx);
+		git_SHA1_Update(&ctx, key_in, key_len);
+		git_SHA1_Final(key, &ctx);
+	} else {
+		memcpy(key, key_in, key_len);
+	}
+
+	/* RFC 2104 2. (2) & (5) */
+	for (i = 0; i < sizeof(key); i++) {
+		k_ipad[i] = key[i] ^ 0x36;
+		k_opad[i] = key[i] ^ 0x5c;
+	}
+
+	/* RFC 2104 2. (3) & (4) */
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, k_ipad, sizeof(k_ipad));
+	git_SHA1_Update(&ctx, text, text_len);
+	git_SHA1_Final(out, &ctx);
+
+	/* RFC 2104 2. (6) & (7) */
+	git_SHA1_Init(&ctx);
+	git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
+	git_SHA1_Update(&ctx, out, sizeof(out));
+	git_SHA1_Final(out, &ctx);
+}
+
+static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
+{
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+
+	strbuf_addf(&buf, "%s:%lu", path, stamp);
+	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));;
+	strbuf_release(&buf);
+
+	/* RFC 2104 5. HMAC-SHA1-80 */
+	strbuf_addf(&buf, "%lu-%.*s", stamp, 20, sha1_to_hex(sha1));
+	return strbuf_detach(&buf, NULL);
+}
+
+/*
+ * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing
+ * after dropping "_commit" from its name and possibly moving it out
+ * of commit.c
+ */
+static const char *find_header(const char *msg, size_t len, const char *key)
+{
+	int key_len = strlen(key);
+	const char *line = msg;
+
+	while (line && line < msg + len) {
+		const char *eol = strchrnul(line, '\n');
+
+		if ((msg + len <= eol) || line == eol)
+			return NULL;
+		if (line + key_len < eol &&
+		    !memcmp(line, key, key_len) && line[key_len] == ' ') {
+			int offset = key_len + 1;
+			return xmemdupz(line + offset, (eol - line) - offset);
+		}
+		line = *eol ? eol + 1 : NULL;
+	}
+	return NULL;
+}
+
+static const char *check_nonce(const char *buf, size_t len)
+{
+	const char *nonce = find_header(buf, len, "nonce");
+
+	if (!nonce)
+		return NONCE_MISSING;
+	else if (!push_cert_nonce)
+		return NONCE_UNSOLICITED;
+	else if (!strcmp(push_cert_nonce, nonce))
+		return NONCE_OK;
+
+	/* returned nonce MUST match what we gave out earlier */
+	return NONCE_BAD;
+}
+
 static void prepare_push_cert_sha1(struct child_process *proc)
 {
 	static int already_done;
@@ -305,6 +405,7 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 
 		strbuf_release(&gpg_output);
 		strbuf_release(&gpg_status);
+		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
 	if (!is_null_sha1(push_cert_sha1)) {
 		argv_array_pushf(&env, "GIT_PUSH_CERT=%s", sha1_to_hex(push_cert_sha1));
@@ -313,7 +414,10 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		argv_array_pushf(&env, "GIT_PUSH_CERT_KEY=%s",
 				 sigcheck.key ? sigcheck.key : "");
 		argv_array_pushf(&env, "GIT_PUSH_CERT_STATUS=%c", sigcheck.result);
-
+		if (push_cert_nonce) {
+			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE=%s", push_cert_nonce);
+			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE_STATUS=%s", nonce_status);
+		}
 		proc->env = env.argv;
 	}
 }
@@ -1296,6 +1400,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(receive_pack_config, NULL);
+	if (cert_nonce_seed)
+		push_cert_nonce = prepare_push_cert_nonce(dir, time(NULL));
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
@@ -1340,5 +1446,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
+	free((void *)push_cert_nonce);
 	return 0;
 }
diff --git a/send-pack.c b/send-pack.c
index 9c2c649..7ad1a59 100644
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
@@ -295,6 +298,7 @@ int send_pack(struct send_pack_args *args,
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
+	const char *push_cert_nonce = NULL;
 
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
@@ -311,8 +315,14 @@ int send_pack(struct send_pack_args *args,
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
@@ -343,7 +353,7 @@ int send_pack(struct send_pack_args *args,
 
 	if (!args->dry_run && args->push_cert)
 		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
-					       cap_buf.buf);
+					       cap_buf.buf, push_cert_nonce);
 
 	/*
 	 * Clear the status for each ref and see if we need to send
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 2f4b74e..d09d411 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -50,7 +50,6 @@ test_expect_success 'unsigned push does not send push certificate' '
 test_expect_success 'talking with a receiver without push certificate support' '
 	prepare_dst &&
 	mkdir -p dst/.git/hooks &&
-	git -C dst config receive.acceptpushcert no &&
 	write_script dst/.git/hooks/post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
@@ -68,7 +67,6 @@ test_expect_success 'talking with a receiver without push certificate support' '
 test_expect_success 'push --signed fails with a receiver without push certificate support' '
 	prepare_dst &&
 	mkdir -p dst/.git/hooks &&
-	git -C dst config receive.acceptpushcert no &&
 	test_must_fail git push --signed dst noop ff +noff 2>err &&
 	test_i18ngrep "the receiving end does not support" err
 '
@@ -89,6 +87,7 @@ test_expect_success GPG 'no certificate for a signed push with no update' '
 test_expect_success GPG 'signed push sends push certificate' '
 	prepare_dst &&
 	mkdir -p dst/.git/hooks &&
+	git -C dst config receive.certnonceseed sekrit &&
 	write_script dst/.git/hooks/post-receive <<-\EOF &&
 	# discard the update list
 	cat >/dev/null
@@ -102,17 +101,22 @@ test_expect_success GPG 'signed push sends push certificate' '
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
2.1.0-410-gd72dacd
