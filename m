From: Yann Dirson <ydirson@altern.org>
Subject: remaining git-cvsimport problems: robustness when cvsps feeds strange history
Date: Sat, 27 May 2006 14:01:05 +0200
Message-ID: <20060527120105.GL6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat May 27 13:49:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjxI6-0007TA-2b
	for gcvg-git@gmane.org; Sat, 27 May 2006 13:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWE0Lsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 07:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWE0Lsq
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 07:48:46 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:50145 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751479AbWE0Lsp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 07:48:45 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 097052252D;
	Sat, 27 May 2006 13:48:44 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FjxTd-0006ko-RC; Sat, 27 May 2006 14:01:05 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20850>

Since there is quite some activity around git-cvsimport these days, I
think I'd raise a couple of issues which are still problematic.

It should at least issue a warning when cvsps feeds it with a
branchpoint that it cannot create because the base branch has not yet
been seen.  I am still investigating why cvsps outputs such a buggy
patchset - it may be a cvs bug at the root, and cvsps probably did not
detect an consistency of the cvs data.  While there is probably a real
bug to fix somewhere, git-cvsimport should not silently skip the
faulty patchset, especially as it will then miserably fail to import
any subsequent patch on that branch it ignored this way.

However, rerunning the script (after creating a master head by copying
heads/origin) manages to complete the import: the forgotten branch now
gets created, and all subsequent patchsets can now be imported.


I'm not sure what would be the best way to handle the issue.  Maybe it
would sufficient to output a bold warning and let the user take the
necessary steps to finish the import (since this is after all a bug in
other tools, which will hopefully be fixed at some point).  It could
also be useful to raise a flag when detecting that condition, and
automatically restart the import process on the first error due to
that branch not being available - otoh, that may be overkill, and
could possibly miss some other obscure cases.

As a sidenote, I'm wondering why there is no precise information on
the branchpoint in "cvsps -A".  I guess the semantics are "fork a new
branch from the ancestor one" at whatever point it currently is - that
would look quite risky to me, and could be part of the reason why
cvsps did not notice the inconsistency: it just did not try to find
out where the new branch was to be grafted exactly.

======
PatchSet 1
Date: 2006/01/03 18:23:53
Author: ydirson
Branch: HEAD
Tag: (none)
Log:
Empty .cvsignore to be used as a branching base

Members:
        .cvsignore:INITIAL->1.1

---------------------
PatchSet 2
Date: 2006/01/03 18:23:53
Author: ydirson
Branch: FOO_V3_0_0_HEAD
Ancestor branch: FOO_VENDOR_HEAD
Tag: (none)
Log:
file .cvsignore was added on branch FOO_V3_0_0_HEAD on 2006-05-24 07:51:07
+0000

Members:
        .cvsignore:1.1->1.1.4.1(DEAD)

---------------------
PatchSet 3
Date: 2006/01/03 18:24:39
Author: ydirson
Branch: FOO_VENDOR_HEAD
Ancestor branch: HEAD
Tag: FOO_V1_1
Log:
Import de FOO 1.1
---------------------
PatchSet 20
Date: 2006/01/10 11:47:54
Author: ydirson
Branch: FOO_V3_0_0_HEAD
Tag: (none)
Log:
file script.sh was added on branch FOO_V3_0_0_HEAD on 2006-05-24 07:51:08
+0000

Members:
        some/script.sh:1.1->1.1.4.1(DEAD)
===== first import
Fetching .cvsignore   v 1.1
New .cvsignore: 0 bytes
Tree ID 87556a35bc2c438ede9eb2120c2cdb04baed33ae
Committing initial tree 87556a35bc2c438ede9eb2120c2cdb04baed33ae
Committed patch 1 (origin 2006-01-03 17:23:53)
Commit ID 2ddb63602915316e60b26d95414100fd80e602ef
Branch FOO_VENDOR_HEAD does not exist!
Delete .cvsignore
[...]
Tree ID ca6e986b5199b01604dfa459b6e3a2841024f11a
Parent ID 2ddb63602915316e60b26d95414100fd80e602ef
Committed patch 3 (FOO_VENDOR_HEAD 2006-01-03 17:24:39)
Commit ID 9e19f11520c89897704fff252901ff4dc5ae88ad
[...]
Committed patch 19 (origin 2006-01-10 10:47:54)
Commit ID 0c5063420b769f8db7c009843b3947350bf78eae
Switching from origin to FOO_V3_0_0_HEAD
fatal: Not a valid object name FOO_V3_0_0_HEAD
read-tree failed: 32768
===== second run
skip patchset 1: 1136309033 before 1136890074
Switching from master to FOO_V3_0_0_HEAD
Delete .cvsignore
Tree ID 38b8067e1d36ce7f45bb1121a22628927bfd2ac2
Parent ID b9cf667acd27ba7fd76a405166b355ec51261b17
Committed patch 2 (FOO_V3_0_0_HEAD 2006-01-03 17:23:53)
Commit ID 528efdac6113af50d4c14c3ccabde9661cb19359
skip patchset 3: 1136309079 before 1136312985
[...]
skip patchset 19: 1136890074 before 1136890074
Delete some/script.sh
Tree ID 38b8067e1d36ce7f45bb1121a22628927bfd2ac2
Parent ID 528efdac6113af50d4c14c3ccabde9661cb19359
Committed patch 20 (FOO_V3_0_0_HEAD 2006-01-10 10:47:54)
[...]
Committed patch 409 (origin 2006-05-24 18:59:44)
Commit ID 74a5c3b1f265f096177120166ae7da1a2cf3f64e
DONE.
=====
--
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
