From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2 for maint] "show --cc" fixes
Date: Wed, 22 Jul 2009 14:48:27 -0700
Message-ID: <1248299309-10579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjg4-0006GE-Gw
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbZGVVsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbZGVVsc
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:48:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbZGVVsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:48:32 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A04310FD8
	for <git@vger.kernel.org>; Wed, 22 Jul 2009 17:48:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AA84E10FD7 for
 <git@vger.kernel.org>; Wed, 22 Jul 2009 17:48:30 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.rc1.10.g2a679
X-Pobox-Relay-ID: 65B1EC6E-7709-11DE-86B4-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123789>

The first one is the same "performance" patch from yesterday, only with
better commit log message.

The second is a bugfix.  "git show --cc" displays merge result incorrectly
when they touch the first line of the affected file (the bug is not about
the commit being wrong; it is about showing the commit incorrectly).  This
was found while writing a new test

Among the 3040 merges up to v1.6.4-rc1 in git.git history, only 643 of
them are interesting merges in "show --cc" sense, and there is only one
commit for which "git show" gives a wrong output due to this bug.

  3ed02de Merge branch 'maint' of git://repo.or.cz/git-gui into maint

The reason git.git history has more "cc-interesting" merges (compared to a
lot larger and more complex kernel history---see below) is an atrifact of
the use of subtree merges.  Most of these are actually not interesting at
all, and the above commit that is shown incorrectly is not interesting
either.  We probably should discourage the use of subtree merges and
switch to use submodules for gitk and git-gui ourselves, but we need to
wait until we can be sure that everybody's installed git is submodule
capable.

Similarly, among the 9487 merges in the Linux kernel history (today's tip
from Linus), only 920 of them are interesting.  There are a handful of
commits for which "git show" gives a wrong output due to this bug.

  f541ae3 Merge branch 'linus' into perfcounters/core-v2
  0ca0f16 Merge branches 'x86/apic', 'x86/asm', 'x86/cleanups', 'x86/debug',...
  9b6a517 Merge branch 'juju' of git://git.kernel.org/pub/scm/linux/kernel/...
  22a3e23 Merge git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial

Take Ingo's 0ca0f16 as an example.  The diff between its first parent and
the commit begins arch/x86/kernel/cpu/common.c like this:

    --- a/arch/x86/kernel/cpu/common.c
    +++ b/arch/x86/kernel/cpu/common.c
    @@ -1,52 +1,52 @@
    -#include <linux/init.h>
    -#include <linux/kernel.h>
    -#include <linux/sched.h>
    -#include <linux/string.h>
     #include <linux/bootmem.h>
    +#include <linux/linkage.h>

When shown in "git show", however, it begins like this (this is an 11-way
octopus):

    --- a/arch/x86/kernel/cpu/common.c
    +++ b/arch/x86/kernel/cpu/common.c
    @@@@@@@@@@@ -1,44 -1,44 -1,44 -1,44 -1,44 -1,44 -1,44 -1,4...
	      #include <linux/bootmem.h>
    --- ------#include <linux/init.h>
    --- ------#include <linux/kernel.h>
    --- ------#include <linux/sched.h>

which is clearly wrong.

In other words, the bug may be rare, but it is real.

An interesting tangent is this graph:

    838 x x
     26 x x x
     18 x x x x
      3 x x x x x
      7 x x x x x x
      5 x x x x x x x
      6 x x x x x x x x
      2 x x x x x x x x x
      1 x x x x x x x x x x
      3 x x x x x x x x x x x
      3 x x x x x x x x x x x x
      1 x x x x x x x x x x x x x
      2 x x x x x x x x x x x x x x
      1 x x x x x x x x x x x x x x x x x x
      1 x x x x x x x x x x x x x x x x x x x x
      1 x x x x x x x x x x x x x x x x x x x x x
      1 x x x x x x x x x x x x x x x x x x x x x x x x
      1 x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x

which is an output from this command in the kernel repository:

    git log --pretty=short |
    sed -ne '/^Merge: /{
	    s/^Merge: //
	    s/[0-9a-f][0-9a-f]*/x/g
	    p
    }' |
    sort |
    uniq -c

Ingo stole the octopus gold star from Len Brown with that 30-way octopus.

Junio C Hamano (2):
  combine-diff.c: fix performance problem when folding common deleted
    lines
  diff --cc: a lost line at the beginning of the file is shown
    incorrectly

 combine-diff.c           |   29 ++++++++--------
 t/t4038-diff-combined.sh |   84 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 15 deletions(-)
 create mode 100755 t/t4038-diff-combined.sh
