Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD4154BF9
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817738; cv=none; b=oMa/Jhvi0ZmjjGQYZZ/aUh6k54RZofZe86X28nSki9ovmqIxAUvUAXu+hqPSis+59PgylBe/n+h3KOnUkmaZi65OIoboZTcznhKMT/RqSDYZfquAP/sDwjwdvU4du02Ps8bl5jDfoc0PpokEjJA6o8m8h5MNUGEbwhiUP8ZwOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817738; c=relaxed/simple;
	bh=g/uo/TiD+C6c+bFnYCFXBQgptmluz5IY8zyBuuyLY18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DN/piCzB0a2eorZE7hTEiBqiogG/zp9vAmbODP9AMTd6JmUPOqOB4Qqrf6owuhwA8bk+20RTXys7acXt1WYL+CFIrBqxjQfxjs3BZWXgzr1y3DesMmS8F4+W7WhTbzoK9yPSrbNDa49/cpxKzMAf+voxgmeiDIV9i1IUUg7/OQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QQSBxA0T; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QQSBxA0T"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B5D3224DF2;
	Mon, 22 Apr 2024 16:28:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g/uo/TiD+C6c+bFnYCFXBQgptmluz5IY8zyBuu
	yLY18=; b=QQSBxA0TEohQTLTM/yvGz7YCYPCYx6S/A7LCR7JEruEAisqBYHI8Wq
	q7yWL4WhdyfSqFY38wZxVr5cZib/XfodUp6vk0R7+5lNrzZiYpRuzTRGgKC5jIqC
	D5eWs7C1pPnRmnMRm54mulMt111x7+SFzIt1DyzE3TIqqH41BlMiU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AD88924DF1;
	Mon, 22 Apr 2024 16:28:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0968024DF0;
	Mon, 22 Apr 2024 16:28:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  rsbecker@nexbridge.com,
  phillip.wood@dunelm.org.uk,  Kyle Lippincott <spectral@google.com>,  Josh
 Steadmon <steadmon@google.com>,  Emily Shaffer <nasamuffin@google.com>,
  Enrico Mrass <emrass@google.com>
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
In-Reply-To: <20240422162617.308366-1-calvinwan@google.com> (Calvin Wan's
	message of "Mon, 22 Apr 2024 16:26:17 +0000")
References: <20240422162617.308366-1-calvinwan@google.com>
Date: Mon, 22 Apr 2024 13:28:51 -0700
Message-ID: <xmqqpluhuoos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EF63EC9C-00E6-11EF-BB42-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Calvin Wan <calvinwan@google.com> writes:

Thanks for writing this down.

> The first idea involves turning `strbuf_grow()` into a wrapper function
> that invokes its equivalent library function, eg.
> `libgit_strbuf_grow()`:
>
> int libgit_strbuf_grow(struct strbuf *sb, size_t extra)
> {
> 	int new_buf = !sb->alloc;
> 	if (unsigned_add_overflows(extra, 1) ||
> 	    unsigned_add_overflows(sb->len, extra + 1))
> 		return -1;
> 	if (new_buf)
> 		sb->buf = NULL;
> 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> 	if (new_buf)
> 		sb->buf[0] = '\0';
>         return 0;
> }
>
> void strbuf_grow(struct strbuf *sb, size_t extra)
> {
>         if (libgit_strbuf_grow(sb, extra))
>                 die("you want to use way too much memory");
> }
>
> (Note a context object could also be added as a parameter to
> `libgit_strbuf_grow()` for error messages and possibly global variables.)
>
> In this scenario, we would be exposing `libgit_strbuf_grow()` to
> external consumers of the library, while not having to refactor internal
> uses of `strbuf_grow()`.

Yes, this is how I envision the things will go.  And it is a good
place to STOP for "git" the command line program everybody knows for
the past 20 years.  It is good that you mentioned the "context"
here, too.  As to the naming, I am OK with "libgit_".  Just wanted
to say that "libgit2" does not seem to use it as their prefix (and
they do not use "libgit2_" as their prefix, either) so if somebody
wants to bikeshed, they do not have to worry about them.

> This method would reduce initial churn within
> the codebase, however, we would want to eventually get rid of
> `strbuf_grow()` and use `libgit_strbuf_grow()` internally as well. 

The "however" and everything that follows wants justification.

I think after we pass the "Traditional API git offered are thin
wrappers around git-std-lib" point, the returns (the "clean-up"
value) will quickly diminish.  Even with diminished returns, there
may still be "clean-up" value left, but it would be simpler to
consider that as outside the scope of "libification" discussion.
Once the "Traditional API are thin wrappers" state is achieved, the
"libification" is done.

> The second idea removes the need for two different functions by removing
> the wrapper function and instead refactoring all callers of
> `strbuf_grow()` (and subsequently callers of other library functions).
> ...
> One shortcoming of this approach is the need to refactor all callers of
> library functions, but that can be handled better and the churn made

There is one huge downside you did not mention.

The appraoch makes "git the command line program" to commit to the
"errors must percolate all the way up to the top", and the
addditional effort to take us there after we have achieved the
libification goals has dubious trade-off.

I do not see why it bothers you, the libification person when he
wears git-std-lib hat, that "git the command line program" that is a
mere one of customers of git-std-lib happens to have a function
whose name is strbuf_grow() and uses libgit_strbuf_grow().  It
shouldn't bother you more than "git the command line program" having
a program called cmd_show() that uses many functions from libgit_
suite.  After we reach the "our implementation of traditional API
are all wrappers around git-std-lib API functions" [*] state, we may
decide to refactor further and may replace those "wrappers" with
direct calls, but that can happen far in the future, when the
libified result is rock solid.

If you try to do everything from the top to bottom at once, you
cannot easily keep the system (the combination of git-std-lib still
work-in-progress plus the client code that is "git the command line
program") as solid as the first approach.
