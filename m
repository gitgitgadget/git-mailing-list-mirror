From: Jeff King <peff@peff.net>
Subject: Re: TODO: git should be able to init a remote repo
Date: Wed, 14 Apr 2010 09:46:46 -0400
Message-ID: <20100414134645.GA12592@coredump.intra.peff.net>
References: <i2i76718491004131030sc2f8ffa3u97a91aa9a57923b5@mail.gmail.com>
 <20100414094048.GA19344@coredump.intra.peff.net>
 <7viq7urwmh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 15:47:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O22w5-000854-Ht
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 15:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630Ab0DNNrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 09:47:16 -0400
Received: from peff.net ([208.65.91.99]:43536 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481Ab0DNNrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 09:47:15 -0400
Received: (qmail 27106 invoked by uid 107); 14 Apr 2010 13:47:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Apr 2010 09:47:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Apr 2010 09:46:46 -0400
Content-Disposition: inline
In-Reply-To: <7viq7urwmh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144873>

On Wed, Apr 14, 2010 at 06:28:54AM -0700, Junio C Hamano wrote:

> >   2. We talked about an "init-serve" program back then. These days, "git
> >      init $dir" works, so I don't see the need for one.
> 
> I don't get this; the primary point of init-serve was _not_ about the lack
> of an internal mkdir in "git init", but was about having an interface to
> trigger "git init" in a transport agnostic way.  The implementation of the
> remote side mechanism could use "git init $dir" instead of "mkdir $dir &&
> cd $dir && git init" these days, but I think that is a very minor point.

Yeah, my explanation was a bit confused. What I meant was that back
then, we needed some wrapper, because you can't tell git-shell "mkdir x
&& cd x && git init". But these days, "git init" could serve as that
wrapper.

Which leaves the question of whether we need a _separate_ git program to
do init serving. I'm not sure we do. For regular shell users, there is
no point in restricting them; they could just run "git init" themselves.
And by using "git init" directly without any configuration from the
remote site, things will just work for such users.

For users of a restricted shell, the site administrator would have to
configure git-shell to allow "git init". But I think it makes sense for
git-shell to support redirecting "git init" to "git-my-custom-init"
internally. So the client end knows it just needs to say "git init"
whether it is a real shell or a restricted git shell. The lingua franca
for "make me a new repository" is "git init $dir".

> > Two questions/reservations looking at your prototype:
> >
> >   1. Should it push just master, or perhaps --all? Should it actually be
> >      two separate options to "git remote add" (--push and --init?).
> 
> I would say "git remote add --create ..." shouldn't even have push option;
> rather, don't put --create in "git remote".
> 
> "git push --create" would behave just like normal "push", and the above
> question does not even come into the picture.  "push" will push whatever
> it would normally push if the repository existed, period.

Yeah, that is much more natural, I think, and resolves all of the "what
should I push" questions. And it keeps remote's job to "manipulate
config for remotes" which is the direction it has been going on (e.g.,
the recent conversion of "git remote update" to "git fetch --all").

> >   2. The "git init $dir" syntax is what makes it reasonably transport
> >      agnostic.
> 
> I am not sure what you are getting at here.  Are you suggesting that $dir
> could be a URL (i.e. "git init over.there.com:myproject.git")?  Or are you
> still thinking in terms of how "init-serve" (or its equivalent that is
> either run directly via ssh or from transports supported by git) is
> implemented using "git init"?  It seems the latter judging from this,...

The latter. Really, I was conflating two issues: how the ssh transport
can handle both regular and restricted shells, and how other transports
handle it. The first I discussed above in a hopefully more clear way.
For the latter, on thinking more, it is really irrelevant. What the
git-daemon refers to as the "init" service does not necessarily have to
map to a command. So it is not really important.

> >      ... But that syntax was not introduced until 1.6.5, so you
> >      will run into problems with remotes running older versions of git.
> 
> ... but then I don't see what it has to do with the "transport agnostic"
> part of your comment.

Again, me conflating issues. What I meant to say was that for the blind
run-this-command-over-ssh transport, this will not work with older
versions of git on the remote side. But if you make it truly
ssh-specific, you can do "mkdir $dir && cd $dir && git init" which would
work with any version.

-Peff
