From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 0/4] fix log -L -M
Date: Fri, 12 Apr 2013 18:05:08 +0200
Message-ID: <cover.1365781999.git.trast@inf.ethz.ch>
References: <87ppy0gjic.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:05:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgTd-0000XF-1p
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab3DLQFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:05:19 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6611 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab3DLQFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:05:18 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:16 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:15 +0200
X-Mailer: git-send-email 1.8.2.1.567.g8ad0f43
In-Reply-To: <87ppy0gjic.fsf@linux-k42r.v.cablecom.net>
X-Originating-IP: [213.55.184.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220987>

Ok, so this was not quite as bad as I feared.  The move support as far
as I had thought to test it previously actually worked ok, it just
wasn't tested (which is embarrassing enough).

The bug fixed in patch 3 is a bit more involved and only triggered by
history that merges a rename with a modification to the original
filename.  Luckily -- I guess -- there are several cases of this
happening in git.git around the big builtin/ move in 81b50f3 (Move
'builtin-*' into a 'builtin/' subdirectory, 2010-02-22).  So my fuzz
tests found that problem.  You can reproduce with e.g.

  git log -M -L:cmd_format_patch:builtin/log.c

in any git.git.


Thomas Rast (4):
  t4211: pass -M to 'git log -M -L...' test
  log -L: test merge of parallel modify/rename
  log -L: store the path instead of a diff_filespec
  log -L: improve comments in process_all_files()

 line-log.c                               |  62 +++++++-----
 line-log.h                               |   8 +-
 t/t4211-line-log.sh                      |  18 +++-
 t/t4211/expect.move-support-f            |  56 +++++++++--
 t/t4211/expect.parallel-change-f-to-main | 160 +++++++++++++++++++++++++++++++
 t/t4211/history.export                   |  80 +++++++++++++++-
 6 files changed, 344 insertions(+), 40 deletions(-)
 create mode 100644 t/t4211/expect.parallel-change-f-to-main

-- 
1.8.2.1.567.g8ad0f43
