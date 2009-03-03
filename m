From: Jeff King <peff@peff.net>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 03:23:18 -0500
Message-ID: <20090303082318.GB3158@coredump.intra.peff.net>
References: <1235865822-14625-2-git-send-email-gitster@pobox.com> <1235865822-14625-3-git-send-email-gitster@pobox.com> <20090301031609.GA30384@coredump.intra.peff.net> <7v63itbxe7.fsf@gitster.siamese.dyndns.org> <20090301100039.GD4146@coredump.intra.peff.net> <20090301170436.GA14365@spearce.org> <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org> <20090303070937.GB30609@coredump.intra.peff.net> <76718490903022337n79a0c11cw95e80d99cd598d17@mail.gmail.com> <7vtz6bf392.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:24:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePvm-0006p8-Lz
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbZCCIXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbZCCIXW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:23:22 -0500
Received: from peff.net ([208.65.91.99]:49801 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbZCCIXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:23:22 -0500
Received: (qmail 13784 invoked by uid 107); 3 Mar 2009 08:23:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 03:23:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 03:23:18 -0500
Content-Disposition: inline
In-Reply-To: <7vtz6bf392.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112028>

On Mon, Mar 02, 2009 at 11:56:57PM -0800, Junio C Hamano wrote:

> > I concur w/Jeff and I think git probably should not as well. I think
> > that instead adding it to init might be interesting
> 
> The thing is Jeff and Shawn already rejected that route.

Since when do you listen to me? ;P

I think there are actually two issues to be resolved, though:

  1. What is a standardized way for clients to ask for repo creation?

  2. How do users trigger that repo creation.

I think once you have (1), then (2) is easy. You can have "git init
host:dir", "git push --init remote", or whatever, and they can all
trigger the same mechanism. For systems which have an out-of-band
method, they can continue to behave as they have, or they can hook into
the standardized mechanism as if they were clients themselves. So there
is not that much point in debating (2), I think, until there is a
working (1).

Now (1) is much harder. Some parameters come from the user, but some
(including whether creation is allowed at all) must come from the site
administrator. And some site administrators will a hook to do whatever
site-specific magic they need.

What about the client just calling init-serve on the server as a program
which does whatever it wants to create a repo? The shipped default would
be:

  #!/bin/sh
  echo >&2 Sorry, repo creation not allowed.
  exit 1

Sites who want to give their users full creation access would do (and
obviously the --mkdir option would need to be added):

  #!/bin/sh
  exec git init --mkdir "$@"

Sites which want to restrict can do:

  #!/bin/sh
  for i in "$@"; do
    case "$i" in
    --bare) ;;
         *) echo >&2 Forbidden argument: $i; exit 1 ;;
    esac
  done
  exec git init --mkdir "$@"

Sites like GitHub or Gerrit can munge the arguments as appropriate. They
could even allow site-specific options if they wanted as long as they
were syntactically correct (i.e., "git init --gerrit-base=foo remote"
would pass the argument through to the remote unharmed).

-Peff
