From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/3] octopus: make merge process simpler to follow
Date: Fri, 11 Dec 2009 16:38:57 -0800
Message-ID: <1260578339-30750-1-git-send-email-bebarino@gmail.com>
References: <87zl5p1gsp.fsf@jondo.cante.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 01:39:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJG0t-0006zo-4u
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 01:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761339AbZLLAi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761258AbZLLAi5
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 19:38:57 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58000 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445AbZLLAi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 19:38:56 -0500
Received: by gxk4 with SMTP id 4so1681109gxk.8
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 16:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iXSKksQlbuGLCK+VyTbV4xZuUzam2qFEOSNv54lPnQI=;
        b=wUocqPmULiZOTsauF3scMrrphsVb+lOLP+yzKSALWRDqxGaqDICLku94dRnJ1G8bjc
         zh9zuvbycixorKIQdqBamhAE3haU1NNZgCd4ArHmilfUmFTgswHUQIf4dFCHadFE4gAR
         qyhMf06wRCTMQx+Q+e5Tiu50lWh/07ucspc3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=li2g4SCRyW+krxGqaDOt26P6uenwvhtxh/gr8wmrc3GYnx4J3Gjj/3Q/YA/FTjpMsj
         GQFxtdTXWyeJaHZPkQHBTf5S+uLBiEOJ8b7qkq+rj6xkA1Kkul8pmr7o0LC0x11+bzF7
         XodiSr6uPxQz0QJvjpGZeLkkQuPHDT3epyqnk=
Received: by 10.150.101.5 with SMTP id y5mr3615941ybb.85.1260578342826;
        Fri, 11 Dec 2009 16:39:02 -0800 (PST)
Received: from localhost (cpe-72-129-49-143.socal.res.rr.com [72.129.49.143])
        by mx.google.com with ESMTPS id 34sm1100057yxf.65.2009.12.11.16.39.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 16:39:01 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.45.g9aadbb
In-Reply-To: <87zl5p1gsp.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135109>

Its not very easy to understand what heads are being merged given
the current output of an octopus merge. Fix this by replacing the
sha1 with the (usually) better description in GITHEAD_<SHA1>.

Suggested-by: Jari Aalto <jari.aalto@cante.net>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Maybe this will work? At least it will replace the sha1 with
whatever is given on the command line.

 git-merge-octopus.sh          |    9 +++++----
 t/t7602-merge-octopus-many.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 825c52c..1c8ee0a 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -61,12 +61,13 @@ do
 		exit 2
 	esac
 
+	pretty_name="$(eval echo \$GITHEAD_$SHA1)"
 	common=$(git merge-base --all $SHA1 $MRC) ||
-		die "Unable to find common commit with $SHA1"
+		die "Unable to find common commit with $pretty_name"
 
 	case "$LF$common$LF" in
 	*"$LF$SHA1$LF"*)
-		echo "Already up-to-date with $SHA1"
+		echo "Already up-to-date with $pretty_name"
 		continue
 		;;
 	esac
@@ -81,7 +82,7 @@ do
 		# tree as the intermediate result of the merge.
 		# We still need to count this as part of the parent set.
 
-		echo "Fast-forwarding to: $SHA1"
+		echo "Fast-forwarding to: $pretty_name"
 		git read-tree -u -m $head $SHA1 || exit
 		MRC=$SHA1 MRT=$(git write-tree)
 		continue
@@ -89,7 +90,7 @@ do
 
 	NON_FF_MERGE=1
 
-	echo "Trying simple merge with $SHA1"
+	echo "Trying simple merge with $pretty_name"
 	git read-tree -u -m --aggressive  $common $MRT $SHA1 || exit 2
 	next=$(git write-tree 2>/dev/null)
 	if test $? -ne 0
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 01e5415..7377033 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -49,4 +49,37 @@ test_expect_success 'merge c1 with c2, c3, c4, ... c29' '
 	done
 '
 
+cat >expected <<\EOF
+Trying simple merge with c2
+Trying simple merge with c3
+Trying simple merge with c4
+Merge made by octopus.
+ c2.c |    1 +
+ c3.c |    1 +
+ c4.c |    1 +
+ 3 files changed, 3 insertions(+), 0 deletions(-)
+ create mode 100644 c2.c
+ create mode 100644 c3.c
+ create mode 100644 c4.c
+EOF
+
+test_expect_success 'merge output uses pretty names' '
+	git reset --hard c1 &&
+	git merge c2 c3 c4 >actual &&
+	test_cmp actual expected
+'
+
+cat >expected <<\EOF
+Already up-to-date with c4
+Trying simple merge with c5
+Merge made by octopus.
+ c5.c |    1 +
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+ create mode 100644 c5.c
+EOF
+
+test_expect_success 'merge up-to-date output uses pretty names' '
+	git merge c4 c5 >actual &&
+	test_cmp actual expected
+'
 test_done
-- 
1.6.6.rc1.45.g9aadbb
