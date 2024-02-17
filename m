Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616321C292
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708147014; cv=none; b=a0YebdgVxgV19xVa1p8iTvlIi9NgG1Fkx6WUAszbXKlqa044lGbi+dSB/r34pZogDsgNFdc0wW1z2gi7QWyJ/jqivHteb+wUZqI/dB0hLZtlS1YmHiyMAX4gYrrj1YDT/EPfQNRXZzigaUI3Z+7Yc0LfKj5adPePBhYQpTJwQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708147014; c=relaxed/simple;
	bh=q7S8CNbou+E/8Er+ULxTvcFbbDK6XjvHrmDIpWj6JFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNXmDKQHDHeI1fQ8no9/FsCrdOvGdqXOqYWdU9RF/4h+IYc8N/PKGY8OENjoH4UK1fJjRv40+WGjEMK7IP+1nxBPZg1aOI7MOnrfI1raidIg2EK8IXKS2gdbhux9uzUEYJqsjVM07fF5gj36Eq626TS+DNX+NjwYQ/JQ3Bih1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2221 invoked by uid 109); 17 Feb 2024 05:16:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Feb 2024 05:16:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20710 invoked by uid 111); 17 Feb 2024 05:16:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Feb 2024 00:16:54 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Feb 2024 00:16:50 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Maarten Bosmans <mkbosmans@gmail.com>, git@vger.kernel.org,
	Teng Long <dyroneteng@gmail.com>,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
Message-ID: <20240217051650.GB539459@coredump.intra.peff.net>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl>
 <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
 <xmqqy1bxiiop.fsf@gitster.g>
 <20240213080014.GB2225494@coredump.intra.peff.net>
 <xmqq5xys6zdr.fsf@gitster.g>
 <20240215052640.GC2821179@coredump.intra.peff.net>
 <xmqqcysxkjrq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcysxkjrq.fsf@gitster.g>

On Thu, Feb 15, 2024 at 10:25:45PM -0800, Junio C Hamano wrote:

> > Of course it's reasonable to also store notes that aren't meant to be
> > displayed via git-log, etc, at all. The textconv-caching machinery
> > stores its results in a separate notes ref. Those should generally be
> > text (since the point is to come up with something diff-able). But I
> > think it would be perfectly reasonable for another mechanism to make use
> > of notes in the same way and store binary goo.
> 
> Yup.  
> 
> The question is if our current use of "git show" allows creative use
> of such binary data attached as notes.  The patch in question will
> break such users, as it would become impossible once we start
> bypassing the "git show" and emitting the binary data directly to
> the standard output stream.

Hmm, good question. I can't think offhand of a way that the user could
convince "git show <oid>" to do anything different than just dumping the
literal contents. It is not even handed a path that could trigger
.gitattributes or similar.

The only difference I can think of is that "git show" triggers a pager
by default.  Probably "git notes show" should be doing the same (and
honestly, that would be less confusing to me; the fact that configuring
"pager.show" would affect "git notes show" is surprising to me).

Digging in the history, it looks like we use "git show" at all because
this was adapted from a shell script (though that shell script probably
ought to have been using cat-file in the first place; maybe back then we
thought we'd support non-blobs ;) ).

> Because the pathname a note blob is stored at is unpredictable and
> not under end-user control, it would not be practical to define
> different smudge filters per note object using the attribute
> mechanism, but if you limit the types of binary data you store in
> your notes (e.g., refs/notes/thumbnail may be a note ref whose
> contents are all jpeg thumbnail images, where your main history is
> your photo archive), you might be able to convince the "git show"
> invocation we use to show the note object to show that thumbnail
> image by using something involving "display" (from imagemagick---of
> course you could use other programs that allows you to view the
> image on different platforms) in your smudge filter.  Bypassing "git
> show" and sending the blob contents directly to the standard output
> would be a grave regression for such a user.

Like I said, I do not think there is a way to convince "git show" in
that way. Unless perhaps something like:

  git -c pager.show='f() { cat >tmp.jpg; display tmp; }; f' \
    notes show --ref thumbnail

But that's pretty awful. Why would you do that instead of just "git
notes show >tmp; display tmp" yourself? And again, even if we wanted to
support such a monstrosity, I feel like setting pager.notes.show would
be much more intuitive than piggy-backing on "git show".

Sometimes, of course, we have to support weird stuff anyway because it
has existed for a long time and we don't want to break users. But this
is really pushing my gut-feeling limit of what is reasonable / plausible
for somebody to be doing.

Of course I may be missing some other case where "show" behaves in a
useful way that is different than a straight dump of the blob. But if
not, I'd almost say that getting rid of the extra "show" call now is a
good thing, because it locks in the simple behavior. ;)

-Peff
