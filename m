From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] push: heed user.signingkey for signed pushes
Date: Wed, 22 Oct 2014 16:57:49 +0200
Message-ID: <7b3546cd125d1ad92dd62297ecbe624a78c6079b.1413989799.git.git@drmicha.warpmail.net>
References: <787502533676138ad113e446eba71d92dee3b4de.1413989046.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 16:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgxMM-00050P-Kq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 16:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbaJVO5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 10:57:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52120 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751889AbaJVO5v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2014 10:57:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway2.nyi.internal (Postfix) with ESMTP id EDED3209E1
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 10:57:50 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 22 Oct 2014 10:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=w2X71G7+d2RU7/
	lQd0vLaCMS5UI=; b=ZwCGDzCmMFOboREdDyqEiwOZwlLOwCjBj3Id8f1IPTMuEX
	WrB2elRqgK0Xida6u58pgpgfNJ+Bjw7EAnhBrZ8e2CgOPiRBZkVp31Tm4oTLuPJP
	Lc1d0US9cTG9H+5Bp7hW3kNp4hRaq3DBJWNqVw17ckeLTrLX2xvTG4iBww9h0=
X-Sasl-enc: gC0jqNApGmv9HznNe0m1wNsmH0+sW6X4/o6kK6c7n5j5 1413989870
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6F1FB68012D;
	Wed, 22 Oct 2014 10:57:50 -0400 (EDT)
X-Mailer: git-send-email 2.1.2.756.gfa53a0a
In-Reply-To: <787502533676138ad113e446eba71d92dee3b4de.1413989046.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

push --signed promises to take user.signingkey as the signing key but
fails to read the config.

Make it do so.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Okay, I guess this is nicer. We do have the committer info in the env. Sorry.

 builtin/push.c         |  13 ++++++++++++-
 t/lib-gpg/trustdb.gpg  | Bin 1360 -> 1360 bytes
 t/t5534-push-signed.sh |  44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index ae56f73..a076b19 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -471,6 +471,17 @@ static int option_parse_recurse_submodules(const struct option *opt,
 	return 0;
 }
 
+static int git_push_config(const char *k, const char *v, void *cb)
+{
+	struct wt_status *s = cb;
+	int status;
+
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
+	return git_default_config(k, v, s);
+}
+
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
@@ -511,7 +522,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	};
 
 	packet_trace_identity("push");
-	git_config(git_default_config, NULL);
+	git_config(git_push_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
diff --git a/t/lib-gpg/trustdb.gpg b/t/lib-gpg/trustdb.gpg
index 4879ae9a84650a93a4d15bd6560c5d1b89eb4c2f..c11b1464b3d13b45966a493e2174fc0e253ddd0c 100644
GIT binary patch
delta 47
ncmcb>b%9HOF})z2nVFH5k%@sJ#C^}~iH71E)x}wb7%%_;=xPS!

delta 51
tcmcb>b%9HSF})z2nVFH5k%@sJ&}Z5*1_lPkiGso#)x}wb*nk{V008$D2C@JE

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 2786346..ecb8d44 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -124,4 +124,48 @@ test_expect_success GPG 'signed push sends push certificate' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPG 'fail without key and heed user.signingkey' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	git -C dst config receive.certnonceseed sekrit &&
+	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	# discard the update list
+	cat >/dev/null
+	# record the push certificate
+	if test -n "${GIT_PUSH_CERT-}"
+	then
+		git cat-file blob $GIT_PUSH_CERT >../push-cert
+	fi &&
+
+	cat >../push-cert-status <<E_O_F
+	SIGNER=${GIT_PUSH_CERT_SIGNER-nobody}
+	KEY=${GIT_PUSH_CERT_KEY-nokey}
+	STATUS=${GIT_PUSH_CERT_STATUS-nostatus}
+	NONCE_STATUS=${GIT_PUSH_CERT_NONCE_STATUS-nononcestatus}
+	NONCE=${GIT_PUSH_CERT_NONCE-nononce}
+	E_O_F
+
+	EOF
+
+	unset GIT_COMMITTER_EMAIL &&
+	git config user.email hasnokey@nowhere.com &&
+	test_must_fail git push --signed dst noop ff +noff &&
+	git config user.signingkey committer@example.com &&
+	git push --signed dst noop ff +noff &&
+
+	(
+		cat <<-\EOF &&
+		SIGNER=C O Mitter <committer@example.com>
+		KEY=13B6F51ECDDE430D
+		STATUS=G
+		NONCE_STATUS=OK
+		EOF
+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
+	) >expect &&
+
+	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
+	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert &&
+	test_cmp expect dst/push-cert-status
+'
+
 test_done
-- 
2.1.2.756.gfa53a0a
