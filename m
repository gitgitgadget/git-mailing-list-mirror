From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] create gpg homedir on the fly
Date: Fri, 12 Dec 2014 12:33:51 -0800
Message-ID: <xmqqiohgbob4.fsf@gitster.dls.corp.google.com>
References: <20141212094753.160a0fb5@leda.localdomain>
	<1418374214-8241-1-git-send-email-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Hesse <mail@eworm.de>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:34:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzWua-0003sM-NE
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 21:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbaLLUdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 15:33:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932686AbaLLUdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 15:33:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BCB423367;
	Fri, 12 Dec 2014 15:33:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R0aGDn1O+Yx9tkNpAFbjulhB/24=; b=kn2zTj
	cDd7/km3DqOogoMOq6teV0sDvyt4ATscq49u5flU4wR4huG24+ky7PyTm9bJ1Sik
	PhWvnWxLeKPFfkWYqwIHrCGXlrB6oomUbz8UhVBegJZb8g+0QJVsFhULBu2P0T+4
	rqFZSm9WXDsUZc5fWAn1N2ak4yHMmUm+V+oyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fgc/yWjPOFOd5oTI+KtkN10VxFMmha/k
	SAz2+Kbe1vSGQFwRM/VLdkDveiSpVIu4JHIkaXaIuBBHHQUMKlZV6nDnu/8qfxh9
	H1ujEnIKwF7dY4Q0wuNF5lvP4RncqlafzfluQMJ//8L6YbmTWN8saRp9wE2eyCvg
	dLQ5ylHrRqE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2262923366;
	Fri, 12 Dec 2014 15:33:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EAEE23365;
	Fri, 12 Dec 2014 15:33:52 -0500 (EST)
In-Reply-To: <1418374214-8241-1-git-send-email-mail@eworm.de> (Christian
	Hesse's message of "Fri, 12 Dec 2014 09:50:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FA082B6-823E-11E4-8A9A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261368>

After queuing these three, I _think_ it is better to have something
like this patch on top, as it is distracting to let the GPG message
while setting up the test gpghome leak into the test output,
especially without running these tests with "-v" option.

The splitting of RFC1991 prerequiste part is about future-proofing.
When we want to define other kinds of specific prerequisites in the
future, I'd prefer to see it done separately from the basic set-up
code.

Thanks.

 t/lib-gpg.sh | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index b611b78..33de402 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -16,23 +16,25 @@ else
 		# Type DSA and Elgamal, size 2048 bits, no expiration date.
 		# Name and email: C O Mitter <committer@example.com>
 		# No password given, to enable non-interactive operation.
-		mkdir ./gpghome
-		chmod 0700 ./gpghome
-		GNUPGHOME="$(pwd)/gpghome"
-		export GNUPGHOME
-		gpg --homedir "${GNUPGHOME}" --import \
-			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg
-		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
-			"$TEST_DIRECTORY"/lib-gpg/ownertrust
+		mkdir ./gpghome &&
+		chmod 0700 ./gpghome &&
+		GNUPGHOME="$(pwd)/gpghome" &&
+		export GNUPGHOME &&
+		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
+			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
+		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
+			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
 		test_set_prereq GPG
-		if echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
-		then
-			test_set_prereq RFC1991
-		fi
 		;;
 	esac
 fi
 
+if test_have_prereq GPG &&
+    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
+then
+	test_set_prereq RFC1991
+fi
+
 sanitize_pgp() {
 	perl -ne '
 		/^-----END PGP/ and $in_pgp = 0;
