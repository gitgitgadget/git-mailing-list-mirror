From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 22/23] signed push: teach smart-HTTP to pass "git push --signed" around
Date: Wed, 17 Sep 2014 15:45:57 -0700
Message-ID: <1410993958-32394-23-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:47:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUO04-0002Ls-74
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944AbaIQWqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57933 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757208AbaIQWqs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9590839E33;
	Wed, 17 Sep 2014 18:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Z8+e
	TXCFIXpdp2GKAhL/rLgeFV0=; b=oAAyeRKbutTPN6gxjFsuXGAp9vNB4pRAF9v9
	NLUCSAr0YPm4kzqIPfHyEbU1HwxIYG6jFC9QvMZcrsIno47cnIhPTSExPyXTg9no
	lZ62yQ9iChWQdM4tLR2wdpj/keqHkC5jvqQycTx+8isXxjenVjkxJht9dT3QD5Ao
	EYl1bVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=pg/1vL
	u1BiMkl3eMQDQr3mcrr+/rgAWzMAcX+yndismEA5IolJJyDwTSqCO0Xlv9UaJ7S1
	hM5RYl+ZxLYK+ihV1LsKRXqa36uCvUEnBP+OTAPGy+WN4oGEs2iKaVTLd36XqiQ9
	5h3t+wZuOm1gGikaZAZKgxyU6Jo7o9/U0zO0s=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BF6B39E32;
	Wed, 17 Sep 2014 18:46:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5AD2B39E2B;
	Wed, 17 Sep 2014 18:46:44 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7F9E3EFE-3EBC-11E4-89C1-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257243>

The "--signed" option received by "git push" is first passed to the
transport layer, which the native transport directly uses to notice
that a push certificate needs to be sent.  When the transport-helper
is involved, however, the option needs to be told to the helper with
set_helper_option(), and the helper needs to take necessary action.
For the smart-HTTP helper, the "necessary action" involves spawning
the "git send-pack" subprocess with the "--signed" option.

Once the above all gets wired in, the smart-HTTP transport now can
use the push certificate mechanism to authenticate its pushes.

Add a test that is modeled after tests for the native transport in
t5534-push-signed.sh to t5541-http-push-smart.sh.  Update the test
Apache configuration to pass GNUPGHOME environment variable through.
As PassEnv would trigger warnings for an environment variable that
is not set, export it from test-lib.sh set to a harmless value when
GnuPG is not being used in the tests.

Note that the added test is deliberately loose and does not check
the nonce in this step.  This is because the stateless RPC mode is
inevitably flaky and a nonce that comes back in the actual push
processing is one issued by a different process; if the two
interactions with the server crossed a second boundary, the nonces
will not match and such a check will fail.  A later patch in the
series will work around this shortcoming.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This used to be after "nonce slop" patch in v5 (and remote-curl
   integration was missing).

 builtin/send-pack.c        |  4 ++++
 remote-curl.c              | 13 ++++++++++++-
 t/lib-httpd/apache.conf    |  1 +
 t/t5541-http-push-smart.sh | 36 ++++++++++++++++++++++++++++++++++++
 t/test-lib.sh              |  3 ++-
 transport-helper.c         |  9 ++++++++-
 6 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f420b74..ca28d8d 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -153,6 +153,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.verbose = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--signed")) {
+				args.push_cert = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--progress")) {
 				progress = 1;
 				continue;
diff --git a/remote-curl.c b/remote-curl.c
index 0fcf2ce..1ea4e95 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -25,7 +25,8 @@ struct options {
 		update_shallow : 1,
 		followtags : 1,
 		dry_run : 1,
-		thin : 1;
+		thin : 1,
+		push_cert : 1;
 };
 static struct options options;
 static struct string_list cas_options = STRING_LIST_INIT_DUP;
@@ -106,6 +107,14 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
+	} else if (!strcmp(name, "pushcert")) {
+		if (!strcmp(value, "true"))
+			options.push_cert = 1;
+		else if (!strcmp(value, "false"))
+			options.push_cert = 0;
+		else
+			return -1;
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -872,6 +881,8 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv_array_push(&args, "--thin");
 	if (options.dry_run)
 		argv_array_push(&args, "--dry-run");
+	if (options.push_cert)
+		argv_array_push(&args, "--signed");
 	if (options.verbosity == 0)
 		argv_array_push(&args, "--quiet");
 	else if (options.verbosity > 1)
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index b384d79..7713dd2 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -68,6 +68,7 @@ LockFile accept.lock
 
 PassEnv GIT_VALGRIND
 PassEnv GIT_VALGRIND_OPTIONS
+PassEnv GNUPGHOME
 
 Alias /dumb/ www/
 Alias /auth/dumb/ www/auth/dumb/
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 73af16f..24926a4 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -12,6 +12,7 @@ if test -n "$NO_CURL"; then
 fi
 
 ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
@@ -323,5 +324,40 @@ test_expect_success 'push into half-auth-complete requires password' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'push with post-receive to inspect certificate' '
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+		mkdir -p hooks &&
+		write_script hooks/post-receive <<-\EOF &&
+		# discard the update list
+		cat >/dev/null
+		# record the push certificate
+		if test -n "${GIT_PUSH_CERT-}"
+		then
+			git cat-file blob $GIT_PUSH_CERT >../push-cert
+		fi &&
+		cat >../push-cert-status <<E_O_F
+		SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
+		KEY=${GIT_PUSH_CERT_KEY-nokey}
+		STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
+		E_O_F
+		EOF
+
+		git config receive.certnonceseed sekrit
+	) &&
+	cd "$ROOT_PATH/test_repo_clone" &&
+	test_commit cert-test &&
+	git push --signed "$HTTPD_URL/smart/test_repo.git" &&
+	(
+		cd "$HTTPD_DOCUMENT_ROOT_PATH" &&
+		cat <<-\EOF
+		SIGNER=C O Mitter <committer@example.com>
+		KEY=13B6F51ECDDE430D
+		STATUS=G
+		EOF
+	) >expect &&
+	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH/push-cert-status"
+'
+
 stop_httpd
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b1bc65b..d5939b7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -813,7 +813,8 @@ rm -fr "$TRASH_DIRECTORY" || {
 }
 
 HOME="$TRASH_DIRECTORY"
-export HOME
+GNUPGHOME="$HOME/gnupg-home-not-used"
+export HOME GNUPGHOME
 
 if test -z "$TEST_NO_CREATE_REPO"
 then
diff --git a/transport-helper.c b/transport-helper.c
index 3d8fe7d..4b1a261 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -259,7 +259,8 @@ static const char *unsupported_options[] = {
 static const char *boolean_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP,
-	TRANS_OPT_FOLLOWTAGS
+	TRANS_OPT_FOLLOWTAGS,
+	TRANS_OPT_PUSH_CERT
 	};
 
 static int set_helper_option(struct transport *transport,
@@ -835,6 +836,9 @@ static int push_refs_with_push(struct transport *transport,
 	if (flags & TRANSPORT_PUSH_DRY_RUN) {
 		if (set_helper_option(transport, "dry-run", "true") != 0)
 			die("helper %s does not support dry-run", data->name);
+	} else if (flags & TRANSPORT_PUSH_CERT) {
+		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)
+			die("helper %s does not support --signed", data->name);
 	}
 
 	strbuf_addch(&buf, '\n');
@@ -859,6 +863,9 @@ static int push_refs_with_export(struct transport *transport,
 	if (flags & TRANSPORT_PUSH_DRY_RUN) {
 		if (set_helper_option(transport, "dry-run", "true") != 0)
 			die("helper %s does not support dry-run", data->name);
+	} else if (flags & TRANSPORT_PUSH_CERT) {
+		if (set_helper_option(transport, TRANS_OPT_PUSH_CERT, "true") != 0)
+			die("helper %s does not support dry-run", data->name);
 	}
 
 	if (flags & TRANSPORT_PUSH_FORCE) {
-- 
2.1.0-403-g099cf47
