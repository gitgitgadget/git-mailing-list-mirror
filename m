Received: from gavdos.tim-landscheidt.de (gavdos.tim-landscheidt.de [116.203.46.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C3D518
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.46.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711306655; cv=none; b=Efy0LuzI6Xr3wUnSH1y80PmN2QGeAwf0xuyeIUGGh/+0SeuoHykYbPQvaopc1ZD1qnL81MJhK7TyJNx90BcfA4enIVJ91uwMF5LI0ju2nncQArvrcVatkKHK03XeRRC8T9GyYDO/zYEAHduyboaP7Q63jXvaJ0V+a5wLNuEdbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711306655; c=relaxed/simple;
	bh=xscuITJzvqN7hLX8y7LkBc9pfsnTzZk09N+9xmHcmEI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nJNtUEt2ni7pVCN7qo8GktTwBXnUZ5qnd39AefDFHMIqKB3e4ECNTbOp0BDKReLnyxzZSpelE2kpwp/Blp+sQyWYRRQpuRW4xtc4Gz/qBWMAeVSO0rKAtvU+TBUQVwehHaxt1nJkxG7CnC5tGVgd4rUTivMrrzVwzfY69BZPYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tim-landscheidt.de; spf=pass smtp.mailfrom=tim-landscheidt.de; arc=none smtp.client-ip=116.203.46.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tim-landscheidt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tim-landscheidt.de
Received: from [146.0.233.147] (port=51428 helo=vagabond)
	by gavdos.tim-landscheidt.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <tim@tim-landscheidt.de>)
	id 1roT22-00GPVa-2t;
	Sun, 24 Mar 2024 18:57:22 +0000
From: Tim Landscheidt <tim@tim-landscheidt.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Inconsistent/buggy behaviour of "git config --add"
Organization: https://www.tim-landscheidt.de/
References: <87o7b5dj8h.fsf@vagabond.tim-landscheidt.de>
	<xmqq8r28ygwi.fsf@gitster.g>
Date: Sun, 24 Mar 2024 18:57:21 +0000
In-Reply-To: <xmqq8r28ygwi.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	23 Mar 2024 10:52:45 -0700")
Message-ID: <87o7b3xxta.fsf@vagabond.tim-landscheidt.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> wrote:

> [=E2=80=A6]

>> So on one hand, "--add" must be given before the key to add
>> a line, but if on the other hand one passes the option after
>> the key and before the value, it is literally taken as the
>> value and the value does not seem to be interpreted as a
>> value-pattern, either.  However, if the value is missing,
>> Git correctly recognizes that this does not make sense.

> Not really.  I agree that the "git config" syntax is messy, but I
> followed your example with "git config --help" (especially its
> SYNOPSIS section) in hand, and reached the above explanation, which
> your conjecutre does not quite match.

I respectfully disagree (somewhat).  git-config(1) reads:

| [=E2=80=A6]

|        Multiple lines can be added to an option by using
|        the --add option. If you want to update or unset an
|        option which can occur on multiple lines, a
|        value-pattern (which is an extended regular
|        expression, unless the --fixed-value option is
|        given) needs to be given. Only the existing values
|        that match the pattern are updated or unset. If you
|        want to handle the lines that do not match the
|        pattern, just prepend a single exclamation mark in
|        front (see also the section called =E2=80=9CEXAMPLES=E2=80=9D), but
|        note that this only works when the --fixed-value
|        option is not in use.

| [=E2=80=A6]

|        --replace-all
|            Default behavior is to replace at most one
|            line. This replaces all lines matching the key
|            (and optionally the value-pattern).

This says quite clearly if one wants to /add/ a value,
"--add" must be given; the default is to /replace/ an
existing value.

The only indication that this might be false is the
description of "--add" itself which gives another and
different explanation for the behaviour of "--replace-all":

|        --add
|            Adds a new line to the option without altering
|            any existing values. This is the same as
|            providing ^$ as the value-pattern in
|            --replace-all.

| [=E2=80=A6]

So the first section states that "only the existing values
that match the pattern are updated or unset", and here it
says that if there are no matches, a new line is added.

>> My expectation of least surprise is that "git config
>> section.key --add value" should be equivalent to "git config
>> --add section.key value".

> You cannot have "--add" as a value by doing so.

> [=E2=80=A6]

The standard way to achieve this would be to use "--",
i. e. "git config section.key --add -- --add" (apparently
even part of POSIX as "Utility Syntax Guidelines", but also
commonly used elsewhere in Git).

Tim
