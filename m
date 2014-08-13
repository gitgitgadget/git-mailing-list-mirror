From: Thanumalayan Sankaranarayana Pillai <madthanu@cs.wisc.edu>
Subject: Possible bug v2.0.4: git reflog after a crash
Date: Wed, 13 Aug 2014 07:03:45 +0530
Message-ID: <CAJ6LpRqaBpinbF7FfU6hk55EmOLZy32Rjc6M9W+WnyK3LD7MUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 03:34:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHNSD-00037s-2w
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 03:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbaHMBeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 21:34:13 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:33884 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbaHMBeM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 21:34:12 -0400
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com [209.85.220.44])
	(authenticated bits=0)
	by sabe.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id s7D1YADg017153
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 12 Aug 2014 20:34:11 -0500
Received: by mail-pa0-f44.google.com with SMTP id eu11so14030820pac.31
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 18:34:05 -0700 (PDT)
X-Received: by 10.70.52.1 with SMTP id p1mr1090685pdo.111.1407893645573; Tue,
 12 Aug 2014 18:34:05 -0700 (PDT)
Received: by 10.70.135.9 with HTTP; Tue, 12 Aug 2014 18:33:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255182>

This is about what happens when a Git process gets killed by someone,
or there is a system crash, and then we try to run Git again on the
repository.

When I run git-commit after adding a few files to the repository, git
updates the .git/refs/heads/master file using rename() to complete the
commit. Just before this, git appends some meta-information to the
.git/logs/HEAD file. If a crash happens such that one of these
operations has been issued but the other has not, then, running
git-reflog in the future seems to silently show wrong information.
Specifically, the HEAD@{} and the message of one commit (either the
in-transaction commit that was being performed during the crash, or
the previous commit) is shown against the commit number of the other
commit. (I am running git-2.0.4.)

The situation can be reproduced by killing a git process between the
append and the rename, using GDB. (Such a crash can also be caused
when a file system buffers only one of the operations for a longer
time and a kernel OOPS happens in-between. Typical re-ordering file
systems such as ext4-ordered buffer the append longer than the rename,
leading to about a 25 second window in-between).

A disclaimer: I am more involved in file system research than in using
Git expertly, and only noticed this issue while examining Git for a
research project. There is a chance that git-reflog is supposed to
output the information it currently outputs, and I am simply expecting
the wrong thing from it. Also, we have found a couple of places where
Git might act wrongly in the event of a system crash if a re-ordering
file system is used, apart from the usual fsync-before-rename
concerns; these, however, require unusual re-orderings that are not
done by most usual file systems. I have not reported them because I
get the sense that Git is written for an ordered file system; do let
me know if reporting these will be useful.

Example wrong outputs from git reflog:
----
1f9cd01 HEAD@{0}: commit: test2
1f9cd01 HEAD@{1}: commit (initial): test1
----
----
4550c4a HEAD@{0}: commit (initial): test1
----

Expected output:
----
4550c4a HEAD@{0}: commit: test2
1f9cd01 HEAD@{1}: commit (initial): test1
----

Thanks,
Thanu
