From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] .clang-format: introduce the use of clang-format
Date: Wed, 21 Jan 2015 15:45:02 -0500
Message-ID: <20150121204502.GA3287@peff.net>
References: <1421530221-39306-1-git-send-email-artagnon@gmail.com>
 <1421859687-27216-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 21:45:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE29K-0004uL-UK
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 21:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbbAUUpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 15:45:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:36992 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752948AbbAUUpE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 15:45:04 -0500
Received: (qmail 27531 invoked by uid 102); 21 Jan 2015 20:45:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 14:45:04 -0600
Received: (qmail 388 invoked by uid 107); 21 Jan 2015 20:45:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 15:45:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 15:45:02 -0500
Content-Disposition: inline
In-Reply-To: <1421859687-27216-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262767>

On Wed, Jan 21, 2015 at 12:01:27PM -0500, Ramkumar Ramachandra wrote:

> Instead of manually eyeballing style in reviews, just ask all
> contributors to run their patches through [git-]clang-format.

Thanks for mentioning this; I hadn't seen the tool before.

I didn't see it mentioned here, but for those who are also new to the
tool, it has modes both for checking the content itself as well as diffs
(so you are not stuck wading through its reformats of code you didn't
touch).

> +BreakBeforeBraces: Linux
> [...]
> +BreakBeforeBraces: Stroustrup

These seem conflicting. It looks like you added "Stroustrup" to keep the
brace on the line with the "struct" keyword. But this does the wrong
thing for "cuddled else"s like:

  if (...) {
     ...
  } else {
     ...
  }

I don't think clang-format has a mode that expresses our style.

I ran some of my recent patches through clang-format-diff, and it
generated quite a bit of output. Here are a few notes on what I saw.
Feel free to ignore. They are not your problem, but others evaluating
the tool might find it useful (and a few of them might suggest some
settings for .clang-format).

 - It really wants to break function declarations that go over the
   column limit, even though we often do not do so. I think we're pretty
   inconsistent here, and I'd be fine going either way with it.

 - It really wanted to left-align some of my asterisks, like:

     struct foo_list {
       ...
     } * foo, **foo_tail;

   The odd thing is that it gets the second one right, but not the first
   one (which should be "*foo" with no space). Setting:

     DerivePointerAlignment: false
     PointerAlignment: Right

   cleared it up, but I'm curious why the auto-deriver didn't work.

 - It really doesn't like list-alignment, like:

      #define FOO    1
      #define LONGER 2

   and would prefer only a single space between "FOO" and "1". I think
   I'm OK with that, but we have a lot of aligned bits in the existing
   code.

 - It really wants to put function __attribute__ macros on the same line
   as the function. We often have it on a line above (especially it can
   be so long). I couldn't find a way to specify this.

 - I had a long ternary operator broken across three lines, like:

     foo = bar ?
           some_long_thing(...) :
	   some_other_long_thing(...);

   It put it all on one long line, which was much less readable. I set
   BreakBeforeTernaryOperators to "true", but it did nothing. I set it
   to "false", and then it broke. Which seems like a bug. It also
   insisted on indenting it like:

     foo = bar ?
                   some_long_thing(...) :
		   some_other_long_thing(...);

    which I found less readable.

So overall I think it has some promise, but I do not think it is quite
flexible enough yet for us to use day-to-day. I'm slightly dubious that
any automated formatter can ever be _perfect_ (sometimes
human-subjective readability trumps a hard-and-fast rule), but this
seems like it might have some promise. And over other indenters I have
seen:

  1. It's built on clang, so we know the parsing is solid.

  2. It can operate on patches (and generates patches for you to apply!
     You could add a git-add--interactive mode to selectively take its
     suggestions).

Again, thanks for sharing.

-Peff
