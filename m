From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 0/6] fix hunk editing with 'commit -p -m'
Date: Thu,  6 Mar 2014 15:50:18 +0100
Message-ID: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 15:50:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLZdM-0005Cd-JS
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 15:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbaCFOuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 09:50:46 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:48501 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaCFOuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 09:50:44 -0500
Received: by mail-wg0-f50.google.com with SMTP id x13so3267216wgg.33
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=hyGgtCqhtVOMqJdX7D4q7yEEYGaad9EsBnC1QO1g/v0=;
        b=gu40/ijfmOG82M5KX0ZLYL/47pdGFuBTPMP3PSmNNAGAvOFnLIHMIpAhXBBwdYJiD3
         QrPHPgFqUaHgS7gF4gWZnFGC9egWBu+/Fuqlc343M0n3q1bDUGi3DWASYqUrjJrJjVM/
         hU/7BKZmjAC61apybyYq5z1aw3FskZpJgkAgX622dR5UinDo9m6BNYvGxWdwgeK052wr
         7Fzymnb0ZXRAjTOefnwjIgplkLOOHde1BxR1utQJnZhU5tcxjZwJm5oruOl09WtU0JVr
         EXvszvZcQJ5/QcDp81I8mAiKwHFreWTOC8jYJxM+LXJUuUHzLpsq+D6H5hQAiPr93HT/
         RrGQ==
X-Received: by 10.194.234.106 with SMTP id ud10mr11133856wjc.0.1394117431255;
        Thu, 06 Mar 2014 06:50:31 -0800 (PST)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id dk9sm17958006wjb.4.2014.03.06.06.50.29
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2014 06:50:30 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243515>

This patch fixes the fact that hunk editing with 'commit -p -m' does not work:
GIT_EDITOR is set to ':' to indicate to hooks that no editor will be launched,
which result in the 'hunk edit' option not launching the editor (and selecting
the whole hunk).

The fix consists in deferring the GIT_EDITOR override to the hook subprocess,
like it's already done for GIT_INDEX_FILE:
- modify 'run_hook' so the first parameter is the environment to set
- add a 'run_hook_v' variant that take a va_list
- add a new 'run_commit_hook' helper (to set both GIT_EDITOR and GIT_INDEX_FILE)

N.B.: the merge builtin 'prepare-commit-msg' hook handling has also been updated
to be consistent; i.e. GIT_EDITOR will not be set to ':' if the '--edit' option
is used.

Benoit Pierre (6):
  test patch hunk editing with "commit -p -m"
  commit: fix patch hunk editing with "commit -p -m"
  merge: fix GIT_EDITOR override for commit hook
  merge hook tests: fix and update tests
  merge hook tests: fix missing '&&' in test
  merge hook tests: use 'test_must_fail' instead of '!'

 builtin/commit.c                   | 35 ++++++++++++++++++++++++++++-------
 builtin/merge.c                    |  4 ++--
 commit.h                           |  3 +++
 run-command.c                      | 27 +++++++++++++++------------
 run-command.h                      |  3 ++-
 t/t7505-prepare-commit-msg-hook.sh | 23 +++++++++++++++++++----
 t/t7513-commit_-p_-m_hunk_edit.sh  | 37 +++++++++++++++++++++++++++++++++++++
 7 files changed, 106 insertions(+), 26 deletions(-)
 create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh

-- 
1.9.0
