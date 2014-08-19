From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/18] receive-pack: GPG-validate push certificates
Date: Tue, 19 Aug 2014 15:06:25 -0700
Message-ID: <1408485987-3590-17-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:09:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrak-0006jD-BM
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbaHSWJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:09:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57889 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbaHSWJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:09:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA86133190;
	Tue, 19 Aug 2014 18:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0rpN
	Km6r7v3y7tXCah00vGd88rg=; b=qbmZHcZWVev74hkNWzWK8CGeTe9/7Hbl+sk5
	rE10mGlJiVjYa6pwEmrKF0U2/2qaaAqbFFAFD9cXwrwXJkUb6f7/9JbzQHsHJfr/
	/88vzMtatYmGv2hgjLAkKr3NOm+TP9ADitIcY7S9Fm+Scd2kPtnFHoqtmh9AHfUm
	N05g310=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FIm7FQ
	H1WKHIUcD+ViUoqodKGgwshnKUGUzC5XCFLP5FgRUj5hW4c/R1dUgnR/1eWr1992
	QjoV2up4QsTP1OM4DDLgPB3lsTs+13t4FYIqg9fgXamMEf6cYXkQBVSgO18QHgc5
	Eq2YnHDGLSAUVtSQT/Ni9DqVPo+KzhcdnNFLA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D8553318F;
	Tue, 19 Aug 2014 18:09:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BAB1A33183;
	Tue, 19 Aug 2014 18:09:04 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6ECF0A6C-27ED-11E4-A1E1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255534>

Reusing the GPG signature check helpers we already have, verify
the signature in receive-pack and give the results to the hooks
via GIT_PUSH_CERT_{SIGNER,KEY,STATUS} environment variables.

Policy decisions, such as accepting or rejecting a good signature by
a key that is not fully trusted, is left to the hook and kept
outside of the core.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-receive-pack.txt | 22 ++++++++++++++++++----
 builtin/receive-pack.c             | 29 +++++++++++++++++++++++++++++
 t/t5534-push-signed.sh             | 18 ++++++++++++++++--
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 6c458af..a66884c 100644
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
@@ -106,13 +120,13 @@ the update.  Refs that were created will have sha1-old equal to
 0\{40}, otherwise sha1-old and sha1-new should be valid objects in
 the repository.
 
-The `GIT_PUSH_CERT` environment variable can be inspected, just as
+The `GIT_PUSH_CERT*` environment variables can be inspected, just as
 in `pre-receive` hook, after accepting a signed push.
 
 Using this hook, it is easy to generate mails describing the updates
 to the repository.  This example script sends one mail message per
 ref listing the commits pushed to the repository, and logs the push
-certificates of signed pushes to a file:
+certificates of signed pushes with good signatures to a file:
 
 	#!/bin/sh
 	# mail out commit update information.
@@ -129,7 +143,7 @@ certificates of signed pushes to a file:
 		mail -s "Changes to ref $ref" commit-list@mydomain
 	done
 	# log signed push certificate, if any
-	if test -n "${GIT_PUSH_CERT-}"
+	if test -n "${GIT_PUSH_CERT-}" && test ${GIT_PUSH_CERT_STATUS} = G
 	then
 		git cat-file blob ${GIT_PUSH_CERT} >>/var/log/push-log
 	fi
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
2.1.0-301-g54593e2
