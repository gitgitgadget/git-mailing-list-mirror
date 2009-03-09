From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [CVSPS PATCH] fix: correct rev order in case commiters clocks
 were not syncronised
Date: Mon, 09 Mar 2009 16:02:12 +0100
Message-ID: <49B52F74.1090006@alum.mit.edu>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu> <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Heiko Voigt <git-list@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:04:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgh1E-0005AE-TR
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbZCIPCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 11:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbZCIPCV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 11:02:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37523 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbZCIPCV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 11:02:21 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n29F2EEI021397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 9 Mar 2009 16:02:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <49B4FCDA.4030106@hvoigt.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112701>

Heiko Voigt wrote:
> This fixes the following kind of cvsps issues:
> 
>  Structure of the test cvs repository
> 
>  Message   File:Content         Commit Time
>  Rev 1     a: 1.1               2009-02-21 19:11:43 +0100
>  Rev 2     a: 1.2    b: 1.1     2009-02-21 19:11:14 +0100
>  Rev 3               b: 1.2     2009-02-21 19:11:43 +0100
> 
>  As you can see the commit of Rev 3 has the same time as
>  Rev 1 this was leading to a broken estimation of patchset
>  order.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>

I am not familiar with the cvsps code, so I will just make some comments
about things that it is not obvious from your patch that you have
considered.  These things all caused problems in pre-2.0 versions of
cvs2svn:

1. It is not clear from the patch in what order the revisions are being
processed.  If they are being processed in the order that they appear in
the RCS file, then you have to consider branches:

   * The date adjustment should only occur along chains of revisions
that are "causally related" -- that is, adjacent revisions on trunk, or
adjacent revisions on a branch, or the first revision on a branch
relative to the revision from which the branch sprouted.  It is not
always the case that revisions that are adjacent in the RCS file are
causally related.

   * The revisions along trunk appear in RCS files in reverse
chronological order; e.g., 1.3, 1.2, 1.1 (this seems to be the case you
handle).  But the revisions along a branch appear in chronological
order; e.g., 1.3.2.1, 1.3.2.2, 1.3.2.3.  Do you handle both cases
correctly?  (A unit test involving revisions on branches would be helpful.)

2. One form of clock skew that is common in CVS repositories is that
some computer's CMOS battery went dead and the clock reverted to 1970
after every reboot.  Given that you adjust revisions' times only towards
the past, then such a glitch would force the times of all earlier
revisions to be pushed back to 1970.  (Since you unconditionally
subtract one second from each commit timestamp, this could also
conceivably cause an underflow to 2038, but this is admittedly rather
unlikely.)  This is a hard problem to solve generally.  But if you want
to handle this problem more robustly, I suggest that you always adjust
times towards the future, as incorrect clock times in the far future
seem to be less common in practice.

Of course these clock skew corrections, if only applied to one file at a
time, can easily cause changesets to be broken up if the time deltas
exceed five minutes.

3. When cvsps collects individual file revisions into changesets (within
the 5 minute window), a single "consensus" commit time has to be chosen
from all of the single-file commits.  Depending on how cvsps does this,
it could be that the consensus commit times for two commits involving
revisions within a single file are put back out of order (undoing your
timestamp fixup).  It would be nice to verify that this does not result
in out-of-order commits.

Michael
