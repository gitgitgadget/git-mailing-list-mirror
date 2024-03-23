Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E5535A8
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711216375; cv=none; b=VXQBjbGYEsEub+S83ud51XZhw5zBJpcmxLymXTJo/T9vnGesXnHTcWN6NRny8efLw8cxLNJu37H02jtWvn+BhLq+NJBsE55W8fdVXwd3P1QZMEVhzkv4nC/7kHovU/3Kskt/Fl833CocOLeSDVZxTRK8KTNPtG1I/U/1htDF9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711216375; c=relaxed/simple;
	bh=Wvw83t9yBOBeASENhdsJ/R7jbzPv+K+FSxAY0nqsKtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=puPIMYEAn27BTYcjV2c7nOzt4dOCOOR8CP4oYVD/tTPVu4VYzd8mOtB5/fhuOaluxUnNjc9ZkvTld9g+IfNxAxl30POrNC9DYdd+HZR/0cAm/JcAw3ojbVYMHKsM8Mn05GJmC9r3PnzJjA/0tOuEd7szPECZonid78gQZqkrIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NRmIwlct; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NRmIwlct"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 15E9F1D68C2;
	Sat, 23 Mar 2024 13:52:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wvw83t9yBOBeASENhdsJ/R7jbzPv+K+FSxAY0n
	qsKtg=; b=NRmIwlctQIL0q9X3dov20YPvpmLfZv0UKa1clYq53K5pk1Xd9kJGHZ
	ciPmF7gTWbTjHtUGzfldizUx85WgwBlAD38vpQJtCGdA4VbuhFrj89KgA2kf09y+
	BQyEnG+uMWzL2KKcFuRK1qoROO/j5sQAKle5bNdQJ2c4xQwROatdI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BD1C1D68C1;
	Sat, 23 Mar 2024 13:52:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 746F71D68C0;
	Sat, 23 Mar 2024 13:52:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tim Landscheidt <tim@tim-landscheidt.de>
Cc: git@vger.kernel.org
Subject: Re: Inconsistent/buggy behaviour of "git config --add"
In-Reply-To: <87o7b5dj8h.fsf@vagabond.tim-landscheidt.de> (Tim Landscheidt's
	message of "Sat, 23 Mar 2024 16:07:58 +0000")
References: <87o7b5dj8h.fsf@vagabond.tim-landscheidt.de>
Date: Sat, 23 Mar 2024 10:52:45 -0700
Message-ID: <xmqq8r28ygwi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 28175454-E93E-11EE-8957-25B3960A682E-77302942!pb-smtp2.pobox.com

Tim Landscheidt <tim@tim-landscheidt.de> writes:

> | # git config section.key value0
> | # git config --add section.key value1

The action verb --add comes immediately after "git config" (and
possibly file-option and type option), so this is a request to
append "key = value1" in the "[section]" (if there is no existing
section.key, then "[section]" would have to be created at the same
time, but in this case there already is one).

> | # cat .git/config
> | [core]
> |         repositoryformatversion = 0
> |         filemode = true
> |         bare = false
> |         logallrefupdates = true
> | [section]
> |         key = value0
> |         key = value1

So this makes perfect sense.

> | # git config section.key --add value2

No action verb immediately after "git config" (possibly after
file-option and type option).  This should be taken as

    git config <name> <value> <value-pattern>

where

    <name> = section.key
    <value> = --add
    <value-pattern> = value2

As we lack --replace-all, the default behaviour is to replace a
single existing entry of "section.key" with existing value "value2",
with the new value "--add", or if there is no such existing entry,
add one such entry.

> | # cat .git/config
> | [core]
> |         repositoryformatversion = 0
> |         filemode = true
> |         bare = false
> |         logallrefupdates = true
> | [section]
> |         key = value0
> |         key = value1
> |         key = --add

which seems to be what the code did.

> | # git config section.key --add

No action verb immediately after "git config" (possibly after
file-option and type option).  This should be taken as

    git config <name> <value>

where

    <name> = section.key
    <value> = --add

and is an attempt to replace existing section.key with the new value
"--add", but because we have already three such entries, we get 

> | warning: section.key has multiple values
> | error: cannot overwrite multiple values with a single value
> |        Use a regexp, --add or --replace-all to change section.key.
> | #

which sounds sensible.

> So on one hand, "--add" must be given before the key to add
> a line, but if on the other hand one passes the option after
> the key and before the value, it is literally taken as the
> value and the value does not seem to be interpreted as a
> value-pattern, either.  However, if the value is missing,
> Git correctly recognizes that this does not make sense.

Not really.  I agree that the "git config" syntax is messy, but I
followed your example with "git config --help" (especially its
SYNOPSIS section) in hand, and reached the above explanation, which
your conjecutre does not quite match.

> My expectation of least surprise is that "git config
> section.key --add value" should be equivalent to "git config
> --add section.key value".

You cannot have "--add" as a value by doing so.

> If that is not possible, I would expect "git config
> section.key --add value2" to mean "change the values of
> section.key to '--add' where they currently match the
> value-pattern of 'value2'".

I think your expectation needs to be updated in this particular
case, but there is a discussion to revamp the UI started elsewhere,
which stops the double-dashed action verbs and instead trigger
different actions as subcommands of "git config", which will
hopefully make things easier to understand.
