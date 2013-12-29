From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Runaway "git remote" if group definition contains a remote
 by the same name
Date: Sun, 29 Dec 2013 02:58:38 -0500
Message-ID: <20131229075838.GC31788@sigill.intra.peff.net>
References: <AANLkTinni=VJLoZp1Hjm4dfW8faChytDObJbXsFF5iXv@mail.gmail.com>
 <CALxABCbRZ4MmiYS4JF20qf1-iubeTfa+3OLibqdb5+raekuKQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 29 08:59:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxBH8-0007Jz-74
	for gcvg-git-2@plane.gmane.org; Sun, 29 Dec 2013 08:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252Ab3L2H6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Dec 2013 02:58:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:51943 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751048Ab3L2H6k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Dec 2013 02:58:40 -0500
Received: (qmail 500 invoked by uid 102); 29 Dec 2013 07:58:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 29 Dec 2013 01:58:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Dec 2013 02:58:38 -0500
Content-Disposition: inline
In-Reply-To: <CALxABCbRZ4MmiYS4JF20qf1-iubeTfa+3OLibqdb5+raekuKQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239796>

On Sat, Dec 28, 2013 at 03:56:55PM +0100, Alex Riesen wrote:

> it is also a way to create a fork bomb out of the innocent tool on platforms
> where pressing Ctrl-C does not terminate subprocesses of the foreground
> process (like, of course, Windows).
> 
> To reproduce, run
> 
>    git -c remotes.origin='origin other' remote update origin

Hmm. This is a pretty straightforward reference cycle. We expand origin
to contain itself, so it recurses forever on expansion. As with most
such problems, the cycle path may be longer than one:

  git -c remotes.foo='bar baz' -c remotes.bar='foo baz' fetch foo

Detecting the cycle can be done by keeping track of which names we've
seen, or just by putting in a depth limit that no sane setup would hit.
In either case, it's complicated slightly by the fact that we pass the
expanded list to a sub-process (which then recurses on the expansion).
So we'd have to communicate the depth (or the list of seen remotes) via
the command line or the environment.

One alternative would be to have the parent "git fetch" recursively
expand the list itself down to scalar entries, and then invoke
sub-processes on the result (and tell them not to expand at all). That
would also let us cull duplicates if a remote is found via multiple
groups.

Interestingly, the problem does not happen with this:

  git -c remotes.foo=foo fetch foo

Fetch sees that foo expands only to a single item and says "oh, that
must not be a group". And then treats it like a regular remote, rather
than recursing. So it's not clear to me whether groups are meant to be
recursive or not. They are in some cases:

  # fetch remotes 1-4
  git -c remotes.parent='child1 child2' \
      -c remotes.child1='remote1 remote2' \
      -c remotes.child2='remote3 remote4' \
      fetch parent

but not in others:

  # "foo" should be an alias for "bar", but it's not
  git -c remotes.foo=bar \
      -c remotes.bar='remote1 remote2' \
      fetch foo

If they are not allowed to recurse, the problem is much easier; the
parent fetch simply tells all of the sub-invocations not to expand the
arguments further. However, whether it was planned or not, it has been
this way for a long time. I would not be surprised if somebody is
relying on the recursion to help organize their groups.

So I think the sanest thing is probably:

  1. Teach "fetch" to expand recursively in a single process, and then
     tell sub-processes (via a new command-line option) not to expand
     any further.

  2. Teach "fetch" to detect cycles (probably just by a simple depth
     counter).

  3. Teach the group-reading code to detect groups more robustly, so
     that a single-item group like "remotes.foo=bar" correctly recurses
     to "bar".

  4. (Optional) Teach the expansion code from step 1 to cull duplicates,
     so that we do not try to fetch from the same remote twice (e.g., if
     it is mentioned as part of two groups, and both are specified on
     the command line).

I do not plan to work on this myself in the immediate future, but
perhaps it is an interesting low-hanging fruit for somebody else.

-Peff
