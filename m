Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA228465
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393897; cv=none; b=rLsMvxxYjqtQey6VankcWcirXEgIw0xLVa/hwm5VQO4n/s279BrGma25AnZsz1y1C/CRSzbn0YTT+klpe2AhiE7n2hjIlVCOsAo8UFy9dG6RhyJ3ZZPjTY8L7Ap6jXIqF9lbpu2irYf1QN/jrjKs+SJqVFMQll57QicmcKOHlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393897; c=relaxed/simple;
	bh=oIZ0BcNOnUDGD65hbMPvW96wK9FcP86c3Lkkadsz4Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME4iDXy3pVTCrzpqt+ahHoezvU647vzAFxmsfk0Xw/XJ4toEsqgoU4j6sIBpjIp1j13VTC7aQt5Avd9OyD9ykv14XQc5g4yexzBdB9V495otjs4HPzc9wCy+SPFp0E87QyHyNi52uYRMGIo65CgVoLUcvO/VzTvM420KwCQOgAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23240 invoked by uid 109); 20 Feb 2024 01:51:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Feb 2024 01:51:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18529 invoked by uid 111); 20 Feb 2024 01:51:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Feb 2024 20:51:36 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Feb 2024 20:51:33 -0500
From: Jeff King <peff@peff.net>
To: Maarten Bosmans <mkbosmans@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
Message-ID: <20240220015133.GA2713741@coredump.intra.peff.net>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl>
 <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
 <xmqqy1bxiiop.fsf@gitster.g>
 <20240213080014.GB2225494@coredump.intra.peff.net>
 <CA+CvcKR9sH=qZB4oZvX9RWd+4H3Bq8WV_qUOiSj_Tsf=Dr_Xvw@mail.gmail.com>
 <20240215150430.GA3453@coredump.intra.peff.net>
 <CA+CvcKSQCUukfLNnRkmTp=K=aXBRaxQnattfL+QexgOsYX18nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+CvcKSQCUukfLNnRkmTp=K=aXBRaxQnattfL+QexgOsYX18nA@mail.gmail.com>

On Sat, Feb 17, 2024 at 01:45:39PM +0100, Maarten Bosmans wrote:

> > Of the two, I'd guess that the second one is a lot less work to
> > implement (on the Git side; on the reading side it's a little more
> > involved, but still should be a constant number of processes).
> 
> The second one is attractive for another reason than implementation
> simplicity. While the first one offers more flexibility, the second
> reuses the existing cat-file batch format, so the interface between
> git and scripts is familiar and consistent.

Agreed.

> > One variant of the second one is to use "git notes list". For example,
> > you can get all notes via cat-file like this right now:
> >
> >   git notes list |
> >   git cat-file --batch='%(objectname) %(objectsize) %(rest)'
> 
> So the cat-file batch output is suitable for blobs containing newline
> or NUL characters. But I struggle a bit with what would be an easy way
> of using this format in a shell script. Something with multiple read
> and read -N commands reading from the output, I guess.
> The git codebase has `extract_batch_output()` in t1006. This uses a
> separate perl invocation to parse the cat-file output, which confirms
> my suspicion there isn't a straight-forward way to do this in e.g.
> just a bash script.

Yes, you could perhaps do it with "read -N". But note that it is a
bash-ism, and other POSIX shells may not support it. That's one of the
reasons we do not use it in t1006.

Also, I suspect that even bash does not retain NUL bytes in shell
variables. E.g.:

  $ printf '\0foo\0bar\0' | cat -A
  ^@foo^@bar^@

  $ printf '\0foo\0bar\0' | (read -r -N 9 var; echo "var=$var" | cat -A)
  var=foobar$

So pure shell is probably a losing battle if you want to be binary
clean. You might be able to do something like using "read" to get the
header line, and then another tool like "head -c" to read those bytes.
But now you're back to one process per object. Plus depending on the
implementation of "head", it might or might not read more bytes from the
pipe as part of its stdio buffering.

So really, you are probably better off handling the output with a more
capable language (though again, there's not much Git can do here; the
complications are from handling binary data, and not Git's output format
choices).

> That was why my first steps were to accept that a launching a separate
> process per note in a bash loop is a pretty clear and well understood
> idiom in shell scripts and try to make the git part of that a bit more
> efficient.

Yes, I agree it's a simple idiom. And I certainly don't mind any
speedups we can get there, if they don't come with a cost (and your
patches looked pretty reasonable to me, though I didn't read them too
carefully). But I do think anytime you are invoking N+1 processes in a
shell script, it's kind of a losing battle for performance. :)

-Peff
