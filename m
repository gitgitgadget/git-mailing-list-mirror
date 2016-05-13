From: Jeff King <peff@peff.net>
Subject: [PATCH 0/6] test -z/-n quoting fix + misc cleanups
Date: Fri, 13 May 2016 16:46:54 -0400
Message-ID: <20160513204654.GA10684@sigill.intra.peff.net>
References: <CALR6jEiH6oxq=KXfz1pqOue9VKnkp=S8zNqC4OFmbuhRFFxoMw@mail.gmail.com>
 <20160513182325.GB30700@sigill.intra.peff.net>
 <xmqqwpmx91mb.fsf@gitster.mtv.corp.google.com>
 <20160513195911.GE9890@sigill.intra.peff.net>
 <xmqqshxl9142.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 22:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1JzC-0008HP-91
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbcEMUq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 16:46:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:39355 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751201AbcEMUq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:46:58 -0400
Received: (qmail 16690 invoked by uid 102); 13 May 2016 20:46:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:46:57 -0400
Received: (qmail 21550 invoked by uid 107); 13 May 2016 20:46:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 16:46:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 16:46:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqshxl9142.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294577>

On Fri, May 13, 2016 at 01:03:41PM -0700, Junio C Hamano wrote:

> > And sadly,
> >
> >   git grep 'test -n [^"]'
> >
> > is not empty.
> 
> Are you doing an audit?  Otherwise I'm interested in taking a brief
> look.

There was only one buggy case there (in git-stash). The rest were false
positives.

I didn't audit for:

  test $foo = bar

which also has problems. You can grep for:

  git grep 'test \$'

and there are a lot of hits. Many of them are probably fine, if they are
variables that are known to be non-empty and not contain whitespace
(e.g., $#). But some of them are questionable, like:

  git-request-pull.sh:if test $(git cat-file -t "$head") = tag

I suspect in practice that's fine just because we're likely to see
either the empty string (in which case test will barf with "unary
operator expected", which matches what we want), or a single-word
response (which doesn't need further quoting).

> >> But working around older/broken shells is easy and the resulting
> >> script it more readable, so let's take this.  It makes the resulting
> >> code easier to understand even when we know we run it under POSIX
> >> shell.

Actually, it's not just older shells:

  foo='bar baz'
  test -z $foo

is "unspecified" according to POSIX, though in practice it will complain
about "binary operator expected". You can get some weirdness, though,
like:

  foo='!= bar'
  test -z $foo

which returns 0. Unlikely, but still clearly wrong for us not to be
quoting.

Anyway. Here's a series that fixes the -n/-z cases, along with a bunch
of cleanups that remove the false positives (most of which I sent out
just a few minutes ago as "minor fixes to some svn tests").

  [1/6]: t/lib-git-svn: drop $remote_git_svn and $git_svn_id
  [2/6]: t9100,t3419: enclose all test code in single-quotes
  [3/6]: t9107: use "return 1" instead of "exit 1"
  [4/6]: t9107: switch inverted single/double quotes in test
  [5/6]: t9103: modernize test style
  [6/6]: always quote shell arguments to test -z/-n

You could take just 6/6 as its own series; the rest are just about
removing the false positives, and fixing other issues. I put it last,
though, because otherwise the "this grep is now empty" claim in it is
not true. :)

-Peff
