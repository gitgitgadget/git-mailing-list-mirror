Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C026F461
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658794; cv=none; b=g+DkY/LFeJh33ori9lI7Tdkwi+1nz+04IPZ6U6iMdle7YXW+VtJZqxan3nPHMto5vne/UrixvToLNs4+Ej6zmCk9j0xo0ksOJLCjpOX4P7EwSK5Q8fdPQXD/1qQt/n5tpjWhzUm62e+h2Mh8QEUGTdlgi76DvZ7pIhzLOgcwgDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658794; c=relaxed/simple;
	bh=fB13q6oaDBa8+xwfWQODOZX9WQ+XFwB9ZARX/9rYQJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2iU0gBrexKBFS9FePC45h50XBqaShFMi37ock0Ok00jh0cGJap2CxsIO3WnM4IilAQ+hHym0tqy+gS2RknaAGpYxQ4+K4R7d+oW6Yf3FcUNXqrUV6W/jjJa9wrWUDakBYz9EYo+IQAqQJvUkzYmnhuR+26GgX3CTz8EcbQYNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UU23ykgx; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UU23ykgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752658790; x=1753263590; i=l.s.r@web.de;
	bh=kDuyBvsSjfWaRUwTIEaoGKLPEFl3Dwf6H6pGdUQ2TmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UU23ykgxBrTJImSYwjaShheRW5qws6VTc1mFmMSzc6JqQDlDJ9A3CJ9lbLFNAG98
	 hJdCp5427EdH7DqOcTPiqJp1dM0FYpiyGJ8pxI2ZC3Mj7IUrfApfcAZlOeDZq8stW
	 QsLme+55neo6M4vo9O/Dz//j2COMwihjDRDkBE8vUXzEwNTkAVya6PnGcAjPcuT4z
	 NZqQmDwH7YaX4QQrNntlAriN4fuXNDjAyh8A0lzKjPxHL2JTVziBcRGkf0ZkE1ST1
	 tS1nQOE3YLWVg4yyVzLdKBqIcCR8OzOKCKQNBTefvZxaZ5MNaPZuYmLRNUSBB1s/y
	 jJH6E1qOl7s/79ihWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnrh-1uMF151SvJ-00XcJY; Wed, 16
 Jul 2025 11:39:50 +0200
Message-ID: <b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>
Date: Wed, 16 Jul 2025 11:39:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
 <20250716050540.GB1396022@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250716050540.GB1396022@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+sSFekAGa5eL+neoPrVxPrnv63gOKXLWs9tU543hIcKULnsbMja
 kLVVxkM5qsfVuhYg9vukdypQhGGPF+MiPe/zFDs6aR0fz99G4XyxGDqAC6dxucj9cD0gGEB
 OteY9pGCKeypHMvCDPVgPs3xrnNVFHuyF0YnE7HDp7FvVj2a11YD6QKGHGYwZ2jAf3LLegH
 AbrPaHrTWdlb/DnkXlflQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gXTnpalWwyw=;yIlRtvi/MugVPOJGbC3y71s+cA+
 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
 Pg==

On 7/16/25 7:05 AM, Jeff King wrote:
> On Tue, Jul 15, 2025 at 04:51:07PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> pop_most_recent_commit() calls commit_list_insert_by_date(), which and
>> is itself called in a loop, which can lead to quadratic complexity.
>> Replace the commit_list with a prio_queue to ensure logarithmic worst
>> case complexity and convert all three users.
>=20
> I guess I'm cc'd because of my frequent complains about the quadratic
> nature of our commit lists? :)

And because you introduced prio_queue.

> Mostly I asked because I had to look at pop_most_recent_commit() to see
> what operation would be made faster here. Looks like it's mostly ":/",
> but maybe also fetch's mark_recent_complete_commits()? I guess we might
> hit that if you have a huge number of refs?

The :/ handling was the easiest to test for me.  fetch_pack() and
walker_fetch() require some server side to set up, which seems not worth
it just to demonstrate quadratic behavior.  Having thousands of refs
would make the list long enough to notice, as would having lots of
merges.

My general idea is to get rid of commit_list_insert_by_date() eventually
to avoid quadratic complexity.

> I actually have a series turning rev_info.commits into a prio_queue
> which I need to polish up (mostly just writing commit messages; I've
> been running with it for almost 2 years without trouble). Ironically it
> does not touch this spot, as these commit lists are formed on their own.

That is not a coincidence.  I had a look at that series and tried to
reach its goals while keeping rev_info.commits a commit_list.  Why?
Mostly being vaguely uncomfortable with prio_queue' memory overhead,
lack of type safety and dual use as a stack.  I still used it, but only
as local variable, not in the central struct rev_info.

Anyway, I failed; revision.c::get_revision_1() took an 8% performance
hit in my versions and none in yours, and I couldn't figure out why.
Perhaps I should revisit it with the new prio_queue_replace() in hand,
hmm..  For now I try to salvage the commit_list_insert_by_date()
replacement work outside of revision.c from that effort.=20

> The patch itself looks reasonable. I think here:
>=20
>> @@ -1461,7 +1462,7 @@ static int get_oid_oneline(struct repository *r,
>>  			   const char *prefix, struct object_id *oid,
>>  			   const struct commit_list *list)
>>  {
>> -	struct commit_list *copy =3D NULL, **copy_tail =3D &copy;
>> +	struct prio_queue copy =3D { compare_commits_by_commit_date };
>>  	const struct commit_list *l;
>>  	int found =3D 0;
>>  	int negative =3D 0;
>> @@ -1483,9 +1484,9 @@ static int get_oid_oneline(struct repository *r,
>> =20
>>  	for (l =3D list; l; l =3D l->next) {
>>  		l->item->object.flags |=3D ONELINE_SEEN;
>> -		copy_tail =3D &commit_list_insert(l->item, copy_tail)->next;
>> +		prio_queue_put(&copy, l->item);
>>  	}
>> -	while (copy) {
>> +	while (copy.nr) {
>>  		const char *p, *buf;
>>  		struct commit *commit;
>>  		int matches;
>=20
> our callers are always generating and passing in a list. So we could
> avoid the overhead of allocating the list in the first place by just
> taking a prio_queue. But maybe it gets weird with clearing the
> ONELINE_SEEN marks? We make a copy even in the current code so that we
> can call clear_commit_marks() on the complete set.
>=20
> I guess we could add them to an array or something, but that probably
> ends up being roughly the same amount of work.
Right, if get_oid_oneline() gets handed a prio_queue, it would need to
copy all commits to a list or array for marks clearing at the end.  I
don't see a way around having both.  And I doubt there would be much of
a difference between list and array here, but could be convinced by
numbers. ;)

>> +build_history () {
>> +	local max_level=3D"$1" &&
>> +	local level=3D"${2:-1}" &&
>> +	local mark=3D"${3:-1}" &&
>> +	if test $level -eq $max_level
>> +	then
>> +		echo "reset refs/heads/master" &&
>> +		echo "from $ZERO_OID" &&
>> +		echo "commit refs/heads/master" &&
>> +		echo "mark :$mark" &&
>> +		echo "committer C <c@example.com> 1234567890 +0000" &&
>> +		echo "data <<EOF" &&
>> +		echo "$mark" &&
>> +		echo "EOF"
>> +	else
>> +		local level1=3D$((level+1)) &&
>> +		local mark1=3D$((2*mark)) &&
>> +		local mark2=3D$((2*mark+1)) &&
>> +		build_history $max_level $level1 $mark1 &&
>> +		build_history $max_level $level1 $mark2 &&
>> +		echo "commit refs/heads/master" &&
>> +		echo "mark :$mark" &&
>> +		echo "committer C <c@example.com> 1234567890 +0000" &&
>> +		echo "data <<EOF" &&
>> +		echo "$mark" &&
>> +		echo "EOF" &&
>> +		echo "from :$mark1" &&
>> +		echo "merge :$mark2"
>> +	fi
>> +}
>=20
> This took some brain cycles to decipher. It looks like we'll make
> 2^$level commits in a filled tree? It might be worth a brief comment
> describing the goal (and maybe even giving an example graph drawing for
> N=3D3 or something, though it gets out of hand quickly).

The goal is to have lots of merges, to make the list that
pop_most_recent_commit() works on long (each pop adds back two parents).

The script builds a binary tree of merges, with root commits (without
parents) as leaf nodes.  (The nomenclature is a bit weird because we
call the child nodes parent commits.)  So it creates 2^($level-1) root
commits and 2^($level-1)-1 two-way merges stacked on top.

    _1_
   /   \
  2     3
 / \   / \
4   5 6   7

The numbers are the marks; 1 to 3 are merges (have two parents), 4 to 7
are root commits.

>> +test_perf "rev-parse ':/$(cat needle)'" "
>> +	git rev-parse ':/$(cat needle)' >actual
>> +"
>=20
> Hmm, usually we frown on putting snippets inside double-quotes because
> it's so easy to accidentally interpolate outside of the test_eval. But
> maybe this is short enough to be OK. I guess you did it here especially
> so that the title is a nice ":/65535" and not the opaque "$(cat
> needle)".
The first one allowed me to check whether the setup step created the
expected number of commits and seems kind of interesting for people
running the test.  The second one could be switched to be evaluated at
test_eval time, but that would make it harder to see that title and
test do the same.  We could strip out the quotes:

   test_perf "rev-parse :/$(cat needle)" '
           git rev-parse :/$(cat needle) >actual
   '

Ren=C3=A9

