From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 0/8] `log -c` speedup (part 2)
Date: Mon,  3 Feb 2014 16:47:14 +0400
Message-ID: <cover.1391430523.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 13:45:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAIuN-0006pd-UQ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 13:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbaBCMpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 07:45:47 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37279 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbaBCMpq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 07:45:46 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAIuC-0004ZE-Tx; Mon, 03 Feb 2014 16:45:41 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAIvz-0007Fd-W6; Mon, 03 Feb 2014 16:47:32 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241426>

Hello up there,

I'm still trying to speedup combined-diff to be not so slow, to be able to
realistically use it in my readonly filesystem for git archives.

In the first part[1], we optimized paths intersections, but combined-diff still
remained slow, because internally it was computing huge diffs, even for small,
or empty output.

This time, here goes paths scanning rework, which results in significant
combine-diff speedup. Please apply.

Thanks beforehand,
Kirill

P.S. the code depends on ks/diff-c-with-diff-order

[1] http://permalink.gmane.org/gmane.comp.version-control.git/240713


Kirill Smelkov (8):
  fixup! combine_diff: simplify intersect_paths() further
  tests: add checking that combine-diff emits only correct paths
  tree-diff: no need to manually verify that there is no mode change for
    a path
  tree-diff: no need to pass match to skip_uninteresting()
  combine-diff: move show_log_first logic/action out of paths scanning
  combine-diff: Move changed-paths scanning logic into its own function
  combine-diff: Fast changed-to-all-parents paths scanning
  combine-diff: bail out early, if num_paths=0

 combine-diff.c                 | 215 +++++++++++++++-----
 diff.c                         |   1 +
 diff.h                         |   6 +
 t/t4057-diff-combined-paths.sh | 106 ++++++++++
 tree-diff.c                    | 442 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 696 insertions(+), 74 deletions(-)
 create mode 100755 t/t4057-diff-combined-paths.sh

-- 
1.9.rc1.181.g641f458
