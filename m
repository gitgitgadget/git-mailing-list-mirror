From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH 1/1] am: add gitk patch format
Date: Wed,  3 Sep 2014 21:35:19 +1200
Message-ID: <1409736919-22341-2-git-send-email-judge.packham@gmail.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 11:36:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP6zc-0008RE-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 11:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbaICJfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 05:35:45 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:44136 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756035AbaICJfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 05:35:44 -0400
Received: by mail-pa0-f49.google.com with SMTP id kq14so16688350pab.8
        for <git@vger.kernel.org>; Wed, 03 Sep 2014 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+LFjhlMRIOLU4NxXI6UiY8ushZXFP775GWSUM9NItAY=;
        b=u3JxqfrQFa+GIUBjSw41/a0EjACQKVNSHTkZ95gANcTBhPM9mf9zK1UnK3qEBLFONT
         EZ0mysgaPGtZm8ZGiP/XUXPPxMYdNT8Im8BD4PYjjK14jbHeD6tLLYPzYi/rrquSzJcx
         dVQ09AZGKSztNcAff2tVYLynL54Xca3R/zvYbVQYvKu6SXEg78z5ahkud9pP0EuUCGbC
         GdRVMQn9KXmFsPNntTfXCu4ZrwTffOEy8SVqQ0aPnjlcMKjHxxGZ5ubaoIxMs+sLqRWk
         +cSaV1iAygtY5qf/b4zNIm+qDkN38V0M+flD1pI/97xoZcE+uBGE+N7kHYd9hCBM1c1H
         RdCg==
X-Received: by 10.66.102.68 with SMTP id fm4mr56224840pab.46.1409736936971;
        Wed, 03 Sep 2014 02:35:36 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id y4sm8733203pdm.1.2014.09.03.02.35.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Sep 2014 02:35:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256385>

Patches created using gitk's "write commit to file" functionality (which
uses 'git diff-tree -p --pretty' under the hood) need some massaging in
order to apply cleanly. This consists of dropping the 'commit' line
automatically determining the subject and removing leading whitespace.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 Documentation/git-am.txt |    3 ++-
 git-am.sh                |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9adce37..b59d2b3 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -101,7 +101,8 @@ default.   You can use `--no-utf8` to override this.
 	By default the command will try to detect the patch format
 	automatically. This option allows the user to bypass the automatic
 	detection and specify the patch format that the patch(es) should be
-	interpreted as. Valid formats are mbox, stgit, stgit-series and hg.
+	interpreted as. Valid formats are mbox, stgit, stgit-series, hg and
+	gitk.
 
 -i::
 --interactive::
diff --git a/git-am.sh b/git-am.sh
index ee61a77..73b0a86 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -227,6 +227,9 @@ check_patch_format () {
 		"# HG changeset patch")
 			patch_format=hg
 			;;
+		'commit '*)
+			patch_format=gitk
+			;;
 		*)
 			# if the second line is empty and the third is
 			# a From, Author or Date entry, this is very
@@ -357,6 +360,38 @@ split_patches () {
 		this=
 		msgnum=
 		;;
+	gitk)
+		# These patches are generates with 'git diff-tree -p --pretty'
+		# we discard the 'commit' line, after that the first line not
+		# starting with 'Author:' or 'Date:' is the subject. We also
+		# need to strip leading whitespace from the message body.
+		this=0
+		for gitk in "$@"
+		do
+			this=$(expr "$this" + 1)
+			msgnum=$(printf "%0${prec}d" $this)
+			@@PERL@@ -ne 'BEGIN { $subject = 0 }
+				s/^    // ;
+				if ($subject > 1) { print ; }
+				elsif (/^commit\s.*$/) { next ; }
+				elsif (/^\s+$/) { next ; }
+				elsif (/^Author:/) { s/Author/From/ ; print ;}
+				elsif (/^Date:/) { print ;}
+				elsif ($subject) {
+					$subject = 2 ;
+					print "\n" ;
+					print ;
+				} else {
+					print "Subject: ", $_ ;
+					$subject = 1;
+				}
+			' <"$gitk" >"$dotest/$msgnum" || clean_abort
+
+		done
+		echo "$this" >"$dotest/last"
+		this=
+		msgnum=
+		;;
 	*)
 		if test -n "$patch_format"
 		then
-- 
1.7.9.5
