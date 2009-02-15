From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 0/2] The ext4 filesystem and racy git
Date: Sun, 15 Feb 2009 20:46:13 +0100
Message-ID: <cover.1234720401.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 20:47:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmxv-0001UZ-2U
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbZBOTqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbZBOTqS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:46:18 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:37965 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbZBOTqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:46:17 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KF400GLLHL4VQA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Feb 2009 20:46:16 +0100 (CET)
Received: from localhost.localdomain ([80.202.92.249])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KF4000XQHL3HX70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 15 Feb 2009 20:46:16 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110044>

Ext4 is marked stable in Linux v2.6.28, and I have done a very simple
test on one disk-partition of my slow laptop, and the numbers look
very promising.

With default created ext3 disk-partition on my harddisk the 'git
checkout -q my-v2.6.25/27' test takes around 20 seconds real time for
the best cases.  The same test run on a ext4 partition takes around 14
seconds for the best cases.

And, since ext4 supports nanosecond timestamps, when I added patch
2/2, the checkout time is much more stable and more close to 14-15
seconds most of the time.

Conclusion: for GIT on my laptop the ext4 filesystem is a speedup!

>From '/proc/mounts' here is the mount options:

  /dev/hda10 /home ext3 rw,noatime,errors=continue,data=ordered 0 0
  /dev/hda12 /opt2 ext4 rw,noatime,barrier=1,journal_async_commit,data=ordered 0 0

/dev/hda10 is formatted with default (gentoo) ext3 parameters, and the
/dev/hda12 is formatted with:

  /sbin/mkfs -t ext4 -I 256 -G 64 -Oflex_bg,uninit_bg /dev/hda12


Kjetil Barvik (2):
  fix compile error when USE_NSEC is defined
  make USE_NSEC work as expected

 builtin-fetch-pack.c |    4 +-
 cache.h              |    6 ++--
 read-cache.c         |   70 ++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 61 insertions(+), 19 deletions(-)
