From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 02/10] pkt-line: drop safe_write function
Date: Mon, 18 Feb 2013 05:24:30 -0500
Message-ID: <20130218102430.GM5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218091519.GB5096@sigill.intra.peff.net>
 <20130218095644.GA7049@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Nu6-0000gU-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab3BRKYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:24:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51772 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094Ab3BRKYc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:24:32 -0500
Received: (qmail 18408 invoked by uid 107); 18 Feb 2013 10:26:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 05:26:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 05:24:30 -0500
Content-Disposition: inline
In-Reply-To: <20130218095644.GA7049@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216468>

On Mon, Feb 18, 2013 at 01:56:45AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > This is just write_or_die by another name.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > Actually, they are not quite the same. write_or_die will exit(0) when it
> > sees EPIPE.
> 
> That information definitely belongs in the commit message.

Yeah, this one was more RFC; I was hoping for some input on the EPIPE
thing, so I could know _what_ to put in the commit message. Is it safe,
and if so, why? And if not, we should drop the patch.

> If the connection to send-pack is lost and stdout becomes a broken
> pipe and I am updating enough refs to overflow the pipe buffer,
> receive-pack will die with SIGPIPE.  So unless the sadistic caller has
> set the inherited SIGPIPE action to SIG_IGN (for example by wrapping
> git with an uncautious Python wrapper that uses subprocess.Popen), the
> change to EPIPE handling is not a behavior change.

Yeah, but I don't want to count on always catching SIGPIPE. There's the
inherited signal handler thing, but there's also the fact that we may
end up ignoring SIGPIPE from backend programs like upload-pack and
receive-pack;  they check their writes anyway, and we have already run
into issues with getting SIGPIPE when we don't necessarily expect or
care about it.

The nice thing about write_or_die is that it still _exits_ on EPIPE.
It's just that it doesn't print an error (which is really not a big
deal) and exit with a 0 return code. I really wonder if we should just
change the latter. For programs which are creating copious output (e.g.,
"git log"), the return value is not important anyway. For backend
programs, an unexpected EPIPE from something like write_or_die should
probably involve a non-successful return code.

> Arguably it would be more friendly to stay alive to run the
> post-receive and post-update hooks, though, given that a ref update
> has occurred.  Maybe transport commands like this one should always
> set the disposition of SIGPIPE to SIG_IGN.

Yeah, I've suggested that in the past. And I do think it's sane, because
if you took a ref update, you almost certainly want to run the
post-receive, even if the client is no longer around (e.g., if it is
going to email out the changeset).

> [...]
> > --- a/builtin/send-pack.c
> > +++ b/builtin/send-pack.c
> > @@ -79,7 +79,7 @@ static void print_helper_status(struct ref *ref)
> >  		}
> >  		strbuf_addch(&buf, '\n');
> >  
> > -		safe_write(1, buf.buf, buf.len);
> > +		write_or_die(1, buf.buf, buf.len);
> 
> A signal will kill send-pack before write_or_die has a chance to
> intervene so this change is a no-op unless the caller is sadistic
> (as in the [1] case).  In the signal(SIGPIPE, SIG_IGN) case, it might
> be a regression, since "git push" should not declare success when its
> connection to receive-pack closes early.

But that isn't going to receive-pack, is it? Send-pack's stdout is
really just going to the user (or wherever). So it would have an effect
more for:

  (git push && echo >&2 OK) | grep -m1 foo

which might print "OK" even if we failed. That's quite contrived, but it
is at least a measurable change. And anyway...

> In that case, if triggerable this looks like a bad change: if
> upload-pack has gone missing, the fetch should not be considered a
> success.
> [...]
> Etc.  I'm stopping here.

Yeah, there are definitely some bad ones.

> I'm thinking before a patch like this we should make the following
> change:
> 
>  1. at startup, set the signal action of SIGPIPE to SIG_DFL, to make
>     the behavior a little more predictable.

I'm lukewarm on that, just because we may want to ignore SIGPIPE
ourselves at some point.

> Perhaps the following as well:
> 
>  2. in write_or_die(), when encountering EPIPE, set the signal action
>     of SIGPIPE to SIG_DFL and raise(SIGPIPE), ensuring the exit status
>     reflects the broken pipe.  If the parent process is unnecessarily
>     noisy about that, that's a bug in the parent process (hopefully
>     uncommon).

I like this. My suggestion would be to just exit(1) instead of exit(0).
But really, raising SIGPIPE makes the most sense, because it
communicates to the parent what happened (and the shell will wisely not
print a message, but careful parents like "git fetch" and "git push"
will check it properly and notice that the child did not succeed).

> Or alternatively:
> 
>  2b. never set SIGPIPE to SIG_IGN except in short blocks of code that
>      do not call write_or_die()

Yuck. :)

> What do you think?

I really like option 2. That exit(0) when we see SIGPIPE bugs me.
Because we _are_ dying due to our write failing, and I think the only
reason to exit(0) was to avoid unnecessary complaints from parents. But
raising SIGPIPE seems like the best of both worlds to me.

-Peff
