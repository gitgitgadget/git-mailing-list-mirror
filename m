From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 5/5] svn-fe: use proper refspec in remote-svn-alpha
Date: Tue,  5 Jul 2011 22:45:50 +0600
Message-ID: <1309884350-13415-6-git-send-email-divanorama@gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 18:44:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe8jx-0002em-DG
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 18:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756341Ab1GEQop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 12:44:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48448 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323Ab1GEQom (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 12:44:42 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4899837bwd.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZvCCZgRe8I92HKEMLJvdmfGMiGXBaHWQauW2FEmKgUs=;
        b=ibloDTrvIV1Tzg+p3CLqMezO8BM28Yb94QqEseRLiCeie6GQwUalGi0dL99mneNkv5
         iklfXjXln6ASTzs2kpyNh1hPXadw9pkVWSJjaopxxNLdYvAdWePMY1XNcvWX237s7gx7
         Mjn+XAQJo3Creuz/9nUbbJ43+/fwHQRbjJCQ0=
Received: by 10.204.80.200 with SMTP id u8mr7411730bkk.81.1309884281887;
        Tue, 05 Jul 2011 09:44:41 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id l24sm6696272bkw.15.2011.07.05.09.44.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 09:44:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176615>

Create a per repository name private refs namespace as suggested by
the remote helpers documentation. This allows to have several svn
remotes at the same time. And also this way we don't overwrite the
local branch master.

The refpec is:
HEAD:refs/svn-alpha/$reponame/SVNHEAD
refs/heads/master:refs/svn-alpha/$reponame/SVNHEAD

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/git-remote-svn-alpha        |   18 ++++++++++--------
 contrib/svn-fe/t/t9010-remote-svn-alpha.sh |    9 +++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/git-remote-svn-alpha
index d75bc2a..d4b90ae 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -36,8 +36,8 @@ SVNDUMP=${SVNDUMP:-`try_svnrdump`}
 SVNDUMP=${SVNDUMP:-`try_svnadmin`}
 
 do_import () {
-	revs=$1 url=$2
-	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --no-progress) 3<&0 || die "FAILURE"
+	revs=$1 url=$2 dst=$3
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --no-progress) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
@@ -46,29 +46,31 @@ usage 'git remote-svn-alpha <repository> <URL> < commandlist'
 repo=$1
 url=$2
 need_import=""
+remote_ref="refs/heads/master"
+private_ref="refs/svn-alpha/$repo/SVNHEAD"
 
 while read -r cmd args
 do
 	case $cmd in
 	capabilities)
 		echo import
-		echo "refspec HEAD:refs/heads/master"
-		echo "refspec refs/heads/master:refs/heads/master"
+		echo "refspec HEAD:$private_ref"
+		echo "refspec $remote_ref:$private_ref"
 		echo
 		;;
 	list)
-		echo '? HEAD'
-		echo '? refs/heads/master'
+		echo "? HEAD"
+		echo "? $remote_ref"
 		echo
 		;;
 	import)
-		test "$args" = "HEAD" || test "$args" = "refs/heads/master" ||
+		test "$args" = "HEAD" || test "$args" = "$remote_ref" ||
 		die "remote-svn-alpha: unsupported import ref argument: $args"
 		need_import="yes"
 		;;
 	'')
 		test "$need_import" = "yes" || exit 0
-		do_import 0:HEAD "$url"
+		do_import 0:HEAD "$url" "$private_ref"
 		need_import=""
 		;;
 	*)
diff --git a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
index 30dc726..786cc1f 100755
--- a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
+++ b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
@@ -226,4 +226,13 @@ test_expect_success SMALL_SVN 'fetch each rev of SMALL separately' '
 	test_cmp ref7_2 ref_2
 '
 
+test_expect_success TINY_SVN 'fetch TINY does not write to refs/heads/master' '
+	reinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git remote add svn "$url" &&
+	git fetch svn &&
+	git show-ref --verify refs/remotes/svn/master &&
+	test_must_fail git show-ref --verify refs/heads/master
+'
+
 test_done
-- 
1.7.3.4
