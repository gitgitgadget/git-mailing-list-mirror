From: Thomas Rast <trast@inf.ethz.ch>
Subject: Clarifications on the "faster index format" project
Date: Wed, 28 Mar 2012 02:36:49 +0200
Message-ID: <878vilr272.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>
To: Thomas Gummerer <t.gummerer@gmail.com>,
	elton sky <eltonsky9404@gmail.com>,
	Calvin Deutschbein <deutschbeinc@gmail.com>,
	Mauricio Galindo <up.mauricio.g@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 02:37:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCgt5-0001Qs-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 02:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456Ab2C1Agx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 20:36:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:52872 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab2C1Agx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 20:36:53 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 28 Mar
 2012 02:36:50 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 28 Mar
 2012 02:36:49 +0200
User-Agent: Notmuch/0.3.1-59-g676d251 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-suse-linux-gnu)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194101>

Dear students,

The proposal "Designing a faster index format" has attracted quite a bit
more attention that we expected.  We would like to emphasize that it is
not an easy project.

I have myself only found out about most of the points I am listing here
through interaction with students.  My apologies for this.  Take them as
a (non-exhaustive!) list of concerns.  The more of them you can address
in your proposal, the better.

Issues with the original project idea:

- Further timings have shown that even on humongous indexes such as
  Webkit's (roughly 25MB), git-add is still pretty fast.  It is a good
  baseline for what index-changing commands need to do however.  Judge
  from your own timings and state what case you want to optimize.

- The notation is confusing.  Asymptotics noted in the proposal should
  distinguish the variables "# index entries" (n), "# changed entries",
  and depending on the application also "size of index file" (though
  this is fairly tightly coupled with n) or other variables.

Some hardnesses that we expect:

- Without prior knowledge of the index, it is hard to see how a new
  format must be designed to stay within the requirements.

- The index format is closely tied to a lot of core git's code.  The
  main work of git-ls-files, git-status, git-read-tree, git-add,
  git-diff etc. all directly accesses the index memory structure.  This
  means that changing the in-memory structure is a lot of work.

- Changing the in-memory structure also makes conversion between the old
  and new format more difficult.

- Writing out only the changed entries would save a lot of time.
  However there are many code paths that change/add/remove index
  entries, and they must all record what to write in some way.

- Cutting down the amount of verification going on is very tempting, but
  needs careful design to keep the chances of a bit error propagating
  all the way into the repository small.

There are many tradeoffs to be made, which must be evaluated carefully:

- If the current lock-rewrite-rename scheme remains in place, any change
  only affects the in-core work done.  If the lock scheme is changed,
  there are many different cases of corruption/partial writes that must
  be handled.

- There may be ways to reduce the data written (and thus checksummed) at
  the cost of extra work.  Similarly, a more complex data structure may
  or may not pay off depending on the extra space taken (or saved) and
  extra bookkeeping done.

- Some improvements would be possible by using techniques from database
  libraries.  However, this either means an external dependency or a lot
  of extra work.  It may also come with extra startup costs.

- Using database libraries may be a deal-breaker for git's own
  portability or the other readers (libgit2 and jgit, mainly).

The format should cope with requirements that are not clearly specified
at this time.  For example:

- The existing code also assumes that iterating over an index is not a
  problem.  For possible future work, the format should allow for
  iterating over only a select part of the index (known, e.g., from an
  inotify daemon or a pathspec) quickly.

Finally I have a request not related to project hardness: please Cc the
proposed mentors for discussions on the respective projects :-)

Thanks for reading,

Thomas

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
