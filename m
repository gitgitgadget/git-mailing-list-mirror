From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: avoid error on reload
Date: Sat, 17 May 2008 22:55:52 +0200
Message-ID: <200805172255.52828.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat May 17 22:58:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxTTc-0005zj-KI
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 22:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758538AbYEQU5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758561AbYEQU5J
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 16:57:09 -0400
Received: from smtp.katamail.com ([62.149.157.154]:40167 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1758438AbYEQU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 16:57:07 -0400
Received: (qmail 2429 invoked by uid 89); 17 May 2008 20:48:50 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host236-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.236)
  by smtp1-pc with SMTP; 17 May 2008 20:48:47 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82364>

When hitting "Reload", gitk can error out, complaining
about "wrong # coordinates: expected 0 or 4, got 2".
This patch checks that there are 4 coordinates to avoid this
error:

wrong # coordinates: expected 0 or 4, got 2
wrong # coordinates: expected 0 or 4, got 2
    while executing
".tf.histframe.pwclist.canv create rect -outline {} -tags secsel -fill gray85"
    ("eval" body line 1)
    invoked from within
"eval $canv create rect [$canv bbox $linehtag($l)] -outline {{}}  -tags secsel -fill [$canv cget -selectbackground]"
    (procedure "make_secsel" line 6)
    invoked from within
"make_secsel $l"
    (procedure "selectline" line 62)
    invoked from within
"selectline [rowofcommit $pending_select] 1"
    (procedure "layoutmore" line 12)
    invoked from within
"layoutmore"
    (procedure "chewcommits" line 5)
    invoked from within
"chewcommits"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 9)
    invoked from within
"dorunq"
    ("after" script)

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

I don't know if this patch is the right fix, so here is a script
that triggers this error:

--->8---
#!/bin/sh

rm -rf .git
git init
touch initial
git add initial
git commit initial -m "initial"

git checkout -b m-master

sleep 1
touch one
git add one
git commit one -m "one"
sleep 1
touch two
git add two
git commit two -m "two"
sleep 1
touch three
git add three
git commit three -m "three"

sleep 1
echo "Now reorder the commits as:"
echo "pick three"
echo "pick one"
echo "pick two"
read
git rebase -i master

git checkout -b m-reload master

sleep 1
touch four
git add four
git commit four -m "four"
sleep 1
touch five
git add five
git commit five -m "five"

git checkout m-master

gitk --all
# within gitk, reload: it should give an error.
# if it does not error out, checkout another branch and try
# to reload again.
---8<---

 gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 9ab6dba..041345d 100755
--- a/gitk
+++ b/gitk
@@ -5827,7 +5827,8 @@ proc dispnexttag {} {
 proc make_secsel {l} {
     global linehtag linentag linedtag canv canv2 canv3
 
-    if {![info exists linehtag($l)]} return
+    if {![info exists linehtag($l)] ||
+	[llength [$canv bbox $linehtag($l)]] ne 4 } return
     $canv delete secsel
     set t [eval $canv create rect [$canv bbox $linehtag($l)] -outline {{}} \
 	       -tags secsel -fill [$canv cget -selectbackground]]
-- 
1.5.5.1
