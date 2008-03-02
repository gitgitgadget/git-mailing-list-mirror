From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] convert shortlog to use parse_options
Date: Sun, 2 Mar 2008 01:15:42 -0500
Message-ID: <20080302061541.GA3935@coredump.intra.peff.net>
References: <20080301090231.GA16937@coredump.intra.peff.net> <7v8x124wfd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 07:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVhUj-0006g2-9m
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 07:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbYCBGPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 01:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbYCBGPp
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 01:15:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2460 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbYCBGPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 01:15:44 -0500
Received: (qmail 32010 invoked by uid 111); 2 Mar 2008 06:15:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Mar 2008 01:15:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Mar 2008 01:15:42 -0500
Content-Disposition: inline
In-Reply-To: <7v8x124wfd.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75728>

On Sat, Mar 01, 2008 at 01:37:26AM -0800, Junio C Hamano wrote:

> > The behavior should be identical, except that we now support
> > option bundling (e.g., "git shortlog -nse").
> 
> Sorry, but this breaks
> 
> 	git shortlog -n -s -e --no-merges v1.5.4..

I didn't test this very extensively (obviously!) since it was just a
respin of an old patch. Sorry to waste your time with something that is
so obviously broken.

I started to write a patch to give parse-options a "stop processing at
the first unknown option" flag, but it was very unsatisfactory.
Specifically:

  - the final parser has to know that it's the last, and complain about
    unrecognized options. In this case, setup_revisions would be the
    second and final parser, and it of course doesn't do this (though
    perhaps one could check the residual options from setup_revisions
    manually and barf on that)

  - the fact that we have two sets of parsed options can't be
    transparent to the user. We'd stop at "--no-merges", which means you
    can't say "git shortlog --no-merges -e", which is silly. But we
    can't possibly continue, since we don't know if "-e" is another
    option or an argument there.

And it doesn't work to do the setup_revisions first, since there is a
conflict over the "-n" option (and we can't even munge the result
afterwards, since one version takes an argument and one doesn't).

So I think using parse-options here should be put on hold until we have
the revision and diff parameters in a parseopt-understandable form. I
would think we could do something like:

#define OPT__REVISION(x) \
        OPT_BOOLEAN(0, "no-merges", &(x)->no_merges, "don't show merges"),
        OPT_BOOLEAN(0, "boundary", &(x)->boundary, "show boundary commits"),
        ...

and we could have unified options tables. I seem to recall some work
being done in this area early on in the parse-options history, but I
can't seem to find any mention of it in the list archive. Pierre, does
this ring a bell?

-Peff
