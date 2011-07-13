From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 7/9] svn-fe: write svnrev notes in remote-svn-alpha
Date: Wed, 13 Jul 2011 21:26:51 +0600
Message-ID: <1310570813-16648-8-git-send-email-divanorama@gmail.com>
References: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 17:27:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh1LC-0002iX-8h
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab1GMP0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:43 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64618 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522Ab1GMP0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:40 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so2202601ewy.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mq/tBRC2Nb4SOVMSnhMCW+uNIfMiB62XJ87UCGC7zC4=;
        b=wTAM75eiggnQ+RSJ1OMN4nfrLMpPfYQAV5MfdQ7a2t/B+Kh4bAMBrxe0+hhc3uRFnw
         qG5XGL8fRzw+ik0m//ZCfDbiB/viJShPFzXXRUw+5vN3W3cKPfe9PF1bo59nXC+6eMla
         xKsidv2SWK/muvXsgp767W47L5Qg/EBkzGGak=
Received: by 10.14.37.142 with SMTP id y14mr364529eea.90.1310570800015;
        Wed, 13 Jul 2011 08:26:40 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177047>

For each imported svn commit write "rN" note in a private namespace.
These can be viewed with somewhat ugly
$ git log --show-notes=refs/svn-alpha/<reponame>/SVNR
But also these notes can be used to import svn history incrementally.
Add a simple test for these notes.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha        |    9 ++++++---
 contrib/svn-fe/t/t9010-remote-svn-alpha.sh |   11 +++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index b410302..c2af393 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -58,8 +58,8 @@ SVNDUMP=${SVNDUMP:-`try_svnadmin`}
 test -n "$SVNDUMP" || die "neither svnrdump nor svnadmin & svnlook was found"
 
 do_import () {
-	revs=$1 url=$2 dst=$3
-	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --no-progress) 3<&0 || die "FAILURE"
+	revs=$1 url=$2 dst=$3 notes=$4
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --notes_ref="$notes" --no-progress) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
@@ -70,6 +70,8 @@ url=$2
 need_import=""
 remote_ref="refs/heads/master"
 private_ref="refs/svn-alpha/$repo/SVNHEAD"
+remote_notes="refs/notes/svnr"
+private_notes="refs/svn-alpha/$repo/SVNR"
 
 while read -r cmd args
 do
@@ -78,6 +80,7 @@ do
 		echo import
 		echo "refspec HEAD:$private_ref"
 		echo "refspec $remote_ref:$private_ref"
+		echo "refspec $remote_notes:$private_notes"
 		echo
 		;;
 	list)
@@ -92,7 +95,7 @@ do
 		;;
 	'')
 		test "$need_import" = "yes" || exit 0
-		do_import 0:HEAD "$url" "$private_ref"
+		do_import 0:HEAD "$url" "$private_ref" "$private_notes"
 		need_import=""
 		;;
 	*)
diff --git a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
index b0f41cb..5102428 100755
--- a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
+++ b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
@@ -265,4 +265,15 @@ test_expect_success TINY_SVN 'fetch TINY does not write to refs/heads/master' '
 	test_must_fail git show-ref --verify refs/heads/master
 '
 
+test_expect_success SMALL_SVN 'fetch SMALL writes revnum notes' '
+	reinit_git &&
+	url=$(svnurl small.svn) &&
+	git remote add svn "$url" &&
+	git fetch svn &&
+	git log --show-notes=refs/svn-alpha/svn/SVNR --format=%N -1 refs/remotes/svn/master^ >actual.note &&
+	echo r9 >expect.note &&
+	echo >>expect.note &&
+	test_cmp expect.note actual.note
+'
+
 test_done
-- 
1.7.3.4
