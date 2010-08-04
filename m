From: Will Palmer <wmpalmer@gmail.com>
Subject: [BUG/TEST] show breakage of status for copy+conflict
Date: Wed,  4 Aug 2010 23:19:53 +0100
Message-ID: <1280960393-17256-1-git-send-email-wmpalmer@gmail.com>
Cc: Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 00:20:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgmJr-0006Z4-JP
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 00:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118Ab0HDWUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 18:20:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57813 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab0HDWUG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 18:20:06 -0400
Received: by wyb39 with SMTP id 39so6014255wyb.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OJfOb6Zt8nMz8CwnRwMSAz04Yc6WHF5SmTGQFNIUjLg=;
        b=eNJhdyXZ5pfQnRM8oNd3rhteR8EgvHooSrKs/bxZXgaDS8Y2tSaH5NOIj0FqChRYth
         eRdeTEWn+kAb0u+G/JAqRKmFNOOAvGgh//8IVxlNn82uqxPaLY/dZNf6R4P/eK6maJ1C
         ARP3dMzDj9ljaprPU3t2BQ0kwTZmGcipA2HlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nH53W0MHu2QqnDuy6mgcMfuGipUZ3zLaWTzoe4wnTWSq05UTDtTSYzXkrDxOAwKRUE
         nnmb6d493ixUfrhGuoMjdEfatfr/edXsn4X9Y0MYjSKBUahbtyZs31/sw0TTZkF8SAa4
         jgvwfqVwvePji+WQbewHi3dKmSleaMPVG4t50=
Received: by 10.216.35.213 with SMTP id u63mr2597467wea.83.1280960404954;
        Wed, 04 Aug 2010 15:20:04 -0700 (PDT)
Received: from localhost.localdomain (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id u32sm4679584weq.35.2010.08.04.15.20.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 15:20:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.703.g42c01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152606>

This is more intended to be a demonstration of a bug than an actual
test for inclusion into the library. It probably needs some cleaning
and moving around if it is to be included.

I noticed during a rebase that a conflicted file was not showing up
under the "both changed:" line, and was instead showing up as the
original name of a rename.
This was because the file had conflicts, and so was not in the index
(or at least, not in stage 0, if I have my terminology correct), while
another, very similar (both based on the same template) file had been
added as part of the same change on my side. This has several
interesting effects:
  - the file showed up as the original of a renamed file
  - the file did not show up under the list of files with staged changes
  - the file did not show up under the list of files with unstaged
    changes

Clearly, this is incorrect. It also had the side-effect of causing me to
accidentally add files with conflict-markers, as I thought that perhaps
the merge was simply confused about a similar file having been added.
That is, I thought the file had simple been removed from the index, so
I added it, conflict-markers and all.

the test presented here is based on conflict+copy, a simplification of
the real-world "conflict+addOfSimilarFile" scenario, as it demonstrates
the problem without the need to make up two similar-but-not-copied
files.

in testing, I noticed that "git status" shows the expected results for:
git checkout modify-and-copy && git merge modify-a-file

but shows the incorrect results for:
git checkout modify-a-file && git merge modify-and-copy

I don't really have the time right now to look for exactly what causes
this bug, so I'm hoping that posting a demonstration of it will get
someone else to fix it for me.

Though I don't think this test is appropriate as-is for inclusion, I'm
signing off just to make it clear that it's okay to base other work on
it.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 t/t7508-status.sh |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a72fe3a..4c0a24a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -7,7 +7,63 @@ test_description='git status'
 
 . ./test-lib.sh
 
+cat >expect << EOF
+# On branch master
+# Unmerged paths:
+#   (use "git add/rm <file>..." as appropriate to mark resolution)
+#
+#	both modified:      A
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	expect
+#	output
+EOF
+
+test_expect_failure "conflict with copy should not trigger rename detection" '
+	cat >A <<- \EOF &&
+		a aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+		b bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
+		c cccccccccccccccccccccccccccccccccccccccccccccccc
+		d dddddddddddddddddddddddddddddddddddddddddddddddd
+		e eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
+		f ffffffffffffffffffffffffffffffffffffffffffffffff
+		g gggggggggggggggggggggggggggggggggggggggggggggggg
+		h hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
+		i iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
+		j jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
+		k kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
+		l llllllllllllllllllllllllllllllllllllllllllllllll
+		m mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
+		n nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
+		o oooooooooooooooooooooooooooooooooooooooooooooooo
+EOF
+	git add A &&
+	git commit -m "add A" &&
+	git tag conflicted-merge-base &&
+	sed -e "/^g /s/.*/g : changed line/" <A >A+ &&
+	cp A B &&
+	mv A+ A &&
+	git add A B &&
+	git commit -m "change and copy A" &&
+	git tag change-copy &&
+	git reset --hard conflicted-merge-base &&
+	sed -e "/^g /s/.*/g : modified row/" <A >A+ &&
+	mv A+ A &&
+	git add A &&
+	git commit -m "change A" &&
+	test_must_fail git merge change-copy &&
+	git status > output &&
+	test_cmp expect output
+'
+
 test_expect_success 'setup' '
+	git reset --hard &&
+	git branch -m merge-test &&
+	git checkout --orphan master &&
+	git rm -f A &&
+	rm expect output &&
 	: >tracked &&
 	: >modified &&
 	mkdir dir1 &&
-- 
1.7.1.703.g42c01
