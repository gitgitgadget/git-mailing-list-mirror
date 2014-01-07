From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop unnecessary copying in credential_ask_one
Date: Tue, 7 Jan 2014 12:50:09 -0500
Message-ID: <20140107175009.GA19691@sigill.intra.peff.net>
References: <1388624793-5563-1-git-send-email-rctay89@gmail.com>
 <20140102030330.GA10976@sigill.intra.peff.net>
 <20140102073835.GA5431@sigill.intra.peff.net>
 <xmqq7gaiqjzw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:50:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0anF-0002Tv-VE
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbaAGRuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:50:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:56568 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753558AbaAGRuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:50:11 -0500
Received: (qmail 13067 invoked by uid 102); 7 Jan 2014 17:50:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 11:50:10 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 12:50:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7gaiqjzw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240118>

On Thu, Jan 02, 2014 at 11:08:51AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... But the test suite, of course, always uses askpass because it
> > cannot rely on accessing a terminal (we'd have to do some magic with
> > lib-terminal, I think).
> >
> > So it doesn't detect the problem in your patch, but I wonder if it is
> > worth applying the patch below anyway, as it makes the test suite
> > slightly more robust.
> 
> Sounds like a good first step in the right direction.  Thanks.

I took a brief look at adding "real" terminal tests for the credential
code using our test-terminal/lib-terminal.sh setup. Unfortunately, it
falls short of what we need.

test-terminal only handles stdout and stderr streams as fake terminals.
We could pretty easily add stdin for input, as it uses fork() to work
asynchronously.  But the credential code does not actually read from
stdin. It opens and reads from /dev/tty explicitly. So I think we'd have
to actually fake setting up a controlling terminal. And that means magic
with setsid() and ioctl(TIOCSCTTY), which in turn sounds like a
portability headache.

So it's definitely possible under Linux, and probably under most Unixes.
But I'm not sure it's worth the effort, given that review already caught
the potential bug here.

Another option would be to instrument git_terminal_prompt with a
mock-terminal interface (say, reading from a file specified in an
environment variable). But I really hate polluting the code with test
cruft, and it would not actually be testing an interesting segment of
the code, anyway.

-Peff
