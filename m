From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] --valgrind improvements
Date: Wed, 29 May 2013 00:53:56 -0400
Message-ID: <20130529045356.GA31762@sigill.intra.peff.net>
References: <cover.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 29 06:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhYOl-0006K8-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab3E2EyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:54:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:35596 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863Ab3E2EyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:54:02 -0400
Received: (qmail 9612 invoked by uid 102); 29 May 2013 04:54:41 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 May 2013 23:54:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 00:53:56 -0400
Content-Disposition: inline
In-Reply-To: <cover.1368736093.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225734>

On Thu, May 16, 2013 at 10:50:11PM +0200, Thomas Rast wrote:

> One open issue with the last patch that currently eludes me: if I
> combine --valgrind-parallel with any --valgrind=*, there are lots of
> errors as (apparently) the valgrind wrapper setups race against each
> other.  However, without any --valgrind=* (thus defaulting to
> 'memcheck') this doesn't happen.

I noticed two racy error messages. If you do:

  cd t &&
  make clean &&
  ./some-test --valgrind-parallel=8

you will get complaints from mkdir about existing directories, as we use
mkdir as a poor man's O_EXCL to create lockfiles. These error messages
are harmless (we loop and try again), and we should perhaps just squelch
the stderr from mkdir. Although that might make weird situations hard to
diagnose, like another error that prevents creating the lockfile, so
maybe it is better to just live with the extra output (after the
directory is built once, it does not happen at all).

I also notice:

  $ ./t4052-* --valgrind-parallel=8 --valgrind=memcheck
  ...
  ./t4052-stat-output.sh: 572: ./test-lib.sh: cannot open
  /home/peff/compile/git/t/valgrind/bin/git-send-email.perl: No such
  file

Line 572 is checking the "#!" line of the _source_ file. So it shouldn't
be checking t/valgrind/bin in the first place. It looks like it comes
from this loop:

        for path in $PATH
        do
                ls "$path"/git-* 2> /dev/null |
                while read file
                do
                        make_valgrind_symlink "$file"
                done
        done

as t/valgrind/bin seems to be in the $PATH of the parallel
sub-processes. Hmm. It looks like you set up the valgrind dir in the
parent test process, and _then_ call the sub-processes in parallel. We
shouldn't need to do any valgrind setup at all in the subprocesses,
should we? They would just be replicating what the parent already did.

-Peff
