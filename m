From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 0/2] Fix spurious conflicts with pull --rebase
Date: Sun,  8 Aug 2010 13:04:44 -0600
Message-ID: <1281294286-27709-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, santi@agolina.net, Johannes.Schindelin@gmx.de,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 08 20:57:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiB3e-0008UE-6Y
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 20:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab0HHS5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 14:57:08 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49891 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab0HHS5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 14:57:07 -0400
Received: by pxi14 with SMTP id 14so3442627pxi.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=zjP1DLb+zkSedZPXBGWAI7/duGxHYTh36/iKrXJfEv4=;
        b=ZImrK2WaAKRXcQ+ijK5SvJzxLf+sm/lOwuCzMsrYJVookeJgpD+bh8fGJx3a1OoVhs
         79x105n3i8pjRBNQTL6tWBTuCl2h4iGWWlC6p9fBKRPkYIm4DibVyNm4Zat2PZ0Z57R5
         39XQMauKQWXYhs/S2ypj0ZbBjpA1WoRObmtGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xHODEyw1sHabubuZCLTW7/jvWLHMpJscjpstrNCQqf8Dkhq6JhunDtvrbpGJdkF4Jw
         FyZHLvqmCV3FMabLmg+F1B+kwclKHQPtj5esygLF8SZLMFUGdptKIB8nECOdEfvXUG+7
         LMk4QH+PO6WduRt6T5mni1EeS5kytMdI3NTrk=
Received: by 10.142.48.18 with SMTP id v18mr12575236wfv.100.1281293824927;
        Sun, 08 Aug 2010 11:57:04 -0700 (PDT)
Received: from localhost.localdomain (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id w27sm5425196wfd.5.2010.08.08.11.57.02
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 11:57:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.28.g92467.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152918>

This patch series fixes spurious conflict issues with git pull
--rebase for the case where the upstream repository is *not* rebased.
(There is no change in the case where the upstream repository is
rebased.)

In c85c79279d and d44e71261f, the call to git-rebase was modified in
an effort to reduce the number of commits being reapplied, by trying
to avoid commits that upstream already had or has.  It was
specifically designed with an upstream that is rebased in mind.
Unfortunately, it had two side effects for the non-rebased upstream
case: (1) it prevented detecting if "local" patches are already
upstream, and (2) it could in some cases cause more patches known to
be upstream to be reapplied rather than less.  This series fixes both
of these issues for the non-rebased upstream case.  See the commit
message of the second patch for details.

It's worth noting that issue (1) above also affects the case where the
upstream repository has been rebased, which this patch series does not
address.  As far as I can tell, fixing it would require changes
(including new syntax) to format-patch to allow it to be told what
'upstream' is, and some changes to git-pull.sh/git-rebase.sh to pass
it this information.

Changes since the last posting of these series:
  * Rewrite cover letter and commit messages for clarity
  * Avoid sed -i in the testsuite to improve portability

Elijah Newren (2):
  t5520-pull: Add testcases showing spurious conflicts from git pull
    --rebase
  pull --rebase: Avoid spurious conflicts and reapplying unnecessary
    patches

 git-pull.sh     |   34 ++++++++++++++++++++-----------
 t/t5520-pull.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 12 deletions(-)

-- 
1.7.2.1
