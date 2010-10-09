From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/5] t7607: add leading-path tests
Date: Sat,  9 Oct 2010 15:52:57 +0200
Message-ID: <1286632380-7002-3-git-send-email-drizzd@aon.at>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 15:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4ZrW-0003Jt-7O
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 15:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab0JINxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 09:53:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55748 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab0JINxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 09:53:05 -0400
Received: by bwz15 with SMTP id 15so854492bwz.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2TSkHr/O6y+yVu03Dg1mlBsLyxeMTXBVS+urznRllHk=;
        b=hkI0voJ0W8WD/xgijd2mka5yPcMXitJyhT52XD0XY4+JT1/JYgcSLlxZzdIUBOCoS1
         Ex5JLvZSv8ai7CjaGCEjuul8RYnE8FF9IlK3P0RAOeGmIaBy5G+m8lmAVB/hAfP1en2Z
         m5Z2SlIWPd0Ohkt1Tos1o6Rw5od2bdNoHk610=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=CTSvwmjfFQoJu0OfH1tiZWbi60mc8IOw4lo5/23/c6MELHWAy2mCuol+ep1JFdf3LR
         CGUObZJ1Y2tzYQlvDPRyd0oHmb6VQZ3PrfDRgqqG4xzDQfrbJWMRtc9qn5BSZxNaqAew
         ZqdNltYScmwy2vWYvezFY66UjOOvuPdW0G2q4=
Received: by 10.204.84.148 with SMTP id j20mr1350398bkl.149.1286632383324;
        Sat, 09 Oct 2010 06:53:03 -0700 (PDT)
Received: from darc.lan (p549A51C3.dip.t-dialin.net [84.154.81.195])
        by mx.google.com with ESMTPS id a25sm1708515bks.8.2010.10.09.06.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 06:53:01 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4ZrN-0001sc-4M; Sat, 09 Oct 2010 15:53:13 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158588>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I added a test for symlinks as well, even though from the code it
looks like overwriting untracked symlinks is intentionally allowed.
One could argue that symlinks are valuable just like regular files.
On the other hand, the potential loss of information is relatively
small.

For consistency, I would prefer to treat symlinks just like regular
files, but I do not feel strongly about it.

Clemens

 t/t7607-merge-overwrite.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 6ed40b1..01b070b 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -12,6 +12,12 @@ test_expect_success 'setup' '
 	test_commit "c1a" "c1.t" "c1 a" &&
 	git reset --hard c0 &&
 	test_commit c2 &&
+	git reset --hard c0 &&
+	mkdir sub &&
+	echo "sub/f" > sub/f &&
+	git add sub/f &&
+	git commit -m sub &&
+	git tag sub &&
 	echo "VERY IMPORTANT CHANGES" > important
 '
 
@@ -23,6 +29,14 @@ test_expect_success 'will not overwrite untracked file' '
 	test_cmp important c2.t
 '
 
+test_expect_success 'will overwrite tracked file' '
+	git reset --hard c1 &&
+	cp important c2.t &&
+	git add c2.t &&
+	git commit -m important &&
+	git checkout c2
+'
+
 test_expect_success 'will not overwrite new file' '
 	git reset --hard c1 &&
 	cp important c2.t &&
@@ -76,4 +90,41 @@ test_expect_success 'will not overwrite removed file with staged changes' '
 	test_cmp important c1.t
 '
 
+test_expect_success 'will not overwrite untracked subtree' '
+	git reset --hard c0 &&
+	rm -rf sub &&
+	mkdir -p sub/f &&
+	cp important sub/f/important &&
+	test_must_fail git merge sub &&
+	! test -f .git/MERGE_HEAD &&
+	test_cmp important sub/f/important
+'
+
+test_expect_failure 'will not overwrite untracked file in leading path' '
+	git reset --hard c0 &&
+	rm -rf sub &&
+	cp important sub &&
+	test_must_fail git merge sub &&
+	! test -f .git/MERGE_HEAD &&
+	test_cmp important sub
+'
+
+test_expect_failure 'will not overwrite untracked symlink in leading path' '
+	git reset --hard c0 &&
+	rm -rf sub &&
+	mkdir sub2 &&
+	ln -s sub2 sub &&
+	test_must_fail git merge sub &&
+	! test -f .git/MERGE_HEAD
+'
+
+test_expect_success 'will not be confused by symlink in leading path' '
+	git reset --hard c0 &&
+	rm -rf sub &&
+	ln -s sub2 sub &&
+	git add sub &&
+	git commit -m ln &&
+	git checkout sub
+'
+
 test_done
-- 
1.7.1.571.gba4d01
