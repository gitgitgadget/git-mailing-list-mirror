From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 08:03:11 -0400
Message-ID: <20090914120311.GA17172@sigill.intra.peff.net>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
 <20090914105750.GB9216@sigill.intra.peff.net>
 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 14:03:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnAHA-0006oO-BS
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 14:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbZINMDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 08:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbZINMDK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 08:03:10 -0400
Received: from peff.net ([208.65.91.99]:54944 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbZINMDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 08:03:09 -0400
Received: (qmail 24252 invoked by uid 107); 14 Sep 2009 12:03:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 14 Sep 2009 08:03:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2009 08:03:11 -0400
Content-Disposition: inline
In-Reply-To: <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128450>

On Mon, Sep 14, 2009 at 01:40:02PM +0200, Erik Faye-Lund wrote:

> > I didn't see a patch 1/2, so maybe it impacts this in some way, but by
> > itself, I don't think this patch is a good idea. See below.
> 
> That's odd. It's listed in my git-folder on GMail as sent to the
> mailing-list, but I can't find it in any of the list-archives. They
> were both sent through the same instance of "git send-email". I guess
> I'll just re-send it. It shouldn't affect this patch directly, though.

Possibly it got swallowed by vger's list filter. The taboo list is here:

  http://vger.kernel.org/majordomo-taboos.txt

> > I think the right solution to turn on NORETURN for (2) is to split it
> > into two cases: NORETURN and NORETURN_PTR. Gcc platforms can define both
> > identically, platforms under (2) above can define NORETURN_PTR as empty,
> > and (3) will keep both off.
> 
> Yeah, this could work. I initially suggested doing this, but Junio
> suggested removing NORETURN all together. I didn't think that was a
> good idea for die() etc, thus this patch.

Doing it this way would keep warnings on compilers that could use them.
I am generally of the opinion that since most development happens on
gcc, it is "good enough" to let gcc warnings help us find broken code,
and then those fixes will be available to users of less-capable
compilers. And we don't have to bend over backwards in the code with
little hacks to trick all compilers into not issuing a warning (like
calling abort() after something we already know is going to exit).

The downside of that attitude is that code that is not exercised by gcc
builds does not get the benefit. And in the case of MSVC, there is
probably quite a bit of code in #ifdef's that gcc will never even parse.
So maybe a hack like abort() is worthwhile in this case.

> > #include <stdlib.h>
> > void (*exit_fun)(int) = exit;
> > static void die(void) __attribute__((__noreturn__));
> > static void die(void) { exit_fun(1); }
> > int main(void) { die(); }
> 
> Well, it fails to compile ;)
> 
> If your change it around this way (which is basically what 1/2 + a
> separate patch that is cooking in msysgit for a litte while longer is
> supposed to do), it does compiles without warnings even on the highest
> warning level:
> 
> -static void die(void) __attribute__((__noreturn__));
> +static void __declspec(noreturn) die(void);

Hmm. So either it doesn't bother checking that noreturn functions don't
return, or it assumes that a function pointer may exit.  Interesting,
but I guess it doesn't change the main point too much: it's not as
strict as gcc's checking.

> Yeah. So we need a portable (enough) way of showing it that it does
> die. How about abort()?
> 
> -static void die(void) { exit_fun(1); }
> +static void die(void) { exit_fun(1); abort(); }
> 
> Adding abort() makes the warning go away here, at least. And reaching
> this point is an error anyway, it means that one of the functions
> passed to set_die_routine() does not hold up it's guarantees. Your
> suggestion (double defines) would make this a compile-time warning
> instead of a run-time error, which I find much more elegant. However,
> it's questionable how much this means in reality - there's only two
> call-sites for set_die_routine() ATM. Do we expect it to grow a lot?

No, I don't think we expect it to grow. Mostly this is about documenting
our assumptions so that gcc can do the right thing in making die() a
noreturn function, which is what we actually care about. We would notice
very quickly, I think, if a die() handler did not actually exit.

I think I am fine doing it either way. The NORETURN_PTR thing is a bit
more elegant to me, but that is maybe just my gcc snobiness. We
shouldn't have to change our code to accomodate MSVC's crappy noreturn
handling. ;)

-Peff
