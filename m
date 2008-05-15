From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 0/3] git-cvsserver: Add support for some binary files
Date: Wed, 14 May 2008 22:35:45 -0600
Message-ID: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 06:37:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwVDH-0001ap-II
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 06:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbYEOEgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 00:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbYEOEgE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 00:36:04 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:59714
	"EHLO QMTA01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488AbYEOEf4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 00:35:56 -0400
Received: from OMTA04.westchester.pa.mail.comcast.net ([76.96.62.35])
	by QMTA01.westchester.pa.mail.comcast.net with comcast
	id RgCH1Z0050ldTLk5101p00; Thu, 15 May 2008 04:35:55 +0000
Received: from fast.fake.domain.org ([75.70.160.185])
	by OMTA04.westchester.pa.mail.comcast.net with comcast
	id Rgbs1Z00240J0Bv3Q00000; Thu, 15 May 2008 04:35:52 +0000
X-Authority-Analysis: v=1.0 c=1 a=Lp_cDmsy1wgA:10 a=bq7OwCgC_roA:10
 a=pqx3iIQs8VCiVOtMDgoA:9 a=tq0axtpz0fOMmLyXoAYA:7
 a=LvnupodZZ7bAE4uyqQNmFtfajZkA:4 a=XF7b4UCPwd8A:10
Received: from localhost.localdomain(really [192.168.30.96]) by fast.fake.domain.org
	via sendmail with esmtp
	id <m1JwVC2-000twPC@fast.fake.domain.org>
	for <mmogilvi_git@miniinfo.net>; Wed, 14 May 2008 22:35:50 -0600 (MDT)
	(Smail-3.2 1996-Jul-4 #13 built 1998-Aug-8)
X-Mailer: git-send-email 1.5.4.3.340.g97b97
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82177>

This series of patches extends git-cvsserver to support telling the
CVS client to set the -kb (binary) mode for files that git considers
to be binary (and not for text files).  It includes updates to
documentation and tests.

By default the new binary support is not enabled.  To enable it,
you should set "gitcvs.usecrlfattr" and "gitcvs.allbinary=guess",
as described in the updated documentation.

-----------------

This patch series is usable now, but there are some things I'm not
sure about, and things that could still use improvement:

1. As currently implemented, the second patch (for checking file
attributes) forks a separate instance of git-check-attr for every
file it needs to look up in the repository.  Each invocation involves
reading the index file, so things may get kind of slow if
there are a whole lot of files in the repository.  It might be
worth reorganizing things so that it can ask about multiple
files in one invocation of git-check-attr, but such a change would
probably be invasive enough to warrant a separate patch.

2. Is there a better/more intuitive way of configuring this?  Perhaps
"gitcvs.autocrlf" that is similar to "core.autocrlf"?  But it seems
unfriendly to drop default and "gitcvs.allbinary" modes; some
users may have set things up such that those modes are needed.

3. I'm not sure about the best way to handle repeatably changing
current directory.  The first patch tries to make a somewhat general
mechanism to manage it, but I keep thinking in the back of my mind
that it might be better to set up a working directory first thing,
and then minimize any further directory changes after that.  Does
anyone have any thoughts about this?

4. Possibly additional enhancements including:
a. Strip out '\r' from "text" files, so when the CVS client
adds '\r', you don't wind up with double '\r's per line.
b. Additional conversions like in convert.c, done on server side.
Including safecrlf, smudge/clean filters, etc.
c. If a new .gitattributes file is sent by the client, use it
in preference over the one from the most recent commit.  As it
is now, a user might need to commit the new .gitattributes before
committing anything else.  This might be much easier if a new
overall design for setting up and using a working directory was
used (see above).

5. It might make things clearer to refactor the special case
transmitfile() modes to be implemented as separate functions that
use open_blob_or_die().  Probably a separate patch, if done at all.

6. Additional tweaks to the documentation?  For example, should
there be a note on "core.autocrlf" that binary support in emulation
tools may use other configuration variables...

Matthew Ogilvie (3):
      git-cvsserver: add mechanism for managing working tree and current directory
      implement gitcvs.usecrlfattr
      git-cvsserver: add ability to guess -kb from contents

 Documentation/config.txt        |   26 ++-
 Documentation/git-cvsserver.txt |   32 ++-
 git-cvsserver.perl              |  500 ++++++++++++++++++++++++++++++++++-----
 t/t9401-git-cvsserver-crlf.sh   |  337 ++++++++++++++++++++++++++
 4 files changed, 826 insertions(+), 69 deletions(-)
 create mode 100755 t/t9401-git-cvsserver-crlf.sh
