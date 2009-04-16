From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Thu, 16 Apr 2009 05:41:55 -0400
Message-ID: <20090416094154.GA30479@coredump.intra.peff.net>
References: <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de> <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net> <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de> <20090416083443.GA27399@coredump.intra.peff.net> <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 11:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuO8A-0005KW-Le
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 11:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZDPJmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 05:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbZDPJmE
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 05:42:04 -0400
Received: from peff.net ([208.65.91.99]:48441 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbZDPJmC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 05:42:02 -0400
Received: (qmail 1517 invoked by uid 107); 16 Apr 2009 09:42:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 05:42:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 05:41:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116689>

On Thu, Apr 16, 2009 at 11:25:08AM +0200, Johannes Schindelin wrote:

> > This feels very hack-ish to me, but perhaps this is a case of "perfect
> > is the enemy of the good".
> 
> I have a strong feeling that none of our diff/rev options can sanely take 
> a parameter looking like "--defaults" or "--no-defaults".
> 
> But I do not have the time to audit the options.  Maybe you have?

Right now, I think we are safe. A few options like "--default" do take a
separated string argument, but saying "--default --no-defaults" seems a
little crazy to me (besides being confusing because they are talking
about two totally unrelated defaults).

Most of the string-taking options require --option=<arg> and don't
support the separated version. If the code were ever parseopt-ified,
they would start to support "--option <arg>"; however, at that time we
should be able to write an "I know about these parseopt options, but
please ignore them according to what we know about them taking an
argument" function.

The one I would worry most about is "-S" since "-S--no-defaults" is a
very reasonable thing to ask for. Right now its argument _must_ be
connected. To be consistent with other git options, "-S --no-defaults"
_should_ be the same thing. But we can perhaps ignore that because:

  1. That might never happen, because it breaks historical usage. IOW,
     it changes the meaning of "git log -S HEAD" to something else.

  2. If it does happen, it is likely to be in a transition to parseopt,
     which would fall under the case mentioned above.

I think the biggest danger is that it is a potential bomb for somebody
to add a new revision option which takes an arbitrary string. They
would probably need to keep it as "--option=<arg>" only.

-Peff
