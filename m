From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 08/10] run test suite without dashed git-commands in PATH
Date: Sun, 25 Jan 2009 23:40:04 -0700
Message-ID: <20090126064004.GA3004@comcast.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net> <alpine.DEB.1.00.0901250255250.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 07:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRLBJ-0003dg-OE
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 07:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbZAZGlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 01:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbZAZGlY
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 01:41:24 -0500
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:57535 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863AbZAZGlX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 01:41:23 -0500
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id 7prP1b0070EPchoA56hPqt; Mon, 26 Jan 2009 06:41:23 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id 86hN1b0021TYyYj8M6hNq2; Mon, 26 Jan 2009 06:41:23 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id BBD2F89115; Sun, 25 Jan 2009 23:40:04 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901250255250.14855@racer>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107172>

Hi,

On Sun, Jan 25, 2009 at 02:59:53AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 24 Jan 2009, Matthew Ogilvie wrote:
> 
> >  .gitignore          |    1 +
> >  Makefile            |   42 +++++++++++++++++++++++++++++++-----------
> >  t/test-lib.sh       |   14 +++++++++++++-
> >  test-bin-wrapper.sh |   12 ++++++++++++
> >  4 files changed, 57 insertions(+), 12 deletions(-)
> >  create mode 100644 test-bin-wrapper.sh
> 
> I am strongly opposed to a patch this big, just for something as 3rd class 
> as CVS server faking.  We already have a big fallout from all that bending 
> over for Windows support, and I do not like it at all.
> 
> Note: I do not even have to look further than the diffstat to see that it 
> is wrong.
> 
> The point is: if cvsserver wants to pretend that it is in a fake bin where 
> almost none of the other Git programs are, fine, let's do that _in the 
> test for cvsserver_.
> 
> Let's not fsck up the whole test suite just for one user.
> 
> Ciao,
> Dscho

Since by default git is installed such that most of the dashed-form
commands are not in a user's default PATH, my thought was that
it would make sense for the test suite to mimick that environment
as much as possible.  This could detect regressions in any
installed/tested git script that erroneously assumes the dashed
form commands are in the PATH, not just git-cvsserver.

I can think of ways it could be made smaller, but they seem uglier than
the current patch to me:

    1. Perhaps just list the executables for the fake bin directory
separately, but then it is all too easy for the list to get out of sync
with what the final install environment will be.

    2. Perhaps strip off the $X's (.exe on windows; currently empty
elsewhere) from the words of the existing variables, in the rule
for building the "fake bin" directory.  But generally I'ld rather
not assume that pattern-matching replacement of
$X's will never conflict with a part of a script name.

    3. Perhaps just use symlinks or hardlinks instead of a wrapper
script.  This might have some promise, except that links are more
likely to fail on windows, and the wrappers generally give you
more flexibility for testing odd scenarios.

    4. The test-bin-wrapper.sh script does not actually need to
set environment variables (GIT_EXEC_DIT and templates) for
purposes of this patch.  But my thought was that in this form
you could run things straight out of the test-bin directory
to manually try out new code without needing to actually install
a build or mess with the environment variables yourself.  It could
also be extended to handle other global wrapper needs
relatively easily, such as valgrind.

Any other ideas?

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
