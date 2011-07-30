From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Sat, 30 Jul 2011 18:28:26 +1000
Message-ID: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com, jnareb@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 10:28:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn4uj-0002FL-Vx
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 10:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab1G3I2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 04:28:47 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36729 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1G3I2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 04:28:43 -0400
Received: by pzk37 with SMTP id 37so7731148pzk.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Gbsz7i1dUPThauNHo3J7jH5FamYmNHq6CTXt+wCd44I=;
        b=gfiDSgC91lpICI7dsCtGlTkkOtrFxURc+aKwZ751vjTNFH7g050qGEI3+T51mKBAUN
         77A1ilc76XXxLsN0NwEmrwiWQpDszo8snEkyqb0Qfq/MWC+JZyXpkl9vqXBE/L9lhkCb
         dw3A/7dOPkFfvN3ENFA4+KcexB9KxCQQSZU1s=
Received: by 10.68.42.131 with SMTP id o3mr3829669pbl.514.1312014523488;
        Sat, 30 Jul 2011 01:28:43 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id p7sm3012490pbn.65.2011.07.30.01.28.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jul 2011 01:28:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.387.g991c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178180>

For some bisection tasks, checking out the commit at each stage of the bisection process is unecessary or undesirable.

This series adds support for a --no-checkout[=<ref>] option to git-bisect.

If specified, this option causes git-bisect to update the specified reference at each stage of the bisection process instead of checking out the commit at that point. If <ref> is not specified, HEAD is assumed.

One application of this option is to find, within a partially damaged repository, the earliest commit such that the graph of commits, trees and blobs reachable from the parents of that commit is completely reachable. 

For example:

    git bisect start HEAD <known-good-commit> [ <damaged-or-missing-commit> ... ]
    git bisect run eval '
    	git rev-list --objects HEAD > /dev/null && 
	git rev-list --objects HEAD | git pack-objects --stdout >/dev/null || 
	false'

Assuming this git bisect run completes successfully, bisect/bad will refer to the first commit whose parents have completely reachable graphs.

This series is a reworking of an earlier series "bisect: allow git bisect to be used with repos containing damaged trees." that incorporates Junio's suggestion to add a --no-checkout option instead of an --ignore-checkout-failure option.

Jon Seymour (5):
  bisect: add tests to document expected behaviour in presence of
    broken trees.
  bisect: introduce support for --no-checkout=<ref> option.
  bisect: introduce --no-checkout[=<ref>] support into porcelain.
  bisect: add tests for the --no-checkout option.
  bisect: add documentation for --no-checkout[=<ref>] option.

 Documentation/git-bisect.txt |   26 ++++++++-
 bisect.c                     |   26 +++++++-
 bisect.h                     |    2 +-
 builtin/bisect--helper.c     |    7 ++-
 git-bisect.sh                |   45 ++++++++++++--
 t/t6030-bisect-porcelain.sh  |  132 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 223 insertions(+), 15 deletions(-)

-- 
1.7.6.387.g991c2
