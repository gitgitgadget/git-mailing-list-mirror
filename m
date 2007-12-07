From: Jeff King <peff@peff.net>
Subject: Re: Git and GCC
Date: Fri, 7 Dec 2007 01:38:48 -0500
Message-ID: <20071207063848.GA13101@coredump.intra.peff.net>
References: <20071206071503.GA19504@coredump.intra.peff.net> <alpine.LFD.0.99999.0712060915590.555@xanadu.home> <20071206173946.GA10845@sigill.intra.peff.net> <20071206.193121.40404287.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nico@cam.org, jonsmirl@gmail.com, dberlin@dberlin.org,
	harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Fri Dec 07 07:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Wrl-0007dw-DM
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 07:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbXLGGiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 01:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbXLGGiw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 01:38:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2368 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbXLGGiv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 01:38:51 -0500
Received: (qmail 3084 invoked by uid 111); 7 Dec 2007 06:38:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Dec 2007 01:38:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2007 01:38:48 -0500
Content-Disposition: inline
In-Reply-To: <20071206.193121.40404287.davem@davemloft.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67385>

On Thu, Dec 06, 2007 at 07:31:21PM -0800, David Miller wrote:

> > So it is about 5% bigger. What is really disappointing is that we saved
> > only about 20% of the time. I didn't sit around watching the stages, but
> > my guess is that we spent a long time in the single threaded "writing
> > objects" stage with a thrashing delta cache.
> 
> If someone can give me a good way to run this test case I can
> have my 64-cpu Niagara-2 box crunch on this and see how fast
> it goes and how much larger the resulting pack file is.

That would be fun to see. The procedure I am using is this:

# compile recent git master with threaded delta
cd git
echo THREADED_DELTA_SEARCH = 1 >>config.mak
make install

# get the gcc pack
mkdir gcc && cd gcc
git --bare init
git config remote.gcc.url git://git.infradead.org/gcc.git
git config remote.gcc.fetch \
  '+refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*'
git remote update

# make a copy, so we can run further tests from a known point
cd ..
cp -a gcc test

# and test multithreaded large depth/window repacking
cd test
git config pack.threads 4
time git repack -a -d -f --window=250 --depth=250

-Peff
