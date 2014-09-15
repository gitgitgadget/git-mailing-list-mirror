From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 17/23] receive-pack: GPG-validate push certificates
Date: Mon, 15 Sep 2014 15:24:18 -0700
Message-ID: <1410819864-22967-18-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:25:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehp-0006RL-1P
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbaIOWZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:25:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57324 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbaIOWZA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:25:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00E393B1C8;
	Mon, 15 Sep 2014 18:25:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lbpB
	WfChcKasgrAOP6PvMYm/gfM=; b=XInUIrPPkt7oytXEaHW83Rk1+/6DLiXzOB+H
	zT6yCYVbFoe+LPcOzRII0h3jyvHvfG5vYTjHAzozoDs/zc3E8V4VXsa6FjP9/yVh
	jD8UeqrOKqXQjjkfb0dIafhSuHsuU8NcPJE/+narlD9qPtUoZoUANF+oQazpttbD
	s0zXoQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=nO6nm2
	m5V0agNJFyvvaB2OYikuKpJDJYvaBb8K0rcRLNWlFZ7WKaYPyRbjHuWjj88yzNsY
	XuoirjEcPV+eSxNpeqyGgjGFJZPzSoKjBEc7bfN3QKf9DxH2nLXUz4VBjiSIUQbf
	4ttfrN7uXSSkmddm8eINVmHaI4GR9Y/UV9i8g=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB6133B1C7;
	Mon, 15 Sep 2014 18:24:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3813C3B1C6;
	Mon, 15 Sep 2014 18:24:59 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 20DDAA58-3D27-11E4-B94A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257098>

Reusing the GPG signature check helpers we already have, verify
the signature in receive-pack and give the results to the hooks
via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.

Policy decisions, such as accepting or rejecting a good signature by
a key that is not fully trusted, is left to the hook and kept
outside of the core.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-receive-pack.txt | 24 +++++++++++++++++++-----
 builtin/receive-pack.c             | 31 +++++++++++++++++++++++++++++++
 t/t5534-push-signed.sh             | 18 ++++++++++++++++--
 3 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index a2dd743..e6df234 100644
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
+`GIT_PUSH_CERT_SIGNER`::
+	The name and the e-mail address of the owner of the key that
+	signed the push certificate.
+
+`GIT_PUSH_CERT_KEY`::
+	The GPG key ID of the key that signed the push certificate.
+
+`GIT_PUSH_CERT_STATUS`::
+	The status of GPG verification of the push certificate,
+	using the same mnemonic as used in `%G?` format of `git log`
+	family of commands (see linkgit:git-log[1]).
 
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
@@ -106,13 +120,13 @@ the update.  Refs that were created will have sha1-old equal to
 0\{40}, otherwise sha1-old and sha1-new should be valid objects in
 the repository.
 
-The `GIT_PUSH_CERT` environment variable can be inspected, just as
+The `GIT_PUSH_CERT*` environment variables can be inspected, just as
 in `pre-receive` hook, after accepting a signed push.
 
 Using this hook, it is easy to generate mails describing the updates
 to the repository.  This example script sends one mail message per
 ref listing the commits pushed to the repository, and logs the push
-certificates of signed pushes to a logger
+certificates of signed pushes with good signatures to a logger
 service:
 
 	#!/bin/sh
@@ -130,11 +144,11 @@ service:
 		mail -s "Changes to ref $ref" commit-list@mydomain
 	done
 	# log signed push certificate, if any
-	if test -n "${GIT_PUSH_CERT-}"
+	if test -n "${GIT_PUSH_CERT-}" && test ${GIT_PUSH_CERT_STATUS} = G
 	then
 		(
 			git cat-file blob ${GIT_PUSH_CERT}
-		) | mail -s "push certificate" push-log@mydomain
+		) | mail -s "push certificate from $GIT_PUSH_CERT_SIGNER" push-log@mydomain
 	fi
 	exit 0
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 610b085..c0a3189 100644
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
index 019ac71..4198b6a 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -83,12 +83,26 @@ test_expect_success GPG 'signed push sends push certificate' '
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
2.1.0-410-gd72dacd
