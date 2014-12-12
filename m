From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] create gpg homedir on the fly
Date: Fri, 12 Dec 2014 12:33:43 -0800
Message-ID: <xmqqk31wbobc.fsf@gitster.dls.corp.google.com>
References: <20141212094753.160a0fb5@leda.localdomain>
	<1418374214-8241-1-git-send-email-mail@eworm.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Hesse <mail@eworm.de>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:33:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzWuQ-0003ZR-Tg
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 21:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935233AbaLLUdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 15:33:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933118AbaLLUdq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 15:33:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF71223361;
	Fri, 12 Dec 2014 15:33:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vCVHs+rojAyqYcn+Tlaua2fb7i8=; b=mYLbPg
	Lp983MUgkWFzg1Ve3AQVbKGwl8MiYkpjWhyi7NXJBSPk/PXx6Yj75WQ6BMvxlAJu
	3r918m6dG7BYdgxl5B7mk0XAizVaa5L9Kf8fEYEWEP3RQuk08ooaP+DyKZn4NalV
	8QOD4zK61tjUqaAfczSOjPm+5qhuSkPBXAhNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DYQ3Si/5P/wYjS347B20igmpNEiMWxx0
	2MXJG3S0qCJ+aG7u8otNVKD7qVT0DVbirhJ1HojKrYVKFRAhuPLxZjI9wpePuC4t
	Sq/Ib0TIVQxc02Pduknq5TLavPk+sidpPmjb1giRPLn6RAT0kuetDBV78t7dFP1i
	r1F+upUwUz0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D56A623360;
	Fri, 12 Dec 2014 15:33:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 608302335F;
	Fri, 12 Dec 2014 15:33:44 -0500 (EST)
In-Reply-To: <1418374214-8241-1-git-send-email-mail@eworm.de> (Christian
	Hesse's message of "Fri, 12 Dec 2014 09:50:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2AB4D16C-823E-11E4-8632-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261367>

After queuing these three, I _think_ it is better to have something
like this patch on top, as it is distracting to let the GPG message
while setting up the test gpghome leak into the test output,
especially without running these tests with "-v" option.

The splitting of RFC1991 prerequiste part is about future-proofing.
When we want to define other kinds of specific prerequisites in the
future, I'd prefer to see it done separately from the basic set-up
code.

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
