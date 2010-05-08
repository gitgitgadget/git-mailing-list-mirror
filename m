From: Jeff King <peff@peff.net>
Subject: Re: Re: git log -M -- filename is not working?
Date: Sat, 8 May 2010 01:30:25 -0400
Message-ID: <20100508053025.GG14998@coredump.intra.peff.net>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
 <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
 <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
 <19428.24021.324557.517627@winooski.ccs.neu.edu>
 <20100508044434.GC14998@coredump.intra.peff.net>
 <19428.62170.654092.308682@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sat May 08 07:30:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAccU-0006O2-4f
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab0EHFa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 01:30:28 -0400
Received: from peff.net ([208.65.91.99]:43536 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab0EHFa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:30:27 -0400
Received: (qmail 2931 invoked by uid 107); 8 May 2010 05:30:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 May 2010 01:30:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 May 2010 01:30:25 -0400
Content-Disposition: inline
In-Reply-To: <19428.62170.654092.308682@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146641>

On Sat, May 08, 2010 at 01:12:58AM -0400, Eli Barzilay wrote:

> > > BTW, I've had at least 4 people now who got confused by this.  Is
> > > there any use for -M/-C without --follow?  In any case, it will be
> > > very helpful if the -M/-C descriptions said "see also --follow".
> > 
> > Yes, it detects renames when doing diffs.
> 
> OK, so just to clear this up: -C and -M (and --find-copies-harder) are
> for `diff', and --follow is for `log' with a single file (and each
> will pass it on to the other)?

Yes (well, diff can never pass --follow to log, since diff never invokes
log, but yes, the per-commit diff shown by log uses the -C and -M given
to log).

> > Documentation patch is below.
> 
> Thanks!  (It would also be nice to mention it in -C, but not critical
> since it's right after -M.)

Yeah, I considered that, but didn't because of the proximity. But maybe
it would make sense to do so, or to point -C at -M (e.g., say "like -M,
but detect copies as well as renames").

> Well, the "algorithm" I used was probably one that is very popular:
> 
> * use `git log some-file' with something that got renamed recently
> * be horrified that all history is gone
> * remember something vague about git detecting renames => go look at
>   the man page
> * Find -M, add it, try it, still doesn't work
> * Go back to scanning the man page, repeat
> * At the end I end up with:
>     -C -M --find-copies-harder --follow
> 
> So if there was some single
> 
>   --do-whatever-you-can-as-much-as-you-can-to-find-all-renames

But I think all you really wanted was "--follow". I'd have to check the
code, but I'm not even sure whether "-C" will impact --follow at all.

> Even with the chain of more flags with descriptions that sound like
> they're trying to scare me away by promising that my machine will work
> for a REALLY LONG TIME, I'd still want to turn it on -- if it got
> something slower I sure didn't notice it so far, and that's on a real
> repository which is not that small (but with git's reputation I won't
> be surprised if "slower" means that I had to way a whole extra 20ms
> for an answer...).  If something would really take too long, as in me
> sitting any waiting for an answer, *then* I can try to remove that and
> see if I ran into some of the horrible edge cases...

No, copy detection can be _really_ slow. There is a reason it isn't on
by default. Try "git log -1000 -p" versus "git log -1000 -p -C -M
--find-copies-harder" in some repository. In a simple git.git test, it
is almost 5x slower (about 1 second versus 5 seconds on my machine). For
large repositories, it can be much worse, because now each diff is
O(size of repository) instead of O(size of changes).

Still, I see your point that you might want it on all the time, if you
have a sufficiently small repo. There is "diff.renames" to turn on
rename detection all the time. But I think a log.follow option doesn't
make sense at this point. For example:

  $ git config log.follow true
  $ git log foo.c ;# ok, follow foo.c
  $ git log foo.c bar.c ;# uh oh, now what?

Does the last one just barf, and make you say "git log --no-follow foo.c
bar.c"? Does it quietly turn off --follow, making the user guess why
"git log foo.c" finds some history that "git log foo.c bar.c" doesn't?

-Peff
