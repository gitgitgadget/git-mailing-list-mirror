From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 0/3] git-cvsserver: Add support for some binary files
Date: Mon, 19 May 2008 01:35:35 -0600
Message-ID: <20080519073535.GA2885@comcast.net>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net> <7v7idteqzn.fsf@gitster.siamese.dyndns.org> <46a038f90805181538v56aee5b8y33d68b226a62494f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <djpig@debian.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 09:36:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxzv6-0007dj-DK
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 09:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYESHfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 03:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYESHfl
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 03:35:41 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:39106
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282AbYESHfk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2008 03:35:40 -0400
Received: from OMTA13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by QMTA07.westchester.pa.mail.comcast.net with comcast
	id TKY31Z00217dt5G5700900; Mon, 19 May 2008 07:35:04 +0000
Received: from mmogilvi.homeip.net ([75.70.160.185])
	by OMTA13.westchester.pa.mail.comcast.net with comcast
	id TKbd1Z00140J0Bv3Z00000; Mon, 19 May 2008 07:35:38 +0000
X-Authority-Analysis: v=1.0 c=1 a=o8s9G-U7OAoA:10 a=DnQ2Ju4PVaQA:10
 a=hoEqNhkXytOAESgxnmgA:9 a=aZRtYM_LnAFoK4MCwIIA:7
 a=Mc4Wpy88u8ZMhAeDrI3CqC_8fPQA:4 a=qIVjreYYsbEA:10 a=3cjVDzgxsZYA:10
 a=LY0hPdMaydYA:10
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 3B67589115; Mon, 19 May 2008 01:35:35 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <46a038f90805181538v56aee5b8y33d68b226a62494f@mail.gmail.com>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82417>

On Mon, May 19, 2008 at 10:38:21AM +1200, Martin Langhoff wrote:
> On Sat, May 17, 2008 at 12:03 PM, Junio C Hamano <junio@pobox.com> wrote:
> > Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:
> >
> >> This series of patches extends git-cvsserver to support telling the
> >> CVS client to set the -kb (binary) mode for files that git considers
> >> to be binary (and not for text files).  It includes updates to
> >> documentation and tests.
> >
> > I am unfortunately not familiar with this part of the system and I'd need
> > to summon help from experts, but it looks rather nicely done.
> 
> IIRC, one thing that is _not_ handled well in CVS -k flag changes on
> the server side (since -k modes are not versioned). If we are
> guessing, this may be more likely to happen, or at least more likely
> to _surprise_ people.

Since git-cvsserver can (and does) refigure and send a different -k
every time it sends a new version of a file, it could be argued
that git-cvsserver actually fixes the non-versioned -k issue,
at least partly, from some perspectives.  (There's still the issue
of when a new .gitattributes file takes effect, etc.)

> 
> Matthew, have you had a chance to test k mode changes against clients?
> Are we reasonably bug-compatible with the original turd^H^H^Hhing? ;-)

So far I've only done limited testing with Linux CVS 1.12.12.
No newline-munging clients; the test cases just check the
CVS/Entries file, not the file contents.  Most of my testing has
been the test cases included with the patch.

I don't expect any new compatibility problems from this.  The old code
would send exactly the same data for text files and binary files
as this new code.  It was just limited to sending all files as text
or all files as binary (existing gitcvs.allbinary), instead of
allowing a mix.

I'll try to do some newline-munging tests with Cygwin CVS (talking
to a server on Linux) sometime this next week.

I've heard the most finicky CVS client is probably the
one embedded in the Eclipse plugin.  Apparently it has had trouble
with minor tweaks in new versions of official CVS, let alone
an emulation.  But given that I have never even tried Eclipse, I
probably am not a good choice for testing it, and probably wont.

----------

Generally my motivation here is to make it easier for
an organization like my day job to transition to git.  I generally
don't intend to use git-cvsserver myself much, especially not from
platforms that need the newline-munging.

I perceive one remaining big issue for git-cvsserver to be
a good replacement for real CVS: The ability to properly
support "cvs update -r VERSION", where VERSION could
be any branch, tag, CVS version number, or git commit hash.
Git-cvsserver can partially support this by checking out a
totally different sandbox as "cvs checkout VERSION" (notice
no -r), but without the ability to switch versions in place,
that is an awkward workaround at best.  Fixing this seems
really involved (extending the DB scheme, etc), unless
clients either treat the CVS version as an opaque string, or
could be easily patched to do so (so that we could just stick
a GIT hash where a CVS version string is expected).  Also, some
form of submodule support would also be nice, but not
critical (the right thing here is still vague in my mind,
which is hardly surprising as there has recently been
discussion about awkward use cases for submodules even
within native git itself).  Merging with "cvs update -j ..."
and creating tags/branches with CVS are relatively unimportant:
rare enough that they could probably just be reserved for
git itself.  Does anyone have any thoughts about any of this?

            - Matthew
