Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1581F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbeGQNXP (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:23:15 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:55383 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbeGQNXP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:23:15 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6HCoFN8029154
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:15 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCoEZb005172;
        Tue, 17 Jul 2018 14:50:15 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 7/7] gpg-interface t: extend the existing GPG tests with GPGSM
Date:   Tue, 17 Jul 2018 14:50:13 +0200
Message-Id: <74d979ec0779b60d04e5dc7d2351783451e30eb4.1531831244.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases to cover the new X509/gpgsm support. Most of them
resemble existing ones. They just switch the format to x509 and set the
signingkey when creating signatures. Validation of signatures does not
need any configuration of git, it does need gpgsm to be configured to
trust the key(-chain).
Several of the testcases build on top of existing gpg testcases.
The commit ships a self-signed key for committer@example.com and
configures gpgsm to trust it.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 t/lib-gpg.sh               |  28 +++++++++++++++++++++++-
 t/lib-gpg/gpgsm-gen-key.in |   8 +++++++
 t/lib-gpg/gpgsm_cert.p12   | Bin 0 -> 2652 bytes
 t/t4202-log.sh             |  39 ++++++++++++++++++++++++++++++++++
 t/t5534-push-signed.sh     |  52 +++++++++++++++++++++++++++++++++++++++++++++
 t/t7004-tag.sh             |  13 ++++++++++++
 t/t7030-verify-tag.sh      |  33 ++++++++++++++++++++++++++++
 7 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-gpg/gpgsm-gen-key.in
 create mode 100644 t/lib-gpg/gpgsm_cert.p12

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index a5d3b2cba..3fe02876c 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -38,7 +38,33 @@ then
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
 		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
 			--sign -u committer@example.com &&
-		test_set_prereq GPG
+		test_set_prereq GPG &&
+		# Available key info:
+		# * see t/lib-gpg/gpgsm-gen-key.in
+		# To generate new certificate:
+		#  * no passphrase
+		#	gpgsm --homedir /tmp/gpghome/ \
+		#		-o /tmp/gpgsm.crt.user \
+		#		--generate-key \
+		#		--batch t/lib-gpg/gpgsm-gen-key.in
+		# To import certificate:
+		#	gpgsm --homedir /tmp/gpghome/ \
+		#		--import /tmp/gpgsm.crt.user
+		# To export into a .p12 we can later import:
+		#	gpgsm --homedir /tmp/gpghome/ \
+		#		-o t/lib-gpg/gpgsm_cert.p12 \
+		#		--export-secret-key-p12 "committer@example.com"
+		echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
+			--passphrase-fd 0 --pinentry-mode loopback \
+			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
+		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K \
+			| grep fingerprint: | cut -d" " -f4 | tr -d '\n' > \
+			${GNUPGHOME}/trustlist.txt &&
+		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
+		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
+		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
+			-u committer@example.com -o /dev/null --sign - 2>&1 &&
+		test_set_prereq GPGSM
 		;;
 	esac
 fi
diff --git a/t/lib-gpg/gpgsm-gen-key.in b/t/lib-gpg/gpgsm-gen-key.in
new file mode 100644
index 000000000..a7fd87c06
--- /dev/null
+++ b/t/lib-gpg/gpgsm-gen-key.in
@@ -0,0 +1,8 @@
+Key-Type: RSA
+Key-Length: 2048
+Key-Usage: sign
+Serial: random
+Name-DN: CN=C O Mitter, O=Example, SN=C O, GN=Mitter
+Name-Email: committer@example.com
+Not-Before: 1970-01-01 00:00:00
+Not-After: 3000-01-01 00:00:00
diff --git a/t/lib-gpg/gpgsm_cert.p12 b/t/lib-gpg/gpgsm_cert.p12
new file mode 100644
index 0000000000000000000000000000000000000000..94ffad0d31a3b6c4e849b29d960762e485ba7ea8
GIT binary patch
literal 2652
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

literal 0
HcmV?d00001

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 25b1f8cc7..f57781e39 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1556,12 +1556,28 @@ test_expect_success GPG 'setup signed branch' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSM 'setup signed branch x509' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b signed-x509 master &&
+	echo foo >foo &&
+	git add foo &&
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	git commit -S -m signed_commit
+'
+
 test_expect_success GPG 'log --graph --show-signature' '
 	git log --graph --show-signature -n1 signed >actual &&
 	grep "^| gpg: Signature made" actual &&
 	grep "^| gpg: Good signature" actual
 '
 
+test_expect_success GPGSM 'log --graph --show-signature x509' '
+	git log --graph --show-signature -n1 signed-x509 >actual &&
+	grep "^| gpgsm: Signature made" actual &&
+	grep "^| gpgsm: Good signature" actual
+'
+
 test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	test_when_finished "git reset --hard && git checkout master" &&
 	git checkout -b plain master &&
@@ -1581,6 +1597,29 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 
+test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	git checkout -b plain-x509 master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit &&
+	git checkout -b tagged-x509 master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit &&
+	git tag -s -m signed_tag_msg signed_tag_x509 &&
+	git checkout plain-x509 &&
+	git merge --no-ff -m msg signed_tag_x509 &&
+	git log --graph --show-signature -n1 plain-x509 >actual &&
+	grep "^|\\\  merged tag" actual &&
+	grep "^| | gpgsm: Signature made" actual &&
+	grep "^| | gpgsm: Good signature" actual &&
+	git config --unset gpg.format &&
+	git config --unset user.signingkey
+'
+
 test_expect_success GPG '--no-show-signature overrides --show-signature' '
 	git log -1 --show-signature --no-show-signature signed >actual &&
 	! grep "^gpg:" actual
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 1cea758f7..a3a12bd05 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -218,4 +218,56 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
+	test_config gpg.format x509 &&
+	env | grep GIT > envfile &&
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
+	unset GIT_COMMITTER_EMAIL &&
+	git config user.email hasnokey@nowhere.com &&
+	git config user.signingkey "" &&
+	test_must_fail git push --signed dst noop ff +noff &&
+	git config user.signingkey committer@example.com &&
+	git push --signed dst noop ff +noff &&
+
+	(
+		cat <<-\EOF &&
+		SIGNER=/CN=C O Mitter/O=Example/SN=C O/GN=Mitter
+		KEY=
+		STATUS=G
+		NONCE_STATUS=OK
+		EOF
+		sed -n -e "s/^nonce /NONCE=/p" -e "/^$/q" dst/push-cert
+	) >expect.in &&
+	key=$(cat "${GNUPGHOME}/trustlist.txt" | cut -d" " -f1 | tr -d ":") &&
+	sed -e "s/^KEY=/KEY=${key}/" expect.in > expect &&
+
+	noop=$(git rev-parse noop) &&
+	ff=$(git rev-parse ff) &&
+	noff=$(git rev-parse noff) &&
+	grep "$noop $ff refs/heads/ff" dst/push-cert &&
+	grep "$noop $noff refs/heads/noff" dst/push-cert &&
+	test_cmp expect dst/push-cert-status
+'
+
+
 test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d7b319e91..2147938aa 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1354,6 +1354,19 @@ test_expect_success GPG \
 	'test_config gpg.program echo &&
 	 test_must_fail git tag -s -m tail tag-gpg-failure'
 
+# try to sign with bad user.signingkey
+test_expect_success GPGSM \
+	'git tag -s fails if gpgsm is misconfigured (bad key)' \
+	'test_config user.signingkey BobTheMouse &&
+	 test_config gpg.format x509 &&
+	 test_must_fail git tag -s -m tail tag-gpg-failure'
+
+# try to produce invalid signature
+test_expect_success GPGSM \
+	'git tag -s fails if gpgsm is misconfigured (bad signature format)' \
+	'test_config gpg.x509.program echo &&
+	 test_config gpg.format x509 &&
+	 test_must_fail git tag -s -m tail tag-gpg-failure'
 
 # try to verify without gpg:
 
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 291a1e2b0..db6295d65 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -41,6 +41,13 @@ test_expect_success GPG 'create signed tags' '
 	git tag -uB7227189 -m eighth eighth-signed-alt
 '
 
+test_expect_success GPGSM 'create signed tags x509 ' '
+	test_config gpg.format x509 &&
+	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
+	echo 9 >file && test_tick && git commit -a -m "nineth gpgsm-signed" &&
+	git tag -s -m nineth nineth-signed-x509
+'
+
 test_expect_success GPG 'verify and show signatures' '
 	(
 		for tag in initial second merge fourth-signed sixth-signed seventh-signed
@@ -72,6 +79,13 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
 
+test_expect_success GPGSM 'verify and show signatures x509' '
+	git verify-tag nineth-signed-x509 2>actual &&
+	grep "Good signature from" actual &&
+	! grep "BAD signature from" actual &&
+	echo nineth-signed-x509 OK
+'
+
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file tag seventh-signed >raw &&
 	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
@@ -112,6 +126,12 @@ test_expect_success GPG 'verify signatures with --raw' '
 	)
 '
 
+test_expect_success GPGSM 'verify signatures with --raw x509' '
+	git verify-tag --raw nineth-signed-x509 2>actual &&
+	grep "GOODSIG" actual &&
+	! grep "BADSIG" actual &&
+	echo nineth-signed-x509 OK
+'
 test_expect_success GPG 'verify multiple tags' '
 	tags="fourth-signed sixth-signed seventh-signed" &&
 	for i in $tags
@@ -125,6 +145,19 @@ test_expect_success GPG 'verify multiple tags' '
 	test_cmp expect.stderr actual.stderr
 '
 
+test_expect_success GPGSM 'verify multiple tags x509' '
+	tags="seventh-signed nineth-signed-x509" &&
+	for i in $tags
+	do
+		git verify-tag -v --raw $i || return 1
+	done >expect.stdout 2>expect.stderr.1 &&
+	grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
+	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
+	grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
+	test_cmp expect.stdout actual.stdout &&
+	test_cmp expect.stderr actual.stderr
+'
+
 test_expect_success GPG 'verifying tag with --format' '
 	cat >expect <<-\EOF &&
 	tagname : fourth-signed
-- 
2.16.4

