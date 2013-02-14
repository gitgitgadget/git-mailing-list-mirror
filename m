From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: filter-branch env-filter example
Date: Thu, 14 Feb 2013 16:09:10 -0500
Message-ID: <20130214210910.GA6660@sigill.intra.peff.net>
References: <511D3C33.6070902@hell.org.pl>
 <7vy5eqy6z3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tadeusz Andrzej =?utf-8?Q?Kad=C5=82ubowski?= <yess@hell.org.pl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 22:09:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U663u-0005Zf-Re
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 22:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934898Ab3BNVJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 16:09:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48946 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759413Ab3BNVJW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 16:09:22 -0500
Received: (qmail 23986 invoked by uid 107); 14 Feb 2013 21:10:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Feb 2013 16:10:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2013 16:09:10 -0500
Content-Disposition: inline
In-Reply-To: <7vy5eqy6z3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216333>

On Thu, Feb 14, 2013 at 12:29:36PM -0800, Junio C Hamano wrote:

> Quote the variable in double-quotes, like this:
> 
> 	if [ "$GIT_AUTHOR_EMAIL" = john@old.example.com ]
> 
> Otherwise the comparison will break, if the e-mail part had a
> whitespace in it, or if it were empty, which is an example of a more
> likely situation where you would want to fix commits using a
> procedure like this, no?

Yeah, definitely. If you are cleaning up a broken ident that cannot be
parsed, the failure mode is to put the whole author line in
$GIT_AUTHOR_EMAIL, which would almost certainly include spaces.

> Taking all of the above, the added text may look more like this, I
> think:
> 
> 	The `--env-filter` can be used to modify committer and/or
> 	author identity.  For example, if you found out that your
> 	commits have wrong identity of yours due to misconfigured
> 	user.email, you can make correction, before publishing the
> 	project, like this:
> 
> 	--------------------------------------------------------
>         git filter-branch --env-filter '
>         	if test "$GIT_AUTHOR_EMAIL" = "root@localhost"
>                 then
> 			GIT_AUTHOR_EMAIL=yess@example.com
> 			export GIT_AUTHOR_EMAIL
> 		fi
>         	if test "$GIT_COMMITTER_EMAIL" = "root@localhost"
>                 then
> 			GIT_COMMITTER_EMAIL=yess@example.com
> 			export GIT_COMMITTER_EMAIL
> 		fi
> 	' -- --all
> 	--------------------------------------------------------

That looks better, though there are a few English nits; here's my edited
version:

        The `--env-filter` option can be used to modify committer and/or
	author identity.  For example, if you found out that your
	commits have the wrong identity due to a misconfigured
        user.email, you can make a correction, before publishing the
	project, like this:

> By the way, I left the "export" in; "git filter-branch --help"
> explicitly says that you need to re-export it.  But I am not sure if
> they are necessary, especially after 3c730fab2cae (filter-branch:
> use git-sh-setup's ident parsing functions, 2012-10-18) by Peff,
> which added extra "export" to make sure all six identity variables
> are exported.  After applying the above rewrite, we may want to do
> the following as a separate, follow-up patch.

I think it has always been the case that we export them after setting
them; just look at the preimage from 3c730fab, and you can see exports
there.

I think the advice in the documentation about re-exporting is because
some versions of the bourne shell will not reliably pass the new version
of the variable when you do this:

  VAR=old
  export VAR
  VAR=new
  some_subprocess ;# we see $VAR=old here!

I do not recall ever running across such a shell myself, but rather
hearing about it third-hand in a portability guide somewhere. Apple's
shell documentation seems to indicate that /bin/sh in older versions of
OS X had this behavior:

  https://developer.apple.com/library/mac/documentation/opensource/conceptual/shellscripting/shell_scripts/shell_scripts.html#//apple_ref/doc/uid/TP40004268-CH237-SW11

which makes me think that BSD ash may behave that way. It is certainly
not necessary to re-export under bash or dash. I shudder to think what
horrible, 1980's-era behavior is codified in Solaris /bin/sh.

We could explicitly re-export all of the ident variables preemptively
before calling commit-tree, just to save the user the hassle of
remembering to do so.  It would be a no-op on sane shells, and I doubt
the runtime cost is very high. I suppose it would break somebody who
explicitly did:

  unset GIT_COMMITTER_NAME ;# use the value from user.name

in their env-filter, but that seems like a pretty unlikely corner case.

-Peff
