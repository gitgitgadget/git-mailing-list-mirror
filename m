From: Jeff King <peff@peff.net>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 07:47:26 -0400
Message-ID: <20090616114726.GA4343@coredump.intra.peff.net>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 13:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGX8Y-000438-K8
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 13:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbZFPLr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 07:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755470AbZFPLr1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 07:47:27 -0400
Received: from peff.net ([208.65.91.99]:40552 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbZFPLr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 07:47:27 -0400
Received: (qmail 3957 invoked by uid 107); 16 Jun 2009 11:49:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 07:49:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 07:47:26 -0400
Content-Disposition: inline
In-Reply-To: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121674>

On Mon, Jun 15, 2009 at 06:37:21PM -0700, John Bito wrote:

> Running Git 1.6.1 on Solaris 10, git diff seems to go into a loop -
> consuming CPU and producing no output after a little bit.  While the
> repository isn't small, it's not huge (it's
> http://repo.or.cz/w/egit.git). I've tried the following:

I can reproduce the problem on Solaris 8 using git v1.6.3. It seems to
be caused by a horribly slow system regex implementation; it really
chokes on the regex we use to find the "funcname" line for java files. I
tried running "git diff v0.4.0" and it still hadn't finished after 90
seconds. Then I did:

  git config diff.java.xfuncname foo ;# some garbage regex
  git diff v0.4.0

and it completed in about 2.5 seconds.

Can you try that and see if it works around the problem for you?

If anybody wants to look further into the problem, I think it is
specifically triggered by this file (and the built-in xfuncname for java
files):

  $ git clone git://repo.or.cz/egit.git
  $ git diff v0.4.0 -- \
    org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java

which isn't even all that big a file, but it is either causing some
horrible algorithmic behavior in the regex library, or is outright
sending it into an infinite loop.

I tried building against the code in compat/regex; it completes in a
reasonable amount of time, though it is still noticeably slow. With
system regex, the diff given above doesn't complete in less than 90
seconds (at which I get bored and kill it). With compat/regex, it
completes in about 2.2 seconds. Disabling the xfuncname, it completes in
0.14 seconds.

So I think it is a viable solution to recommend building against
compat/regex on Solaris, but I think there is still room for improvement
in what we ship in compat/.

-Peff
