From: Jeff King <peff@peff.net>
Subject: Re: Parallel make problem?
Date: Mon, 4 Feb 2008 22:30:20 -0500
Message-ID: <20080205033020.GA2558@coredump.intra.peff.net>
References: <18343.29301.981552.418860@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 04:31:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMEWQ-0004n7-JH
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 04:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbYBEDaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 22:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYBEDaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 22:30:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1315 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbYBEDaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 22:30:24 -0500
Received: (qmail 11234 invoked by uid 111); 5 Feb 2008 03:30:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 04 Feb 2008 22:30:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Feb 2008 22:30:20 -0500
Content-Disposition: inline
In-Reply-To: <18343.29301.981552.418860@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72618>

On Mon, Feb 04, 2008 at 02:15:49PM -0600, Bill Lear wrote:

> I just downloaded 1.5.4 and am building with gnu make, passing the '-j5'
> flag to invoke multiple jobs.  I get the following:
> 
> % make -j5 prefix=/opt/git-1.5.4 all doc info

I'm not sure this will ever be safe because of the recursive make
invocations ('make doc' invokes '$(MAKE) -C Documentation all', which in
turn does an '-include ../GIT-VERSION-FILE' which triggers a 'make -C
../ GIT-VERSION-FILE'; and that's just one of the possible problems). So
you actually have three different makes running, and nothing to prevent
them from clobbering each other if they hit the same file.

> [...]
> make[1]: Entering directory `/home/blear/build/git-1.5.4/Documentation'
> rm -f doc.dep+ doc.dep
> /usr/bin/perl ./build-docdep.perl >doc.dep+
> Writing perl.mak for Git
> make -C ../ GIT-VERSION-FILE
> mv doc.dep+ doc.dep
> make -C ../ GIT-VERSION-FILE
> mv doc.dep+ doc.dep
> mv: cannot stat `doc.dep+': No such file or directory
> [...]

Actually, I think the particular one you're seeing is caused by the two
documentation makes going at once (both 'doc' and 'info' spawn a
recursive make in Documentation).

The solution is to avoid recursive make invocations, which is
potentially a lot of work and not likely to happen.

The workaround, as you have may have figured out already, is:

  make -j5 && make -j5 doc && make -j5 info

which should be equivalently fast, since there's plenty to parallelize
within each target.

-Peff
