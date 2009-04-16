From: Jeff King <peff@peff.net>
Subject: Re: integrating make and git
Date: Thu, 16 Apr 2009 04:26:15 -0400
Message-ID: <20090416082615.GA27365@coredump.intra.peff.net>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com> <alpine.LNX.1.00.0904151148030.19665@iabervon.org> <3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com> <200904151930.32816.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: E R <pc88mxer@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 10:27:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuMwt-0004Kk-7e
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 10:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbZDPI0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 04:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbZDPI0W
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 04:26:22 -0400
Received: from peff.net ([208.65.91.99]:37653 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbZDPI0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 04:26:21 -0400
Received: (qmail 1155 invoked by uid 107); 16 Apr 2009 08:26:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 04:26:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 04:26:15 -0400
Content-Disposition: inline
In-Reply-To: <200904151930.32816.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116686>

On Wed, Apr 15, 2009 at 07:30:32PM +0200, Robin Rosenberg wrote:

> Take a look at ccache. It doesn't use Git, but it uses hashes of source, and
> compiler flags and associates that with the resulting object files, so it
> can avoid compiling. If you are building largs C/C++ (especially C++)
> projects you want it. 

In theory, one could improve something like ccache by asking git the
sha-1 of the file. Since git maintains a cache based on stat info, you
can get away with not looking at the file contents at all (which saves
CPU time in hashing, but also helps a lot when building from a cold
cache).

In practice, this doesn't help because:

  1. ccache looks at more than just the file itself. I believe it
     actually runs it through cpp and hashes that.

  2. People combine ccache with make; if the stat data hasn't changed,
     in most cases, you will skip building before you even get to
     ccache.

But one could probably design a system to replace both ccache and make
that relies on git's fast sha-1 reporting to avoid duplicate work. I
suspect nobody has bothered because make+ccache is "fast enough" that
the added complexity would not be worth it.

-Peff
