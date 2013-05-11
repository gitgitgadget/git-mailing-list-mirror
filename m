From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sat, 11 May 2013 13:23:42 +0100
Message-ID: <cover.1368274689.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 14:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub8qf-0004Th-7h
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 14:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab3EKMYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 08:24:07 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:51595 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3EKMYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 08:24:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3E2F5198007;
	Sat, 11 May 2013 13:24:04 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NxV+QqOza1VH; Sat, 11 May 2013 13:24:03 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 5D11B198003;
	Sat, 11 May 2013 13:24:03 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 45B17161E410;
	Sat, 11 May 2013 13:24:03 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DPMLMEVj5LGf; Sat, 11 May 2013 13:24:02 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 20A68161E3B6;
	Sat, 11 May 2013 13:23:52 +0100 (BST)
X-Mailer: git-send-email 1.8.3.rc1.289.gcb3647f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223959>

This is helpful when examining branches with disjoint roots, for example
because one is periodically merged into a subtree of the other.

With the --merge-child option, "git merge-base" will print a
first-parent ancestor of the first revision given, where the commit
printed is either a merge-base of the supplied revisions or a merge for
which one of its parents (not the first) is a merge-base.

For example, given the history:

        A---C---G
             \
        B-----D---F
         \
          E

we have:

        $ git merge-base F E
        B

        $ git merge-base --merge-child F E
        D

	$ git merge-base F G
	C

	$ git merge-base --merge-child F G
	C

        $ git log --left-right F...E
        < F
        < D
        < C
        < A
        > E

        $ git log --left-right F...E --not $(git merge-base --merge-child F E)
        < F
        > E

The git-log case is useful because it allows us to limit the range of
commits that we are examining for patch-identical changes when using
--cherry.  For example with git-gui in git.git I know that anything
before the last merge of git-gui is not interesting:

        $ time git log --cherry master...git-gui/master >/dev/null
        real    0m32.731s
        user    0m31.956s
        sys     0m0.664s

        $ time git log --cherry master...git-gui/master --not \
                $(git merge-base --merge-child master git-gui/master) \
                >/dev/null
        real    0m2.296s
        user    0m2.193s
        sys     0m0.092s


The first commit is a small prerequisite to extract a useful function
from builtin/tag.c to commit.c.  The second is the main change (the
commit message is identical to the text before this paragraph).

I'm not convinced that '--merge-child' is the right name for this but I
think the functionality itself is useful.

John Keeping (2):
  commit: add commit_list_contains function
  merge-base: add --merge-child option

 Documentation/git-merge-base.txt |  6 ++++
 builtin/merge-base.c             | 61 ++++++++++++++++++++++++++++++++++++++--
 builtin/tag.c                    | 10 +------
 commit.c                         |  8 ++++++
 commit.h                         |  1 +
 t/t6010-merge-base.sh            | 25 ++++++++++++++--
 6 files changed, 98 insertions(+), 13 deletions(-)

-- 
1.8.3.rc1.289.gcb3647f
