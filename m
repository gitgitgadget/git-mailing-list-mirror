From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 0/2] fetch-pack: log(n)-transmission find_common()
Date: Sun,  7 Dec 2008 00:20:19 +0100
Message-ID: <1228605621-29685-1-git-send-email-trast@student.ethz.ch>
References: <alpine.LFD.2.00.0810281034500.13034@xanadu.home>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 00:21:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L96T1-0007ZB-2F
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 00:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbYLFXU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 18:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbYLFXU0
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 18:20:26 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:22011 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227AbYLFXUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 18:20:25 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 7 Dec 2008 00:20:23 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 7 Dec 2008 00:20:23 +0100
X-Mailer: git-send-email 1.6.1.rc1.369.g2b340
In-Reply-To: <alpine.LFD.2.00.0810281034500.13034@xanadu.home>
X-OriginalArrivalTime: 06 Dec 2008 23:20:23.0753 (UTC) FILETIME=[36F8FB90:01C957F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102484>

If you still know what this was about, you can skip ahead to the "=="
marker below.


The mail that started it all was

  http://kerneltrap.org/mailarchive/git/2008/9/17/3328364

  [Abstract:]
  Using two passes, first exponential stride through history, then
  bisection on the "right" windows, we implement the find_common
  handshake in log(history_size) many transmissions.  The followup
  patch partially achieves that, but a few points are open and strict
  backwards compatibility is missing (but its absence is Mostly
  Harmless).

This spawned out of a problem originally reported on IRC where pulling
several disjoint histories together takes ages (due to the load on the
server caused by ok_to_give_up()).  Apparently this is a common
workflow in the Ruby-on-Rails.  The bound on the number of
transmissions holds in other cases too, of course.

The idea attracted some interest, but to my knowledge nobody actually
reviewed the code, and it eventually died because of Nicholas's
finding:

Nicolas Pitre wrote:
> FWIW, I had to back this patch out from my version as things seemed to 
> fall into an infinite loop of ref negotiation while fetching the Linux 
> kernel repository at some point.  Doing a "git fetch -v -v" turned up an 
> endless stream of "got" and "have" lines.  I was in a hurry for $work so 
> didn't think of preserving my local refs for reproduction of the 
> problem.

Unfortunately, I was never able to reliably reproduce this problem.
(IIRC I did once when running an automated hammering script but it
vanished when I tried again manually.)



==

After a long break, I decided to pick this up again.  I'm not sure
this is the best time to do so, but I had the time to spare, and
(unless there are more serious bugs, and Gods and Junio willing) we
might get it into 'next' sometime early in the next cycle for better
testing.

I rewrote the core of the algorithm, though some helpers and most of
the glue to surrounding routines are still the same.  I took the
following design decisions that weren't in v2:

0. Lots of comments.  Well, by my standards in any case.

1. The old code stays.  I mostly want to make it (far) easier to be
   certain that it behaves exactly as before if the server does not
   support disabling ok_to_give_up().  [The idea is that it should be
   easy to verify that 1/2 is a no-change refactoring and 2/2 only
   does something if the server supports it.]

2. The work list now uses a Fibonacci heap to order jobs.  I'm not
   religious about the specific flavour of heap, but I had the
   description of these handy.  (The work list can get rather large.)

3. The bisection is essentially precomputed.  By staring at the binary
   representation of the distance from the starting commit hard
   enough, it can be constructed during the stride pass.  Barring a
   circular bisection "tree", the algorithm is now guaranteed to
   terminate even if it, say, emits too many or too few sha1s due to
   some other bug.

The last point of course means that the main work is now in the
tangled mess that is get_rev_new_stride(), and "staring hard enough"
frequently enough meant grabbing a notepad.  YMMV.

While I did run a lot of tests, including 'make test' and some
automated hammering, it seems quite hard to make sure it _really_
bisects correctly (except manually in toy examples, such as two linear
histories with a common base).  Suggestions for automated tests
welcome.

To see the effects of the patch, try

  git fetch-pack -v -k <url> <head> 2>&1 \
    | git name-rev --stdin refs/heads/master

with a daemon that supports the feature.
