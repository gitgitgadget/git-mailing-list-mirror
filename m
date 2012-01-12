From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] diff --word-diff: use non-whitespace regex by default
Date: Thu, 12 Jan 2012 10:22:03 +0100
Message-ID: <87ipkhqnr8.fsf@thomas.inf.ethz.ch>
References: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
	<1326302702-4536-2-git-send-email-rctay89@gmail.com>
	<87lipexawp.fsf@thomas.inf.ethz.ch>
	<CALUzUxo3DcKqC6sQFQ1Oi0vgASFSHCcmOgHAj2_4c3vEjy663w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 10:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlGrd-0006lC-46
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 10:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab2ALJWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 04:22:22 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:14463 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab2ALJWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 04:22:07 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 10:22:03 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 10:22:03 +0100
In-Reply-To: <CALUzUxo3DcKqC6sQFQ1Oi0vgASFSHCcmOgHAj2_4c3vEjy663w@mail.gmail.com>
	(Tay Ray Chuan's message of "Thu, 12 Jan 2012 08:52:49 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188439>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Thu, Jan 12, 2012 at 4:05 AM, Thomas Rast <trast@student.ethz.ch> wrote:
>> Tay Ray Chuan <rctay89@gmail.com> writes:
>>
>>> Factor out the comprehensive non-whitespace regex in use by PATTERNS and
>>> IPATTERN and use it as the word-diff regex for the default diff driver.
>>
>> Why?

Sorry for distracting you with the performance argument; it was mostly
the first thing that came to my mind that I could use to ask for the
motivation, and evaluation of tradeoffs, that both were missing from the
proposed commit message.

> But I think it's worthwhile to trade-off performance for a sensible
> default. Something like
>
>   matrix[a,b,c]
>   matrix[d,b,c]
>
> gives
>
>   matrix[[-a-]{+d+},b,c]
>
> and when we have
>
>   ImagineALanguageLikeFoo
>   ImagineALanguageLikeBar
>
> we get
>
>   ImagineALanguageLike[-Foo-]{+Bar+}

In that case (and I should have read the original patch), I am
definitely against this change.  It turns the default word-diff into
character-diff, which is something entirely different, and frequently
useless precisely for the reason you state:

> (But I cheated. Foo and Bar have no common characters in common; if
> they did, the word diff would be messy.)

Case in point, consider my patch sent out yesterday

  http://article.gmane.org/gmane.comp.version-control.git/188391

It consists of a one-hunk doc update.  word-diff is not brilliant:

  -k::
          Usually the program [-'cleans up'-]{+removes email cruft from+} the Subject:
          header line to extract the title line for the commit log
          [-message,-]
  [-      among which (1) remove 'Re:' or 're:', (2) leading-]
  [-      whitespaces, (3) '[' up to ']', typically '[PATCH]', and-]
  [-      then prepends "[PATCH] ".-]{+message.+}  This [-flag forbids-]{+option prevents+} this munging, and is most
          useful when used to read back 'git format-patch -k' output.
[snip the rest as it's only {+}]

But character-diff tries too hard to find common subsequences:

  $ g show HEAD^^ --word-diff-regex='[^[:space:]]' | xsel
  -k::
          Usually the program [-'cl-]{+remov+}e[-an-]s {+email cr+}u[-p'-]{+ft from+} the Subject:
          header line to extract the title line for the commit log
          message[-,-]
  [-      among which (1) remove 'Re:' or 're:', (2) leading-]
  [-      w-]{+.  T+}hi[-te-]s[-paces, (3) '[' up t-] o[-']', ty-]p[-ically '[PATCH]', and-]t[-he-]{+io+}n pre[-p-]{+v+}en[-ds "[PATCH] ".  This flag forbid-]{+t+}s this munging, and is most
          useful when used to read back 'git format-patch -k' output.
[snip]

Wouldn't you agree that

  w-]{+.  T+}hi[-te-]s[-paces, (3) '[' up t-] o[-']', ty-]p[

is just line noise?  The colors don't even help as most of it is removed
(red).

Regarding your examples

> [1] http://article.gmane.org/gmane.comp.version-control.git/105896
> [2] http://article.gmane.org/gmane.comp.version-control.git/105237

first please notice that both of them were written before (and actually
discussing) the introduction of the wordRegex feature.  At this point,
we were trying to make up our minds w.r.t. how powerful the feature
needs to be.  Nowadays (or in fact, starting a few days after those
emails) the user can easily achieve everything discussed here by setting
the wordRegex to taste.

That being said, I can see some arguments for changing the default to
split punctuation into a separate word.  That is, whereas the current
default is semantically equivalent to a wordRegex of

  [^[:space:]]*

(but has a faster code path) and your proposal is equivalent to

  [^[:space:]]|UTF_8_GUARD

I think there is a case to be made for a default of

  [^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+

or some such.  There's a lot of bikeshedding lurking in the (non)extent
of the [[:alnum:]] here, however.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
