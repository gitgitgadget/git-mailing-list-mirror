Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7731494D7
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321434; cv=none; b=Levys6rkaQMYK+XhGOYIdfQ9U5htHM+3hVGT0qBMBXo1sLjCYuH/vulty19uxKOfrM+R0CEkDiHinaYgKEstEmXm4Vzkw+ovQSXAjjBTVVhBDgAzKzcvWZDaXp6DW3OpkYK5Kl8IxIGUCZ42vVPSkItWJjUUBmM/3bFkxBokH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321434; c=relaxed/simple;
	bh=ZhbH0MPwzTFAR59Tj+UDaG91WA/um6x0qH6BdHgMgrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp+ORBaVw8A5WwZrxcTmwdnhNWyJJ+DUG0tdYkZW+lIq2W+azsP7ALURCbyYJkIy42KPK9NV5bJuAhYo5JVKvMgQ+XO7HyvIqitdnsWfe78cARy44/EStXh1teO9r/BIOAK2UQZZpI269rb8BABA7U3k60L4Yur1wKCpmtMR1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=caUC4JH9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="caUC4JH9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D3E3031236;
	Tue, 21 May 2024 15:57:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=ZhbH0MPwzTFAR59Tj+UDaG91W
	A/um6x0qH6BdHgMgrM=; b=caUC4JH9CQ9XjPAHQt2+yM+QczeQJtTeObW4D+AMU
	n16UsuWKwoR2oAREKtfjmOkU9qn8sTcH1oBliN9Nz/UD3EjINK34lA9NF3wkbjeK
	lzfgMA81qEyWNESXmEPpNrbD4Fr2kuoFak2r+haxxNtS7SeLPsm8L3lpCU/Yj3cU
	nA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CBC7F31235;
	Tue, 21 May 2024 15:57:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C3E8031234;
	Tue, 21 May 2024 15:57:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 01/12] send-email: drop FakeTerm hack
Date: Tue, 21 May 2024 12:56:47 -0700
Message-ID: <20240521195659.870714-2-gitster@pobox.com>
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
 4BF8A4C6-17AC-11EF-BC39-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

From: Jeff King <peff@peff.net>

Back in 280242d1cc (send-email: do not barf when Term::ReadLine does not
like your terminal, 2006-07-02), we added a fallback for when
Term::ReadLine's constructor failed: we'd have a FakeTerm object
instead, which would then die if anybody actually tried to call
readline() on it. Since we instantiated the $term variable at program
startup, we needed this workaround to let the program run in modes when
we did not prompt the user.

But later, in f4dc9432fd (send-email: lazily load modules for a big
speedup, 2021-05-28), we started loading Term::ReadLine lazily only when
ask() is called. So at that point we know we're trying to prompt the
user, and we can just die if ReadLine instantiation fails, rather than
making this fake object to lazily delay showing the error.

This should be OK even if there is no tty (e.g., we're in a cron job),
because Term::ReadLine will return a stub object in that case whose "IN"
and "OUT" functions return undef. And since 5906f54e47 (send-email:
don't attempt to prompt if tty is closed, 2009-03-31), we check for that
case and skip prompting.

And we can be sure that FakeTerm was not kicking in for such a
situation, because it has actually been broken since that commit! It
does not define "IN" or "OUT" methods, so perl would barf with an error.
If FakeTerm was in use, we were neither honoring what 5906f54e47 tried
to do, nor producing the readable message that 280242d1cc intended.

So we're better off just dropping FakeTerm entirely, and letting the
error reported by constructing Term::ReadLine through.

[jc: cherry-picked from v2.42.0-rc2~6^2~1]

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..72d876f0a0 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,18 +26,6 @@
=20
 Getopt::Long::Configure qw/ pass_through /;
=20
-package FakeTerm;
-sub new {
-	my ($class, $reason) =3D @_;
-	return bless \$reason, shift;
-}
-sub readline {
-	my $self =3D shift;
-	die "Cannot use readline on FakeTerm: $$self";
-}
-package main;
-
-
 sub usage {
 	print <<EOT;
 git send-email' [<options>] <file|directory>
@@ -930,16 +918,10 @@ sub get_patch_subject {
 }
=20
 sub term {
-	my $term =3D eval {
-		require Term::ReadLine;
-		$ENV{"GIT_SEND_EMAIL_NOTTY"}
+	require Term::ReadLine;
+	return $ENV{"GIT_SEND_EMAIL_NOTTY"}
 			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
 			: Term::ReadLine->new('git-send-email');
-	};
-	if ($@) {
-		$term =3D FakeTerm->new("$@: going non-interactive");
-	}
-	return $term;
 }
=20
 sub ask {
--=20
2.45.1-216-g4365c6fcf9

