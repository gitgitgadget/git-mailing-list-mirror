Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BB8F48
	for <git@vger.kernel.org>; Sun, 31 Dec 2023 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GGbsUiL2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 92D6835584;
	Sun, 31 Dec 2023 12:27:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=++LvhmMo9Xzd1j+GnPOhCZEpI2vrUbLyMEU9oG
	6XTKs=; b=GGbsUiL2q6LIDQ+qxJJA0yevzaZJ9Eu0E9uyBSHIcfQ0pIU+bObF3G
	H+2IvcRnfWQa01Ki1IqxMCi0hSZe5AY/QcYMI8HoVnXliPcyhcyV6J/XxjQZD06X
	hoh0peHoFJCF5nYfSO2YmrTuB+/u6KCWA53iAR7S4kDO8qjI9U1Xk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BF4B35583;
	Sun, 31 Dec 2023 12:27:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32BA435582;
	Sun, 31 Dec 2023 12:27:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: Concurrent fetch commands
In-Reply-To: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de> (Stefan
	Haller's message of "Sun, 31 Dec 2023 14:30:05 +0100")
References: <c11ca0b3-aaf4-4a8d-80a1-3832954aa7aa@haller-berlin.de>
Date: Sun, 31 Dec 2023 09:27:19 -0800
Message-ID: <xmqqy1daffk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DAAC9896-A801-11EE-BE69-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Stefan Haller <lists@haller-berlin.de> writes:

> I can reliably reproduce this by doing
>
>    $ git fetch&; sleep 0.1; git pull
>    [1] 42160
>    [1]  + done       git fetch
>    fatal: Cannot rebase onto multiple branches.

I see a bug here.

How this _ought_ to work is

 - The first "git fetch" wants to report what it fetched by writing
   into the $GIT_DIR/FETCH_HEAD file ("git merge FETCH_HEAD" after
   the fetch finishes can consume its contents).

 - The second "git pull" runs "git fetch" under the hood.  Because
   it also wants to write to $GIT_DIR/FETCH_HEAD, and because there
   is already somebody writing to the file, it should notice and
   barf, saying "fatal: a 'git fetch' is already working" or
   something.

But because there is no "Do not overwrite FETCH_HEAD somebody else
is using" protection, "git merge" or "git rebase" that is run as the
second half of the "git pull" ends up working on the contents of
FETCH_HEAD that is undefined, and GIGO result follows.

The "bug" that the second "git fetch" does not notice an already
running one (who is in possession of FETCH_HEAD) and refrain from
starting is not easy to design a fix for---we cannot just abort by
opening it with O_CREAT|O_EXCL because it is a normal thing for
$GIT_DIR/FETCH_HEAD to exist after the "last" fetch.  We truncate
its contents before starting to avoid getting affected by contents
leftover by the last fetch, but when there is a "git fetch" that is
actively running, and it finishes _after_ the second one starts and
truncates the file, the second one will end up seeing the contents
the first one left.  We have the "--no-write-fetch-head" option for
users to explicitly tell which invocation of "git fetch" should not
write FETCH_HEAD.

Running "background/priming" fetches (the one before "sleep 0.1" you
have) is not a crime by itself, but it is a crime to run them
without the "--no-fetch-head" option.  Since you have *NO* intention
of using its contents to feed a "git merge" (or equivalent)
yourself, you are breaking your "git pull" step in your example
reproduction yourself.

