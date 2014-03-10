From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH V2 0/7] fix hunk editing with 'commit -p -m'
Date: Mon, 10 Mar 2014 19:49:30 +0100
Message-ID: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:49:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5Gp-00053J-2i
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbaCJStq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:49:46 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:58456 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaCJStp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:49:45 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so8800793wgh.16
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=bBL8XfP3f3tAZsEYaAx4JYE4PX17CLpo0xRfJNqDYak=;
        b=FJqc3ffzSSLUkR5wmGoJJw/mSwluMtY7WMrWVJC+Y6/eAC6zRau9FOySMlGsk7vvJo
         RwoA0kIz3GhqMAVeAAN93f6vjDcLnG+QoFR3gtgch2CYyaQCiRJZ5bFlHEmWZexIM/08
         I386aPwxIwU3bLjYPPR4OxUHQv5qkP8dHqaVV8i9VP+JR8qgSRZg4H3ogIlCvGyK7CgE
         n/J6ijfN52W2lG7d99eJuoFvgGa2F0QPfFn5yhwMj+L9+yUkJ5sNd1PFZgvQJbk4MOk4
         dKo7JEYcSgVGX6KO2c+0YW5rU45Nggqy4iBX6KzuMVTnbXcsz8czclPtkB+3UTE0kBL4
         8e9w==
X-Received: by 10.194.2.194 with SMTP id 2mr3048857wjw.73.1394477384373;
        Mon, 10 Mar 2014 11:49:44 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id z1sm54391971wjq.19.2014.03.10.11.49.42
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 11:49:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.7.gca5104e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243785>

This patch fixes the fact that hunk editing with 'commit -p -m' does not work:
GIT_EDITOR is set to ':' to indicate to hooks that no editor will be launched,
which result in the 'hunk edit' option not launching the editor (and selecting
the whole hunk).

The fix consists in deferring the GIT_EDITOR override to the hook subprocess,
like it's already done for GIT_INDEX_FILE:
- rename 'run_hook' to 'run_hook_le' and change the first parameter to the environment to set
- add a 'run_hook_ve' variant that take a va_list
- add a new 'run_commit_hook' helper (to set both GIT_EDITOR and GIT_INDEX_FILE)
- the old 'run_hook' functionality is available as 'run_hook_with_custom_index'
  (and marked as deprecated in the last optional patch of this series)

N.B.: the merge builtin 'prepare-commit-msg' hook handling has also been updated
to be consistent; i.e. GIT_EDITOR will not be set to ':' if the '--edit' option
is used.

Benoit Pierre (7):
  merge hook tests: fix missing '&&' in test
  merge hook tests: use 'test_must_fail' instead of '!'
  test patch hunk editing with "commit -p -m"
  commit: fix patch hunk editing with "commit -p -m"
  merge: fix GIT_EDITOR override for commit hook
  merge hook tests: fix and update tests
  run-command: mark run_hook_with_custom_index as deprecated

 builtin/checkout.c                 |  8 +++----
 builtin/clone.c                    |  4 ++--
 builtin/commit.c                   | 35 ++++++++++++++++++++++++------
 builtin/gc.c                       |  2 +-
 builtin/merge.c                    |  6 +++---
 commit.h                           |  3 +++
 run-command.c                      | 44 +++++++++++++++++++++++++++-----------
 run-command.h                      |  7 +++++-
 t/t7505-prepare-commit-msg-hook.sh | 33 ++++++++++++++++++++--------
 t/t7513-commit_-p_-m_hunk_edit.sh  | 34 +++++++++++++++++++++++++++++
 10 files changed, 137 insertions(+), 39 deletions(-)
 create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh

-- 
1.9.0
