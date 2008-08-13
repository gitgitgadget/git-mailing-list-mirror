From: bdowning@lavos.net (Brian Downing)
Subject: [PATCH 0/2] Speed up xdiff_outf, and therefore git blame
Date: Wed, 13 Aug 2008 02:04:01 -0500
Message-ID: <20080813070401.GA4396@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 09:05:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTAQU-0004Ia-FL
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 09:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbYHMHEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 03:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbYHMHEH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 03:04:07 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:36955
	"EHLO QMTA05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753329AbYHMHEG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 03:04:06 -0400
Received: from OMTA11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by QMTA05.westchester.pa.mail.comcast.net with comcast
	id 1ig01a0020mv7h055j42Sj; Wed, 13 Aug 2008 07:04:02 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA11.westchester.pa.mail.comcast.net with comcast
	id 1j421a0024BqYqi3Xj42x9; Wed, 13 Aug 2008 07:04:02 +0000
X-Authority-Analysis: v=1.0 c=1 a=77md-ET0fR8A:10 a=Yc_7fIhg-5YA:10
 a=8FY4ldL6RjiRgWfPgZkA:9 a=XJHm3Fhoiavz4sAUi1z5aT13keYA:4 a=hpF-ijbX5cwA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id F3C92309F23; Wed, 13 Aug 2008 02:04:01 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92182>

When using git gui blame on some files in one of my repositories, and
noticing some rather depressing performance, I decided to look for some
low-hanging fruit to optimize.

I found that a lot of the time is spent in xdiff_outf continually
xreallocing and freeing memory for a string.  I decided to replace that
with a strbuf.  Unfortunately this now means that there are resources
that need to be freed after using xdiff_outf, so a new interface for
doing that needed to be created first.

The performance difference on my repository is not amazing, but quite
noticeable.  Before:

:; time git blame -M -C -C -p --incremental server.c >/dev/null
101.52user 0.17system 1:41.73elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+39561minor)pagefaults 0swaps

After:

:; time git blame -M -C -C -p --incremental server.c >/dev/null
80.38user 0.30system 1:20.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+50979minor)pagefaults 0swaps

Obviously, it should improve other uses of xdiff_outf as well, though I
doubt many things hit it as hard as blame does.

 [PATCH 1/2] Make xdiff_outf_{init,release} interface
 [PATCH 2/2] Use strbuf for struct xdiff_emit_state's remainder

 builtin-blame.c   |    4 ++--
 combine-diff.c    |    4 ++--
 diff.c            |   20 ++++++++++----------
 xdiff-interface.c |   44 ++++++++++++++++++++++----------------------
 xdiff-interface.h |    6 ++++--
 5 files changed, 40 insertions(+), 38 deletions(-)

-bcd
