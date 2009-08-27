From: Jeff King <peff@peff.net>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 16:48:35 -0400
Message-ID: <20090827204835.GC4399@coredump.intra.peff.net>
References: <1251387045053-3527289.post@n2.nabble.com>
 <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
 <20090827164657.GA17090@atjola.homenet>
 <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 22:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgltl-0005Wt-PT
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 22:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbZH0Usg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 16:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbZH0Usg
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 16:48:36 -0400
Received: from peff.net ([208.65.91.99]:53264 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbZH0Usf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 16:48:35 -0400
Received: (qmail 362 invoked by uid 107); 27 Aug 2009 20:48:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 Aug 2009 16:48:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Aug 2009 16:48:35 -0400
Content-Disposition: inline
In-Reply-To: <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127207>

On Thu, Aug 27, 2009 at 05:22:55PM +0000, Avery Pennarun wrote:

> 2009/8/27 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
> > It would also be pretty hard to implement that. Given the default f=
etch
> > refspec, it would "simply" be a matter of mapping the given ref to =
the
> > refspec, so e.g. "foo" becomes "refs/heads/foo:refs/remotes/origin/=
foo".
> > But even just using "git remote add -t master foo git://..." breaks
> > that, as the fetch refspec in the config will no longer be a glob, =
and
> > thus no such mapping is possible.
>=20
> Hmm, I don't really see why that introduces a problem.  If you use -t
> to override explicitly which refs you want to save, then it's not a
> problem if git doesn't save other refs, right?

I think you can handle both cases just by matching the fetched refs to
the LHS of the refspec.

So if you fetch "refs/heads/foo", and if you have a refspec of:

  refs/heads/*:refs/remotes/origin/*

then you see that the LHS glob matches, and the RHS expands to
refs/remotes/origin/foo. And if you have a more restrictive refspec,
that would work, too:

  refs/heads/foo:refs/remotes/origin/foo

would still match, but

  refs/heads/bar:refs/remotes/origin/bar

does not match on the LHS, so you write nothing. It would even handle
multiple refspecs properly.

And this matching is not really any different than what the fetch code
does when applying the refspec to what the remote offers. So I don't
think it should be any significant new code; it's just a matter of
activating that matching and updating the local tracking refs based on
what we actually fetched, instead of what the remote advertised.

> I'd be more concerned about the inconsistency between
>=20
>    git fetch git://whatever master
> and
>    git fetch origin master
>=20
> There's no really good way for the first one to know it needs to
> update any branches, even though 'origin' might be an alias for
> git://whatever.  So users will still be confused.

Well, you can always reverse-lookup each remote to see if the URL
matches. Of course you would never know that "http://whatever" is an
alias for "git://whatever". Personally, I don't imagine that users
really expect git to reverse-map remotes in that way (after all, why
would they input git://whatever long-hand if they knew that it was a
remote).

> Thinking of that also reminds me of another surprise.  If you do:
>=20
>    git fetch git://whatever
>=20
> ...it seems to do nothing at all, as far as I can see.  Which makes
> sense, I guess, since I wouldn't really expect it to be meaningful.
> But it seems to connect up to the remote server anyway just in case.

Shouldn't it fetch HEAD from the remote and store it in FETCH_HEAD? And
then tell you that it did that?

I get:

  $ mkdir foo && cd foo && git init
  Initialized empty Git repository in /home/peff/foo/.git/

  $ git fetch ~/compile/git
  remote: Counting objects: 85011, done.
  remote: Compressing objects: 100% (23942/23942), done.
  remote: Total 85011 (delta 61389), reused 83076 (delta 59655)
  Receiving objects: 100% (85011/85011), 19.03 MiB | 11385 KiB/s, done.
  Resolving deltas: 100% (61389/61389), done.
  From /home/peff/compile/git
   * branch            HEAD       -> FETCH_HEAD

  $ git fetch git://git.kernel.org/pub/scm/git/git.git
  From git://git.kernel.org/pub/scm/git/git
   * branch            HEAD       -> FETCH_HEAD

-Peff
