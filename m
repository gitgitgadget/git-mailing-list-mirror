From: Thomas Rast <trast@student.ethz.ch>
Subject: Handling racy entries in the v5 format [Re: [GSoC] Designing a faster index format - Progress report week 7]
Date: Wed, 6 Jun 2012 11:45:44 +0200
Message-ID: <87aa0gbwon.fsf@thomas.inf.ethz.ch>
References: <20120604200746.GK6449@tgummerer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <trast@student.ethz.ch>,
	<gitster@pobox.com>, <mhagger@alum.mit.edu>, <pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 11:45:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScCoM-0001yb-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 11:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2FFJpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 05:45:49 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:43726 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab2FFJps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 05:45:48 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 6 Jun
 2012 11:45:43 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 6 Jun
 2012 11:45:44 +0200
In-Reply-To: <20120604200746.GK6449@tgummerer> (Thomas Gummerer's message of
	"Mon, 4 Jun 2012 22:07:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199309>

Hi,

Michael, Thomas and me just had a lengthy discussion on IRC about racy
entries.  I'll use "simultaneously" from the perspective of the
filesystem's mtimes; depending on your USE_NSEC, that may mean in the
same second, or the same nanosecond.


Background: Racy Entries
------------------------

There are two cases of racy index entries:

(A)  echo foo >foo
     git add foo
     echo bar >foo

If the latter two commands happen simultaneously, lstat() will match the
index entry.  Git handles this by checking foo.mtime >= index.mtime, and
if so, doing a content check.  Such entries are called racy.

(B) echo foo >foo
    git add foo     # (i)
    echo bar >foo
    sleep 2
    : >dummy
    git add dummy   # (ii)

If the commands before the sleep happen simultaneously, then foo.mtime
has not changed since (i), but due to (ii) index.mtime has, defeating
the raciness check.  To handle this, git checks for racy entries
*w.r.t. the old index* immediately before it writes a new index.  For
all[1] such entries it does a content check.  All racy entries found to
be modified get ce_size=0, which tells the next git that "we know they
are modified".  We call them "smudged".


The Problem
-----------

The use of ce_size=0 is a problem for index v5.  The current drafts
exclude the size field, instead wrapping it in stat_crc along with most
of the other stat fields.

There are some obvious solutions:

* Put the size field back, costing us 4B/entry.

* Use some other marker field for the v5 format, e.g., the stat crc.

Neither of these is good, for an entirely different reason: The current
scheme checks *all* entries for being racy w.r.t. the old index, before
any write.  This completely defeats the point of index v5: *avoid*
loading the entire index for small changes.


Proposed Solution
-----------------

(Michael, we have adapted it somewhat this since you left IRC.)

  When writing an entry: check whether ce_mtime >= index.mtime.  If so,
  write out ce_mtime=0.

The index.mtime here is a lower bound on the mtime of the new index,
obtained e.g. by touching the index and then stat()ing it immediately
before writing out the changed entries.

Note that this is a fundamentally different approach from the one taken
in v[2-4] indexes.  In the old approach, it is the *next* writer's
responsibility to ensure that all racy entries are either truly clean,
or smudged (since they will presumably lose their raciness).  In the new
approach, racy entries are immediately smudged and remain so until an
update.



Footnotes: 
[1]  Ignoring the case where st_size==0 at the beginning, which needs
some arguing around because st_size is also the smudge marker.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
