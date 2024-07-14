Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE46B64E
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720923818; cv=none; b=XmU8/GbCez4YfN5sGtJZVy6P03ja023oodgiXLQfYXH21IanD7JHmNxaax3/3AGQsZLAwahXyYBFaN7dk/OoFbhHFWOEVKobOAqUevMR4v/7+MUMQNGqgVJ1tSWwZhFdShAJSqwPphlAEAiqdR7YRwqLZlmxU0NcVHQXuoDBxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720923818; c=relaxed/simple;
	bh=5E/+tme9rBUvqIteT8OutLrY41l8KApMpdGnkdW+N0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IVczATs7bD6D2t9J72HE/eiXvPduhovNaGh7Z6KRYKs9/eJc/LN9rpvJ2EgJWB0yO1kXXNYQN/LCyFDOFLIqITGisAe6i30J9K0Xw+IwuQbwvXPlgIcFxRb3UlFbMrlJMwIUKdd8LfiddLwarsovUc2Vq8JRMMjFS+zhDS1XLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Po3sRjWf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Po3sRjWf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 92CBB31815;
	Sat, 13 Jul 2024 22:23:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5E/+tme9rBUvqIteT8OutLrY41l8KApMpdGnkd
	W+N0Y=; b=Po3sRjWfCJTxwkXUVt+gP29v7sIy4Tc2rMNPQ0NX00IQUtGoQzQzth
	wGXZk3KwxX6ASr4bcfBqNnW4tMSH5uHebEEoQTBeulcIAGHMfBOsOdPOLTfByNmd
	zttaXLKHUBV8xMbbp8UF4X3wIF3czw/QDBcW7yd4Caq5n3ICFkTDI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A5C531814;
	Sat, 13 Jul 2024 22:23:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1790C31813;
	Sat, 13 Jul 2024 22:23:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [Test Breakage 2.46.0-rc0] Test t4135.06 fails on NonStop
In-Reply-To: <024201dad543$877221e0$965665a0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Sat, 13 Jul 2024 12:41:31
	-0400")
References: <024201dad543$877221e0$965665a0$@nexbridge.com>
Date: Sat, 13 Jul 2024 19:23:25 -0700
Message-ID: <xmqqv818aezm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D96CB30-4188-11EF-9061-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

<rsbecker@nexbridge.com> writes:

> Here is the breakage. This looks like a non-portable dependency on /dev/zero
> was introduced.
>
> expecting success of 4153.6 '--reject overrides --no-reject':
>         rm -fr .git/rebase-apply &&
>         git reset --hard &&
>         git checkout first &&
>         rm -f file.rej &&
>
>         test_must_fail git am --no-reject side1.eml &&
>         test_path_is_dir .git/rebase-apply &&
>         test_path_is_missing file.rej &&
>
>         test_must_fail git am --retry --reject </dev/zero &&
>         test_path_is_dir .git/rebase-apply &&
>         test_path_is_file file.rej

I think you are blaming 53ce2e3f (am: add explicit "--retry" option,
2024-06-06), but /dev/zero was in use before that commit.

        diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
        ...
        @@ -40,7 +44,7 @@ test_expect_success TTY '--3way overrides --no-3way' '

                # Applying side1 with am --3way will succeed due to the threeway-merge.
                # Applying side2 will fail as --3way does not apply to it.
        -	test_must_fail test_terminal git am --3way </dev/zero &&
        +	test_must_fail git am --retry --3way &&
                test_path_is_dir .git/rebase-apply &&
                test side1 = "$(cat file2)"
         '

In this hunk, use of /dev/zero goes away; if /dev/zero were a
problem, you would have been failing this test already.

        @@ -94,7 +98,7 @@ test_expect_success TTY '--reject overrides --no-reject' '
                test_path_is_dir .git/rebase-apply &&
                test_path_is_missing file.rej &&

        -	test_must_fail test_terminal git am --reject </dev/zero &&
        +	test_must_fail git am --retry --reject </dev/zero &&
                test_path_is_dir .git/rebase-apply &&
                test_path_is_file file.rej
         '

And this hunk uses /dev/zero the same way before and after.  The
older use of /dev/zero in these tests were from 852a1710 (am: let
command-line options override saved options, 2015-08-04), which was
part of v2.6.0 that was tagged in late Sep 2015.

In short this is nothing new in this release.

Preparing a garbage file that is sufficiently large (like 1kB) and
feeding from that file to the commands instead of from /dev/null may
be sufficient to reduce the dependence of /dev/zero but given that
this is ancient, there are many other uses of /dev/zero in the test
directory, it does not seem ultra-urgent to address this, at least
to me.  Certainly not during the pre-release freeze.

Thanks for a report.


