From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Thu, 6 Mar 2014 16:28:36 -0500
Message-ID: <20140306212835.GA11743@sigill.intra.peff.net>
References: <20140305003639.GA9474@sigill.intra.peff.net>
 <5316D922.9010501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:28:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLfqM-0001hs-8S
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 22:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbaCFV2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 16:28:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:34356 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751548AbaCFV2h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 16:28:37 -0500
Received: (qmail 403 invoked by uid 102); 6 Mar 2014 21:28:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 15:28:37 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 16:28:36 -0500
Content-Disposition: inline
In-Reply-To: <5316D922.9010501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243557>

On Wed, Mar 05, 2014 at 08:58:26AM +0100, Johannes Sixt wrote:

> Here is a patch that I'm carrying around since... a while.
> What do you think?
> 
> The pattern I chose also catches variable definition, not just
> functions. That is what I need, but it hurts grep --function-context
> That's the reason I didn't forward the patch, yet.

If by variable definition you mean:

   struct foo bar = {
  -       old
  +       new
   };

I'd think that would be covered by the existing "struct|class|enum".
Though I think we'd want to also allow keywords in front of it, like
"static". I suspect the original was more meant to find:

   struct foo {
  -old
  +new
   };

> The parts of the pattern have the following flaws:
> 
> - The first part matches an identifier followed immediately by a colon and
>   arbitrary text and is intended to reject goto labels and C++ access
>   specifiers (public, private, protected). But this pattern also rejects
>   C++ constructs, which look like this:
> 
>     MyClass::MyClass()
>     MyClass::~MyClass()
>     MyClass::Item MyClass::Find(...

Makes sense. I noticed your fix is to look for end-of-line or comments
afterwards.  Would it be simpler to just check for a non-colon, like:

  !^[ \t]*[A-Za-z_][A-Za-z_0-9]*:($|[^:])

> - The second part matches an identifier followed by a list of qualified
>   names (i.e. identifiers separated by the C++ scope operator '::')
> [...]

A tried to keep the "looks like a function definition" bit in mine, and
yours loosens this quite a bit more. I think that may be OK. That is, I
do not think there is any reason for somebody to do:

    void foo() {
    call_to_bar();
   -old
   +new
    }

That is, nobody would put a function _call_ without indentation. If
something has alphanumerics at the left-most column, then it is probably
interesting no matter what.

> - The third part of the pattern finally matches compound definitions. But
>   it forgets about unions and namespaces, and also skips single-line
>   definitions
> 
>     struct random_iterator_tag {};
> 
>   because no semicolon can occur on the line.

I don't see how that is an interesting line. The point is to find a
block that is surrounding the changes, but that is not surrounding
the lines below.

> Notice that all interesting anchor points begin with an identifier or
> keyword. But since there is a large variety of syntactical constructs after
> the first "word", the simplest is to require only this word and accept
> everything else. Therefore, this boils down to a line that begins with a
> letter or underscore (optionally preceded by the C++ scope operator '::'
> to accept functions returning a type anchored at the global namespace).
> Replace the second and third part by a single pattern that picks such a
> line.

Yeah, this bit makes sense to me.

Both yours and mine will find the first line here in things like:

   void foo(void);
  -void bar(void);
  +void bar(int arg);

but I think that is OK. There _isn't_ any interesting surrounding
context here. The current code will sometimes come up with an empty
funcline (which is good), but it may just as easily come up with a
totally bogus funcline in a case like:

   void unrelated(void)
   {
   }

   void foo(void);
  -void bar(void);
  +void bar(int arg);

So trying to be very restrictive and say "that doesn't look like a
function" does not really buy us anything (and it creates tons of false
negatives, as you documented, because C++ syntax has all kinds of crazy
stuff).

_If_ the backwards search learned to terminate (e.g., seeing the "^}"
line and saying "well, we can't be inside a function"), then such
negative lines might be useful for coming up with an empty funcname
rather than the bogus "void foo(void);". But we do not do that
currently, and I do not think it is that useful (the funcname above is
arguably just as or more useful than an empty one).

-Peff
