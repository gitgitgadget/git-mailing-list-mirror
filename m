From: Jeff King <peff@peff.net>
Subject: Re: command return values
Date: Sun, 11 Jul 2010 07:37:33 -0400
Message-ID: <20100711113733.GA19113@coredump.intra.peff.net>
References: <AANLkTimQcqhD8FClAXef5dGAWRDbAGdVBmIVXxotzKoa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Craft <bcboy@thecraftstudio.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 13:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXuxV-000819-RI
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 13:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab0GKLoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 07:44:20 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53424 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab0GKLoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 07:44:20 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Jul 2010 07:44:19 EDT
Received: (qmail 30859 invoked by uid 111); 11 Jul 2010 11:37:38 -0000
Received: from peff.net (HELO coredump.intra.peff.net) (208.65.91.99)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Jul 2010 11:37:38 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Jul 2010 07:37:33 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimQcqhD8FClAXef5dGAWRDbAGdVBmIVXxotzKoa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150773>

On Sat, Jul 10, 2010 at 09:11:18PM -0700, Brian Craft wrote:

> I'm finding that "git clone" doesn't return useful error codes, e.g.
> trying to clone from a bad repository.  Also, it doesn't abort if you
> try to clone a branch that doesn't exist. The command succeeds,
> leaving you with the wrong result. I haven't found a way to tell when
> the command really succeeds, except for scraping the output.

It should give useful error codes. I see:

  $ git clone parent child; echo $?
  Cloning into child...
  done.
  0

  $ git clone bogus child; echo $?
  Cloning into child...
  fatal: '/home/peff/foo/bogus' does not appear to be a git repository
  fatal: The remote end hung up unexpectedly
  128

  $ find parent -depth | xargs chmod ogu-r
  $ git clone parent child; echo $?
  Cloning into child...
  fatal: failed to open '/home/peff/foo/parent/.git/objects': Permission
  denied
  128

So those all seem reasonable. Is there some other case of a "bad
repository" that fails but gets you a zero exit code?

For the case of a non-existent branch, I see:

  $ git clone -b bogus parent child; echo $?
  Cloning into child...
  done.
  warning: Remote branch bogus not found in upstream origin, using HEAD
  instead
  0

So yes, it completes with a warning. I agree that is not ideal, as a
script that clones has no idea that it did not actually get the data it
was looking for.

I think the rationale for not aborting totally is that we have done
significant work (including network traffic) during the clone, and the
warning can generally be remedied with "git checkout the-right-branch".
We could perhaps keep the repository but signal with a non-zero exit
code.

The other option for a script is not to use "-b", which only impacts
checkout. Instead, you could do:

  $ git clone -n parent child &&
    cd child &&
    git checkout -b interesting-branch origin/interesting-branch

which is just as efficient, but lets you react differently to failure of
each part. You can also break it down further into:

  $ git init &&
    git remote add origin parent &&
    git fetch origin &&
    git branch interesting-branch origin/interesting-branch &&
    git checkout interesting-branch

but I don't think there is much point in doing so.

-Peff
