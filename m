Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5EB1E532
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594959; cv=none; b=WCwKixK7L14/WRtnB9buMupBq00Mdql36GVcRMwB5IPV66Cn6z2pS5Aqe77zObiPlukKAkvMzA7njdTYlhavssHxSnMT6h7vDXkkjMuVgNMpcz8J+XjoxUnDTN4bc3N45FNU83lzp/j6nKDdYgXStAv2lRL62pbgPT7czmDzMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594959; c=relaxed/simple;
	bh=VZUV8yQDTsuFkyyM60d92OJql1fMycRdB9TIYwoLzQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQsJUgIam00TSG7XL6nWIXwssiYprIQtvUqjVO7UcaA5OkdBejL0sz7C7yIJq+aEjeVYjdfR3w8xI5qqdGV0OuVIOnfL+hgDpLUiJqPfrZ54yI3h/Er2KwFW5G+PVLYjTUI5BJC8qJ2DSfWcK4DeAs5UoKnQJceRc6IGQcl0P/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i7ptn71i; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i7ptn71i"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A6D71F3264;
	Mon,  8 Apr 2024 12:49:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VZUV8yQDTsuFkyyM60d92OJql1fMycRdB9TIYw
	oLzQM=; b=i7ptn71iBgsDhtHi1M/wzyrbdlVS54m2NjmG8BaaHqPtCTcyYsvQ2I
	C2sw0eswcZRDmwUKgMhHrNzbwDUaufiFoObjC3Q/KHaFTQf+/HIHMRk2/y1QjFu9
	2tkKSQ/xttKQH+smP1kzYGxkr/pJlXenPatsZx/VZFsK9a5P9Ufk8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 608E41F3263;
	Mon,  8 Apr 2024 12:49:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7F921F3262;
	Mon,  8 Apr 2024 12:49:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Olliver Schinagl <oliver@schinagl.nl>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Stefan Haller <lists@haller-berlin.de>
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
In-Reply-To: <c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com> (phillip's
	message of "Sun, 7 Apr 2024 16:12:28 +0100")
References: <20240330081026.362962-2-oliver@schinagl.nl>
	<864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
	<xmqqcyr3s3gj.fsf@gitster.g>
	<b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
	<4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
	<6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
	<d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
	<2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
	<c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com>
Date: Mon, 08 Apr 2024 09:49:14 -0700
Message-ID: <xmqqzfu3dcl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF601B0A-F5C7-11EE-91A9-25B3960A682E-77302942!pb-smtp2.pobox.com

phillip.wood123@gmail.com writes:

>>> get_terms() wants to read the first line into `term_bad` and the
>>> second line into `term_good` so it makes sense that it uses two
>>> calls to `strbuf_getline()` to do that. It does not want to read
>>> the whole file into a single buffer as we do here.
>> Right, but I why not use strbuf_getline()?
>
> Because you want the whole file, not just one line as the script name
> could potentially contain a newline

It is technically true, but it somehow sounds like an implausible
scenario to me.  The real reason why read_file() is preferrable is
because you do not have to write, and we do not want to see you write,
the whole "open (and handle error), read, chomp, and return" sequence.

I would even suspect that get_terms() is a poorly written
anti-pattern.  If I were adding that function to the system today, I
wouldn't be surprised if I did read_file() the whole thing and
worked in-core to split two items out.

> If I understand correctly we're encouraging the user to run "git
> bisect skip" from the post checkout script. Doesn't that mean we'll
> end up with a set of processes that look like
>
> 	- git bisect start
> 	  - post checkout script
>             - git bisect skip
>               - post checkout script
>                 - git bisect skip
>                   ...
>
> as the "git bisect start" is waiting for the post checkout script to
> finish running, but that script is waiting for "git bisect skip" to
> finish running and so on. Each of those processes takes up system
> resources, similar to how a recursive function can exhaust the
> available stack space by calling itself over and over again.

True.  What such a post-checkout script can do is to only mark the
HEAD as "untestable", just like a run script given to "bisect run"
signals that fact by returnint 125.  And at that point, I doubt it
makes sense to add such a post-checkout script for the purpose of
allowing "bisect skip".

Having said that, a post-checkout script and pre-resume script may
have a huge value in helping those whose tests cannot be automated
(in other words, they cannot do "git bisect run") when they need to
tweak the working tree during bisection.  We all have seen, during a
bisection session that spans a segment of history that has another
bug that affects our test *but* is orthogonal to the bug we are
chasing, that we "cherry-pick --no-commit" the fix for that other
problem inside "git bisect run" script.  It might look something
like

    #!/bin/sh
    if git merge-base --is-ancestor $the_other_bug HEAD
    then
	# we need the fix
	git cherry-pick --no-commit $fix_for_the_other_bug ||
	exit 125
    fi

    make test
    status=$?
    git reset --hard ;# undo the cherry-pick
    exit $status

But to those whose test is not a good match to "git bisect run", if
we had a mechanism to tweak the checked out working tree after the
"bisect next" (which is an internal mechanism that "bisect good",
"bisect bad", and "bisect skip" share to give you the next HEAD and
the working tree to test) checks out the working tree before it
gives the control back to you, we could split the above script into
two parts and throw the "conditionally cherry-pick the fix" part
into that mechanism.  We'd need to have a companion script to "redo
the damage" (the "reset --hard" in the above illustration) if this
were to work seamlessly.  That obviously is totally orthogonal to
what we are discussing in this thread, but may make a good #leftoverbits
material (but not for novices).
