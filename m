From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 0/5] Memory-limited pack-object window support
Date: Wed, 11 Jul 2007 22:14:13 -0500
Message-ID: <11842100581060-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 05:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8p8K-0005sZ-Sv
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 05:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765377AbXGLDOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 23:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765356AbXGLDOT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 23:14:19 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:60167 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759339AbXGLDOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 23:14:17 -0400
Received: by silvara (Postfix, from userid 1000)
	id 1754752133; Wed, 11 Jul 2007 22:14:18 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52238>

This patch series implements a memory limit on the window size for
pack-objects and repack.  Basically, the window size will temporarily
grow smaller than the --window option specifies if the total memory
usage of the window is over the specified limit.

With this series I can run even with --window=1000 on my troublesome
repository (described in an email a couple of days ago; basically, it
has a 20MB file with around 200 revisions, plus a bunch of normal sized
files) with memory usage limited to 512MB and it will happily scale down
the window to accommodate the file without blowing out my machine.

The --window option still specifies the size of the window and is still
required; the window will not grow to reach the memory limit, it will
only shrink to fit.  I think this may be a feature, as running with a
very large window depth and a memory limit basically means that you will
pack at an approximately constant slow speed, rather than rushing ahead
as it does now for very small objects.

I took the easy way out and expire objects out of the window after
allocation has occurred, rather than figuring out how much needed to
be cleared before allocating.  This made the logic much more feasible,
though.

I chose --window-bytes=N and pack.windowBytes=N as my option and
configuration names.  I'm not in love with them, though; no other
configuration in Git mentions bytes in the name as far as I can see,
but I wanted to clearly differentiate it from the window "size" that
--window gets you.

The first patch in this series is optional, but I recommend it.  It makes
it so that files that are much smaller than a potential delta source
don't even try to delta with it.  This is handy for running in a mixed
file size repository with a large window, as it means that when you get
to small files again you start moving fast without having to wait for
the large objects to trickle out of the window.  The cut-off is currently
if it is 1/32 the size, but that number was completely arbitrary.

 [PATCH 1/5] Don't try to delta if target is much smaller than source
 [PATCH 2/5] Support fetching the memory usage of a delta index
 [PATCH 3/5] Add pack-objects window memory usage limit
 [PATCH 4/5] Add --window-bytes option to git-repack
 [PATCH 5/5] Add documentation for --window-bytes, pack.windowBytes

 Documentation/config.txt           |    5 +++
 Documentation/git-pack-objects.txt |    8 +++++
 Documentation/git-repack.txt       |    8 +++++
 builtin-pack-objects.c             |   58 +++++++++++++++++++++++++++++++----
 delta.h                            |    7 ++++
 diff-delta.c                       |   10 ++++++
 git-repack.sh                      |    3 +-
 7 files changed, 91 insertions(+), 8 deletions(-)

-bcd
