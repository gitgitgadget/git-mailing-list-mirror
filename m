From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/21] receive-pack: GPG-validate push certificates
Date: Thu,  4 Sep 2014 13:04:53 -0700
Message-ID: <1409861097-19151-18-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:07:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ3-0001FP-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421AbaIDUGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:06:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62804 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419AbaIDUGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:06:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7E5E381FA;
	Thu,  4 Sep 2014 16:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xsNk
	wZZQpPldzX/Jjsm3XWICF2s=; b=NRNb18PzVjAK20HDYx/qfGa1W0JGrYpMcF4g
	Xn5YFRe3wYakvZRM15nLZluCBpOh+EmyHerApEodpAopsAj5TTbEMV4RfXzKgcQI
	LsdbxrMSTcpDrXMQxfVD3r6IZJN70j8dJSvAqL/jpxHFm3xzrF+BmLg0OM2ByCKv
	P4uMkiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dY/tgJ
	2WZvdu79vSC3q4MqoJm73+qCMbmV4lG3FSYK/XDzte9Z2MXaDGZOHgMq7OO6Tu5R
	dJ7aOTAffkwZgiGEtRdCJsWC2rL+6MHeK83nyFJY62/oCi25+olk/omJ+/BPGGnh
	AumRkVIh49V6sTTvb+BjC2G/whqtNGKj/u9LA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61C1E381F5;
	Thu,  4 Sep 2014 16:06:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C76D5381E4;
	Thu,  4 Sep 2014 16:05:55 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E14E36C0-346E-11E4-895D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256477>

Reusing the GPG signature check helpers we already have, verify
the signature in receive-pack and give the results to the hooks
via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.

Policy decisions, such as accepting or rejecting a good signature by
a key that is not fully trusted, is left to the hook and kept
outside of the core.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-receive-pack.txt | 27 ++++++++++++++++++++++-----
 builtin/receive-pack.c             | 31 +++++++++++++++++++++++++++++++
 t/t5534-push-signed.sh             | 18 ++++++++++++++++--
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 6c458af..60151a6 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -56,7 +56,21 @@ sha1-old and sha1-new should be valid objects in the repository.
 When accepting a signed push (see linkgit:git-push[1]), the signed
 push certificate is stored in a blob and an environment variable
 `GIT_PUSH_CERT` can be consulted for its object name.  See the
-description of `post-receive` hook for an example.
+description of `post-receive` hook for an example.  In addition, the
+certificate is verified using GPG and the result is exported with
+the following environment variables:
+
+GIT_PUSH_CERT_SIGNER::
+	The name and the e-mail address of the owner of the key that
+	signed the push certificate.
+
+GIT_PUSH_CERT_KEY::
+	The GPG key ID of the key that signed the push certificate.
+
+GIT_PUSH_CERT_STATUS::
+	The status of GPG verification of the push certificate,
+	using the same mnemonic as used in `%G?` format of `git log`
+	family of commands (see linkgit:git-log[1]).
 
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
@@ -106,13 +120,14 @@ the update.  Refs that were created will have sha1-old equal to
 0\{40}, otherwise sha1-old and sha1-new should be valid objects in
 the repository.
 
-The `GIT_PUSH_CERT` environment variable can be inspected, just as
+The `GIT_PUSH_CERT*` environment variables can be inspected, just as
 in `pre-receive` hook, after accepting a signed push.
 
 Using this hook, it is easy to generate mails describing the updates
 to the repository.  This example script sends one mail message per
 ref listing the commits pushed to the repository, and logs the push
-certificates of signed pushes to a file:
+certificates of signed pushes with good signatures to a logger
+service:
 
 	#!/bin/sh
 	# mail out commit update information.
@@ -129,9 +144,11 @@ certificates of signed pushes to a file:
 		mail -s "Changes to ref $ref" commit-list@mydomain
 	done
 	# log signed push certificate, if any
-	if test -n "${GIT_PUSH_CERT-}"
+	if test -n "${GIT_PUSH_CERT-}" && test ${GIT_PUSH_CERT_STATUS} = G
 	then
-		git cat-file blob ${GIT_PUSH_CERT} >>/var/log/push-log
+		(
+			git cat-file blob ${GIT_PUSH_CERT}
+		) | mail -s "push from $GIT_PUSH_CERT_SIGNER" push-log@mydomain
 	fi
 	exit 0
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4335309..bfd078c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -15,6 +15,8 @@
 #include "connected.h"
 #include "argv-array.h"
 #include "version.h"
+#include "tag.h"
+#include "gpg-interface.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -49,6 +51,7 @@ static const char *alt_shallow_file;
 static int accept_push_cert = 1;
 static struct strbuf push_cert = STRBUF_INIT;
 static unsigned char push_cert_sha1[20];
+static struct signature_check sigcheck;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -277,12 +280,40 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		return;
 
 	if (!already_done) {
+		struct strbuf gpg_output = STRBUF_INIT;
+		struct strbuf gpg_status = STRBUF_INIT;
+		int bogs /* beginning_of_gpg_sig */;
+
 		already_done = 1;
 		if (write_sha1_file(push_cert.buf, push_cert.len, "blob", push_cert_sha1))
 			hashclr(push_cert_sha1);
+
+		memset(&sigcheck, '\0', sizeof(sigcheck));
+		sigcheck.result = 'N';
+
+		bogs = parse_signature(push_cert.buf, push_cert.len);
+		if (verify_signed_buffer(push_cert.buf, bogs,
+					 push_cert.buf + bogs, push_cert.len - bogs,
+					 &gpg_output, &gpg_status) < 0) {
+			; /* error running gpg */
+		} else {
+			sigcheck.payload = push_cert.buf;
+			sigcheck.gpg_output = gpg_output.buf;
+			sigcheck.gpg_status = gpg_status.buf;
+			parse_gpg_output(&sigcheck);
+		}
+
+		strbuf_release(&gpg_output);
+		strbuf_release(&gpg_status);
 	}
 	if (!is_null_sha1(push_cert_sha1)) {
 		argv_array_pushf(&env, "GIT_PUSH_CERT=%s", sha1_to_hex(push_cert_sha1));
+		argv_array_pushf(&env, "GIT_PUSH_CERT_SIGNER=%s",
+				 sigcheck.signer ? sigcheck.signer : "");
+		argv_array_pushf(&env, "GIT_PUSH_CERT_KEY=%s",
+				 sigcheck.key ? sigcheck.key : "");
+		argv_array_pushf(&env, "GIT_PUSH_CERT_STATUS=%c", sigcheck.result);
+
 		proc->env = env.argv;
 	}
 }
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 97323bb..35fe704 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -66,12 +66,26 @@ test_expect_success GPG 'signed push sends push certificate' '
 	if test -n "${GIT_PUSH_CERT-}"
 	then
 		git cat-file blob $GIT_PUSH_CERT >../push-cert
-	fi
+	fi &&
+
+	cat >../push-cert-status <<E_O_F
+	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
+	KEY=${GIT_PUSH_CERT_KEY-nokey}
+	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
+	E_O_F
+
+	EOF
+
+	cat >expect <<-\EOF &&
+	SIGNER=C O Mitter <committer@example.com>
+	KEY=13B6F51ECDDE430D
+	STATUS=G
 	EOF
 
 	git push --signed dst noop ff +noff &&
 	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
-	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert
+	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
+	test_cmp expect dst/push-cert-status
 '
 
 test_done
-- 
2.1.0-399-g1364b4d
