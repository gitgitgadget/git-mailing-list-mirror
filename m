From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Tue, 28 Jun 2011 18:45:16 -0400
Message-ID: <20110628224516.GB4192@sigill.intra.peff.net>
References: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
 <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 00:45:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbh2F-0002ud-ET
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276Ab1F1WpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 18:45:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39045
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab1F1WpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:45:18 -0400
Received: (qmail 11153 invoked by uid 107); 28 Jun 2011 22:45:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Jun 2011 18:45:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2011 18:45:16 -0400
Content-Disposition: inline
In-Reply-To: <7vwrg5u7oz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176427>

On Tue, Jun 28, 2011 at 11:33:48AM -0700, Junio C Hamano wrote:

> > So far progress always uses \r to produce one-line output on stderr.
> > This only produces useful and easy parsable output if stderr is opened
> > on a file which does interpret CR as a real carriage return operation.
> > This patch changes EOL to the plain newline \n control if isatty() is
> > false instead.
> >
> > Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
> 
> I kind of like this patch, in the sense that if there is a sane scenario
> to emit progress to non-tty, we should do just LF not CRLF, but I would
> like to know the real motivation behind this proposal.
> 
> I thought that we try to disable the progress pretty much everywhere when
> we are not talking to a tty, so ugliness coming from many CRLF appearing
> in the cron e-mail shouldn't be the issue.

We certainly do try to turn off progress reporting when stderr isn't a
tty. So unless "--progress" is being given explicitly, seeing it is a
bug that should be fixed.

I'm not sure dropping the CR is a good thing, though. One of the uses
for forcing output to a non-terminal via "--progress", is that something
_else_ is going to parse the output. And that other thing gets useful
information from the carriage returns.

For example, you may be piping into a file or a fifo and running 'tail'
to a terminal on the other end. You want the CR because we are
ultimately going to a terminal.

Another example: you write a GUI wrapper around git that captures and
parses stderr. You show progress and informative messages in a running
dialog. The difference between CR and LF is important. The former means
"clear the progress line and show this new one instead"; the latter
means "keep this on the screen and show more lines".

I'm willing to accept that there are use cases where you don't want the
CRs, but just want a list of lines[1]. But it seems like this change
hurts some existing use cases.

-Peff

[1] Actually, I would be curious to see such a use case. If you are
planning on saving the output, is it really useful to have a hundred
lines saying:

  Compressing objects 1% (100/10000)
  Compressing objects 2% (200/10000)

and so forth?
