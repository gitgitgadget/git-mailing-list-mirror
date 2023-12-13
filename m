Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E557BD
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 00:01:45 -0800 (PST)
Received: (qmail 24037 invoked by uid 109); 13 Dec 2023 08:01:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Dec 2023 08:01:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25186 invoked by uid 111); 13 Dec 2023 08:01:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Dec 2023 03:01:44 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Dec 2023 03:01:43 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: AtariDreams via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	AtariDreams <83477269+AtariDreams@users.noreply.github.com>,
	Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Message-ID: <20231213080143.GA1684525@coredump.intra.peff.net>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bea38fe-38a3-412a-b189-541a6596d623@web.de>

On Tue, Dec 12, 2023 at 11:30:03PM +0100, René Scharfe wrote:

> Am 12.12.23 um 21:09 schrieb Jeff King:
> > On Tue, Dec 12, 2023 at 05:17:47PM +0000, AtariDreams via GitGitGadget wrote:
> >
> >> diff --git a/diff.c b/diff.c
> >> index 2c602df10a3..91842b54753 100644
> >> --- a/diff.c
> >> +++ b/diff.c
> >> @@ -1191,7 +1191,7 @@ static void mark_color_as_moved(struct diff_options *o,
> >>  							    &pmb_nr);
> >>
> >>  			if (contiguous && pmb_nr && moved_symbol == l->s)
> >> -				flipped_block = (flipped_block + 1) % 2;
> >> +				flipped_block ^= 1;
> >>  			else
> >>  				flipped_block = 0;
> >
> > This one I do not see any problem with changing, though I think it is a
> > matter of opinion on which is more readable (I actually tend to think of
> > "x = 0 - x" as idiomatic for flipping).
> 
> Did you mean "x = 1 - x"?

Oops, yes, of course. I'm not sure how I managed to fumble that.

> I don't particular like this; it repeats x and seems error-prone. ;-)

Yes. :)

Without digging into the code, I had just assumed that flipped_block was
used as an array index. But it really is a boolean, so I actually think
"flipped_block = !flipped_block" would probably be the most clear (but
IMHO not really worth the churn).

> Can we salvage something from this bikeshedding exercise?  I wonder if
> it's time to use the C99 type _Bool in our code.  It would allow
> documenting that only two possible values exist in cases like the one
> above.  That would be even more useful for function returns, I assume.

Hmm, possibly. I guess that might have helped my confusion, and I do
think returning bool for function returns would help make their meaning
more clear (it would help distinguish them from the usual "0 for
success" return values).

I don't even know that we'd need much of a weather-balloon patch. I
think it would be valid to do:

  #ifndef bool
  #define bool int

to handle pre-C99 compilers (if there even are any these days). Of
course we probably need some conditional magic to try to "#include
<stdbool.h>" for the actual C99. I guess we could assume C99 by default
and then add NO_STDBOOL as an escape hatch if anybody complains.

-Peff
