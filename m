From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len" better
Date: Thu, 10 Mar 2011 18:21:36 -0800
Message-ID: <AANLkTinHCsyN4TLBAxzxOn_QAK67VkT1pLgcu7XB0JCD@mail.gmail.com>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop> <20101028075631.GA7690@elte.hu>
 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
 <20101028163854.GA15450@elte.hu> <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
 <7veiba9ev2.fsf@alter.siamese.dyndns.org> <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
 <7vzkp21ocm.fsf@alter.siamese.dyndns.org> <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
 <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Namhyung Kim <namhyung@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 03:22:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxrzQ-0003IW-Hx
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 03:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab1CKCV6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 21:21:58 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59171 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307Ab1CKCV6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 21:21:58 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p2B2LuUQ031715
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 10 Mar 2011 18:21:56 -0800
Received: by iwn34 with SMTP id 34so2174252iwn.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 18:21:56 -0800 (PST)
Received: by 10.42.228.2 with SMTP id jc2mr2517948icb.0.1299810116173; Thu, 10
 Mar 2011 18:21:56 -0800 (PST)
Received: by 10.231.12.10 with HTTP; Thu, 10 Mar 2011 18:21:36 -0800 (PST)
In-Reply-To: <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-104.984 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168878>

On Thu, Mar 10, 2011 at 5:33 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> That 979f79 one already have enough other objects with similar names,=
 so
> compared to 83c3c that doesn't, it is natural that you would need mor=
e
> digits to protect its uniqueness, no? =A0The result shouldn't be affe=
cted by
> the value of "short" as long as it is not long enough, as that is mer=
ely
> specifying "at least this many letters"

Yes, uniqueness in that sense is sane and has a good definition.

But that's _not_ the case when you then randomly add extra <n> digits t=
o it.

Why? Because that <n> is meaningless, because what <n> means depends
on what the base number was. And the base number is different for
different objects.

The case of n=3D0 is special, because it is the "current state". But
what does "n=3D1" mean?

Let me make it more explicit by making an extreme example about this.
It's extreme just because I'm going to assume that the shortest
abbreviation is 1 (in reality it's 4) but that doesn't really change
the math, it just makes the numbers smaller/easier.

So let's say that we have a repository with just 100 objects. What
does that mean? In practical terms, it means that it is not impossible
that you will have some object that is unique in a single digit (yes,
it may be a bit unlikely, but it's not unreasonable), while you'll
have other objects that need three digits. And most will be unique in
two.

Shortening the numbers that way has a _meaning_: the notion of
"unique" is clearly meaningful. Sure, different objects get different
lengths, but the different lengths have a very real reason for them.

So then (again, to make the numbers small, and the math simple), let's
assume abbrevguard=3D1. What does that MEAN?

And I claim that it means something totally _different_ for the
different objects, and that's the crazy thing. Because now we're
talking about possible _future_ objects, but the likely _future_
uniqueness of "unique in one digit" is TOTALLY DIFFERENT from the
future uniqueness of "unique in three digits"!

The single-digit uniqueness is going to be gone _long long_ before the
three-digit uniqueness is gone. Adding a single digit to the object
that currently happens to need only a single-digit unique id will
_not_ do a whole lot of future-proofing - if you add another one
hundred objects, that object may well need three digits to be unique.
But if you add a single digit to the one that currently already needed
three digits, you're likely to need to add an order of magnitude more
objects to need to extend the three digits to four.

See what I'm trying to say? This is why I think abbrevguard is a
broken concept, when it is relative to "how unique is the object now".

If the abbrevguard was related to the maximum number of digits
required for _any_ object in the current repository, it would be
meaningful - it would actually be about the _size_ of the current
repository, and thus indirectly about the size of a future one. But it
isn't. It's always relative to the "local uniqueness", which is only
valid for the *current* state, and has very little to do with future
growth.

Now, to put things in terms of a real repository ("git" itself), and
two extreme cases from it:

 - commit 1dae(0d38b8119de2b67f87e800c860ed958bbed6) currently unique
in four digits

 - commit 979f7929(51913d75f992f87022b75610303a614f) currently unique
in eight digits

and think about what "abbrevguard" means for those two commits.

Let's pick an abbrev-guard of two digits. For the first one, it means
that you use six digits total, and for the second one, you'd use 10
digits total.

What does that mean for future work? How many objects do we need to
add for clashes to start happening?

=46or the first commit, it's _almost certain_ that if you double the
size of the repository, those six digits will no longer be unique. For
the second case? I can pretty much guarantee that EVEN IF you didn't
have any abbrev-guard at all, and you doubled the size of the git
repository, the thing would still be unique in eight digits.

Why? It's simply *much*much* less likely that you'll get future
clashes from new objects in the eight digits. The likelihood of a
clash with the currently unique 4-digit object is 16^4=3D65536 times
higher than a clash with the currently 8-digit unique shortening.

So it's senseless to add an equal number of digits to the two objects.
They simply don't have the same likelihood of future collisions.

So what is mathematically the sensible thing? It's actually to extend
both objects to the _same_ number of digits. It's _more_ sensible to
extend the current four-digit number to eight digits, than it is to
extend the currently unique in eight digits by even a single digit. It
would future-proof things a fair amount, exactly because the
likelihood of future objects clashing with the two objects are totally
different.

That's why I said that it would be sensible to make the abbrevguard be
relative to the current worst-case uniqueness. Because THAT actually
is what is probable. If we currently have a maximum uniqueness
requirement of 8 characters, it is _probable_ that by the time the
project has grown by a factor of 4, we'll need 9 characters (I think,
I may have gotten the math wrong).

But it is somewhat expensive to calculate "max current uniqueness", so
I would suggest ditching the whole notion of "how many extra numbers
do I need for futureproofing", and go for just setting the absolute
value of DEFAULT_ABBREV.

                               Linus
