From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 00/19] Make git-pull a builtin
Date: Wed,  3 Jun 2015 14:48:44 +0800
Message-ID: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:49:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02Un-0004Fp-3K
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbbFCGtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:49:45 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35786 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbbFCGto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:49:44 -0400
Received: by pdbnf5 with SMTP id nf5so733648pdb.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9AbOgUtucGxUJxPiKTkC6weAwYHAb1UlhNFyFkEh28I=;
        b=b+y1YrmJuoj9fDJBkLk4iShppOc4RswOGhoEyPn9VXjmofA0Ta194e9ItK6bnOrypr
         tAW5dJ50KluAyLli5hEv1I9K/GYPy07Lvf2jV0Z3pJWAnr47aVrepo18RpAsVxQNbGuD
         x1mZRMIVQysQXNGYZ2RLBpBB4xxCpLtySC4troe/cOJDKfd7boUy52g8gJDdM7QAybdY
         /xGGyZjzu/HztBilWvgcOMl5sEdw/AC5aoiKAVHjYmCk+kMHis5mVgzS9ZZSR0BBM2zr
         Ks1CbVUnpv0klE1x+3iN6a8zQzaTUKuR9S20Un6+9KRbHiB4dE0J2X6piVT+AlyQn17U
         63gw==
X-Received: by 10.70.29.164 with SMTP id l4mr56916833pdh.32.1433314183558;
        Tue, 02 Jun 2015 23:49:43 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.49.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:49:42 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270639>

This is a re-roll of [v1]. Thanks Johannes, Stefan and Junio for the reviews
last round.

Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/269258

git-pull is a commonly executed command to check for new changes in the
upstream repository and, if there are, fetch and integrate them into the
current branch. Currently it is implemented by the shell script git-pull.sh.
However, compared to C, shell scripts have certain deficiencies -- they need to
spawn a lot of processes, introduce a lot of dependencies and cannot take
advantage of git's internal caches.

This series rewrites git-pull.sh into a C builtin, thus improving its
performance and portability. It is part of my GSoC project to rewrite git-pull
and git-am into builtins[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (19):
  parse-options-cb: implement parse_opt_pass_strbuf()
  parse-options-cb: implement parse_opt_pass_argv_array()
  argv-array: implement argv_array_pushv()
  pull: implement skeletal builtin pull
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
  pull: remove redirection to git-pull.sh

 Documentation/technical/api-argv-array.txt  |   3 +
 Makefile                                    |   2 +-
 advice.c                                    |   8 +
 advice.h                                    |   1 +
 argv-array.c                                |   6 +
 argv-array.h                                |   1 +
 builtin.h                                   |   1 +
 builtin/pull.c                              | 888 ++++++++++++++++++++++++++++
 git-pull.sh => contrib/examples/git-pull.sh |   0
 git.c                                       |   1 +
 parse-options-cb.c                          |  61 ++
 parse-options.h                             |   2 +
 12 files changed, 973 insertions(+), 1 deletion(-)
 create mode 100644 builtin/pull.c
 rename git-pull.sh => contrib/examples/git-pull.sh (100%)

-- 
2.1.4
