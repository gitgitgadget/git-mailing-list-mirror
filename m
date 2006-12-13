X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Remove uncontested renamed files during merge.
Date: Wed, 13 Dec 2006 04:55:40 -0500
Message-ID: <20061213095540.GA25001@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 09:56:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 8343 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:55:46 EST
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34197>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuQqJ-0000ln-Jx for gcvg-git@gmane.org; Wed, 13 Dec
 2006 10:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932644AbWLMJzr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 04:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWLMJzr
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 04:55:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57575 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932644AbWLMJzq (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 04:55:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuQpw-0004Hh-2H; Wed, 13 Dec 2006 04:55:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 57B1320FB6E; Wed, 13 Dec 2006 04:55:40 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Prior to 65ac6e9c3f47807cb603af07a6a9e1a43bc119ae we deleted a
file from the working directory during a merge if the file existed
in the working directory before the merge started but was renamed
by the branch which is being merged in.  This broke in 65ac63 as
git-merge-recursive did not actually update the working directory
on this uncontested rename case.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 The same repository that spawned my 'Bug in merge-recursive in
 virtual commit corner case' thread discovered this feature of
 git-merge-recursive today.

 I'm not sure this is the right way to fix the issue, but it does
 appear to fix the problem and passes both the existing tests and
 this new one.

 merge-recursive.c        |    2 +-
 t/t6024-merge-rename2.sh |   97 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9d53bcd..741d17f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -873,7 +873,7 @@ static int process_renames(struct path_list *a_renames,
 			struct diff_filespec src_other, dst_other;
 			int try_merge, stage = a_renames == renames1 ? 3: 2;
 
-			remove_file(1, ren1_src, 1);
+			remove_file(1, ren1_src, 0);
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[stage].sha);
 			src_other.mode = ren1->src_entry->stages[stage].mode;
diff --git a/t/t6024-merge-rename2.sh b/t/t6024-merge-rename2.sh
new file mode 100755
index 0000000..69c66cf
--- /dev/null
+++ b/t/t6024-merge-rename2.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+test_description='Merge-recursive merging renames'
+. ./test-lib.sh
+
+test_expect_success setup \
+'
+cat >A <<\EOF &&
+a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
+c cccccccccccccccccccccccccccccccccccccccccccccccc
+d dddddddddddddddddddddddddddddddddddddddddddddddd
+e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
+f ffffffffffffffffffffffffffffffffffffffffffffffff
+g gggggggggggggggggggggggggggggggggggggggggggggggg
+h hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
+i iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
+j jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
+k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
+l llllllllllllllllllllllllllllllllllllllllllllllll
+m mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
+n nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
+o oooooooooooooooooooooooooooooooooooooooooooooooo
+EOF
+
+cat >M <<\EOF &&
+A AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+B BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
+C CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
+D DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
+E EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
+F FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
+G GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
+H HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH
+I IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
+J JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
+K KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
+L LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL
+M MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
+N NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
+O OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
+EOF
+
+git add A M &&
+git commit -m "initial has A and M" &&
+git branch white &&
+git branch red &&
+
+git checkout white &&
+sed -e "/^g /s/.*/g : white changes a line/" <A >B &&
+sed -e "/^G /s/.*/G : colored branch changes a line/" <M >N &&
+rm -f A M &&
+git update-index --add --remove A B M N &&
+git commit -m "white renames A->B, M->N" &&
+
+git checkout red &&
+echo created by red >R &&
+git update-index --add R &&
+git commit -m "red creates R" &&
+
+git checkout master'
+
+# This test broke in 65ac6e9c3f47807cb603af07a6a9e1a43bc119ae
+test_expect_success 'merge white into red (A->B,M->N)' \
+'
+	git checkout -b red-white red &&
+	git merge white &&
+	git write-tree >/dev/null || {
+		echo "BAD: merge did not complete"
+		return 1
+	}
+
+	test -f B || {
+		echo "BAD: B does not exist in working directory"
+		return 1
+	}
+	test -f N || {
+		echo "BAD: N does not exist in working directory"
+		return 1
+	}
+	test -f R || {
+		echo "BAD: R does not exist in working directory"
+		return 1
+	}
+
+	test -f A && {
+		echo "BAD: A still exists in working directory"
+		return 1
+	}
+	test -f M && {
+		echo "BAD: M still exists in working directory"
+		return 1
+	}
+	return 0
+'
+
+test_done
-- 
