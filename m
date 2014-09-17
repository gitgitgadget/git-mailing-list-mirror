From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 23/23] signed push: allow stale nonce in stateless mode
Date: Wed, 17 Sep 2014 15:45:58 -0700
Message-ID: <1410993958-32394-24-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:47:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUO05-0002Ls-Un
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242AbaIQWq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58903 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757220AbaIQWqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A995539E35;
	Wed, 17 Sep 2014 18:46:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=G3Se
	f2vGPanfP5ZOdXHKVzXbbVY=; b=SvkW43p8Aakeujfl0QmYYxvwOjPi7i88VWxM
	FQuOKGIRyRvzdutHcSI6yxK78FHLB2dU80DdySar47s9e/7RfACiLrpvRWO5PzIP
	DOWPduGXvMmz3BE4ZBIqcvDQpAhf93BHRXCgK1ItQkIcOZR6csVZGxYfKnrRTBFb
	0hQiQng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hsWXRJ
	C0FSE7VzHEoMaWQSNXAWYKAWBOFbHvYRXgJiOrwD+TQ7dRNGIgqVsigSkePDdBDc
	B/cXKUfr6NWUiDRyADNJJwD4jWI9vUQzwG1skQfiMQvg3pbIpX8TJsWY7psrsJvy
	eW3t919EpIuvbX5Fo1kW7LsgcZHK2oWl1Mbxw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EFE639E34;
	Wed, 17 Sep 2014 18:46:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4986739E2E;
	Wed, 17 Sep 2014 18:46:46 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 80C45F66-3EBC-11E4-8146-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257244>

When operating with the stateless RPC mode, we will receive a nonce
issued by another instance of us that advertised our capability and
refs some time ago.  Update the logic to check received nonce to
detect this case, compute how much time has passed since the nonce
was issued and report the status with a new environment variable
GIT_PUSH_CERT_NONCE_SLOP to the hooks.

GIT_PUSH_CERT_NONCE_STATUS will report "SLOP" in such a case.  The
hooks are free to decide how large a slop it is willing to accept.

Strictly speaking, the "nonce" is not really a "nonce" anymore in
the stateless RPC mode, as it will happily take any "nonce" issued
by it (which is protected by HMAC and its secret key) as long as it
is fresh enough.  The degree of this security degradation, relative
to the native protocol, is about the same as the "we make sure that
the 'git push' decided to update our refs with new objects based on
the freshest observation of our refs by making sure the values they
claim the original value of the refs they ask us to update exactly
match the current state" security is loosened to accomodate the
stateless RPC mode in the existing code without this series, so
there is no need for those who are already using smart HTTP to push
to their repositories to be alarmed any more than they already are.

In addition, the server operator can set receive.certnonceslop
configuration variable to specify how stale a nonce can be (in
seconds).  When this variable is set, and if the nonce received in
the certificate that passes the HMAC check was less than that many
seconds old, hooks are given "OK" in GIT_PUSH_CERT_NONCE_STATUS
(instead of "SLOP") and the received nonce value is given in
GIT_PUSH_CERT_NONCE, which makes it easier for a simple-minded
hook to check if the certificate we received is recent enough.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This roughly corresponds to 22/23 in v5; instead of always
   forcing the hooks to check NONCE_SLOP, v6 also adds a mechanism
   for the server operators to tell receive-pack to "lie" about the
   nonce it requested when the push certificate received is fresh
   enough to make it easier to code hooks.

 Documentation/config.txt           | 13 ++++++
 Documentation/git-receive-pack.txt | 13 ++++++
 builtin/receive-pack.c             | 89 +++++++++++++++++++++++++++++++++-----
 t/t5541-http-push-smart.sh         |  9 +++-
 4 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dd6fd65..d73366f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2049,6 +2049,19 @@ receive.certnonceseed::
 	a "nonce" protected by HMAC using this string as a secret
 	key.
 
+receive.certnonceslop::
+	When a `git push --signed` sent a push certificate with a
+	"nonce" that was issued by a receive-pack serving the same
+	repository within this many seconds, export the "nonce"
+	found in the certificate to `GIT_PUSH_CERT_NONCE` to the
+	hooks (instead of what the receive-pack asked the sending
+	side to include).  This may allow writing checks in
+	`pre-receive` and `post-receive` a bit easier.  Instead of
+	checking `GIT_PUSH_CERT_NONCE_SLOP` environment variable
+	that records by how many seconds the nonce is stale to
+	decide if they want to accept the certificate, they only
+	can check `GIT_PUSH_CERT_NONCE_STATUS` is `OK`.
+
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
 	objects. It will abort in the case of a malformed object or a
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 2d4b452..9016960 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -89,6 +89,19 @@ the following environment variables:
 	"git push --signed" sent a bogus nonce.
 `OK`;;
 	"git push --signed" sent the nonce we asked it to send.
+`SLOP`;;
+	"git push --signed" sent a nonce different from what we
+	asked it to send now, but in a previous session.  See
+	`GIT_PUSH_CERT_NONCE_SLOP` environment variable.
+
+`GIT_PUSH_CERT_NONCE_SLOP`::
+	"git push --signed" sent a nonce different from what we
+	asked it to send now, but in a different session whose
+	starting time is different by this many seconds from the
+	current session.  Only meaningful when
+	`GIT_PUSH_CERT_NONCE_STATUS` says `SLOP`.
+	Also read about `receive.certnonceslop` variable in
+	linkgit:git-config[1].
 
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 91d1a6f..efb13b1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -43,6 +43,8 @@ static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static int fix_thin = 1;
+static int stateless_rpc;
+static const char *service_dir;
 static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
@@ -58,7 +60,10 @@ static const char *NONCE_UNSOLICITED = "UNSOLICITED";
 static const char *NONCE_BAD = "BAD";
 static const char *NONCE_MISSING = "MISSING";
 static const char *NONCE_OK = "OK";
+static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
+static long nonce_stamp_slop;
+static unsigned long nonce_stamp_slop_limit;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -145,6 +150,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	if (strcmp(var, "receive.certnonceseed") == 0)
 		return git_config_string(&cert_nonce_seed, var, value);
 
+	if (strcmp(var, "receive.certnonceslop") == 0) {
+		nonce_stamp_slop_limit = git_config_ulong(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -359,6 +369,8 @@ static char *find_header(const char *msg, size_t len, const char *key)
 static const char *check_nonce(const char *buf, size_t len)
 {
 	char *nonce = find_header(buf, len, "nonce");
+	unsigned long stamp, ostamp;
+	char *bohmac, *expect = NULL;
 	const char *retval = NONCE_BAD;
 
 	if (!nonce) {
@@ -372,11 +384,67 @@ static const char *check_nonce(const char *buf, size_t len)
 		goto leave;
 	}
 
-	/* returned nonce MUST match what we gave out earlier */
-	retval = NONCE_BAD;
+	if (!stateless_rpc) {
+		/* returned nonce MUST match what we gave out earlier */
+		retval = NONCE_BAD;
+		goto leave;
+	}
+
+	/*
+	 * In stateless mode, we may be receiving a nonce issued by
+	 * another instance of the server that serving the same
+	 * repository, and the timestamps may not match, but the
+	 * nonce-seed and dir should match, so we can recompute and
+	 * report the time slop.
+	 *
+	 * In addition, when a nonce issued by another instance has
+	 * timestamp within receive.certnonceslop seconds, we pretend
+	 * as if we issued that nonce when reporting to the hook.
+	 */
+
+	/* nonce is concat(<seconds-since-epoch>, "-", <hmac>) */
+	if (*nonce <= '0' || '9' < *nonce) {
+		retval = NONCE_BAD;
+		goto leave;
+	}
+	stamp = strtoul(nonce, &bohmac, 10);
+	if (bohmac == nonce || bohmac[0] != '-') {
+		retval = NONCE_BAD;
+		goto leave;
+	}
+
+	expect = prepare_push_cert_nonce(service_dir, stamp);
+	if (strcmp(expect, nonce)) {
+		/* Not what we would have signed earlier */
+		retval = NONCE_BAD;
+		goto leave;
+	}
+
+	/*
+	 * By how many seconds is this nonce stale?  Negative value
+	 * would mean it was issued by another server with its clock
+	 * skewed in the future.
+	 */
+	ostamp = strtoul(push_cert_nonce, NULL, 10);
+	nonce_stamp_slop = (long)ostamp - (long)stamp;
+
+	if (nonce_stamp_slop_limit &&
+	    abs(nonce_stamp_slop) <= nonce_stamp_slop_limit) {
+		/*
+		 * Pretend as if the received nonce (which passes the
+		 * HMAC check, so it is not a forged by third-party)
+		 * is what we issued.
+		 */
+		free((void *)push_cert_nonce);
+		push_cert_nonce = xstrdup(nonce);
+		retval = NONCE_OK;
+	} else {
+		retval = NONCE_SLOP;
+	}
 
 leave:
 	free(nonce);
+	free(expect);
 	return retval;
 }
 
@@ -426,6 +494,9 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		if (push_cert_nonce) {
 			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE=%s", push_cert_nonce);
 			argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE_STATUS=%s", nonce_status);
+			if (nonce_status == NONCE_SLOP)
+				argv_array_pushf(&env, "GIT_PUSH_CERT_NONCE_SLOP=%ld",
+						 nonce_stamp_slop);
 		}
 		proc->env = env.argv;
 	}
@@ -1361,9 +1432,7 @@ static int delete_only(struct command *commands)
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
-	int stateless_rpc = 0;
 	int i;
-	const char *dir = NULL;
 	struct command *commands;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
 	struct sha1_array ref = SHA1_ARRAY_INIT;
@@ -1396,21 +1465,21 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 			usage(receive_pack_usage);
 		}
-		if (dir)
+		if (service_dir)
 			usage(receive_pack_usage);
-		dir = arg;
+		service_dir = arg;
 	}
-	if (!dir)
+	if (!service_dir)
 		usage(receive_pack_usage);
 
 	setup_path();
 
-	if (!enter_repo(dir, 0))
-		die("'%s' does not appear to be a git repository", dir);
+	if (!enter_repo(service_dir, 0))
+		die("'%s' does not appear to be a git repository", service_dir);
 
 	git_config(receive_pack_config, NULL);
 	if (cert_nonce_seed)
-		push_cert_nonce = prepare_push_cert_nonce(dir, time(NULL));
+		push_cert_nonce = prepare_push_cert_nonce(service_dir, time(NULL));
 
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 24926a4..ffb3af4 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -340,21 +340,26 @@ test_expect_success GPG 'push with post-receive to inspect certificate' '
 		SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
 		KEY=${GIT_PUSH_CERT_KEY-nokey}
 		STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
+		NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
+		NONCE=${GIT_PUSH_CERT_NONCE-nononce}
 		E_O_F
 		EOF
 
-		git config receive.certnonceseed sekrit
+		git config receive.certnonceseed sekrit &&
+		git config receive.certnonceslop 30
 	) &&
 	cd "$ROOT_PATH/test_repo_clone" &&
 	test_commit cert-test &&
 	git push --signed "$HTTPD_URL/smart/test_repo.git" &&
 	(
 		cd "$HTTPD_DOCUMENT_ROOT_PATH" &&
-		cat <<-\EOF
+		cat <<-\EOF &&
 		SIGNER=C O Mitter <committer@example.com>
 		KEY=13B6F51ECDDE430D
 		STATUS=G
+		NONCE_STATUS=OK
 		EOF
+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" push-cert
 	) >expect &&
 	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH/push-cert-status"
 '
-- 
2.1.0-403-g099cf47
