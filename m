From: Jim Meyering <jim@meyering.net>
Subject: git-diff-tree inordinately (O(M*N)) slow on files with many changes
Date: Mon, 16 Oct 2006 16:12:51 +0200
Message-ID: <87slhopcws.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 16 16:13:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZTD6-00009J-6C
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 16:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWJPOMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 10:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWJPOMx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 10:12:53 -0400
Received: from mx.meyering.net ([82.230.74.64]:53410 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S932065AbWJPOMx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 10:12:53 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 58405E6C; Mon, 16 Oct 2006 16:12:51 +0200 (CEST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28962>

[using very latest code, built an hour ago:
 git version 1.4.3.rc3.gb32db-dirty ]

I found that git-diff-tree is *very* slow when processing files with
many changes.  The offending example involves comparing the configure
file from coreutils-6.3 with that from the latest coreutils development
sources.  Both are over 50k lines long, and the diff -u output is almost
50k-lines long, divided into ~700 hunks.

  http://meyering.net/code/git-perf/configure.gz
  http://meyering.net/code/git-perf/configure-curr.gz

Comparing them with "diff -u" takes about 0.3s.
Putting them in a git repo (uncompressed, and with the same name,
of course) and comparing with git-diff-tree takes over a minute.
That's 200 times slower.

I traced the problem to xdiff/xprepare.c's xdl_cleanup_records function.
Each of its two doubly-nested loops ends up running the inner-loop
code more than 2 *billion* times.

That seems to be due to the two typos fixed by this patch:
With this patch, my "git-diff-tree --no-commit-id -r -p 2c2172"
command completes in just 2 seconds.

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 1be7b31..e5438a9 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -381,7 +381,7 @@ static int xdl_cleanup_records(xdfile_t
 		hav = (*recs)->ha;
 		rhi = (long) XDL_HASHLONG(hav, xdf2->hbits);
 		for (nm = 0, rec = xdf2->rhash[rhi]; rec; rec = rec->next)
-			if (rec->ha == hav && ++nm == mlim)
+			if (rec->ha == hav || ++nm == mlim)
 				break;
 		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
 	}
@@ -392,7 +392,7 @@ static int xdl_cleanup_records(xdfile_t
 		hav = (*recs)->ha;
 		rhi = (long) XDL_HASHLONG(hav, xdf1->hbits);
 		for (nm = 0, rec = xdf1->rhash[rhi]; rec; rec = rec->next)
-			if (rec->ha == hav && ++nm == mlim)
+			if (rec->ha == hav || ++nm == mlim)
 				break;
 		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
 	}

However, that change causes the t800*.sh (14,16,18) annotate/blame
tests to fail, so take it with a grain of salt.

I.e., running one of them manually gave this:

    $ sh t8001-annotate.sh --immediate --verbose
    * expecting success: check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1
    Author A (expected 2, attributed 2) good
    Author B1 (expected 2, attributed 1) bad
    Author A U Thor (expected 1, attributed 2) bad
    Author B2 (expected 1, attributed 1) good
    Author B (expected 1, attributed 1) good
    * FAIL 14: Two lines blamed on A, one on B, two on B1, one on B2, one on A U Thor
            check_count A 2 B 1 B1 2 B2 1 "A U Thor" 1
    [Exit 1]
