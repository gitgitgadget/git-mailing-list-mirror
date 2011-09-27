From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Mon, 26 Sep 2011 23:31:34 -0400
Message-ID: <20110927033134.GB8534@sigill.intra.peff.net>
References: <20110926184739.GA11745@erythro.kitwarein.com>
 <7vehz30wdy.fsf@alter.siamese.dyndns.org>
 <1317078667.5579.13.camel@centaur.lab.cmartin.tk>
 <7v1uv228t4.fsf@alter.siamese.dyndns.org>
 <1317079692.5579.19.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, mathstuf@gmail.com,
	git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Sep 27 05:31:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8OOU-0001X0-7H
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 05:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab1I0Dbh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 23:31:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44988
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549Ab1I0Dbh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 23:31:37 -0400
Received: (qmail 19970 invoked by uid 107); 27 Sep 2011 03:36:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Sep 2011 23:36:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2011 23:31:34 -0400
Content-Disposition: inline
In-Reply-To: <1317079692.5579.19.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182208>

On Tue, Sep 27, 2011 at 01:28:09AM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> > term I think we should fix it properly. We are already learning "wh=
at are
> > the refs the remote side currently has" from the transport and the =
right
> > fix ought to be to use that original information, not the version f=
iltered
> > for the use of the primary objective of fetch, which is to only fet=
ch what
> > the user asked for.
>=20
> Do you mean that we should ignore the refspec? Or do you mean that we
> should look at the refspec if it exists, and only consider deleting
> those that meet the refspec, so that `--prune --tags` would only dele=
te
> tags that don't exist in the remote?

The latter. If I say:

  git fetch --prune origin refs/heads/master:refs/remotes/origin/master

and refs/heads/master doesn't exist on the remote, I would expect
refs/remotes/origin/master to be deleted locally. And that naturally
extends to:

  git fetch --prune origin refs/heads/*:refs/remotes/origin/*

We do something similar with "git push --mirror", which does pruning
like this[1].

-Peff

[1] Actually, I'm not sure how correct "push --mirror" is. It would be
    nice if the prune operation could be split from the mirror, too. In
    the past, I have wanted to do both:

      # backup to a repository where our objects will be shared
      # with other related backups. So we must only use our slice of th=
e
      # ref namespace.
      git push --mirror backup-repo +refs/*:refs/`hostname`/*

    and:

      # update topic branches we have already published (using the
      # "matching" refspec), but remove any that we have deleted
      # locally.
      git push --mirror publish-point +:

    and I don't think either works.
