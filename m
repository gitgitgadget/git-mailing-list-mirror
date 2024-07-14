Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76AE54D
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720940762; cv=none; b=aopAtLajX1LXp7IeS789YqCCK6CNoipC0mBjanGXNvEdP2Revc8j2Sxw2gw7kf4vELQTD56JWsS4qCZ6G0IyQYKPaLR5H724q6oL9q6dqcfpANdOYVF4/Ng4MDxVo5QCC1F+2bwKE+TGh1aoGJL/DoMvPVb9+w+9fUFDNaO67jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720940762; c=relaxed/simple;
	bh=b7FKtuWC4RZmf3yc4lr0tn8E4vJ/WPI2qgH07HmZn8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq05qAH/okjeFqGaPyf6bf5JAUtrC8PlKqLiVpofmkUpqA3pYg0A5PYEePWgUUy0Vs3rBCi9Hr/fbM4eBSZnBbYk2RHPEjsprNDvkFv2twTq+tpsM/bbvoEm8Oi29g7rDCdSXm3E59kcaDXSYw3K4B0KAP6Sl3aPeHUu1TxM6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24280 invoked by uid 109); 14 Jul 2024 07:05:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Jul 2024 07:05:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18011 invoked by uid 111); 14 Jul 2024 07:05:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Jul 2024 03:05:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 14 Jul 2024 03:05:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [Test Breakage 2.46.0-rc0] Test t4135.06 fails on NonStop
Message-ID: <20240714070558.GA575927@coredump.intra.peff.net>
References: <024201dad543$877221e0$965665a0$@nexbridge.com>
 <xmqqv818aezm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv818aezm.fsf@gitster.g>

On Sat, Jul 13, 2024 at 07:23:25PM -0700, Junio C Hamano wrote:

> And this hunk uses /dev/zero the same way before and after.  The
> older use of /dev/zero in these tests were from 852a1710 (am: let
> command-line options override saved options, 2015-08-04), which was
> part of v2.6.0 that was tagged in late Sep 2015.
> 
> In short this is nothing new in this release.

One thing my recent patch did was remove the TTY prereq from those
tests. So it's possible that they're now being run on his platform for
the first time.

> Preparing a garbage file that is sufficiently large (like 1kB) and
> feeding from that file to the commands instead of from /dev/null may
> be sufficient to reduce the dependence of /dev/zero but given that
> this is ancient, there are many other uses of /dev/zero in the test
> directory, it does not seem ultra-urgent to address this, at least
> to me.  Certainly not during the pre-release freeze.

The other mentions of /dev/zero that I see are all in tests marked as
EXPENSIVE, which likewise aren't run normally.

So I think it is plausibly a new issue for some platforms, though I
agree it is not super urgent.

With --retry I think we would not actually read stdin at all, so we
could just remove the mention of /dev/zero entirely. But if we wanted to
be sure it did not read and choke on any input provided, I think just:

diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index a4d0c03ca6..76783bdd67 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -45,6 +45,7 @@ test_expect_success '--3way overrides --no-3way' '
 
 	# Applying side1 with am --3way will succeed due to the threeway-merge.
 	# Applying side2 will fail as --3way does not apply to it.
+	echo garbage |
 	test_must_fail git am --retry --3way &&
 	test_path_is_dir .git/rebase-apply &&
 	test side1 = "$(cat file2)"
@@ -99,7 +100,8 @@ test_expect_success '--reject overrides --no-reject' '
 	test_path_is_dir .git/rebase-apply &&
 	test_path_is_missing file.rej &&
 
-	test_must_fail git am --retry --reject </dev/zero &&
+	echo garbage |
+	test_must_fail git am --retry --reject &&
 	test_path_is_dir .git/rebase-apply &&
 	test_path_is_file file.rej
 '

would be sufficient.

-Peff
