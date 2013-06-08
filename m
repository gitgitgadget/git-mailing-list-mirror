From: Jeff King <peff@peff.net>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 13:15:13 -0400
Message-ID: <20130608171513.GA28029@sigill.intra.peff.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
 <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
 <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
 <CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
 <CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
 <CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
 <CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
 <CAMP44s192hzh8AWU-Eg1VVVXjZ9qyNqHw99X6y48MXJn3DHw+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 19:15:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlMja-000158-F6
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab3FHRPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 13:15:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:55376 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3FHRPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 13:15:16 -0400
Received: (qmail 11479 invoked by uid 102); 8 Jun 2013 17:16:05 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Jun 2013 12:16:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Jun 2013 13:15:13 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s192hzh8AWU-Eg1VVVXjZ9qyNqHw99X6y48MXJn3DHw+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226842>

On Sat, Jun 08, 2013 at 08:20:28AM -0500, Felipe Contreras wrote:

> > There are a lot of static variables in builtin/ (and outside too),
> > which make it non-entrant, or at least not safe.
> 
> So?
> 
> > fork provides a process space isolation, some depend on that.
> 
> Process space isolation from what?

Manipulation of global variables. Here are a few examples off the top of
my head:

Try running "git diff" from your Ruby hook, then try running "git
diff-files" within the same process. I believe the latter will start
respecting porcelain diff config like diff.mnemonicprefix. To clear
state you need to reset a list of global variables back to their initial
states (some of which are the BSS-default zero, but some of which are
not).

Try running "git log" followed by another "git log". The log family of
commands does not clear its marks from the commit objects, since it
expects to exit after the traversal. The second log will sometimes give
wrong answers if its traversal overlaps with the first (e.g., commits
marked SEEN or UNINTERESTING that should not be). You can add a call to
clear them at the end of the process, but that does not cover any cases
where we die().

These are problems that can be solved. But there is a lot of work
involved in finding these subtle bugs and coming up with fixes. I think
you would be better off working on an implementation of git that was
designed from scratch to work in-process, like libgit2. And it even has
an actively developed and maintained Ruby binding[1].

libgit2 doesn't have feature parity with regular git yet, but there are
many clients based around it that use the library internally for speed,
and then exec regular git to fill in the gaps.

-Peff

[1] https://github.com/libgit2/rugged
