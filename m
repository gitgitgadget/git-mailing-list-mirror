Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F537160
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189A92586
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 13:27:04 -0800 (PST)
Received: (qmail 21081 invoked by uid 109); 8 Nov 2023 21:27:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Nov 2023 21:27:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7762 invoked by uid 111); 8 Nov 2023 21:27:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Nov 2023 16:27:05 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Nov 2023 16:27:02 -0500
From: Jeff King <peff@peff.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <20231108212702.GA1586965@coredump.intra.peff.net>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUv3gjjmuqvCaJEd@debian>

On Wed, Nov 08, 2023 at 10:02:52PM +0100, Alejandro Colomar wrote:

> > That seems like a reasonable feature. Probably it should be
> > --cc-from-trailer=signed-off-by, and then you could do the same with
> > other trailers.
> 
> That would work for me.  I only suggested the other one because it's
> aleady in send-email in that form.  But yeah, it might be useful to have
> finer control.  In my case, something that CCs every mail in the trailer
> would work (Reviewed-by, Suggested-by, ...  I want them all, always).

Oh, I didn't realize it existed in send-email. I am showing my ignorance
of it. ;)

> > # spool the message to a fake mbox; we need to add
> > # a "From" line to make it look legit
> > trap 'rm -f to-send' 0 &&
> > {
> >   echo "From whatever Mon Sep 17 00:00:00 2001" &&
> >   cat
> > } >to-send &&
> 
> Would a named pipe work?  Or maybe we could use $(mktemp)?

I suspect mutt wants it to be a real file. But yeah, mktemp would
definitely work. I actually started to write it that way but switched to
a static name for simplicity in demonstrating the idea. :)

One note, though. Later we need to pass this filename to mutt config:

> > mutt -p \
> >   -e 'set postponed=to-send' \

so it's a potential worry if "mktemp" might use a path with spaces or
funny characters (e.g., from $TMPDIR). Probably not much of a problem in
practice, though.

> Huh, this is magic sauce!  Works perfect for what I need.  This would
> need to be packaged to the masses.  :-)
> 
> I found a minor problem: If I ctrl+C within mutt(1), I expect it to
> cancel the last action, but this script intercepts the signal and exits.
> We would probably need to ignore SIGINT from mutt-as-mta.

Yeah, that might make sense, and can be done with trap.

> Would you mind adding this as part of git?  Or should we suggest the
> mutt project adding this script?

IMHO it is a little too weird and user-specific to really make sense in
either project. It's really glue-ing together two systems. And as it's
not something I use myself, I don't plan it moving it further along. But
you are welcome to take what I wrote and do what you will with it,
including submitting it to mutt.

-Peff
