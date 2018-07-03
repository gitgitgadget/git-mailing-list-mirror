Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4CD1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 12:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeGCM66 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 08:58:58 -0400
Received: from goliath.siemens.de ([192.35.17.28]:44948 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeGCM65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 08:58:57 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w63CcO79017415
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 14:38:24 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id w63CcMEB008580;
        Tue, 3 Jul 2018 14:38:24 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 8/8] gpg-interface t: extend the existing GPG tests with GPGSM
Date:   Tue,  3 Jul 2018 14:38:20 +0200
Message-Id: <9ad3e4b6adb38440d5766e34e3a41b7f64281dca.1530616446.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases to cover the new X509/gpgsm support. Most of them
resemble existing ones. They just switch the format to X509 and set the
signingkey when creating signatures. Validation of signatures does not
need any configuration of git, it does need gpgsm to be configured to
trust the key(-chain).
We generate a self-signed key for committer@example.com and configure
gpgsm to trust it.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 t/lib-gpg.sh               |  9 ++++++-
 t/lib-gpg/gpgsm-gen-key.in |  6 +++++
 t/t4202-log.sh             | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5534-push-signed.sh     | 52 ++++++++++++++++++++++++++++++++++++
 t/t7003-filter-branch.sh   | 15 +++++++++++
 t/t7030-verify-tag.sh      | 47 +++++++++++++++++++++++++++++++--
 t/t7600-merge.sh           | 31 ++++++++++++++++++++++
 7 files changed, 223 insertions(+), 3 deletions(-)
 create mode 100644 t/lib-gpg/gpgsm-gen-key.in

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index a5d3b2cba..9dcb4e990 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -38,7 +38,14 @@ then
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
 		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
 			--sign -u committer@example.com &&
-		test_set_prereq GPG
+		test_set_prereq GPG &&
+		echo | gpgsm --homedir "${GNUPGHOME}" -o "$TEST_DIRECTORY"/lib-gpg/gpgsm.crt.user --passphrase-fd 0 --pinentry-mode loopback --generate-key --batch "$TEST_DIRECTORY"/lib-gpg/gpgsm-gen-key.in &&
+		gpgsm --homedir "${GNUPGHOME}" --import "$TEST_DIRECTORY"/lib-gpg/gpgsm.crt.user &&
+		gpgsm --homedir "${GNUPGHOME}" -K | grep fingerprint: | cut -d" " -f4 | tr -d '\n' > ${GNUPGHOME}/trustlist.txt &&
+		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
+		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
+		echo hello | gpgsm --homedir "${GNUPGHOME}" -u committer@example.com -o /dev/null --sign - 2>&1 &&
+		test_set_prereq GPGSM
 		;;
 	esac
 fi
diff --git a/t/lib-gpg/gpgsm-gen-key.in b/t/lib-gpg/gpgsm-gen-key.in
new file mode 100644
index 000000000..3470b9dc7
--- /dev/null
+++ b/t/lib-gpg/gpgsm-gen-key.in
@@ -0,0 +1,6 @@
+Key-Type: RSA
+Key-Length: 2048
+Key-Usage: sign
+Serial: random
+Name-DN: CN=C O Mitter, O=Example, SN=C O, GN=Mitter
+Name-Email: committer@example.com
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 25b1f8cc7..a2f234053 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1556,12 +1556,30 @@ test_expect_success GPG 'setup signed branch' '
 	git commit -S -m signed_commit
 '
 
+test_expect_success GPGSM 'setup signed branch x509' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b signed-x509 master &&
+	echo foo >foo &&
+	git add foo &&
+	git config gpg.format X509 &&
+	git config user.signingkey $GIT_COMMITTER_EMAIL &&
+	git commit -S -m signed_commit &&
+	git config --unset gpg.format &&
+	git config --unset user.signingkey
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
@@ -1581,11 +1599,39 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 
+test_expect_success GPGSM 'log --graph --show-signature for merged tag x509' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git config gpg.format X509 &&
+	git config user.signingkey $GIT_COMMITTER_EMAIL &&
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
 '
 
+test_expect_success GPGSM '--no-show-signature overrides --show-signature x509' '
+	git log -1 --show-signature --no-show-signature signed-x509 >actual &&
+	! grep "^gpgsm:" actual
+'
+
 test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
 	test_config log.showsignature true &&
 	git log -1 signed >actual &&
@@ -1593,12 +1639,25 @@ test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
 	grep "gpg: Good signature" actual
 '
 
+test_expect_success GPGSM 'log.showsignature=true behaves like --show-signature x509' '
+	test_config log.showsignature true &&
+	git log -1 signed-x509 >actual &&
+	grep "gpgsm: Signature made" actual &&
+	grep "gpgsm: Good signature" actual
+'
+
 test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
 	test_config log.showsignature true &&
 	git log -1 --no-show-signature signed >actual &&
 	! grep "^gpg:" actual
 '
 
+test_expect_success GPGSM '--no-show-signature overrides log.showsignature=true x509' '
+	test_config log.showsignature true &&
+	git log -1 --no-show-signature signed-x509 >actual &&
+	! grep "^gpgsm:" actual
+'
+
 test_expect_success GPG '--show-signature overrides log.showsignature=false' '
 	test_config log.showsignature false &&
 	git log -1 --show-signature signed >actual &&
@@ -1606,6 +1665,13 @@ test_expect_success GPG '--show-signature overrides log.showsignature=false' '
 	grep "gpg: Good signature" actual
 '
 
+test_expect_success GPGSM '--show-signature overrides log.showsignature=false x509' '
+	test_config log.showsignature false &&
+	git log -1 --show-signature signed-x509 >actual &&
+	grep "gpgsm: Signature made" actual &&
+	grep "gpgsm: Good signature" actual
+'
+
 test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 1cea758f7..9d5029fcf 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -218,4 +218,56 @@ test_expect_success GPG 'fail without key and heed user.signingkey' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
+	git config gpg.format X509 &&
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
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index ec4b160dd..69b9e05d6 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -309,6 +309,21 @@ test_expect_success GPG 'Filtering retains message of gpg signed commit' '
 	test_cmp expect actual
 '
 
+test_expect_success GPGSM 'Filtering retains message of gpgsm signed commit' '
+	mkdir gpgsm &&
+	touch gpgsm/foo &&
+	git add gpgsm &&
+	git config gpg.format X509 &&
+	git config user.signingkey $GIT_COMMITTER_EMAIL &&
+	test_tick &&
+	git commit -S -m "Adding gpgsm" &&
+
+	git log -1 --format="%s" > expect &&
+	git filter-branch -f --msg-filter "cat" &&
+	git log -1 --format="%s" > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Tag name filtering allows slashes in tag names' '
 	git tag -m tag-with-slash X/1 &&
 	git cat-file tag X/1 | sed -e s,X/1,X/2, > expect &&
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 291a1e2b0..a76bcf333 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -41,6 +41,13 @@ test_expect_success GPG 'create signed tags' '
 	git tag -uB7227189 -m eighth eighth-signed-alt
 '
 
+test_expect_success GPGSM 'create signed tags x509 ' '
+	git config gpg.format X509 &&
+	git config user.signingkey $GIT_COMMITTER_EMAIL &&
+	echo 9 >file && test_tick && git commit -a -m "nineth gpgsm-signed" &&
+	git tag -s -m nineth nineth-signed-x509
+'
+
 test_expect_success GPG 'verify and show signatures' '
 	(
 		for tag in initial second merge fourth-signed sixth-signed seventh-signed
@@ -72,6 +79,18 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
 
+test_expect_success GPGSM 'verify and show signatures x509' '
+	(
+		for tag in nineth-signed-x509
+		do
+			git verify-tag $tag 2>actual &&
+			grep "Good signature from" actual &&
+			! grep "BAD signature from" actual &&
+			echo $tag OK || exit 1
+		done
+	)
+'
+
 test_expect_success GPG 'detect fudged signature' '
 	git cat-file tag seventh-signed >raw &&
 	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
@@ -112,8 +131,32 @@ test_expect_success GPG 'verify signatures with --raw' '
 	)
 '
 
-test_expect_success GPG 'verify multiple tags' '
-	tags="fourth-signed sixth-signed seventh-signed" &&
+test_expect_success GPGSM 'verify signatures with --raw x509' '
+	(
+		for tag in nineth-signed-x509
+		do
+			git verify-tag --raw $tag 2>actual &&
+			grep "GOODSIG" actual &&
+			! grep "BADSIG" actual &&
+			echo $tag OK || exit 1
+		done
+	)
+'
+test_expect_success GPGSM 'verify multiple tags' '
+	tags="fourth-signed sixth-signed seventh-signed nineth-signed-x509" &&
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
+test_expect_success GPGSM 'verify multiple tags x509' '
+	tags="fourth-signed sixth-signed seventh-signed nineth-signed-x509" &&
 	for i in $tags
 	do
 		git verify-tag -v --raw $i || return 1
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 6736d8d13..ef742aa16 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -747,6 +747,21 @@ test_expect_success GPG 'merge --ff-only tag' '
 	git rev-parse HEAD >actual &&
 	test_cmp expect actual
 '
+test_expect_success GPGSM 'merge --ff-only tag x509' '
+	git reset --hard c0 &&
+	git commit --allow-empty -m "A newer commit" &&
+	git config gpg.format X509 &&
+	git config user.signingkey $GIT_COMMITTER_EMAIL &&
+	git tag -s -m "A newer commit" signed-x509 &&
+	git reset --hard c0 &&
+
+	git merge --ff-only signed &&
+	git rev-parse signed^0 >expect &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual &&
+	git config --unset gpg.format &&
+	git config --unset user.signingkey
+'
 
 test_expect_success GPG 'merge --no-edit tag should skip editor' '
 	git reset --hard c0 &&
@@ -760,6 +775,22 @@ test_expect_success GPG 'merge --no-edit tag should skip editor' '
 	test_cmp expect actual
 '
 
+test_expect_success GPGSM 'merge --no-edit tag should skip editor x509' '
+	git reset --hard c0 &&
+	git commit --allow-empty -m "A newer commit" &&
+	git config gpg.format X509 &&
+	git config user.signingkey $GIT_COMMITTER_EMAIL &&
+	git tag -f -s -m "A newer commit" signed &&
+	git reset --hard c0 &&
+
+	EDITOR=false git merge --no-edit --no-ff signed-x509 &&
+	git rev-parse signed^0 >expect &&
+	git rev-parse HEAD^2 >actual &&
+	test_cmp expect actual &&
+	git config --unset gpg.format &&
+	git config --unset user.signingkey
+'
+
 test_expect_success 'set up mod-256 conflict scenario' '
 	# 256 near-identical stanzas...
 	for i in $(test_seq 1 256); do
-- 
2.16.4

