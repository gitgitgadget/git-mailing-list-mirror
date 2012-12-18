From: Jeff King <peff@peff.net>
Subject: Re: problem with BOINC repository and CR/LF
Date: Tue, 18 Dec 2012 11:41:32 -0500
Message-ID: <20121218164132.GC20122@sigill.intra.peff.net>
References: <50CEF289.4040503@gmx.de>
 <CAH5451=FpmtGVVJ=mubE0KeD-tTVaNU96audzTRnNQh2BEEXPg@mail.gmail.com>
 <50CF41EB.1060402@gmx.de>
 <CAH5451=xiipSKrAb_DFXCW=+NAn+mnSm1zPzjhEVc8fZ2KGcnw@mail.gmail.com>
 <50D03D80.3090005@gmx.de>
 <50D05E62.7090605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:41:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl0Er-000322-1w
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 17:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272Ab2LRQlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2012 11:41:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57696 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932202Ab2LRQlf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 11:41:35 -0500
Received: (qmail 19091 invoked by uid 107); 18 Dec 2012 16:42:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Dec 2012 11:42:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2012 11:41:32 -0500
Content-Disposition: inline
In-Reply-To: <50D05E62.7090605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211760>

On Tue, Dec 18, 2012 at 01:15:30PM +0100, Torsten B=C3=B6gershausen wro=
te:

> I could re-produce the problem here:
> git version 1.8.0.197.g5a90748
> Mac OS X (that what I had at hands fastest)

I could reproduce it, too, on Linux.

The reason it does not always happen is that git will not re-examine th=
e
file content unless the timestamp on the file is older than what's in
the index. So it is a race condition for git to see whether the file is
stat-dirty.

But you can make sure all files are stat-dirty by just resetting the
index:

  $ git clone git://boinc.berkeley.edu/boinc.git
  $ rm .git/index
  $ git reset

which shows the complete list of files with LF/CRLF normalization
issues.

> So my conclusion is:
> The file has CRLF in the repo, but should have LF.
> This is not a good thing, and the files need to be normalized.

Yes, exactly. The project has told git via .gitattributes that certain
files should have particular line endings in the repository, but that i=
s
not the case with the current versions. Doing:

  $ git commit -a -m 'normalize line endings according to gitattributes=
'

on top of the commands above would fix it (for that commit and onwards,
anyway).

-Peff
