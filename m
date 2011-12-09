From: Thomas Rast <trast@student.ethz.ch>
Subject: [POC PATCH 0/5] Threaded loose object and pack access
Date: Fri, 9 Dec 2011 09:39:32 +0100
Message-ID: <cover.1323419666.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 09:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYvzh-0005RO-1L
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 09:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab1LIIjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 03:39:42 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:15752 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab1LIIjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 03:39:41 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:38 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 9 Dec
 2011 09:39:38 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186618>

Well, just to make sure we're all left in a confused mess of partly
conflicting patches, here's another angle on the same thing:

Jeff King wrote:
> Wow, that's horrible. Leaving aside the parallelism, it's just terrible
> that reading from the cache is 20 times slower than the worktree. I get
> similar results on my quad-core machine.

By poking around in sha1_file.c I got that down to about 10.  It's not
great yet, but it seems a start.

The goal would be to improve it to the point where a patch lookup that
already has all relevant packs open and windows mapped can proceed
without locking.  I'm not sure that's doable short of duplicating the
whole pack state (including fds and windows) across threads, but I'll
give it some more thought before going that route.



Thomas Rast (5):
  Turn grep's use_threads into a global flag
  grep: push locking into read_sha1_*
  sha1_file_name_buf(): sha1_file_name in caller's buffer
  sha1_file: stuff various pack reading variables into a struct
  sha1_file: make the pack machinery thread-safe

 builtin/grep.c   |   60 +++++-----------
 cache.h          |    1 +
 replace_object.c |    5 +-
 sha1_file.c      |  213 +++++++++++++++++++++++++++++++++++++++++-------------
 thread-utils.c   |   30 ++++++++
 thread-utils.h   |   23 ++++++
 6 files changed, 240 insertions(+), 92 deletions(-)

-- 
1.7.8.431.g2abf2
