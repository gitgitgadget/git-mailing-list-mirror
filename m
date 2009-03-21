From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 0/2] cvsimport: add test illustrating a bug in cvsps
Date: Sat, 21 Mar 2009 06:41:11 +0100
Message-ID: <49C47DF7.9000601@alum.mit.edu>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net> <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net> <7vfxhag07g.fsf@gitster.siamese.dyndns.org> <49C22166.3000807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010905070509010603030107"
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <git-list@hvoigt.net>, ydirson@altern.org,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Mar 21 06:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lku0k-0007NB-R4
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 06:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbZCUFlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 01:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbZCUFlh
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 01:41:37 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60163 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbZCUFlg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 01:41:36 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.129] (77-20-65-209-dynip.superkabel.de [77.20.65.209])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n2L5fDYx032338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 21 Mar 2009 06:41:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.6.666
In-Reply-To: <49C22166.3000807@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114029>

This is a multi-part message in MIME format.
--------------010905070509010603030107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michael J Gruber wrote:
> [...]
> Right now this really seems to be going in the direction of: Make
> everyone feel uneasy about working with git on cvs repos at all (aka
> guerilla git), because git cvsimport still seems to be "recommended" or
> "the standard", we have all this talk about how bad it is, and no clear
> alternative.
> 
> I wish we had something saying: "If your cvs repo fulfills these
> conditions you can use cvsimport. If not watch out for the following
> (cvsps related) caveats. If you don't need two-way sync you're better of
> with..."

Good idea.  Let me try to summarize the situations I have found that can
result in cvsps/cvsimport giving objectively incorrect output.  I am
only including the most blatant problems that can cause the content
checked out of git to differ from that checked out of CVS.  I have
attached some scripts that illustrate some of the problems that I
haven't yet submitted to the test suite.


Problems known to occur in the conversion of CVS HEAD:

- If any files were ever "cvs import"ed more than once (e.g., import of
more than one vendor release) but not modified locally, then the HEAD
version is incorrect (t9601-cvsimport-vendor-branch.sh).

- If the CVS timestamps on subsequent revisions are out of order (e.g.,
because of clock skew) then file commits can be out of order in git
(e.g. b.txt<1.2> overwritten by b.txt<1.1>).  This is demonstrated by
t9603-cvsimport-time.sh.

- If two files ever had what look like cross-cross commits within
cvsps's 5-minute time window (e.g.,

a.txt<1.1> Log message 1
a.txt<1.2> Log message 2

b.txt<1.1> Log message 2
b.txt<1.2> Log message 1

) then the commits of one file will be out of order in git (e.g.
b.txt<1.2> overwritten by b.txt<1.1>).  I have a test for this that I
haven't yet submitted.


Problems known to occur in the conversion of CVS branches:

Any of the above problems can occur, plus:

- A branch does not appear in the git repository if no commits were made
on the branch (t01.sh)

- All files from the branching point are added to a branch, including
those that were never added to the branch in CVS.  (CVS allows part of a
source tree to be added to a branch/tag.) (t06.sh)

- A file that was added to the source branch *after* a daughter branch
was created but before the first commit on the branch will incorrectly
be added to the daughter branch in git. (t04.sh)


Problems known to occur in the conversion of CVS tags:

Any of the above problems can affect the content of the tag, plus:

- If multiple tags mark the same revision, only one of them is included
in the conversion. (t03.sh)


Michael

--------------010905070509010603030107
Content-Type: application/x-sh;
 name="t01.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="t01.sh"

#! /bin/sh

# FAIL: Branch not converted if there were no commits on the branch.

set -e
set -x

CVSROOT=$(pwd)/cvs
export CVSROOT

rm -rf cvs wc git $HOME/.cvsps

cvs init
cvs co -d wc .
(
    cd wc
    mkdir module
    cvs add module
)
(
    cd wc/module
    echo '1.1' >a.txt
    cvs add a.txt
    cvs commit -m 'Add a.txt'
    cvs tag -b BRANCH
)
git cvsimport -a -C git module
(
    cd git
    gitk --all &
)

--------------010905070509010603030107
Content-Type: application/x-sh;
 name="t06.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="t06.sh"

#! /bin/sh

# FAIL: A file never added to BRANCH is nevertheless included on
# BRANCH.

set -e
set -x

CVSROOT=$(pwd)/cvs
export CVSROOT

rm -rf cvs wc git $HOME/.cvsps

cvs init
cvs co -d wc .
(
    cd wc
    mkdir module
    cvs add module
)
(
    cd wc/module
    echo '1.1' >a.txt
    echo '1.1' >b.txt
    cvs add a.txt b.txt
    cvs commit -m 'Add files'
    # Add only a.txt to BRANCH:
    cvs tag -b BRANCH a.txt
    # We have to make a commit on BRANCH, otherwise the branch will be
    # entirely ignored by cvsimport:
    cvs up -r BRANCH
    echo '1.1.2.1' >a.txt
    cvs commit -m 'Revision 1.1.2.1'
)
git cvsimport -a -C git module
(
    cd git
    gitk --all &
)

--------------010905070509010603030107
Content-Type: application/x-sh;
 name="t04.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="t04.sh"

#! /bin/sh

# FAIL: A file added to trunk after the creation of BRANCH is
# nevertheless included on BRANCH.

set -e
set -x

CVSROOT=$(pwd)/cvs
export CVSROOT

rm -rf cvs wc git $HOME/.cvsps

cvs init
cvs co -d wc .
(
    cd wc
    mkdir module
    cvs add module
)
(
    cd wc/module
    echo '1.1' >a.txt
    cvs add a.txt
    cvs commit -m 'Add a.txt'
    cvs tag -b BRANCH
    echo '1.1' >b.txt
    cvs add b.txt
    cvs commit -m 'Add b.txt'
    # We have to make a commit on BRANCH so that the branch is not
    # entirely ignored by cvsimport:
    cvs up -r BRANCH
    echo '1.1.2.1' >a.txt
    cvs commit -m 'Revision 1.1.2.1'
)
git cvsimport -a -C git module
(
    cd git
    gitk --all &
)

--------------010905070509010603030107
Content-Type: application/x-sh;
 name="t03.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="t03.sh"

#! /bin/sh

# FAIL: If the same revision is tagged twice, one of the tags is lost
# in the conversion.

set -e
set -x

CVSROOT=$(pwd)/cvs
export CVSROOT

rm -rf cvs wc git $HOME/.cvsps

cvs init
cvs co -d wc .
(
    cd wc
    mkdir module
    cvs add module
)
(
    cd wc/module
    echo '1.1' >a.txt
    cvs add a.txt
    cvs commit -m 'Add a.txt'
    cvs tag TAG1
    cvs tag TAG2
)
git cvsimport -a -C git module
(
    cd git
    gitk --all &
)

--------------010905070509010603030107--
