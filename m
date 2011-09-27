From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 0/2] Debugging tools for get_pathname()
Date: Tue, 27 Sep 2011 06:28:05 +0200
Message-ID: <1317097687-11098-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 06:29:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8PI9-0006KN-Go
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 06:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab1I0E3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 00:29:03 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58799 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1I0E3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 00:29:01 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB231.dip.t-dialin.net [84.190.178.49])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8R4SE3Q023431;
	Tue, 27 Sep 2011 06:28:14 +0200
X-Mailer: git-send-email 1.7.7.rc2
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182209>

I just wasted a bunch of time diagnosing a problem that was caused by
other code's misuse of a temporary buffer created by get_pathname()
(patch forthcoming).  The bug was triggered by totally unrelated (and
innocent) code changes that I had made.  I found it quite difficult to
figure out the source of the problem.

It is probably obvious to everybody else, but here are the two tricks
that finally enabled me to diagnose the problem:

1. I increased the number of temporary buffers available to
   get_pathname().  This made the test suite failure go away, which
   was a good indication that the problem was related to the buffers.

2. I changed get_pathname() to allocate and free the buffers instead
   of using statically-allocated buffers.  This made it trivial to
   find the offender using valgrind.

This patch series make it easier to apply these tricks.  I hope it
helps somebody else avoid the pain that I just experienced.

Michael Haggerty (2):
  Make the number of pathname buffers a compile-time constant
  Make misuse of get_pathname() buffers detectable by valgrind

 path.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 2 deletions(-)

-- 
1.7.7.rc2
