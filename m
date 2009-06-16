From: Jeff King <peff@peff.net>
Subject: Re: git diff looping?
Date: Tue, 16 Jun 2009 13:15:31 -0400
Message-ID: <20090616171531.GA17538@coredump.intra.peff.net>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com> <20090616114726.GA4343@coredump.intra.peff.net> <7v3aa0dsvn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Bito <jwbito@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGcGO-00061k-V8
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 19:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760479AbZFPRPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 13:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759486AbZFPRPd
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 13:15:33 -0400
Received: from peff.net ([208.65.91.99]:54539 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758133AbZFPRPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 13:15:32 -0400
Received: (qmail 5162 invoked by uid 107); 16 Jun 2009 17:17:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 13:17:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 13:15:31 -0400
Content-Disposition: inline
In-Reply-To: <7v3aa0dsvn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121689>

On Tue, Jun 16, 2009 at 09:51:24AM -0700, Junio C Hamano wrote:

> > I can reproduce the problem on Solaris 8 using git v1.6.3. It seems to
> > be caused by a horribly slow system regex implementation; it really
> > chokes on the regex we use to find the "funcname" line for java files.
> 
> Hmm.  Is running under LC_ALL=C LANG=C _with_ the slow system regex help?

No, it remains extremely slow (it is possible that it _is_ faster,
though, but I never managed to run either case to completion; they are
both clearly orders of magnitude off of acceptable).

> In this particular case it is clear that a good way to fix the problem is
> to replace Solaris's dumb regex implemention with what comes in compat/,
> but I at the same time have to wonder if that funcname pattern for java
> can somehow be simplified, so that it does not to require so sophisticated
> implementation of regexp?

That may be a possibility. The default pattern is actually two regexes
(one is a "do not match this" and the other is "match this"). The
problematic one seems to be (and that is a space and a tab between the
brackets):

  ^[      ]*(([   ]*[A-Za-z_][A-Za-z_0-9]*){2,}[  ]*\([^;]*)$

which I determined by setting diff.java.xfuncname just to that (and it
remains slow). Whereas setting it to:

  ^[     ]*(catch|do|for|if|instanceof|new|return|switch|throw|while)

completes in about 5 seconds of CPU time (in the actual pattern it is
negated, but that shouldn't matter as we do the negation ourselves).

Now that being said, 5 seconds is still embarrassingly bad. Watch this
(with the solaris system regex):

  $ git config diff.java.xfuncname '^[ 	]*(catch|do|for|if|instanceof|new|return|switch|throw|while)'
  $ time git diff v0.4.0 >/dev/null
  real    0m5.869s
  user    0m4.720s
  sys     0m0.200s

  $ git config diff.java.xfuncname foo
  $ time git diff v0.4.0 >/dev/null
  real    0m1.895s
  user    0m0.980s
  sys     0m0.210s

So besides learning that this machine is horribly slow, we can see that
running that relatively simple regex takes almost 4 seconds, compared to
a little over 1 second to do the entire rest of the diff. I am inclined
to say that regex performance like that is so bad that we shouldn't care
about optimizing for it, and just use something else.

Bear in mind that the same engine will be used for "grep", too. So you
aren't really doing "git grep" users any favors by linking against such
an awful library.

Really, that performance is so bad that I'm beginning to wonder if I am
somehow measuring something wrong. How could they ship something so
crappy through so many versions?

-Peff
