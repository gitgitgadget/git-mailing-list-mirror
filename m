From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/19] receive-pack: GPG-validate push certificates
Date: Fri, 22 Aug 2014 13:30:21 -0700
Message-ID: <1408739424-31429-17-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:33:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvWr-0000Qq-DG
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbaHVUdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:33:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65376 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbaHVUdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:33:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74F6E3325E;
	Fri, 22 Aug 2014 16:33:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AZkH
	L/Nr8fvRClyGZf0zQMDFnHA=; b=irZqOooZve4IGBMGLG6vZk9Ez2PjY6u5vTVP
	kXpJKzUc1oY54dLtZpXx5C61l2e5UZWbUu8OTHPu7qaKXtuzP9YA8CNK/LVoUEf7
	BaVfln/nvhq26E/npR2oVuSyXcNVFHp8s8EGj6CtgxBxAEPL/lprQpYiuSBqj4xi
	soVXSxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jtaoS9
	Benqi6SmTVZSsa7Rm70oPfkqg7wjSx5GbXTfTMBpsAqK1gKEUPOT4dMjC3jFjzpf
	4PymwR68I8PU9r0nYTKHvTKNO/ePyTTrhVkGJDRnu1nmB/dYausQGUy7dScicbhI
	yCKy3A0//0yMPDHTL4L5R9B9qu7Blit9Lxrn4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C0463325C;
	Fri, 22 Aug 2014 16:33:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C2CF833247;
	Fri, 22 Aug 2014 16:33:13 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8A348426-2A3B-11E4-8149-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255716>

Reusing the GPG signature check helpers we already have, verify
the signature in receive-pack and give the results to the hooks
via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.

Policy decisions, such as accepting or rejecting a good signature by
a key that is not fully trusted, is left to the hook and kept
outside of the core.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-receive-pack.txt | 27 ++++++++++++++++++++++-----
 builtin/receive-pack.c             | 29 +++++++++++++++++++++++++++++
 t/t5534-push-signed.sh             | 18 ++++++++++++++++--
 3 files changed, 67 insertions(+), 7 deletions(-)

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
index f30df8a..abdc296 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -15,6 +15,8 @@
 #include "connected.h"
 #include "argv-array.h"
 #include "version.h"
+#include "tag.h"
+#include "gpg-interface.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -48,6 +50,7 @@ static int shallow_update;
 static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
 static unsigned char push_cert_sha1[20];
+static struct signature_check sigcheck;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -260,12 +263,38 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 	struct argv_array env = ARGV_ARRAY_INIT;
 
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
+		argv_array_pushf(&env, "GIT_PUSH_CERT_SIGNER=%s", sigcheck.signer);
+		argv_array_pushf(&env, "GIT_PUSH_CERT_KEY=%s", sigcheck.key);
+		argv_array_pushf(&env, "GIT_PUSH_CERT_STATUS=%c", sigcheck.result);
+
 		proc->env = env.argv;
 	}
 }
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 0eb5004..659bca0 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -52,12 +52,26 @@ test_expect_success GPG 'signed push sends push certificate' '
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
2.1.0-304-g950f846
