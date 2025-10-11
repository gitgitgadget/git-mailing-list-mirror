Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958E1F9F47
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760174129; cv=none; b=A4UI8be3AbyCEurBlCjD0tzItSuYBm/184uXSbZjb7cl/oZXt4789LgJ2XDAlgBGkCPgUQgw3fwq98915f8x3o39SjCYSnpUh/EwDxThT/3YMkWYZ7N/5y3A9zdPurOpQKC2sc6ID9zEgSWTjo5H8cNzDhm4ecMMYvbwRJJ1oQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760174129; c=relaxed/simple;
	bh=kwrqupI6Iaj14Aw5m7N5KOl9VrK97OsIVABMp3EuORY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRiJTlwSBprYmAEFkx1xExZ9b5lvK6VYGiuy+4QIWHjb6e2vnEygAaUQPR+AxcLgGr73Ak902Fgod/mU+RqEvaIC9ZaZ8LE55wfSrQBnQHBbhZSzjTY+0ZPWeHsd9O7+tG0DhV19rO2VWV8qKFDhwljfBMs19ezuIB2H9ssrlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4ckHy94nVFzRnlJ;
	Sat, 11 Oct 2025 11:15:13 +0200 (CEST)
Message-ID: <601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org>
Date: Sat, 11 Oct 2025 11:15:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Language: en-US
To: kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 phillip.wood@dunelm.org.uk
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <d17060d9b72.1759952528.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 08.10.25 um 21:45 schrieb kristofferhaugsbakk@fastmail.com:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> This option has legitimate uses but could create a commit history which
> violates the assumption that commits are strictly increasing in terms of
> commit timestamps. Warn against that in both git-am(1) and git-rebase(1).

I think that the discussion has meanwhile converged insofar that we do
not think that the option has a legitimate use case. Rather, it was
introduced to solve one particular problem case (that is cited below),
but with a solution that was misguided and not well thought through.

> The genesis of this option is 3f01ad66 (am: Add --committer-date-is-
> author-date option, 2009-01-22). The commit message doesn’t give us an
> example of a use case, but the thread starter does:[1]
> 
>     I've a big set of patches in a mbox file: there's sufficient info
>     inside for git-am to work.
> 
>     Yet, each time I do import these, my sha1sums are changing because of
>     different commit dates.
> 
>     I'd like to force the commit date to match the info/date from the time
>     I received the email (and therefore always get back the right
>     sha1sums).
> 
> So the motivation was to treat git-am(1) as an import command that
> creates the same commit IDs given the same base and committer.
> 
> [1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/

> diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
> index 221070de481..c36ae679cfb 100644
> --- a/Documentation/git-am.adoc
> +++ b/Documentation/git-am.adoc
> @@ -156,11 +156,18 @@ Valid <action> for the `--whitespace` option are:
>  	See also linkgit:githooks[5].
>  
>  --committer-date-is-author-date::
> -	By default the command records the date from the e-mail
> -	message as the commit author date, and uses the time of
> -	commit creation as the committer date. This allows the
> -	user to lie about the committer date by using the same
> -	value as the author date.
> +	NOTE: The history walking machinery assumes that commits have
> +	strictly increasing commit timestamps, with some tolerance for
> +	clock skew (see linkgit:git-rev-list[1]). You should only use
> +	this option to lie about the committer date when applying
> +	commits on top of a base which commit is older (in terms of the
> +	commit date) than the oldest patch you are applying.

IMO, "NOTE" is not strong enough, it should be at least "WARNING".

> ++
> +By default the command records the date from the e-mail
> +message as the commit author date, and uses the time of
> +commit creation as the committer date. This allows the
> +user to lie about the committer date by using the same
> +value as the author date.

I would not mind leaving the description first and the warning in the
follow-up paragraph. It would make for a better flow of reading.

Perhaps insert "Do not use this option." as the the first sentence,
either before the description (my preference) or in the warning.

Thank you for picking up this topic.

-- Hannes

