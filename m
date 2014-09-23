From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Tue, 23 Sep 2014 04:12:25 -0400
Message-ID: <20140923081225.GB11104@peff.net>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
 <xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
 <CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
 <20140923060407.GA23861@peff.net>
 <CAPig+cQmbOs7Xw8wv63mLHfpG13Vo+tR7oLq-5srCcP1QQddnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:13:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWLDa-0007xA-Dt
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 10:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbaIWIMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 04:12:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:50845 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753073AbaIWIM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 04:12:27 -0400
Received: (qmail 6609 invoked by uid 102); 23 Sep 2014 08:12:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 03:12:28 -0500
Received: (qmail 25367 invoked by uid 107); 23 Sep 2014 08:12:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 04:12:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 04:12:25 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQmbOs7Xw8wv63mLHfpG13Vo+tR7oLq-5srCcP1QQddnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257404>

On Tue, Sep 23, 2014 at 03:52:21AM -0400, Eric Sunshine wrote:

> > That is my reading from the warning text, too, but I have to wonder:
> > wouldn't that mean they should be warning about pointer + pointer, not
> > pointer + int?
> 
> 'pointer + pointer' is not legal C, is it? What would the result
> represent? The compiler correctly diagnoses that case as an error
> (without special command-line switches):
> 
>     error: invalid operands to binary expression
>       ('char *' and 'char *')
>       return "a" + "b";
>              ~~~ ^ ~~~

You're correct that it's not legal. My point was more that "pointer +
int" is already clearly not string concatenation, because the operands
are not two strings.

I think the answer here (from the threads you linked below) is that
people expect it to not just concatenate, but also auto-convert integers
to strings. Yeesh.

> > Also, wouldn't the same advice apply to adding to _any_ char pointer,
> > not just a string literal?
> 
> Not really. Indexing into a char array via pointer arithmetic is a
> perfectly reasonable and common idiom in C (indeed, git is peppered
> with it), so such a warning would be pure noise.

That is a good reason not to do the warning in these cases (and why I
hope that we will not have to deal with this further). But IMHO it is
good evidence that the warning is not well thought-out. It seems silly
that:

  x = "foo" + 1;

is bad, but:

  y = "foo";
  x = y + 1;

is not[1]. Saying the first one is rare does not seem like a good
excuse; rather the existence of the second should tip you off that the
idiom is valid and not to be complained about.

Anyway, there is not much point in me complaining further about it here.
You are not the one who introduced it. :)

Thanks for digging in the history. It was interesting at least.

-Peff

[1] Actually, from reading the patch thread, I think the "1" needs to be
    a non-constant integer here. But that just furthers the point: if
    you have to neuter the warning to prevent a ton of false positives,
    that is a good indication that you should not be warning. :)
