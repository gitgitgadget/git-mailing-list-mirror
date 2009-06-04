From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add strerror(errno) to die() calls where applicable
Date: Thu, 4 Jun 2009 16:32:39 -0400
Message-ID: <20090604203239.GA17478@sigill.intra.peff.net>
References: <8df45fb3586160fa5c47af39d2a7eb2b8d405a3c.1243978065.git.trast@student.ethz.ch> <20090603015503.GA14166@coredump.intra.peff.net> <2325a7950906031855t1977448lbb1c8aa671c72f3d@mail.gmail.com> <2325a7950906031858oed495d0x406ea375ff08eb28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 22:32:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCJcI-0007v8-0d
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 22:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbZFDUck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 16:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbZFDUcj
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 16:32:39 -0400
Received: from peff.net ([208.65.91.99]:39395 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbZFDUcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 16:32:39 -0400
Received: (qmail 809 invoked by uid 107); 4 Jun 2009 20:32:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 04 Jun 2009 16:32:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2009 16:32:39 -0400
Content-Disposition: inline
In-Reply-To: <2325a7950906031858oed495d0x406ea375ff08eb28@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120707>

On Thu, Jun 04, 2009 at 05:58:14AM +0400, Alexander Potashev wrote:

> I was also thinking (about 1 month ago) about a helper function
> similar to your 'diesys', but I never thought that adding yet another
> "backend" function (diesys_routine) is reasonable.
> 
> Following your approach, you will need to add 'set_diesys_routine' and
> call it along with 'set_die_routine' (however, if you want to use
> 'diesys', but there are several places in 'daemon.c' and
> 'fast-import.c' where 'die' is being used to write 'strerror(errno)').

Yeah, I didn't look into who is actually using set_die_routine, but
adding another routine like this makes it a lot more annoying for
git-daemon to use it. So I think your approach is probably better,
though I have a few comments on the patch itself (which I'll put in the
next mail).

-Peff

PS Actually, the nicest interface IMHO would be a variadic macro
like:

  #define diesys(fmt, ...) die(fmt ": %s", __VA_ARGS__, strerror(errno))

but that requires a c99 compiler, which we otherwise do not need.
