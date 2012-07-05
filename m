From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Thu, 5 Jul 2012 05:42:13 -0400
Message-ID: <20120705094213.GA29740@sigill.intra.peff.net>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 11:42:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmiZt-0008Dt-Ew
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 11:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab2GEJmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jul 2012 05:42:20 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:53610
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754028Ab2GEJmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 05:42:20 -0400
Received: (qmail 10742 invoked by uid 107); 5 Jul 2012 09:42:27 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Jul 2012 05:42:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jul 2012 05:42:13 -0400
Content-Disposition: inline
In-Reply-To: <1341480589-1890-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201041>

On Thu, Jul 05, 2012 at 11:29:49AM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> The branch command assumes HEAD as the starting point if none is
> specified. This causes --set-upstream to behave unexpectedly if the
> user types
>=20
>     git branch --set-upstream origin/master
>=20
> git-branch will assume a second argument of HEAD and create config
> entries for a local branch origin/master to track the current
> branch. This is rarely, if ever, what the user wants to do.
>=20
> Catch invocations with --set-upstream and only one branch so the
> command above sets up the current branch to track origin's master
> branch.

I have been tempted to write this patch several times but was afraid
that somebody was relying on the existing behavior. I think the behavio=
r
you propose is much saner.

> +# The unsets at the end is to leave the master config as we found it=
,
> +# so later tests don't get confused
> +
> +test_expect_success 'set upstream with implicit HEAD as branch to mo=
dify' \
> +    'git config remote.local.url . &&
> +     git config remote.local.fetch refs/heads/master:refs/remotes/lo=
cal/master &&
> +     (git show-ref -q refs/remotes/local/master || git fetch local) =
&&
> +     git branch --set-upstream local/master &&
> +     test $(git config branch.master.remote) =3D local &&
> +     test $(git config branch.master.merge) =3D refs/heads/master
> +     git config --unset branch.master.remote &&
> +     git config --unset branch.master.merge
> +'

The unsets will not run if the test fails. Use test_when_finished to
insert cleanup, or better yet use test_config which handles this case
automagically (you are not setting them initially, but perhaps you
should set them to some known value initially to make sure that your
command changes them as expected).

I don't understand the point of the show-ref call, though. Isn't the
fetch idempotent, and you can just run it always?

-Peff
