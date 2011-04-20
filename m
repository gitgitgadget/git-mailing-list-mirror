From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 0/5] Date Mode: Add --time-zone; deprecate --date=local
Date: Wed, 20 Apr 2011 02:53:36 +0000
Message-ID: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 04:55:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCNZz-0004IO-B4
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 04:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab1DTCzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 22:55:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57025 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab1DTCzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 22:55:41 -0400
Received: by ewy4 with SMTP id 4so83230ewy.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id;
        bh=WPAojvWpjEWfagWbYBi8QEBKKBCRfacbW3Q7fuCoV2Q=;
        b=fhB30udPllYA099HZtd3IOsJocU14zPs8PVSq4nVHPhhcgwPUs9S5T4mFu80+g7Ba3
         IDL/CXwuUeXwochLJXmrpqMkY+f6wZnKHkZBsK3A5RTQEWaFs0oTmZ0/wK7vESu8UKdI
         0fa/rCAvulRU+isAvFNl50Omb2OK1IcDwmQAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id;
        b=wsrRcgze27NdG2pIGYH8hpwWTEeebNCyQ8SNrC5C+wj/cIOqEIKgb6ooW3SFWjfaMI
         DGkdtWuMkOKx9hIVuBSCKsdLmFm9JC4Ni5dD2w/XbgsxhP6gFxQ7StTV8hl5tIshUVpZ
         49m+22kP5eRqEWMAmZcuqOMiXIgwjmy/g/P7c=
Received: by 10.213.14.2 with SMTP id e2mr67171eba.147.1303268139986;
        Tue, 19 Apr 2011 19:55:39 -0700 (PDT)
Received: from gmail.com (156-49-223.ftth.xms.internl.net [85.223.49.156])
        by mx.google.com with ESMTPS id u1sm334824eeh.6.2011.04.19.19.55.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 19:55:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171831>

One of the possible values for a date format is `local', which
specifies that a date should be output as though the date format
were instead `default' but in terms of the user's time zone
instead of the time zone stored by git; clearly, then, `local'
does not really provide just another format, but rather the
combination of 2 specifications:

  * A format for the date (`default')
  * A time zone in which to interpret the date (`local', if you will)

Interestingly, the existing documentation suggests that the original
purpose of the `--date' option was to specify the time zone rather
than a format:

  $ git grep -hC1 '`--date=local`\|`--date=default`' \
  >   6ceb270ce6f65cf4bc2a22830f96e0cc838b3fec       \
  >   -- Documentation/rev-list-options.txt
  +
  `--date=local` shows timestamps in user's local timezone.
  +
  --
  +
  `--date=default` shows timestamps in the original timezone
  (either committer's or author's).

This patch series reimplements the original purpose of `--date' by allowing
the time zone mode to be specified independently of the date format
(see the commit message for [2] and the documentation provided by [3]):

  [0] Light refactoring of date infrastructure
  [1] Pretty Print: show tz when using DATE_LOCAL
  [2] Date Mode: Implementation
  [3] Date Mode: Documentation
  [4] Date Mode: Tests

The date format `local' has thus been deprecated, though it is still
supported (with a warning on stderr).

These patches apply cleanly to the current tip of Junio's `next' branch:

  commit 63e4ee5f87eede11d1377370c385c26c5b90c6e7
  Merge: 359ea0b 6ceb270
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Tue Apr 19 11:51:25 2011 -0700
  
      Merge branch 'master' into next
      
      * master:
        Git 1.7.5-rc3
        Git 1.7.4.5
        git-svn.txt: Document --mergeinfo
  
and it would appear that `make test' runs successfully (including the
extensive testing that I have implemented for date mode features, both
old and new).

There are some whitespace warnings (a la `git diff --check'), but I
have reviewed them and personally approve of them; if you think that
appraisal is incorrect, then you don't know what you're talking about :-P

Sincerely,
Michael Witten

  Documentation/blame-options.txt    |    9 +--
  Documentation/config.txt           |   32 ++++---
  Documentation/date-mode-docs.txt   |   87 +++++++++++++++++++
  Documentation/git-for-each-ref.txt |   19 ++++-
  Documentation/git-log.txt          |   43 ---------
  Documentation/git-rev-list.txt     |    4 +-
  Documentation/git-svn.txt          |    2 +-
  Documentation/rev-list-options.txt |   28 +------
  archive.c                          |    2 +-
  builtin/blame.c                    |   24 +++---
  builtin/cat-file.c                 |    3 +-
  builtin/commit.c                   |    2 +-
  builtin/for-each-ref.c             |   65 ++++++++++----
  builtin/log.c                      |   17 ++--
  builtin/shortlog.c                 |    2 +-
  builtin/show-branch.c              |    3 +-
  cache.h                            |   41 ++++++++-
  commit.h                           |    4 +-
  date.c                             |   84 ++++++++++++++++---
  fast-import.c                      |    4 +-
  http-backend.c                     |    3 +-
  log-tree.c                         |   10 ++-
  pretty.c                           |   18 +++--
  reflog-walk.c                      |    6 +-
  reflog-walk.h                      |    4 +-
  refs.c                             |    6 +-
  revision.c                         |   11 ++-
  revision.h                         |    4 +-
  sha1_name.c                        |    5 +-
  submodule.c                        |    2 +-
  t/date-modes-lib.sh                |  168 ++++++++++++++++++++++++++++++++++++
  t/date-modes-permutator.perl       |   94 ++++++++++++++++++++
  t/t4202-log.sh                     |    3 +
  t/t6300-for-each-ref.sh            |   15 +++-
  t/t8002-blame.sh                   |    9 ++
  test-date.c                        |   11 ++-
  36 files changed, 654 insertions(+), 190 deletions(-)
  create mode 100644 Documentation/date-mode-docs.txt
  create mode 100755 t/date-modes-lib.sh
  create mode 100755 t/date-modes-permutator.perl

-- 
1.7.4.18.g68fe8
