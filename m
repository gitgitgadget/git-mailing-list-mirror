From: Jeff King <peff@peff.net>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 18:03:29 -0500
Message-ID: <20111207230329.GB21852@sigill.intra.peff.net>
References: <CAJ8P3RA48W7ZiABvjkn_KkU-JPnCnaF_X_WK0wPtToph3DGDvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 00:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYQWV-0000DB-Ev
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 00:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758566Ab1LGXDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 18:03:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42938
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758563Ab1LGXDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 18:03:31 -0500
Received: (qmail 21190 invoked by uid 107); 7 Dec 2011 23:10:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 18:10:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 18:03:29 -0500
Content-Disposition: inline
In-Reply-To: <CAJ8P3RA48W7ZiABvjkn_KkU-JPnCnaF_X_WK0wPtToph3DGDvg@mail.gmail.com>
 <CAJ8P3RB=Gj-QCe6meqXSZ7N8+PnfNxSD8omUxT6dDh00bUf0QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186518>

On Wed, Dec 07, 2011 at 05:24:01PM -0500, Chris Patti wrote:

> Yup, you nailed it.  The files in question are CloudSponge.php
> (deleted) and Cloudsponge.php (still being actively maintained).
> [...]
> Actually I'm wrong on that count, but in an interesting way.
> 
> Both CloudSponge.php and Cloudsponge.php exist and are *not* deleted
> in the remote repository, but on OSX only Cloudsponge.php shows up on
> the filesystem, yet CloudSponge.php is being reported as modified.
> 
> Turns out two of our other developers are also seeing this behavior.

OK. Then it's not a bug[1], but rather an incompatibility issue. Your
repository stores two files which differ only in case, but your
underlying case-insensitive filesystem is incapable of storing both of
them simultaneously.

There's really no way around it except to either use a case-sensitive
filesystem, rename your files (or if one if obsolete, get rid of it).

[1] Arguably git could be better at noticing and reporting this issue,
but that wouldn't change the fundamental problem.

> I am seeing the same behavior with 1.7.7.4 which I backrevved to
> yesterday while troubleshooting this issue.  Can you suggest an older
> version for me to try next?

No, you'll see the same behavior in all versions of git (I was mostly
concerned that it was a regression new in v1.7.8, as I fixed some
case-sensitivity bugs recently).

> I'm not sure how I would git bisect in this case, I'd need to have all
> the different git revs installed in order to do that right? (I'm
> relatively new to git bisect, just figured it out the other day).

You can't bisect, because you don't have a version that actually worked.
But if you had, you would do it by cloning and building the git
repository itself, then starting a bisection like:

  git clone git://git.kernel.org/pub/scm/git/git.git
  git bisect start
  git bisect bad v1.7.8
  git bisect good v1.7.7.4 ;# if it had turned out to be OK

and then repeatedly build and try your test with each version of git,
until if finally narrowed it down to a single offending commit.

-Peff
