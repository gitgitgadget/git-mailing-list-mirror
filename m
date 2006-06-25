From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] resurrect format-patch's patch id checking
Date: Sun, 25 Jun 2006 03:50:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 25 03:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJlj-0005ZE-GF
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWFYBuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWFYBuc
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:50:32 -0400
Received: from mail.gmx.net ([213.165.64.21]:1456 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751308AbWFYBub (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:50:31 -0400
Received: (qmail invoked by alias); 25 Jun 2006 01:50:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 25 Jun 2006 03:50:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net, martin@catalyst.net.nz
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22566>


With these patches, you can say

	git format-patch --ignore-if-in-upstream upstream

to get a series of only the patches which are in HEAD, but not upstream.

The first patch adds diff_flush_patch_id() to calculate the patch id, after
a diff queue was set up. (Earlier, I sent out a version which also adds
a command line option to the diff family, but I'll postpone that until
Timo's patches went in).

The second patch adds the actual patch id checking. There are two tricky
things involved:

	- I add a pseudo-object for each patch of the upstream, which has
	  the patch id as sha1. This is no real object, but since we rely
	  on the hashes being unique for all practical purposes, and since
	  it has parsed == 0, it should be no problem.

	- To add the patch ids of the upstream, the revision walker must
	  be called twice.

	  So, if format-patch was called with a range "a..b" (a single
	  revision "a" is handled as "a..HEAD" by format-patch), a revision
	  walker is set up for "b..a", and the patch ids are calculated and
	  stored. This is done by toggling the UNINTERESTING bits of both
	  pending objects.

	  After that, the flags of all objects are reset to 0, so that the
	  revisions can be walked again. The flags of the two pending objects
	  are then reset to their original state.

Note that "--numbered" still works.

WARNING: since it is quite late in this part of the world, _and_ I am known
to produce not-always-optimal patches which could eat your children, please
give this a good beating.

Ciao,
Dscho
