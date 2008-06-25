From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix t5303 (the test case for pack corruptions) on Windows
Date: Wed, 25 Jun 2008 20:35:13 +0200
Message-ID: <20080625183513.GD4039@steel.home>
References: <alpine.LFD.1.10.0806232123420.2979@xanadu.home> <20080625164438.GA4039@steel.home> <7vskv11keo.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:36:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZqp-0001Mb-CX
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 20:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbYFYSfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbYFYSfS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:35:18 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:60744 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbYFYSfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:35:17 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf4EbVSQ==
Received: from tigra.home (Fad8f.f.strato-dslnet.de [195.4.173.143])
	by post.webmailer.de (klopstock mo34) (RZmta 16.45)
	with ESMTP id j03818k5PHjEKB ; Wed, 25 Jun 2008 20:35:13 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4CC7D277BD;
	Wed, 25 Jun 2008 20:35:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 36CDC56D2A; Wed, 25 Jun 2008 20:35:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vskv11keo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86316>

The perldiag(1) has following to say about this:

    "Can't do inplace edit without backup"

	(F) You're on a system such as MS-DOS that gets confused if
	you try reading from a deleted (but still opened) file. You
	have to say -i.bak, or some such.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Wed, Jun 25, 2008 19:42:07 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > The perldiag(1) has following to say about this:
> >
> >     "Can't do inplace edit without backup"
> >
> > 	(F) You're on a system such as MS-DOS that gets confused if
> > 	you try reading from a deleted (but still opened) file. You
> > 	have to say -i.bak, or some such.
> 
> Thanks.  By the way, there are others.
> 
> t/t9106-git-svn-dcommit-clobber-series.sh:23:		perl -i -p -e "s/^58$/5588/" file &&
> t/t9106-git-svn-dcommit-clobber-series.sh:24:		perl -i -p -e "s/^61$/6611/" file &&
> t/t9106-git-svn-dcommit-clobber-series.sh:43:	perl -i -p -e 's/^4\$/4444/' file &&
> t/t9106-git-svn-dcommit-clobber-series.sh:44:	perl -i -p -e 's/^7\$/7777/' file &&
> templates/hooks--prepare-commit-msg.sample:25:    perl -i -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
> templates/hooks--prepare-commit-msg.sample:28:#   perl -i -pe '

Ouch, I have the svn tests disabled, so I couldn't notice.

FWIW, resending with the rest corrected.

 t/t5303-pack-corruption-resilience.sh      |    4 ++--
 t/t9106-git-svn-dcommit-clobber-series.sh  |    8 ++++----
 templates/hooks--prepare-commit-msg.sample |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index b0f5693..31b20b2 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -90,7 +90,7 @@ test_expect_success \
     'create_new_pack &&
      git prune-packed &&
      chmod +w ${pack}.pack &&
-     perl -i -pe "s/ base /abcdef/" ${pack}.pack &&
+     perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
      test_must_fail git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -138,7 +138,7 @@ test_expect_success \
     'create_new_pack &&
      git prune-packed &&
      chmod +w ${pack}.pack &&
-     perl -i -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
+     perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
index a400dc7..f8f4718 100755
--- a/t/t9106-git-svn-dcommit-clobber-series.sh
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -20,8 +20,8 @@ test_expect_success '(supposedly) non-conflicting change from SVN' '
 	test x"`sed -n -e 61p < file`" = x61 &&
 	svn co "$svnrepo" tmp &&
 	cd tmp &&
-		perl -i -p -e "s/^58$/5588/" file &&
-		perl -i -p -e "s/^61$/6611/" file &&
+		perl -i.bak -p -e "s/^58$/5588/" file &&
+		perl -i.bak -p -e "s/^61$/6611/" file &&
 		poke file &&
 		test x"`sed -n -e 58p < file`" = x5588 &&
 		test x"`sed -n -e 61p < file`" = x6611 &&
@@ -40,8 +40,8 @@ test_expect_success 'some unrelated changes to git' "
 test_expect_success 'change file but in unrelated area' "
 	test x\"\`sed -n -e 4p < file\`\" = x4 &&
 	test x\"\`sed -n -e 7p < file\`\" = x7 &&
-	perl -i -p -e 's/^4\$/4444/' file &&
-	perl -i -p -e 's/^7\$/7777/' file &&
+	perl -i.bak -p -e 's/^4\$/4444/' file &&
+	perl -i.bak -p -e 's/^7\$/7777/' file &&
 	test x\"\`sed -n -e 4p < file\`\" = x4444 &&
 	test x\"\`sed -n -e 7p < file\`\" = x7777 &&
 	git commit -m '4 => 4444, 7 => 7777' file &&
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index aa42acf..3652424 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -22,10 +22,10 @@
 
 case "$2,$3" in
   merge,)
-    perl -i -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
+    perl -i.bak -ne 's/^/# /, s/^# #/#/ if /^Conflicts/ .. /#/; print' "$1" ;;
 
 # ,|template,)
-#   perl -i -pe '
+#   perl -i.bak -pe '
 #      print "\n" . `git diff --cached --name-status -r`
 #	 if /^#/ && $first++ == 0' "$1" ;;
 
-- 
1.5.6.91.geb23
