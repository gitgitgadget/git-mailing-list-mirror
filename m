From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 00/17] A barebones git-rebase in C
Date: Sat, 12 Mar 2016 18:46:20 +0800
Message-ID: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh4b-0005bI-G8
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbcCLKq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:46:57 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35639 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbcCLKqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:46:55 -0500
Received: by mail-pf0-f182.google.com with SMTP id n5so63103321pfn.2
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=u7TJnzWv1cLqWAZowc7kN6yVr2YPhDeWm2c/OhvhRiQ=;
        b=RdvQM9lxeD5VKs5IsIqlDV4f8NzZmOYwFePF0p9zfbjbQLEb7jvHBomBHOdkwr/wKA
         BmPRNb3kkgOkMfss67Ezz1NasPWqG2EVwUXIWKD5iN5XSDZWs9g9pX7pZRerC5O34Ldm
         9mAm8rzrEegc1XGjjc1a1Oc8M3JG4MBALH5rx0fACLffYM5Ar3+HbyGsnoTQWU/aVVZ7
         toXpfir3rNIem6lrHI935EzcSrwvD81cukFn9gjPaiEH78QRV0M+c/5QNrxbguZRspsg
         JK8HMXoAsbDe8WPgmX+18P/3QX026kSfc2aZeuWuumK1MenoOm3AzCP/whX9wUuURK8+
         IXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u7TJnzWv1cLqWAZowc7kN6yVr2YPhDeWm2c/OhvhRiQ=;
        b=WKHyJ2FnGcHu6005DfddURPnTEq89ayp/uueTEBL8o+9jkVUjd7DOUQqtwHOXen2hb
         ayZO43uDULAtBg5ueH4wSqYDU0ZwEntEbw3chHZmR10Yt6CzeqAhxUdjIUntnnmb07Wg
         72u6D2wcDbU2Istsk4qSiEj6JOfBAZQ2BsVtJv2pgmKO4do5kNR3i0DONE/lgJo6NEUW
         Q8SCZ5N4Ip4oP10fM/5aImo8CdMoEjCkJM6z+V1V+ITUcdQANdjZLiikhYwBRgYuGoc6
         0RlVNnwg2QRhjk0YQvE7TWBhTIphlVJxxtMoG7c8S3twEjKsZN8hqWIX8VXsVw1EqUX4
         QrPA==
X-Gm-Message-State: AD7BkJL+by4DV6EtbtL3beRLukLEzk2RbUH6z6+bdSWvli0YL9IHbx3vcuoeiauvnfwSMw==
X-Received: by 10.98.75.10 with SMTP id y10mr14871384pfa.32.1457779614282;
        Sat, 12 Mar 2016 02:46:54 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:46:53 -0800 (PST)
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288733>

Hi all,

Last year I rewrote git-am from shell script to C. This succeeded in speeding
up a non-interactive git-rebase by 6-7x[1], which is really handly when rebasing
multiple topic branches.

[1] http://thread.gmane.org/gmane.comp.version-control.git/271967

However, it turns out that when working on a topic branch, I frequently use
interactive rebase instead to edit and squash commits. Unfortunately, as
git-rebase--interactive.sh is still a shell script, it is a bit slower (e.g.
taking a few seconds longer compared to non-interactive rebase when rebasing
big topic branches).

The situation is much worse on Windows, as from the invocation of git rebase -i,
it takes a few seconds before the editor even pops up, and the actual
rebase proceeds at a snails pace, taking around 3 minutes for a 50-patch
series, which is a huge deal-breaker since my workflow depends on frequent
commits and squashes.

As such, this year I would like to apply for GSoC to work on a rewrite of
git-rebase to C. It is slightly hefty, as there are three backends (am, merge
and interactive), along with the git-rebase.sh script.

To get a gauge of how much code is needed for the rewrite, I explored rewriting
the scripts into C, and then extracted some bits out and polished them a bit to
make a barebones git-rebase in C, creating this patch series:

[01/17] perf: introduce performance tests for git-rebase

A simple performance test for the three rebase backends so we can compare this
C version and the shell version below.

[02/17] sha1_name: implement get_oid() and friends
[03/17] builtin-rebase: implement skeletal builtin rebase
[04/17] builtin-rebase: parse rebase arguments into a common rebase_options struct
[05/17] rebase-options: implement rebase_options_load() and rebase_options_save()

The three rebase backends (am, merge, interactive) have vastly different
capabilities, so I did not try to shoehorn them into the same interface.
However, they do share a few common options and functionality, so I introduced
the common rebase-common.c library and rebase_options struct.

In the above patches we implement the essential arguments for a rebase: the
upstream, branch_name and --onto <newbase>.

[06/17] rebase-am: introduce am backend for builtin rebase

This patch implements a barebones rebase-am backend.

[07/17] rebase-common: implement refresh_and_write_cache()
[08/17] rebase-common: let refresh_and_write_cache() take a flags argument
[09/17] rebase-common: implement cache_has_unstaged_changes()
[10/17] rebase-common: implement cache_has_uncommitted_changes()
[11/17] rebase-merge: introduce merge backend for builtin rebase

These patches implement a barebones rebase-merge backend.

[12/17] rebase-todo: introduce rebase_todo_item
[13/17] rebase-todo: introduce rebase_todo_list
[14/17] status: use rebase_todo_list
[15/17] wrapper: implement append_file()
[16/17] editor: implement git_sequence_editor() and launch_sequence_editor()
[17/17] rebase-interactive: introduce interactive backend for builtin rebase

And these patches implement a barebones rebase-interactive backend.

With these patches the performance numbers when rebasing 50 commits on the
git.git repository are, on Linux,

Before patch series:

Test                               this tree
--------------------------------------------------
3400.2: rebase --onto master^      1.10(0.84+0.06)
3402.2: rebase -m --onto master^   2.38(1.38+0.13)
3404.2: rebase -i --onto master^   3.11(1.37+0.27)

After patch series:

Test                               this tree
--------------------------------------------------
3400.2: rebase --onto master^      0.74(0.51+0.08)
3402.2: rebase -m --onto master^   1.72(1.26+0.17)
3404.2: rebase -i --onto master^   1.74(1.20+0.18)

And on Windows,

Before patch series:

Test                               this tree
----------------------------------------------------
3400.2: rebase --onto master^      10.90(0.06+0.47)
3402.2: rebase -m --onto master^   86.87(0.04+0.47)
3404.2: rebase -i --onto master^   191.65(0.09+0.44)

After patch series:

Test                               this tree
---------------------------------------------------
3400.2: rebase --onto master^      6.45(0.13+0.40)
3402.2: rebase -m --onto master^   12.32(0.13+0.40)
3404.2: rebase -i --onto master^   14.16(0.15+0.40)

(Thanks to the git-am rewrite, non-interactive rebase on Windows is already
relatively fast ;-) )

So, we have around a 1.4x-1.8x speedup for Linux users, and a 1.7x-13x speedup
for Windows users. The annoying long delay before the interactive editor is
launched on Windows is gotten rid of, which I'm very happy about :-)

On the code side, we do get some nice things with a rewrite to C. For example,
we get the rebase-todo library for parsing and writing git-rebase-todo files,
which means that wt-status.c and rebase-interactive.c can share the same
parsing code. Although not in this patch series, rebase-interactive.c can also
now share the same author-script parsing and writing code from builtin/am.c as
well.

Regards,
Paul

Paul Tan (17):
  perf: introduce performance tests for git-rebase
  sha1_name: implement get_oid() and friends
  builtin-rebase: implement skeletal builtin rebase
  builtin-rebase: parse rebase arguments into a common rebase_options
    struct
  rebase-options: implement rebase_options_load() and
    rebase_options_save()
  rebase-am: introduce am backend for builtin rebase
  rebase-common: implement refresh_and_write_cache()
  rebase-common: let refresh_and_write_cache() take a flags argument
  rebase-common: implement cache_has_unstaged_changes()
  rebase-common: implement cache_has_uncommitted_changes()
  rebase-merge: introduce merge backend for builtin rebase
  rebase-todo: introduce rebase_todo_item
  rebase-todo: introduce rebase_todo_list
  status: use rebase_todo_list
  wrapper: implement append_file()
  editor: implement git_sequence_editor() and launch_sequence_editor()
  rebase-interactive: introduce interactive backend for builtin rebase

 Makefile                           |  10 +-
 builtin.h                          |   1 +
 builtin/am.c                       |  16 +-
 builtin/pull.c                     |  41 +---
 builtin/rebase.c                   | 264 ++++++++++++++++++++++++++
 cache.h                            |   8 +
 editor.c                           |  27 ++-
 git.c                              |   1 +
 rebase-am.c                        | 110 +++++++++++
 rebase-am.h                        |  22 +++
 rebase-common.c                    | 220 ++++++++++++++++++++++
 rebase-common.h                    |  48 +++++
 rebase-interactive.c               | 375 +++++++++++++++++++++++++++++++++++++
 rebase-interactive.h               |  33 ++++
 rebase-merge.c                     | 256 +++++++++++++++++++++++++
 rebase-merge.h                     |  28 +++
 rebase-todo.c                      | 251 +++++++++++++++++++++++++
 rebase-todo.h                      |  55 ++++++
 sha1_name.c                        |  30 +++
 strbuf.h                           |   1 +
 t/perf/p3400-rebase.sh             |  25 +++
 t/perf/p3402-rebase-merge.sh       |  25 +++
 t/perf/p3404-rebase-interactive.sh |  26 +++
 wrapper.c                          |  23 +++
 wt-status.c                        | 100 +++-------
 25 files changed, 1863 insertions(+), 133 deletions(-)
 create mode 100644 builtin/rebase.c
 create mode 100644 rebase-am.c
 create mode 100644 rebase-am.h
 create mode 100644 rebase-common.c
 create mode 100644 rebase-common.h
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h
 create mode 100644 rebase-merge.c
 create mode 100644 rebase-merge.h
 create mode 100644 rebase-todo.c
 create mode 100644 rebase-todo.h
 create mode 100755 t/perf/p3400-rebase.sh
 create mode 100755 t/perf/p3402-rebase-merge.sh
 create mode 100755 t/perf/p3404-rebase-interactive.sh

-- 
2.7.0
