From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Extend t6020 with another test for d/f interactions
Date: Wed, 19 Sep 2007 00:12:08 +0200
Message-ID: <20070918221208.GB14488@steel.home>
References: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	David Euresti <evelio@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 00:12:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlIp-0007sF-KZ
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbXIRWMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbXIRWMM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:12:12 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:63248 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbXIRWMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:12:10 -0400
Received: from tigra.home (Faaaa.f.strato-dslnet.de [195.4.170.170])
	by post.webmailer.de (klopstock mo8) (RZmta 12.10)
	with ESMTP id f00d38j8ILpvBt ; Wed, 19 Sep 2007 00:12:08 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3913B27752;
	Wed, 19 Sep 2007 00:12:08 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 18978BF18; Wed, 19 Sep 2007 00:12:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolCodE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58636>

A test for a merge when one of the trees has a file moved into a
directory with the same name (not just file replaced by a directory).

The problem noticed and reported by David Euresti

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---
 t/t6020-merge-df.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

David Euresti, Tue, Sep 18, 2007 22:34:53 +0200:
> If I try to merge in the changes from the other branch or if the other
> branch tries to merge in these changes I get this error:
> 
> dir/foo/foo.bin: unmerged (257cc5642cb1a054f08cc83f2d943e56fd3ebe99)
> fatal: git-write-tree: error building trees
> Merge with strategy recursive failed.

I extended the d/f merge test with the case. Have no idea how to fix
it yet though.

diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index a19d49d..c081d3f 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -10,6 +10,7 @@ test_expect_success 'prepare repository' \
 'echo "Hello" > init &&
 git add init &&
 git commit -m "Initial commit" &&
+git branch init &&
 git branch B &&
 mkdir dir &&
 echo "foo" > dir/foo &&
@@ -22,4 +23,20 @@ git commit -m "File: dir"'
 
 test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" B master'
 
+test_expect_success 'file moved into a dir of same name' '
+    git reset --hard &&
+    git checkout -b d1 init &&
+    mkdir dir &&
+    mv init dir/init &&
+    mv dir init &&
+    git add . &&
+    git commit -a -m"init moved into init/init" &&
+    git checkout -b d2 init &&
+    echo file >file &&
+    git add file &&
+    git commit -m"unrelated change" &&
+    git checkout d1 &&
+    git merge d2
+'
+
 test_done
-- 
1.5.3.1.173.g9a67
