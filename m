From: Mark Lodato <lodatom@gmail.com>
Subject: Bug report: git status does not report unmerged entries with copies
Date: Wed, 6 Apr 2011 20:34:26 -0400
Message-ID: <BANLkTikWVgsX6yEY=d7kEcO5PLMTRwDU_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 02:34:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dBU-00017L-Pq
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 02:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705Ab1DGAer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 20:34:47 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51954 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab1DGAeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 20:34:46 -0400
Received: by vxi39 with SMTP id 39so1577255vxi.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 17:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=2CXQasePaMp0dYSxo7Cg3n6k2BpMEYbKUzupniwUURA=;
        b=jdY7euiGdMGCJ+PZE5uSHW3nzCkP2/WKRU6a5Jua89A31/B9ffxWnB1wxJqJKM/ncr
         wF3/JPthqPv1/eWAQ4VQWbftaueBJD4gQViCKCuxMKLvTbKrat7wW9UDG7zcokv+GIkZ
         sGDei1pEmpqvPAhVHLwwElyf4oJJv5SXhe1yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=E3dF9N9L2Bmxvr7KqFHFl8Ytnu959O7Y38rS2aMvHe3YfZP4JWCq9x491acadbInWM
         OE16X9iepM7cEn0fiqmOIPTUT+w6rYw6mkRMHwJ1fuIcizlrOcPdyvCzVEN8T8quTrQK
         1YUXyfxlhAYlZnLssHivS6wFWL+5sOdU25NjQ=
Received: by 10.52.73.193 with SMTP id n1mr406976vdv.226.1302136486061; Wed,
 06 Apr 2011 17:34:46 -0700 (PDT)
Received: by 10.52.160.103 with HTTP; Wed, 6 Apr 2011 17:34:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171028>

Commit 4d4d572, "status: show worktree status of conflicted paths
separately" introduced the following bug:  If one tries to merge two
branches with a conflict, where the conflicting file was also copied
in one of the branches, "git status" (but not "git status -sb" or
git-gui) fails to report the unmerged status.  You can use the below
test file to see the error.  A similar test should probably be
integrated into one of the existing git-status test files, though you
may need to get rid of the "sed -i" command.

$ git status
# On branch master
# Changes to be committed:
#
#       renamed:    file -> copy
#
$ git status -sb
## master
R  file -> copy
 U file

In the above, "git status" should have reported "file" being in an
unmerged state.  It probably should also mark "copy" as a copy, not a
rename.

-------- 8< --------
#!/bin/sh
#
# Copyright (c) 2011 Mark Lodato
#

test_description='git status on merge with copy'

. ./test-lib.sh

test_expect_success 'setup' '
        echo first > file &&
        echo second >> file &&
        echo third >> file &&
        echo fourth >> file &&
        git add file &&
        git commit -m initial &&
        git checkout -b branch &&
        cp file copy &&
        git add copy &&
        git commit -m copy &&
        sed -i -e "s/second/fifth/" file &&
        git add file &&
        git commit -m fifth &&
        git checkout master &&
        sed -i -e "s/second/sixth/" file &&
        git add file &&
        git commit -m sixth
'

test_expect_success 'merge' '
        ! git merge branch
'

test_expect_success 'status' '
        git status | grep unmerged
'

test_done
