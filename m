Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B7D1482E7
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321432; cv=none; b=Xv3znCExierJVV+8G+kCLcH1Mt030Wgt+K09xKNkxnoK5HPNaFy7EbrmXnfXYkgU0ywvLv0wQX7GtCJlH3S0Z6Ycvyxl+tk98aDNUEiBFVuwLFhnV5SC7fDVdAM5eH/NzTwhrYFmf9pJGL/zuoYZr6dTfxpOus3g8yDhIF8T1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321432; c=relaxed/simple;
	bh=iW/LSqSO4Kn2BU87K7kzFrZ7HnQ3V0sqDKqd7PZtJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/GYoJNng7npoiP5Uo6sT5wxpy/tkfI0Mbg0QB4dnoDwpuWw/RAubREMdHtp1f1PQuDKDoGPpBODO18xv3lZujG/S0Nmz3ofcyqvHF7mHGmS5mgmxmJ/ls9QdCxe7lSTSqmndk0xXSj76NZH6llHy9qSXyPaBT1MfsukuFk3InM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QS6WDEEb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QS6WDEEb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB18831203;
	Tue, 21 May 2024 15:57:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=iW/LSqSO4Kn2BU87K7kzFrZ7H
	nQ3V0sqDKqd7PZtJd4=; b=QS6WDEEbeEqVcnH4NPRgWYN3zzea1RbtVWN9tIzBF
	MU03v11dQZ8VF09FbcA3Ntpdp1aEUZppVybXZ+9Vtu8GBy2CdDoPngd9kDtAsKAr
	hPTVsASsWdr3TI6QPPB2OqX//g3xcyqOCLKgPOXQsN+YQyHj9BDWkXGrCfQ4gtE0
	ts=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C11EC31202;
	Tue, 21 May 2024 15:57:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BAF331201;
	Tue, 21 May 2024 15:57:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 02/12] send-email: avoid creating more than one Term::ReadLine object
Date: Tue, 21 May 2024 12:56:48 -0700
Message-ID: <20240521195659.870714-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 4DF28512-17AC-11EF-BEB2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Jeff King <peff@peff.net>

Every time git-send-email calls its ask() function to prompt the user,
we call term(), which instantiates a new Term::ReadLine object. But in
v1.46 of Term::ReadLine::Gnu (which provides the Term::ReadLine
interface on some platforms), its constructor refuses to create a second
instance[1]. So on systems with that version of the module, most
git-send-email instances will fail (as we usually prompt for both "to"
and "in-reply-to" unless the user provided them on the command line).

We can fix this by keeping a single instance variable and returning it
for each call to term(). In perl 5.10 and up, we could do that with a
"state" variable. But since we only require 5.008, we'll do it the
old-fashioned way, with a lexical "my" in its own scope.

Note that the tests in t9001 detect this problem as-is, since the
failure mode is for the program to die. But let's also beef up the
"Prompting works" test to check that it correctly handles multiple
inputs (if we had chosen to keep our FakeTerm hack in the previous
commit, then the failure mode would be incorrectly ignoring prompts
after the first).

[1] For discussion of why multiple instances are forbidden, see:
    https://github.com/hirooih/perl-trg/issues/16

[jc: cherry-picked from v2.42.0-rc2~6^2]

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl   | 18 +++++++++++++-----
 t/t9001-send-email.sh |  5 +++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 72d876f0a0..ad51508790 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -917,11 +917,19 @@ sub get_patch_subject {
 	do_edit(@files);
 }
=20
-sub term {
-	require Term::ReadLine;
-	return $ENV{"GIT_SEND_EMAIL_NOTTY"}
-			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
-			: Term::ReadLine->new('git-send-email');
+{
+	# Only instantiate one $term per program run, since some
+	# Term::ReadLine providers refuse to create a second instance.
+	my $term;
+	sub term {
+		require Term::ReadLine;
+		if (!defined $term) {
+			$term =3D $ENV{"GIT_SEND_EMAIL_NOTTY"}
+				? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
+				: Term::ReadLine->new('git-send-email');
+		}
+		return $term;
+	}
 }
=20
 sub ask {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1130ef21b3..0f08a9542b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -337,13 +337,14 @@ test_expect_success $PREREQ 'Show all headers' '
 test_expect_success $PREREQ 'Prompting works' '
 	clean_fake_sendmail &&
 	(echo "to@example.com" &&
-	 echo ""
+	 echo "my-message-id@example.com"
 	) | GIT_SEND_EMAIL_NOTTY=3D1 git send-email \
 		--smtp-server=3D"$(pwd)/fake.sendmail" \
 		$patches \
 		2>errors &&
 		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
-		grep "^To: to@example.com\$" msgtxt1
+		grep "^To: to@example.com\$" msgtxt1 &&
+		grep "^In-Reply-To: <my-message-id@example.com>" msgtxt1
 '
=20
 test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
--=20
2.45.1-216-g4365c6fcf9

