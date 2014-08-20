From: Jeff King <peff@peff.net>
Subject: Re: [BUG] rewriting history with filter-branch --commit-filter
Date: Wed, 20 Aug 2014 04:52:47 -0400
Message-ID: <20140820085247.GB12999@peff.net>
References: <17DBA232-E993-4B3C-9952-90424976A28D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Davide Fiorentino <davide.fiorentino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 10:52:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK1dY-0000z8-Et
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 10:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbaHTIwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2014 04:52:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:55426 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750977AbaHTIwt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 04:52:49 -0400
Received: (qmail 32595 invoked by uid 102); 20 Aug 2014 08:52:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Aug 2014 03:52:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2014 04:52:47 -0400
Content-Disposition: inline
In-Reply-To: <17DBA232-E993-4B3C-9952-90424976A28D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255558>

On Wed, Aug 20, 2014 at 10:16:11AM +0200, Davide Fiorentino wrote:

> I was in the need to rewrite author name and email and commit date fo=
r a single commit and I guess I found a bug.
> I run this git-filter script
>=20
> $ git filter-branch --commit-filter =E2=80=98
>     if [ "$GIT_COMMIT"=3D"9cfca27" ];=20
>         then GIT_AUTHOR_NAME=3D=E2=80=9CMichelle=E2=80=9D;=20
>             GIT_AUTHOR_EMAIL=3D=E2=80=9Cmichelle@email.com=E2=80=9D;=20
>             GIT_AUTHOR_DATE=3D"2009-12-31T23:59:59=E2=80=9D;=20
>             git commit-tree "$@=E2=80=9C;=20
>         else=20
>             git commit-tree "$@=E2=80=9C;
>     fi' HEAD
>=20
> and found that all history was rewritten as if =E2=80=9CMichelle=E2=80=
=9D not only commit 9cfca27.

The filter snippets you provide to filter-branch are shell script. The
`[` command (aka `test`) is just another shell command, and follows the
usual whitespace splitting rules. In your command:

  [ "$GIT_COMMIT"=3D"9cfca27" ]

it sees only one single argument, all concatenated together. A single
argument given to `test` is the same as `test -n`: it tells you whether
the string is empty, so this conditional is always true. You wanted:

  [ "$GIT_COMMIT" =3D "9cfca27" ]

instead. The whitespace makes the "=3D" a separate argument, and the
command knows it's an operator. You should also use the full commit id,
as that is what will be in $GIT_COMMIT.

-Peff
