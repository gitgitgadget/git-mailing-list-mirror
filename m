From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 0/3] git-cvsserver: Add support for some binary files
Date: Mon, 19 May 2008 21:05:58 -0600
Message-ID: <20080520030557.GA1438@comcast.net>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net> <7v7idteqzn.fsf@gitster.siamese.dyndns.org> <46a038f90805181538v56aee5b8y33d68b226a62494f@mail.gmail.com> <20080519073535.GA2885@comcast.net> <alpine.DEB.1.00.0805191033080.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <djpig@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 20 05:07:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyICA-0006rE-77
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 05:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbYETDGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 23:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbYETDGO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 23:06:14 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:43146
	"EHLO QMTA05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755057AbYETDGN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2008 23:06:13 -0400
Received: from OMTA14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by QMTA05.westchester.pa.mail.comcast.net with comcast
	id TdAB1Z00Y1HzFnQ5504m00; Tue, 20 May 2008 03:06:12 +0000
Received: from mmogilvi.homeip.net ([75.70.160.185])
	by OMTA14.westchester.pa.mail.comcast.net with comcast
	id Tf6A1Z00540J0Bv3a00000; Tue, 20 May 2008 03:06:12 +0000
X-Authority-Analysis: v=1.0 c=1 a=o8s9G-U7OAoA:10 a=DnQ2Ju4PVaQA:10
 a=T6aK4jdCrIremxx7HBgA:9 a=v9eLYKq0B1aw_p79pEkA:7
 a=-wWtm2muuB0K7wpcehTEAkpPWkIA:4 a=LY0hPdMaydYA:10
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id A36F089115; Mon, 19 May 2008 21:05:59 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805191033080.30431@racer>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82460>

On Mon, May 19, 2008 at 10:34:47AM +0100, Johannes Schindelin wrote:
> Hi,
>
> On Mon, 19 May 2008, Matthew Ogilvie wrote:
>
> > I perceive one remaining big issue for git-cvsserver to be a good
> > replacement for real CVS: The ability to properly support "cvs update -r
> > VERSION", where VERSION could be any branch, tag, CVS version number, or
> > git commit hash. Git-cvsserver can partially support this by checking
> > out a totally different sandbox as "cvs checkout VERSION" (notice no
> > -r), but without the ability to switch versions in place, that is an
> > awkward workaround at best.
>
> I might be missing something obvious, but would it not be better to _not_
> check out anything, but serve every object straight from the object
> database (possibly with CR/LF mangling)?

Ah, an opportunity to explain a few things about how git-cvsserver
works generally:

1. git-cvsserver serves most objects straight from the object database
already (actually via git-cat-file), and will continue to do
so.  The exception is when it merges user's changed files
with new versions from the repository, for which git-cvsserver
uses temporary files.

2. git-cvsserver does need to use a temporary git index file for
some things, though.  Usually it is using an empty working
directory with such an index file.  User-modified files get
temporary names that get tracked internally, but it might make
sense for modified .gitattributes files (at least) to be put into the
otherwise empty working directory with the right name so that the
changes effect the current cvs command.

3. CR/LF mangling needs to be done by the CVS client, not the server.
A windows client would do such mangling, while a Linux client would not
(both talking to the same server).  With my patch, the server just
tells the client when a file is binary, so that it won't be
mangled even on windows.

4. git-cvsserver currently does not support the "-r" argument to
checkout or update (to get a particular a branch, a tag, or a
version number).  Instead, as a kind of workaround, it has a hook to
treat the CVS "module" argument (primarily intended to be a
project name in a repository with multiple projects) as a branch
or tag name instead.  But the "module" can't be switched on the fly;
you have to checkout a completely new sandbox to get a different
module (or with git-cvsserver, another branch).

- Matthew Ogilvie
