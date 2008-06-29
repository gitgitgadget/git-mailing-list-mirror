From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH v2] git-svn: avoid filling up the disk with temp files.
Date: Sun, 29 Jun 2008 02:58:58 +0200
Message-ID: <20080629005858.GA2036@atjola.homenet>
References: <1214686673-28099-1-git-send-email-apenwarr@gmail.com> <1214696036-8294-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Adam Roben <aroben@apple.com>,
	Samuel Bronson <naesten@gmail.com>, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 03:00:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KClHR-0000Mz-NT
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 03:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbYF2A7F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jun 2008 20:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYF2A7E
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 20:59:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:44224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752717AbYF2A7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 20:59:03 -0400
Received: (qmail invoked by alias); 29 Jun 2008 00:59:00 -0000
Received: from i577BB248.versanet.de (EHLO atjola.local) [87.123.178.72]
  by mail.gmx.net (mp037) with SMTP; 29 Jun 2008 02:59:00 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18JziNIQwkJ8j1N4x13wf/pFnGmgQLw5twjiiOpro
	vYbk+5wp5iQEw8
Content-Disposition: inline
In-Reply-To: <1214696036-8294-1-git-send-email-apenwarr@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86752>

On 2008.06.28 19:33:56 -0400, Avery Pennarun wrote:
> Commit ffe256f9bac8a40ff751a9341a5869d98f72c285 ("git-svn: Speed up f=
etch")
> introduced changes that create a temporary file for each object fetch=
ed by
> svn.  These files should be deleted automatically, but perl apparentl=
y
> doesn't do this until the process exits (or perhaps when its garbage
> collector runs).
>=20
> This means that on a large fetch, especially with lots of branches, w=
e
> sometimes fill up /tmp completely, which prevents the next temp file =
from
> being written completely.  This is aggravated by the fact that a new =
temp
> file is created for each updated file, even if that update produces a=
 file
> identical to one already in git.  Thus, it can happen even if there's=
 lots
> of disk space to store the finished repository.
>=20
> We weren't adequately checking for write errors, so this would result=
 in an
> invalid file getting committed, which caused git-svn to fail later wi=
th an
> invalid checksum.
>=20
> This patch adds a check to syswrite() so similar problems don't lead =
to
> corruption in the future.  It also unlink()'s each temp file explicit=
ly
> when we're done with it, so the disk doesn't need to fill up.

Oh sweet! That also means that I don't have to fear about the repos I
already track with git-svn being corrupted (at least I hope so). :-)

And yeah, looking at /tmp, there are still 58K temp files belonging to
the failed import. Temporarily mounting a 8k tmpfs there triggers the
bug immediately, while with this patch I get a error message.

I'm running another import of the coq repo that failed earlier, just to
make sure, but I also just noticed that cat-file --batch is leaking
memory. For example this one shoots up to about 700M RSS usage with
git.git:

git rev-list --objects origin/master | \
	sed 's/ .*//' | \
	git cat-file --batch > /dev/null

I'll follow-up with a patch that at least fixes the worst part of that,
getting the RSS usage for the above test down to about 40M.

Thanks!
Bj=F6rn
