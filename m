From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/23] Signed push
Date: Tue, 16 Sep 2014 11:40:21 -0700
Message-ID: <xmqq7g132yui.fsf@gitster.dls.corp.google.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 20:40:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxfy-0000Ds-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbaIPSkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:40:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58086 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbaIPSkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:40:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF48338DB5;
	Tue, 16 Sep 2014 14:40:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zG1VJMC5jlefTGqTdhrZ+4VmM24=; b=GX+ORU8Ru/ylVHqAJwjm
	ReauzvjV4oP/jwwlFLswvQQu2xmYm7j1BE+8MYC7yccPvbWLQD5tqGFkNdbNRVGS
	592w1ngfMCW64CebW/dhLpdhNn6HIpWzUrbaHYxzoNIstPGi4wBEox8HzTMgVJfS
	DihnZ36YTWAI3m72PU1dSIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=JUAoGuVOomqgYrcrCh09dX4mTp80PoHZ/JsHx4SiRYlAqs7aF3pLJFp0
	LoixD2/ahFnrC1QBV/aWGUNDhRXVQ1ENy9asaRczRa003G/8NBYMMynjhpalg/h5
	NZ5Sz0SqGuOd8s7morAINJbknQLFBLGISGUBMqPFYM9lHrQ6/1s=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77A6A38DB2;
	Tue, 16 Sep 2014 14:40:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BED8638DB1;
	Tue, 16 Sep 2014 14:40:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EAB0E904-3DD0-11E4-8601-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257140>

Junio C Hamano <gitster@pobox.com> writes:

> A failing test has been added at the end for smart HTTP.  It appears
> that somewhere in the callchain "--signed" is forgotten and the
> sending end not to send the certificate for some reason.  If
> somebody with a fresh set of eyes can look into it, that would be
> very much appreciated, as I do not expect I would have sufficient
> concentration to dig it quickly for several days at least.

I lied.  This is to replace the patch at the end (23/23).

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 15 Sep 2014 14:59:00 -0700
Subject: [PATCH] push: teach smart-HTTP to pass "git push --signed" around

The "--signed" option received by "git push" is first passed to the
transport layer, which the native transport directly uses to notice
that a push certificate needs to be sent.  When the transport-helper
is involved, however, the option needs to be told to the helper with
set_helper_option(), and the helepr needs to take necessary action.
For the smart-HTTP helper, the "necessary action" involves spawning
the "git send-pack" subprocess with the "--signed" option.

Once the above all gets wired in, the smart-HTTP transport now can
use the push certificate mechanism to authenticate its pushes.

Add a test that is modeled after tests for the native transport in
t5534-push-signed.sh to t5541-http-push-smart.sh.  Update the test
Apache configuration to pass GNUPGHOME environment variable through.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Unconditional addition of "PassEnv GNUPGHOME" may give warnings
   from Apache in other tests that do not do GPG, but I left it
   as-is because I didn't think of a good way to squelch it.
   Perhaps define it as an empty in test-lib.sh, to be overriden by
   lib-gpg.sh?

 builtin/send-pack.c        |  4 ++++
 remote-curl.c              | 13 ++++++++++++-
 t/lib-httpd/apache.conf    |  1 +
 t/t5541-http-push-smart.sh | 38 ++++++++++++++++++++++++++++++++++++++
 transport-helper.c         |  9 ++++++++-
 5 files changed, 63 insertions(+), 2 deletions(-)

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
index 73af16f..6552366 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -12,6 +12,7 @@ if test -n "$NO_CURL"; then
 fi
 
 ROOT_PATH="$PWD"
+. "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 start_httpd
@@ -323,5 +324,42 @@ test_expect_success 'push into half-auth-complete requires password' '
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
+		NONCE=${GIT_PUSH_CERT_NONCE-nononce}
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
+		cat <<-\EOF &&
+		SIGNER=C O Mitter <committer@example.com>
+		KEY=13B6F51ECDDE430D
+		STATUS=G
+		EOF
+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" push-cert
+	) >expect &&
+	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH/push-cert-status"
+'
+
 stop_httpd
 test_done
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
2.1.0-420-g23b5121
