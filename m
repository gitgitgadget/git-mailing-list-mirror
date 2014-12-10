From: Jeff King <peff@peff.net>
Subject: Re: Git's configure script --mandir doesn't work
Date: Wed, 10 Dec 2014 14:55:09 -0500
Message-ID: <20141210195509.GB22969@peff.net>
References: <20141204232532.GB14036@SDF.ORG>
 <20141205093619.GE32112@peff.net>
 <20141210194150.GA28190@SDF.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Fisher <sfisher@SDF.ORG>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:55:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XynLz-00065d-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 20:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031AbaLJTzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 14:55:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:51228 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932354AbaLJTzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 14:55:12 -0500
Received: (qmail 24402 invoked by uid 102); 10 Dec 2014 19:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 13:55:11 -0600
Received: (qmail 12321 invoked by uid 107); 10 Dec 2014 19:55:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 14:55:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 14:55:09 -0500
Content-Disposition: inline
In-Reply-To: <20141210194150.GA28190@SDF.ORG>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261242>

On Wed, Dec 10, 2014 at 12:41:50PM -0700, Stephen Fisher wrote:

> I'm executing ./configure --mandir=/usr/local/man --disable-pthreads 
> then gmake and gmake install.  I'm using gmake (GNU make) because I get 
> Makefile errors with the regular BSD make, but that's another issue.

You have to build git with GNU make; there are several GNU-isms in the
Makefile.

> I'm disabling pthreads because there is a linking error for undefined 
> references to a few functions (I probably need to pass -lpthread in 
> LDFLAGS, but haven't tried that yet).

We should link against -lpthread automatically unless pthreads are
disabled. So that may be an issue worth investigating.

> I noticed text files in Documentation/ that look like the content of man 
> pages, and when I run gmake in that directory, I get an error about 
> asciidoc missing to make an HTML file.  Is asciidoc required for the man 
> pages as well?

Yes, you need asciidoc to build the manpages. However, there is a "make
quick-install-man" target which will install pre-formatted manpages.
You'll need to:

  git clone git://git.kernel.org/pub/scm/git/git-manpages.git

next to your git.git clone. If you are installing from tarballs, I think
there are manpage tarballs on kernel.org, as well.

> I don't see any files that appear to be man page format 
> other than in perl/blib/man3 and those are installed (but not under the 
> mandir prefix, rather the default /usr/local/share/man prefix).

It sounds like the manpage install bailed due to asciidoc failing. So
the remaining bug is that the perl Makefile does not respect $(mandir).
That does not surprise me too much. We use perl's MakeMaker to build that
Makefile, and it looks like we just pass in the prefix, not individual
paths.

-Peff
