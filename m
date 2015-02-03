From: Jeff King <peff@peff.net>
Subject: Re: Weird output of git status in pre-commit hook when providing a
 pathspec on commit
Date: Tue, 3 Feb 2015 11:32:35 -0500
Message-ID: <20150203163235.GA9325@peff.net>
References: <80E24BA2-84FE-47FC-A5C0-D291E3C63BD5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C3=ABl?= Fortin <fortinmike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIgP6-0005cK-BH
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 17:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965811AbbBCQcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2015 11:32:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:44585 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965765AbbBCQci (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 11:32:38 -0500
Received: (qmail 3542 invoked by uid 102); 3 Feb 2015 16:32:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 10:32:38 -0600
Received: (qmail 10722 invoked by uid 107); 3 Feb 2015 16:32:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Feb 2015 11:32:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2015 11:32:35 -0500
Content-Disposition: inline
In-Reply-To: <80E24BA2-84FE-47FC-A5C0-D291E3C63BD5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263323>

On Tue, Feb 03, 2015 at 08:14:06AM -0500, Micha=C3=ABl Fortin wrote:

> Repo1 has the following pre-commit hook:
>=20
> #!/bin/bash
> git -C "../Repo2" status --porcelain
>=20
> I then commit in Repo1 using the following (this is actually ran by a
> GUI, I have no control over the commands themselves):
>=20
> git add --force -- MyNewFile
> git commit -m "My message" -o -- MyNewFile

Because the commit command uses "-o", git must use a temporary index
file to stage the commit. It sets GIT_INDEX_FILE in the environment, an=
d
then runs your hook.

When the hook runs "git -C" it moves into another repository, but the
GIT_INDEX_FILE in the environment takes precedence over the local index
found in that repository. So you see a HEAD and working tree from Repo2=
,
but the index from Repo1.

This is a specific case of a more general problem. If you were to run
git like:

  git --git-dir=3D/path/to/.git commit ...

you would have similar problems. You would have $GIT_DIR set in the
environment, and would see the HEAD from Repo1, but the working tree
from Repo2.

In other words, moving into another git directory from inside a hook is
not as easy as just going there. You also need to clear any state from
the environment. E.g., by adding this to the top of your hook:

  unset $(git rev-parse --local-env-vars)

Should "-C" (or "--git-dir") make this easier by doing it for you? I'm
not sure it is a good idea. It is right now valid to do:

  GIT_INDEX_FILE=3D/path/to/index.tmp git -C /path/to/repo ...

which would break if we cleared git variables. OTOH, maybe using "-C"
(instead of chdir-ing yourself) is a good indication that you want that
cleared. I dunno. It is probably too late at this point, as we would be
subtly breaking backwards compatibility. Perhaps it would make more
sense to add a new option, so you could do:

  git --reset-git-vars -C ../Repo2 status --porcelain

But this is a fairly obscure use case, and the rev-parse invocation
above is not so bad. I think it is more about knowing that you need to
use it, rather than the pain of typing it. And I am not sure how to mak=
e
that more clear. Is there a specific place in the documentation you
looked and might have been warned? Maybe the description for "-C" shoul=
d
cover this.

-Peff
