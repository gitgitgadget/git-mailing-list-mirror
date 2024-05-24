Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF27405D8
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580044; cv=none; b=Pa0GiMH0CNByS+ik9daz3RzclUozVsKjydccNdE1v4hUSHxcSOkNSNt3vtTGymBSeKxITEWK/gfhu7eqNhGwOtzu+3UO+ONltWOZpebqwSFQQVLq5EiIpmrKTZeJOtiyrXoyhNQrSzUNPYd82gCAApgOOLB5Vh/kYgg8i/Qda+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580044; c=relaxed/simple;
	bh=5acxYs1UNkSGxrVBn1TTqduB6RyayglG2ZCANXwdNlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toFzo9TmNafU1GLx3B90fcX3wSWB4RPRNsPLNzXmM9imW7wwMM2Md9JvgR2fbDmMUVxhPtbOr6U1F98E7fj6O0EeAlLCcsiW1yPr+W02i+MMKTR1VOQe3bGDavETDvOd/pyUS5jOlwYY8+VNxHOqx3b4wusJw/SUSVAiyR0cX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s5/EXCyo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s5/EXCyo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C72682B223;
	Fri, 24 May 2024 15:47:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=5acxYs1UNkSGxrVBn1TTqduB6
	RyayglG2ZCANXwdNlk=; b=s5/EXCyobEUyx47hALZMbDPT2lU2kZWnoYcgrVAjM
	bZtf2QKHgLMRFErLPH34oTMElDcSZ6RyaJ5hayajUqHtPo/0PeW5MdEdhtsDqhr6
	lB4D9U721vUGuJLzzNn4M7PY5R0DQLJXefi7zV7K5k0BHz+NqF7hck2aY3a+nUfx
	Pg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BF6A22B222;
	Fri, 24 May 2024 15:47:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCDB72B221;
	Fri, 24 May 2024 15:47:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 02/12] send-email: avoid creating more than one Term::ReadLine object
Date: Fri, 24 May 2024 12:47:05 -0700
Message-ID: <20240524194715.695916-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
In-Reply-To: <20240524194715.695916-1-gitster@pobox.com>
References: <20240524194715.695916-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 6E95B9CC-1A06-11EF-8B25-A19503B9AAD1-77302942!pb-smtp21.pobox.com
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
2.45.1-246-gb9cfe4845c

