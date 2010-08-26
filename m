From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 0/8] Make rev-list --objects work with pathspecs; minor optimizations
Date: Thu, 26 Aug 2010 00:21:43 -0600
Message-ID: <1282803711-10253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 08:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVp6-0002DN-Be
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab0HZGUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:23 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34823 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0HZGUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:21 -0400
Received: by yxg6 with SMTP id 6so511700yxg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Y9xjgVTipLtIcgxOmTOECf3vzIe+26jUz+2gx2hUVZo=;
        b=g2aFsot6SStX7J/3FQd2kSQRCYzHZ8pArIsXQdZwblvwjoiJ5NzstgBNTKBssqOSt2
         3DJtSej2SrZY4toNXXrsVgPg6IMPA270CfGNhexxnOdqk5J3gOC0Ar2Abvbtnj49+rK1
         eMnSsx7n3x04nT8xfchnza6mKQwi3kBCAryb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WJSkmAbi+WsJIU+G7C0yWibvALRjCYK9Jj/7hf70bm5K8kW+rIieOM8e/ZpAXS2j2Y
         8DdsQ/RZ/v2nfY/EfoYlXdAy6D3xT0vZiBDADVSOWoQxgn0uiS348vcuidqCC8YHwPc+
         IrTf+lFSva6JTYT4m/D2+zloXiQaPPOMjWCpg=
Received: by 10.151.69.21 with SMTP id w21mr9708362ybk.428.1282803621317;
        Wed, 25 Aug 2010 23:20:21 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154517>

This series enables rev-list to produce a list of objects that is path
limited, when the user requests it.  It also provides a few small code
cleanups and some small optimizations.

Changes since last round:
  * Patch 1 has two new testcase; one that triggered a bug I found,
    and an interesting case Junio mentioned needed to work.
  * Patch 2 will have fewer mallocs/frees in some cases (a suggestion
    from Nguyen Thai Ngoc Duy), and corrects an issue from the first
    series with how it calls tree_entry_interesting.
  * Patch 3 is new; it adds a simple code comment that would have
    alerted me to avoiding the bug in the first round of the series.
  * Patches 4-8 are unchanged.

As before, the last two patches are weatherballons.  They can be
silently dropped.

Updated timings, for the curious:
 A git rev-list --quiet HEAD
 B git rev-list --quiet HEAD -- Documentation/
 C git rev-list --quiet HEAD -- t/
 D git rev-list --objects HEAD > /dev/null
 E git rev-list --objects HEAD -- Documentation/ > /dev/null
 F git rev-list --objects HEAD -- t/t9350-fast-export.sh > /dev/null
Results:
             A      B      C      D      E      F
maint       0.34   0.68   1.33   1.90   1.39   0.65
Patch-1     0.34   0.68   1.33   1.90   1.38   0.65
Patch-2     0.34   0.68   1.33   1.88   0.97   0.66
Patch-3     0.34   0.68   1.33   1.88   0.97   0.65
Patch-4     0.34   0.67   1.33   1.87   0.97   0.65
Patch-5     0.34   0.68   1.33   1.88   0.97   0.65
Patch-6     0.34   0.65   1.28   1.87   0.93   0.65
Patch-7     0.34   0.65   1.29   1.86   0.94   0.65
Patch-8     0.34   0.65   1.28   1.85   0.93   0.65



Elijah Newren (8):
  Add testcases showing how pathspecs are ignored with rev-list
    --objects
  Make rev-list --objects work together with pathspecs
  Document pre-condition for tree_entry_interesting
  tree-walk: Correct bitrotted comment about tree_entry()
  tree_entry_interesting(): Make return value more specific
  diff_tree(): Skip skip_uninteresting() when all remaining paths
    interesting
  list-objects.c: Avoid recomputing interesting-ness for subtrees when
    possible
  tree-diff.c: Avoid recomputing interesting-ness for subtrees when
    possible

 diff.h                   |    1 +
 list-objects.c           |   34 +++++++++++++++++++++++---
 revision.c               |    8 ++++-
 revision.h               |    3 +-
 t/t6000-rev-list-misc.sh |   51 +++++++++++++++++++++++++++++++++++++++
 tree-diff.c              |   60 +++++++++++++++++++++++----------------------
 tree-walk.h              |    4 ++-
 7 files changed, 124 insertions(+), 37 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh

-- 
1.7.2.2.45.ga60f
