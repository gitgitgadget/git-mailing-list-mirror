From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 08:44:28 -0400
Message-ID: <20090914124428.GA9394@coredump.intra.peff.net>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
 <20090914105750.GB9216@sigill.intra.peff.net>
 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
 <20090914120311.GA17172@sigill.intra.peff.net>
 <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 14:44:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnAv9-0002jH-1X
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 14:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbZINMob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 08:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbZINMoa
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 08:44:30 -0400
Received: from peff.net ([208.65.91.99]:46377 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755422AbZINMo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 08:44:29 -0400
Received: (qmail 24402 invoked by uid 107); 14 Sep 2009 12:44:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 14 Sep 2009 08:44:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2009 08:44:28 -0400
Content-Disposition: inline
In-Reply-To: <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128453>

On Mon, Sep 14, 2009 at 02:32:38PM +0200, Erik Faye-Lund wrote:

> Compiling the following code gives a warning about unreachable code,
> so it's clear that msvc doesn't simply ignore the directive. I'm not
> saying that anyone suggested otherwise, I just wanted to know for
> sure.
> 
> #include <stdio.h>
> #include <stdlib.h>
> void (*exit_fun)(int) = exit;
> void __declspec(noreturn) die(void);
> void die(void) { exit_fun(1); }
> int main(void) { printf("hello!\n"); die(); printf("world!\n"); }

Right. What I'm guessing is that it sees the noreturn on die(), but then
doesn't actually look inside die to confirm that the noreturn is upheld.
You could test that with:

#include <stdlib.h>
void __declspec(noreturn) die(void);
void die(void) { }
int main(void) { die(); }

If it doesn't complain, then I am right. If it does, then it is
something magic with the function pointer (presumably it decides that
the function pointer could exit, so it stops the analysis and gives your
code the benefit of the doubt).

> First of all, MSVC is not the only compiler that behaves this way. In
> fact, GCC the only compiler I've found that behaves this way (but I
> must admit, I only tested 4 different compilers, one of which (Comeau)
> does not support noreturn at all AFAICT). That behavior might be
> crappy, but it's not "MSVC's crappy noreturn handling" - it's
> "non-GCC's crappy noreturn handling" :P

Well, OK, I'll accept that. ;)

> The arguments against each solution I see are these:
> - abort() gives a run-time error instead of a compile-time warning, so
> breakage is trickier to detect (on GCC, which seems to be the target
> compiler for the vast majority of git-developers).
> - NORETURN_PTR might be bit big of a hammer for a small problem, as it
> "pollutes" the whole git source-tree instead of just usage.c.

I don't know that NORETURN_PTR pollutes the whole source-tree. At least
no more than NORETURN does. The only functions that will need it are
these two function pointers.

But I think your analysis is generally correct. It's not going to make a
big difference which is chosen.

-Peff
