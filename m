From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] Add unit test for check_cherry_pick
Date: Fri,  3 Sep 2010 14:52:15 -0400
Message-ID: <1283539935-14672-1-git-send-email-stevenrwalter@gmail.com>
References: <AANLkTikuY28wwccxekDXD1WGtaOoF3JG7ZBfm6vjapwt@mail.gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 03 20:52:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrbNX-000283-HZ
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 20:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab0ICSwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 14:52:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49100 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0ICSwl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 14:52:41 -0400
Received: by gwj17 with SMTP id 17so832089gwj.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=5681aeA8USFQvQn1kDgmPuDm3U1XNo6J0zC52VxFinU=;
        b=r9ceTrocqKiaJNwOVU70SpQrH9rPo7+RDFN0ZBUNTQyP4jrXAhMXBwcs1XoxHl5SUi
         Ct9r+vmygSbhMww+s1NpIpSdaSyK8WtJ1qwJF0s/QlC3Y769dfJI83oIN/Uz+DsYyVFY
         Es0/PkqOrwKLPfG8ilFAXykbWUHUbXxkYBl+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Srh9q1qE7icFZTkmRZtcWLYkQZRSVF/xFCyFVno0oRyE9u7PlHA06OYT6Fnpx4M8z/
         fJmHft/lu9JqQow5JCHNv+mMgJQviZU4rx7XfM4BQJbJ1uPN7yzoJTgvBGHK4hqDT28y
         gprVP8MJ30Hlc+sK/WnBIorxM5umTH7sGHHO4=
Received: by 10.150.69.34 with SMTP id r34mr187587yba.385.1283539960798;
        Fri, 03 Sep 2010 11:52:40 -0700 (PDT)
Received: from brock (adsl-234-158-248.bgk.bellsouth.net [74.234.158.248])
        by mx.google.com with ESMTPS id q1sm2642661ybk.20.2010.09.03.11.52.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 11:52:39 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.71)
	(envelope-from <srwalter@dervierte>)
	id 1OrbNN-0003pB-Fr; Fri, 03 Sep 2010 14:52:37 -0400
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <AANLkTikuY28wwccxekDXD1WGtaOoF3JG7ZBfm6vjapwt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155263>


Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 t/t9155-git-svn-fetch-merge.sh |   65 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100644 t/t9155-git-svn-fetch-merge.sh

diff --git a/t/t9155-git-svn-fetch-merge.sh b/t/t9155-git-svn-fetch-merge.sh
new file mode 100644
index 0000000..1c87986
--- /dev/null
+++ b/t/t9155-git-svn-fetch-merge.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Steven Walter
+#
+
+test_description='git svn merge detection'
+
+GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
+
+. ./lib-git-svn.sh
+
+say 'define NO_SVN_TESTS to skip git svn tests'
+
+case "$GIT_SVN_LC_ALL" in
+*.UTF-8)
+	test_set_prereq UTF8
+	;;
+*)
+	say "UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
+	;;
+esac
+
+test_expect_success \
+    'initialize source svn repo' '
+        svn_cmd mkdir -m x "$svnrepo"/trunk &&
+        svn_cmd mkdir -m x "$svnrepo"/branches &&
+        svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
+	cd "$SVN_TREE" &&
+	touch foo &&
+	svn add foo &&
+	svn commit -m "initial commit" &&
+	svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
+	touch bar &&
+	svn add bar &&
+	svn commit -m x &&
+	svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch2 &&
+	svn switch "$svnrepo"/branches/branch1 &&
+	touch baz &&
+	svn add baz &&
+	svn commit -m x &&
+	svn switch "$svnrepo"/trunk &&
+	svn merge "$svnrepo"/branches/branch1 &&
+	svn commit -m "merge" &&
+	svn switch "$svnrepo"/branches/branch1 &&
+	svn commit -m x &&
+	svn switch "$svnrepo"/branches/branch2 &&
+	svn merge "$svnrepo"/branches/branch1 &&
+	svn commit -m "merge branch1" &&
+	svn switch "$svnrepo"/trunk &&
+	svn merge "$svnrepo"/branches/branch2 &&
+	svn resolved baz &&
+	svn commit -m "merge branch2" &&
+	cd .. &&
+	rm -rf "$SVN_TREE"'
+
+test_expect_success \
+    'clone svn repo' '
+        git svn init -s "$svnrepo" &&
+	git svn fetch'
+
+test_expect_success \
+    'verify merge commit' '
+        git rev-parse HEAD^2'
+
+test_done
-- 
1.7.0.5.gbc75a
