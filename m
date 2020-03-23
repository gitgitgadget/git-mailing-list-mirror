Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33609C10DCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0797B2073C
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgCWUPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:15:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:48436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725830AbgCWUPv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:15:51 -0400
Received: (qmail 12586 invoked by uid 109); 23 Mar 2020 20:15:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Mar 2020 20:15:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16781 invoked by uid 111); 23 Mar 2020 20:25:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2020 16:25:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Mar 2020 16:15:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tests(gpg): increase verbosity to allow debugging
Message-ID: <20200323201547.GA35429@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <dd26cb05a37a54d9d245823772d33fe0daab8ffa.1584968990.git.gitgitgadget@gmail.com>
 <20200323173258.GA3977@coredump.intra.peff.net>
 <20200323180445.GA31401@coredump.intra.peff.net>
 <xmqq8sjq6fob.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sjq6fob.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 12:21:08PM -0700, Junio C Hamano wrote:

> > +		gpg --homedir "${GNUPGHOME}" \
> > +			--sign -u committer@example.com >/dev/null &&
> 
> We lost input redirection; I am assuming that it was unnecessary as
> the standard input of our tests are all redirected from /dev/null
> anyway?

Yes (though it also wouldn't hurt to leave it to explicitly document
that we're ignoring it for this command).

> We are not interested in seeing the signed output (we have nothing
> to compare to validate the correctness anyway), so discarding the
> standard output is fine.  We do not want to see it even while we are
> debugging, either.

Yes, exactly. I originally dropped it, but after looking at the "-v"
output I saw it was full of signed binary goo. :)

> Looking good.

There were actually a few subtle breakages in what I posted before. One
was just a dumb conversion: I forgot to set $gpg_version correctly. But
the other is much trickier: we have to hide our exit codes from
test_expect_success, since in the non-GPG case we want it to still
report success. So any breakage in the big &&-chain would say "test
failure", when it should just quietly continue without setting the GPG
prereq.

Here's what I came up with that I think is suitable for applying (though
if you find the GNUPGHOME thing below too gross, I can rework it as
indicated):

-- >8 --
Subject: [PATCH] t/lib-gpg: run setup code in test blocks

The steps to check the GPG prereq and set up GNUPGHOME are run in the
main script, with stdout and stderr redirected. This avoids spewing
useless output when GPG isn't available. But it also means that there's
no easy way to see what did happen if you're using "-v" or "-x".

Let's push this as much as possible into a lazy_prereq blocks, which
handle verbosity and tracing for us. There's one tricky thing here: part
of the setup involves setting $GNUPGHOME, but lazy_prereq blocks are
evaluated in a subshell in order to avoid accidental environment
contamination. Splitting the setup from the prereq is tricky; the prereq
is basically "did we successfully set things up".

We could run all of the GPG prereq code in its own test_expect_success
block. But that gets awkward because we _don't_ want to report failure
if a command fails (we just want to not set the prereq).

I've solved it here by pulling the GNUPGHOME setup into its own separate
setup step, that happens _before_ we check the prereq. That means we'd
set up the variable even if we don't have gpg, but that should be OK;
we'll be skipping any gpg tests in that case anyway. (If it's not, the
alternative is to put the big &&-chain into a separate function of "{}"
block).

Now that the code is inside test blocks, we can take advantage of this
to use &&-chaining and early returns, and avoid indenting everything
inside a big case statement.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of Dscho's patch 1, since it uses $PWD/gpghome.

 t/lib-gpg.sh | 145 +++++++++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 69 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 11b83b8c24..56153b3123 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -1,81 +1,88 @@
 #!/bin/sh
 
-gpg_version=$(gpg --version 2>&1)
-if test $? != 127
-then
+# This can't run as part of the lazy_prereq below because it has the side
+# effect of setting an environment variable.
+test_expect_success 'set up GNUPGHOME' '
+	mkdir ./gpghome &&
+	chmod 0700 ./gpghome &&
+	GNUPGHOME="$PWD/gpghome" &&
+	export GNUPGHOME
+'
+
+test_lazy_prereq GPG '
+	{
+		gpg_version=$(gpg --version)
+		test $? != 127
+	} &&
+
 	# As said here: http://www.gnupg.org/documentation/faqs.html#q6.19
-	# the gpg version 1.0.6 didn't parse trust packets correctly, so for
+	# the gpg version 1.0.6 did not parse trust packets correctly, so for
 	# that version, creation of signed tags using the generated key fails.
 	case "$gpg_version" in
-	'gpg (GnuPG) 1.0.6'*)
-		say "Your version of gpg (1.0.6) is too buggy for testing"
+		"gpg (GnuPG) 1.0.6"*)
+		echo >&2 "Your version of gpg (1.0.6) is too buggy for testing"
+		return 1
 		;;
-	*)
-		# Available key info:
-		# * Type DSA and Elgamal, size 2048 bits, no expiration date,
-		#   name and email: C O Mitter <committer@example.com>
-		# * Type RSA, size 2048 bits, no expiration date,
-		#   name and email: Eris Discordia <discord@example.net>
-		# No password given, to enable non-interactive operation.
-		# To generate new key:
-		#	gpg --homedir /tmp/gpghome --gen-key
-		# To write armored exported key to keyring:
-		#	gpg --homedir /tmp/gpghome --export-secret-keys \
-		#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
-		#	gpg --homedir /tmp/gpghome --export \
-		#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
-		# To export ownertrust:
-		#	gpg --homedir /tmp/gpghome --export-ownertrust \
-		#		> lib-gpg/ownertrust
-		mkdir ./gpghome &&
-		chmod 0700 ./gpghome &&
-		GNUPGHOME="$PWD/gpghome" &&
-		export GNUPGHOME &&
-		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
-			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
-		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
-			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
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
+	esac &&
 
-		gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
-		grep fingerprint: |
-		cut -d" " -f4 |
-		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
+	# Available key info:
+	# * Type DSA and Elgamal, size 2048 bits, no expiration date,
+	#   name and email: C O Mitter <committer@example.com>
+	# * Type RSA, size 2048 bits, no expiration date,
+	#   name and email: Eris Discordia <discord@example.net>
+	# No password given, to enable non-interactive operation.
+	# To generate new key:
+	#	gpg --homedir /tmp/gpghome --gen-key
+	# To write armored exported key to keyring:
+	#	gpg --homedir /tmp/gpghome --export-secret-keys \
+	#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
+	#	gpg --homedir /tmp/gpghome --export \
+	#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
+	# To export ownertrust:
+	#	gpg --homedir /tmp/gpghome --export-ownertrust \
+	#		> lib-gpg/ownertrust
+	(gpgconf --kill gpg-agent || : ) &&
+	gpg --homedir "${GNUPGHOME}" --import \
+		"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
+	gpg --homedir "${GNUPGHOME}" --import-ownertrust \
+		"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
+	gpg --homedir "${GNUPGHOME}" \
+		--sign -u committer@example.com >/dev/null
+'
 
-		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
-		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
-			-u committer@example.com -o /dev/null --sign - 2>&1 &&
-		test_set_prereq GPGSM
-		;;
-	esac
-fi
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
-- 
2.26.0.561.g096102dc45

