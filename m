From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Wed, 14 Aug 2013 03:31:08 -0400
Message-ID: <20130814073107.GA5095@sigill.intra.peff.net>
References: <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu>
 <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net>
 <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net>
 <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
 <20130813114635.GA16506@sigill.intra.peff.net>
 <520B2D11.2080405@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 14 09:31:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9VY3-0001Mp-UD
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 09:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759333Ab3HNHbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 03:31:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:35442 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758279Ab3HNHbK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 03:31:10 -0400
Received: (qmail 5093 invoked by uid 102); 14 Aug 2013 07:31:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Aug 2013 02:31:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Aug 2013 03:31:08 -0400
Content-Disposition: inline
In-Reply-To: <520B2D11.2080405@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232269>

On Wed, Aug 14, 2013 at 09:09:05AM +0200, Michael Haggerty wrote:

> Gaaak!  Let me again plead for supporting a post-clone hook rather than
> inventing some crazy config-file syntax that is becoming ever more
> complicated.  A post-clone hook would make all of these things that have
> been suggested pretty easy, and would also open lots of other
> possibilities, all without further changes in git.core, like (I'm just
> brainstorming here):

My problem with a post-clone hook is that it only runs once, and then
potentially goes stale.  For example:

>     ln -s $(HOME)/.githooks/* .git/hooks

Because of the symlink, this tracks hooks as they are updated, but what
happens when you add a new hook (or delete one)? You have to manually
hunt down each repository using it and update the links. You can get it
around it by replacing and symlinking the whole hook directory, though.

>     case "$(git --version)" in
>     *.1.[78].*)
>         git config include.path "$(HOME)/.gitinclude
>         ;;
>     esac

What happens when you upgrade (or downgrade) your git, or even use
multiple versions interleaved? You need to revisit this version check.

>     echo "(cd $(pwd) && git gc)" >>"$(HOME)/cron.weekly/git-gc"

What happens when you move your repository to a different directory? You
have to manually fix up the generated cron script.

>     case "$remote" in
>     *.work.com/*)
>         git config user.email me@work.com
>         ;;
>     *.github.com/*)
>         git config user.email me@debian.org
>         ;;
>     *)
>         echo '### Remember to set user.email ###'
>         ;;
>     esac

What happens when you update your address? You have to manually fix up
each repository.

I agree that running arbitrarily shell code is the most flexible thing,
but I think in many cases users would prefer to have something that
makes decisions at runtime, rather than having to remember to update
existing repositories with changes. That can be shell code, too, though
there are complications (performance and security come to mind).

I do not see the two features as necessarily an either-or; they can
accomplish the same thing, but with different tradeoffs in complexity
for the user.

-Peff
