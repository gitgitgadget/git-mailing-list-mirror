From: Luke Diamand <luke@diamand.org>
Subject: [RFC/PATCHv1] git-p4: label import: first draft
Date: Sat, 17 Mar 2012 10:44:40 +0000
Message-ID: <1331981081-25598-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luked@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 11:45:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8r87-00023Z-70
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 11:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974Ab2CQKox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 06:44:53 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60408 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756743Ab2CQKow (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 06:44:52 -0400
Received: by wibhj6 with SMTP id hj6so1902292wib.1
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 03:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=Y0+LYiBGtTPgmJnVwD3PhlZWs3Uh7wemPnAffkWzqvE=;
        b=mVblIXKzpeOF5i2WRrvbb+u6jPfpATBUV32F2Vsm2qw9VIZjYEh8OMynSV2I0aHGug
         gDBRlMGdRIMf4QVZL3VqI68/v292thegShKHXZQu277V6//HhZL3jY/agQVgvuA7wRYz
         hc2z9sal+yL+uCtx3IasxRiqLrQnW/O04C0cNVTimnVgluub5CZulRLiOnOkKiypr+Ob
         pmFrrRQJriOEQvJRNmJDkCjSIr5XHq9GfTHkVgK7k9AD6zrbrPNpms2f8rB+nR23cCbj
         UrXZO6fJFkM+Z8yI8Ewp45iKBDqLuHhPcSstGk+gHxPENWuYxA09qlTE+r2BRsZ45FIY
         znDg==
Received: by 10.180.85.35 with SMTP id e3mr5546898wiz.6.1331981090970;
        Sat, 17 Mar 2012 03:44:50 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id j3sm10811407wiw.1.2012.03.17.03.44.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 03:44:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0.1.gab923
X-Gm-Message-State: ALoCoQkF70Ds6bD3CcfZ9dqx/EKCsCV21wGZt4fEGG3kCDfjho2W4GwmZnkTrFndktI9RLkSXkXu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193316>

From: Luke Diamand <luked@diamand.org>

The existing label import code (--detect-labels) looks at each
commit being imported, and then checks for labels at that commit.

This doesn't work in the real world though because labels applied
in changelists that have already been imported are ignored. e.g.:

% p4 submit -d 'a change'
% git-p4 rebase
% p4 tag -l TAG ...
% git-p4 sync --detect-labels

TAG will never be detected.

Additionally the existing label detection has some annoying shortcomings

* It gets the list of files at each label every time git-p4 is run,
  which on a large repo with many labels is a problem. The new
  scheme only pays this price the first time a label is seen.

* It only imports a label if the number of files in the label matches
  the number of files in the repo at the highest revision found. This
  is to cope with the way that git tags and p4 labels cannot be
  directly mapped to each other. In practice this is not a useful rule,
  for example if the p4 tag was applied across a wider area of the tree
  than just the part being imported by git-p4, then the tag is ignored.
  The new code just checks that there are no diffs between the label
  and the p4 changelist to be used.

The new code gets the lists of git tags and p4 labels, and then creates
git tags for all the missing p4 labels. Any labels that could not be
imported are added to an ignore-list so that they are not repeatedly
queried. A regular expression can be specified to limit the p4 label
patterns that will be imported.

Limitations:

* The code currently doesn't know anything about branch-based setups, and
  has 'p4/master' hardcoded as the branch to search for git revisions. I
  haven't yet thought about the best way to handle this, which is why this
  is only an RFC at this stage. I would welcome suggestions on the best way
  to deal with this.

* The code uses "git log --grep" to get from a p4 changelist to a git
  commit. This means it doesn't work on older versions of git, e.g.
  git 1.7.0. Arguably it should use gitCommitByP4Change().

* The unit tests could be expanded.

Thanks,
Luke

Luke Diamand (1):
  git-p4: improved import of labels from p4

 Documentation/git-p4.txt       |   15 +++-
 contrib/fast-import/git-p4     |  152 +++++++++++++++++++++++++++++++---------
 t/t9811-git-p4-label-import.sh |  116 ++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+), 35 deletions(-)
 create mode 100755 t/t9811-git-p4-label-import.sh

-- 
1.7.10.rc0.158.gd9e55
