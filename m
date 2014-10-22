From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFD/PATCH] push: heed user.signingkey for signed pushes
Date: Wed, 22 Oct 2014 16:47:03 +0200
Message-ID: <787502533676138ad113e446eba71d92dee3b4de.1413989046.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 16:47:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgxBw-0007UU-6e
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 16:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaJVOrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 10:47:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57930 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751022AbaJVOrG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2014 10:47:06 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway2.nyi.internal (Postfix) with ESMTP id DCB0020A79
	for <git@vger.kernel.org>; Wed, 22 Oct 2014 10:47:04 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 22 Oct 2014 10:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id; s=smtpout; bh=qNHSRdxrJaIkXR9hQyYPD/ZgZpQ=; b=buuzS
	SxNmQN/0eaSsO0J/o7Ligwkpnbn5/IulMNhv5Q4cLD+4jiS0PFNziePpOFeXgmkz
	ko3hD58jHt61jEEXpJbihX9ViMNQIV//+q/8FlvY2TB+9NEb26u8eXX71YfmXqxj
	W7Jq992E4tJkWJ/V6z9bXv3EbMR2TBNq5JKflM=
X-Sasl-enc: U/ld0QgFsd5sPizQlIa1WCgeM/5+Db0vBYS7kyAYz9Kq 1413989224
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7B40268012D;
	Wed, 22 Oct 2014 10:47:04 -0400 (EDT)
X-Mailer: git-send-email 2.1.2.756.gfa53a0a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

push --signed promises to take user.signingkey as the signing key but
fails to read the config.

Make it do so.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Interestingly, when I wrote the test I had the impression that user.email
is not heeded either - or do we have GIT_COMMITTER_EMAIL in the environment
of the tests by default?

In any case, that is why the test looks the way it looks and why this is RFD.

 1 file changed, 12 insertions(+), 1 deletion(-)

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
-- 
2.1.2.756.gfa53a0a


 builtin/push.c         |  13 ++++++++++++-
 t/lib-gpg/trustdb.gpg  | Bin 1360 -> 1360 bytes
 t/t5534-push-signed.sh |  43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

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
index 2786346..c68867d 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -124,4 +124,47 @@ test_expect_success GPG 'signed push sends push certificate' '
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
+	git config user.email hasnokey@nowhere.com &&
+	test_must_fail env GIT_COMMITTER_EMAIL=hasnokey@nowhere.com git push --signed dst noop ff +noff &&
+	git config user.signingkey committer@example.com &&
+	GIT_COMMITTER_EMAIL=hasnokey@nowhere.com git push --signed dst noop ff +noff &&
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
