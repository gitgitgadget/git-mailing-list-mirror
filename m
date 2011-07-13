From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 6/9] svn-fe: use proper refspec in remote-svn-alpha
Date: Wed, 13 Jul 2011 21:26:50 +0600
Message-ID: <1310570813-16648-7-git-send-email-divanorama@gmail.com>
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
	id 1Qh1LB-0002iX-Oj
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab1GMP0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56795 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab1GMP0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:38 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so2112143eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jaw8RiK+YRrmL5ZLp0WMYUHo1M9tSIfcfmV5Zhbg9QA=;
        b=P7Ovg7ADfpEQFBW4zAO6ZTH1bs2VCJLhU4pccnOFnd7bpEnEfaMrq0YXVXncIG6qE2
         CbD3kRVbO9wuKh2wz+0no3KjAXxjqbIRBlz6YCAALzv8y8KEVPA3gD0ViItTW/KlKdlA
         G7/q68pARWLqrnpLH1H0Jo9Kb/Hpp20wWnE80=
Received: by 10.213.106.198 with SMTP id y6mr1606048ebo.125.1310570798188;
        Wed, 13 Jul 2011 08:26:38 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177050>

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
index ed8da7b..b410302 100755
--- a/contrib/svn-fe/git-remote-svn-alpha
+++ b/contrib/svn-fe/git-remote-svn-alpha
@@ -58,8 +58,8 @@ SVNDUMP=${SVNDUMP:-`try_svnadmin`}
 test -n "$SVNDUMP" || die "neither svnrdump nor svnadmin & svnlook was found"
 
 do_import () {
-	revs=$1 url=$2
-	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --no-progress) 3<&0 || die "FAILURE"
+	revs=$1 url=$2 dst=$3
+	(eval "$SVNDUMP \"$url\" -r\"$revs\"" |	svn-fe --ref="$dst" --no-progress) 3<&0 || die "FAILURE"
 	exec 1>&-
 }
 
@@ -68,29 +68,31 @@ usage 'git remote-svn-alpha <repository> <URL> < commandlist'
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
index 92bc4b2..b0f41cb 100755
--- a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
+++ b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
@@ -256,4 +256,13 @@ test_expect_success SMALL_SVN 'fetch updates from SMALL' '
 	test_nr_revs 10 .git refs/remotes/svn/master
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
