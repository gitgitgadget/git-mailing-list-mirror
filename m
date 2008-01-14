From: Jeff King <peff@peff.net>
Subject: valgrind test scripts (was Re: [PATCH] Teach remote...)
Date: Mon, 14 Jan 2008 07:16:15 -0500
Message-ID: <20080114121615.GC12723@coredump.intra.peff.net>
References: <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801141202240.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 13:16:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEOFD-0002gB-Df
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 13:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbYANMQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 07:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbYANMQS
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 07:16:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3485 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865AbYANMQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 07:16:17 -0500
Received: (qmail 6427 invoked by uid 111); 14 Jan 2008 12:16:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 14 Jan 2008 07:16:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2008 07:16:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801141202240.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70457>

On Mon, Jan 14, 2008 at 12:18:13PM +0100, Johannes Schindelin wrote:

> >  * test scripts to use valgrind (Jeff King, but there was another
> >    one in the past -- can their efforts compared and coordinated
> >    better?).
> 
> Yes, that was written in Perl by Christian Couder:
> 
> http://article.gmane.org/gmane.comp.version-control.git/69236
> 
> Peff's version does not need Perl, and is better integrated with the 
> testsuite (via the new option -m).  Christian's version parses the output, 
> and might therefore be nicer to look at.

I don't think parsing is necessary. Christian's version counts the
errors, whereas I just barf if valgrind has mentioned any errors. And
using the '-q' output of valgrind means the output is fairly cleaned up.

But of course the main difference is that I tried to integrate into the
test scripts, and stop running as soon as any errors are found.

> However, I think that both versions do not account for scripts, and I 
> imagine that going through Git.pm and git-sh-setup is necessary for that.

Both versions use the 'alias' approach. A more comprehensive approach
would be something like:

  mkdir wrapper-bin
  cat >wrapper-bin/git <<EOF
  ...
  EOF
  chmod 755 wrapper-bin/git
  for i in $GIT_PROGRAMS; do
    ln -s git wrapper-bin/git-$i
  done
  PATH=$PWD/wrapper-bin:$PATH

which should get all git calls (though we should probably not wrap
"git-foo" if git-foo is a script (or we should convert it to "git
foo") since I have no desire to valgrind bash or perl).

> Also, it might be a good idea to be able to provide extra arguments, such 
> as "--attach-db=yes".

Yes. I suspect some people will need to add custom suppression files
depending on their platform, as well.

> Post 1.5.4, definitely.

Agreed.

-Peff
