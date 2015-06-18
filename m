From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 00/19] Make git-pull a builtin
Date: Thu, 18 Jun 2015 18:53:53 +0800
Message-ID: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:54:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XT3-0001BB-Mw
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbbFRKyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:54:41 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34224 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbFRKyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:54:40 -0400
Received: by pdbki1 with SMTP id ki1so64210419pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NplskrRYdTnA8m8JC4zfm+TBXbXodGmC9Jijn4gG6Lw=;
        b=YhYvI8G6jPfS92ssXCy8tY4q4/+Bk/VFCOQYq2tQMdC57Ld8uU9yOGLzppKdGUZ8fy
         EVDj3EzSwW8xHOOPi8IOwamjT3STTD49NRRBr4BybBbYrtFAIp9R0UGSuGh+SbvOYgj8
         MidmD1xDTQHE/wweS9/+03jZP4sOmRZMTW3N9ZLs0Lgwxf/3F9UEMwdLxO/acR58biX1
         PX+H5d4Ugd4fHWof307Hw8mxeEZDT8VUqrRYlPkXqOXpOI62WMdv+1paD9sblW/hH+cC
         4jdoKpdTUTkkh9nDU1OCuEG4S7KhWO/l1Y1U2mIpoZt/5V90Pl3I2diy+ItmPTrptX5F
         wGxg==
X-Received: by 10.68.219.201 with SMTP id pq9mr20233874pbc.97.1434624879706;
        Thu, 18 Jun 2015 03:54:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.54.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:54:38 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271943>

This is a re-roll of [v3]. It squashes in Ramsay's patch "fix some sparse
warnings", and fixes the use-before-free reported by Duy. Thanks a lot for
dealing with my mess :-).

Other than that, there are no other changes as I'm working on the git-am side
of things.

Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/269258
[v2] http://thread.gmane.org/gmane.comp.version-control.git/270639
[v3] http://thread.gmane.org/gmane.comp.version-control.git/271614

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
  parse-options-cb: implement parse_opt_passthru()
  parse-options-cb: implement parse_opt_passthru_argv()
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

 Documentation/technical/api-argv-array.txt    |   3 +
 Documentation/technical/api-parse-options.txt |  13 +
 Makefile                                      |   2 +-
 advice.c                                      |   8 +
 advice.h                                      |   1 +
 argv-array.c                                  |   6 +
 argv-array.h                                  |   1 +
 builtin.h                                     |   1 +
 builtin/pull.c                                | 882 ++++++++++++++++++++++++++
 git-pull.sh => contrib/examples/git-pull.sh   |   0
 git.c                                         |   1 +
 parse-options-cb.c                            |  69 ++
 parse-options.h                               |   6 +
 13 files changed, 992 insertions(+), 1 deletion(-)
 create mode 100644 builtin/pull.c
 rename git-pull.sh => contrib/examples/git-pull.sh (100%)

-- 
2.1.4
