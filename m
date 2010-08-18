From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 0/8] detached-stash: regularise handling of stash arguments by git stash
Date: Wed, 18 Aug 2010 23:07:57 +1000
Message-ID: <1282136885-24190-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:08:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OliNt-0000Kk-Jb
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab0HRNIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:08:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62960 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab0HRNIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:08:43 -0400
Received: by pwi4 with SMTP id 4so292485pwi.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KafjchTHM5lPq7EZqUMvpmO2N8Azm6YVwDKjuqOgDSM=;
        b=KB6CYurVldCpXadNO/H/cwFJDtm9y2shyPL3kiGfLxFwXNijo2kvg7lc+Wcbi0Rime
         IUex+cBvUVfTb7w8C/d+dto2kTk1YujL8+Aet2bGmxa49TFvhUTwZOofhvsYuYybso4C
         lgztVDZU9QNtkwhKn+OF52X94sLniVoKRvfMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z6JESUBC4+9lrBDsHrt+5pmlWbrD5qaHUt5HNmqcUaGpsY0eYdKkY9XnmtdvWpGA9P
         pkVONjaYDC3dsQe7T022Pf92IH6UIKf5bCwslqFQaGdNoJ0l+UvjGJg+yi3BhnY7jHsr
         DM/Bm6z10o0VSvlelzM4xfiAj9ghtn/kDiUzo=
Received: by 10.142.204.17 with SMTP id b17mr7003086wfg.184.1282136923285;
        Wed, 18 Aug 2010 06:08:43 -0700 (PDT)
Received: from localhost.localdomain ([120.16.55.229])
        by mx.google.com with ESMTPS id 23sm302973wfa.22.2010.08.18.06.08.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:08:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g4fabf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153836>

This patch introduces a common flags and revision parsing function to the following git stash commands:
 * apply
 * branch
 * pop
 * drop
 * show

With these changes, git stash now:
 * allows non-stash log entry references to passed to 'stash branch' provided they are stash-like
 * relaxes the requirement that a stash log currently entry exists for 'stash show' or 'stash branch' 
 * does not attempt to drop the specified revision if it doesn't look like a stash log entry reference
 * fails 'stash pop' and 'stash drop' early if the specified revision is not a stash log entry reference
 * fails early if more than one stash-like commit is specified
 * fails early if the specified revision is of the form ref@{n} and ref exists, but ref@{n} does not exist
 * reports various error conditions that can occur across multiple commanbds with consistent error messages.

The implementation of several commands is simplified to a lesser or greater degree by taking
advantage of the new common parsing and validation function, parse_flags_and_rev(). 

This revision incorporates feedback and corrections from Johannes Sixt and Junio Hamano.

Jon Seymour (8):
  detached-stash: introduce parse_flags_and_revs function
  detached-stash: simplify stash_apply
  detached-stash: simplify stash_drop
  detached-stash: refactor git stash pop implementation
  detached-stash: simplify git stash branch
  detached-stash: simplify git stash show
  detached-stash: tests of git stash with stash-like arguments
  detached-stash: update Documentation

 Documentation/git-stash.txt |   16 ++-
 git-stash.sh                |  223 ++++++++++++++++++++++++++++---------------
 t/t3903-stash.sh            |  140 +++++++++++++++++++++++++++
 3 files changed, 296 insertions(+), 83 deletions(-)

-- 
1.7.2.1.95.g969a4.dirty
