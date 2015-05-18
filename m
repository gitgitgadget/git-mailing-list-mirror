From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 00/14] Make git-pull a builtin
Date: Mon, 18 May 2015 23:05:57 +0800
Message-ID: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:07:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMdf-0004D0-5V
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbbERPH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:27 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34042 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbbERPHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:25 -0400
Received: by pabru16 with SMTP id ru16so155818142pab.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7YhpOWy7vZfO2aaUNOSSps1AFZDM8FRHVczBclOXkmk=;
        b=XEbtrGsbwlKnIfGFbU6L6UAStIOd9g1gdbTIACjXB0Ewc7hlFqKPZzlpy/XD7Ffsc5
         5BCt+PsN7TxHq/3SBrs9mIORNd7T2el8OfrtrNaKmAdjIxmkZtKa5lnU5YykahMZA3z4
         V/per6VoD1uIGaMkcJnCYbAP/8YYwbCh6L6T1FDg+kzp7pe6nCY7VIlcY70No80bqBY5
         E22S9rlPuU9hiKqsRgZnNVoYgIHskcgNhXxkdTjPR6LTzbmUrJHcBkF4M4RK23iQUHyP
         1GoDXiRp+E/HXmcM9Aua7AlbiKBuz3VdDpnu0XeVKGMNOW+uUoVIJX0BnVdhuj8f+bBL
         xUQA==
X-Received: by 10.70.37.225 with SMTP id b1mr43223493pdk.35.1431961645470;
        Mon, 18 May 2015 08:07:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:24 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269258>

This series directly depends on the changes made in jc/merge and
pt/pull-tests. The commit messages assume that the behavioral changes
proposed in pt/pull-log-n, pt/pull-tags-error-diag, pt/pull-ff-vs-merge-ff,
and [1] have been introduced.

git-pull is a commonly executed command to check for new changes in the
upstream repository and, if there are, fetch and integrate them into the
current branch. Currently it is implemented by the shell script git-pull.sh.
However, compared to C, shell scripts have certain deficiencies:

1. Usually have to rely on spawning a lot of processes, which can be slow on
   systems that do not implement copy-on-write semantics.

2. They introduce a lot of dependencies, especially on non-POSIX systems.

3. They cannot take advantage of git's C API and internal caches.

This series rewrites git-pull.sh into a C builtin, thus improving its
performance and portability. It is part of my GSoC project to rewrite git-pull
and git-am into builtins[2].

[1] http://thread.gmane.org/gmane.comp.version-control.git/269249
[2] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1

Paul Tan (14):
  pull: implement fetch + merge
  pull: pass verbosity, --progress flags to fetch and merge
  pull: pass git-merge's options to git-merge
  pull: pass git-fetch's options to git-fetch
  pull: error on no merge candidates
  pull: support pull.ff config
  pull: check if in unresolved merge state
  pull: fast-forward working tree if head is updated
  pull: implement pulling into an unborn branch
  pull: set reflog message
  pull: teach git pull about --rebase
  pull: configure --rebase via branch.<name>.rebase or pull.rebase
  pull --rebase: exit early when the working directory is dirty
  pull --rebase: error on no merge candidate cases

 Makefile                     |   2 +-
 advice.c                     |   8 +
 advice.h                     |   1 +
 builtin.h                    |   1 +
 builtin/pull.c               | 919 +++++++++++++++++++++++++++++++++++++++++++
 contrib/examples/git-pull.sh | 339 ++++++++++++++++
 git-pull.sh                  | 339 ----------------
 git.c                        |   1 +
 8 files changed, 1270 insertions(+), 340 deletions(-)
 create mode 100644 builtin/pull.c
 create mode 100755 contrib/examples/git-pull.sh
 delete mode 100755 git-pull.sh

-- 
2.1.4
