Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454B1C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250362072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgCWSEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:04:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726991AbgCWSEq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:04:46 -0400
Received: (qmail 9400 invoked by uid 109); 23 Mar 2020 18:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Mar 2020 18:04:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12388 invoked by uid 111); 23 Mar 2020 18:14:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2020 14:14:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Mar 2020 14:04:45 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
Message-ID: <20200323180445.GA31401@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
 <20200323173258.GA3977@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323173258.GA3977@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 01:32:58PM -0400, Jeff King wrote:

> In this case if the whole thing were in a "test_lazy_prereq" we would
> have gotten all that for free. I don't think the laziness would matter
> too much in practice, though it is a little funny that it has side
> effects (like setting up $GPGHOME). Having an immediate version like
> "test_check_prereq" would make sense to me.
> 
> I don't know if it's worth re-doing this patch (I'll leave that decision
> to you). But something to keep in mind when we run into similar
> situations (or are writing new prereq code).

Actually, it's pretty straight-forward and I think the resulting code is
cleaner. Note that we do have to use a real expect_success because of
the side effects. That does increment the test counter. IMHO that's not
a big deal, but if we're concerned it wouldn't be too hard to add a
non-lazy prereq block.

Patch is below (I pulled GPGSM into its own block, which involved
reindenting; view with "-w").

---
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 11b83b8c24..6aa936e3ac 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -1,13 +1,16 @@
 #!/bin/sh
 
-gpg_version=$(gpg --version 2>&1)
-if test $? != 127
-then
+# This has to happen in a real test and not a lazy_prereq because it
+# has side effects (like setting up $GNUPGHOME).
+test_expect_success 'set up GPG prereq' '
+	test_might_fail gpg --version &&
+	test $? != 127 &&
+
 	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
-	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
+	# the gpg version 1.0.6 did not parse trust packets correctly, so for
 	# that version, creation of signed tags using the generated key fails.
 	case "$gpg_version" in
-	'gpg (GnuPG) 1.0.6'*)
+	"gpg (GnuPG) 1.0.6"*)
 		say "Your version of gpg (1.0.6) is too buggy for testing"
 		;;
 	*)
@@ -31,51 +34,51 @@ then
 		chmod 0700 ./gpghome &&
 		GNUPGHOME="$PWD/gpghome" &&
 		export GNUPGHOME &&
-		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
+		(gpgconf --kill gpg-agent || : ) &&
+		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
+		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
 			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
-		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null 2>&1 \
-			--sign -u committer@example.com &&
-		test_set_prereq GPG &&
-		# Available key info:
-		# * see t/lib-gpg/gpgsm-gen-key.in
-		# To generate new certificate:
-		#  * no passphrase
-		#	gpgsm --homedir /tmp/gpghome/ \
-		#		-o /tmp/gpgsm.crt.user \
-		#		--generate-key \
-		#		--batch t/lib-gpg/gpgsm-gen-key.in
-		# To import certificate:
-		#	gpgsm --homedir /tmp/gpghome/ \
-		#		--import /tmp/gpgsm.crt.user
-		# To export into a .p12 we can later import:
-		#	gpgsm --homedir /tmp/gpghome/ \
-		#		-o t/lib-gpg/gpgsm_cert.p12 \
-		#		--export-secret-key-p12 "committer@example.com"
-		echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
-			--passphrase-fd 0 --pinentry-mode loopback \
-			--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
-
-		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
-		grep fingerprint: |
-		cut -d" " -f4 |
-		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
-
-		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
-		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
-			-u committer@example.com -o /dev/null --sign - 2>&1 &&
-		test_set_prereq GPGSM
+		gpg --homedir "${GNUPGHOME}" \
+			--sign -u committer@example.com >/dev/null &&
+		test_set_prereq GPG
 		;;
 	esac
-fi
+'
+
+test_have_prereq GPG &&
+test_lazy_prereq GPGSM '
+	# Available key info:
+	# * see t/lib-gpg/gpgsm-gen-key.in
+	# To generate new certificate:
+	#  * no passphrase
+	#	gpgsm --homedir /tmp/gpghome/ \
+	#		-o /tmp/gpgsm.crt.user \
+	#		--generate-key \
+	#		--batch t/lib-gpg/gpgsm-gen-key.in
+	# To import certificate:
+	#	gpgsm --homedir /tmp/gpghome/ \
+	#		--import /tmp/gpgsm.crt.user
+	# To export into a .p12 we can later import:
+	#	gpgsm --homedir /tmp/gpghome/ \
+	#		-o t/lib-gpg/gpgsm_cert.p12 \
+	#		--export-secret-key-p12 "committer@example.com"
+	echo | gpgsm --homedir "${GNUPGHOME}" \
+		--passphrase-fd 0 --pinentry-mode loopback \
+		--import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
+	gpgsm --homedir "${GNUPGHOME}" -K |
+	grep fingerprint: |
+	cut -d" " -f4 |
+	tr -d "\\n" >"${GNUPGHOME}/trustlist.txt" &&
+	echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
+	echo hello | gpgsm --homedir "${GNUPGHOME}" \
+		-u committer@example.com -o /dev/null --sign -
+'
 
-if test_have_prereq GPG &&
-    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
-then
-	test_set_prereq RFC1991
-fi
+test_have_prereq GPG &&
+test_lazy_prereq RFC1991 '
+    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991
+'
 
 sanitize_pgp() {
 	perl -ne '
