From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] get_cwd_relative(): do not misinterpret suffix as
 subdirectory
Date: Sat, 22 May 2010 13:13:05 +0200
Message-ID: <20100522111305.GA2888@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 13:13:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFme4-0001m8-P9
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 13:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab0EVLN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 07:13:27 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:47507 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab0EVLN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 07:13:26 -0400
Received: by wwi18 with SMTP id 18so1287253wwi.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 04:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=ZiAtj7DbVdU9nQG305YxiBrM2jt2hLM1fV6HA1ffZ2w=;
        b=GBwCVYSOxB33f0Q37W0Nt6Ydc5cp3eLkfzNvJzyjqVytLxKhqZiodpxXGzgh/BL+kf
         KSbrQMdJ/xUL6ko6Hmj3nANH3dS9cTO2aUNVMbR5D5XUwkHWHWbVv6ZWkvHeAQHYnaAk
         zquFg/UDnAt9UdZaMMbmAMbXNPaSHVqXFrceg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=xD/R+BL2IJoWL0poLymKpaPd+lIJC8ccphsbNfCHG+Q91gRl8kILlyKQgsKyQBmgQR
         O8xSHT2cbl4RYEETWHQCYKdjYio1IraJzyy45nlq6QX0B6Jogc/Utle4ci0/ykf7v3nr
         21RO0jvxoBX5U47ebLPuM3G7NwpBEbysHHM74=
Received: by 10.227.141.137 with SMTP id m9mr2552145wbu.202.1274526804544;
        Sat, 22 May 2010 04:13:24 -0700 (PDT)
Received: from darc.lan (p549A3CF7.dip.t-dialin.net [84.154.60.247])
        by mx.google.com with ESMTPS id z33sm14674606wbd.13.2010.05.22.04.13.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 04:13:23 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OFmdd-0003wf-6s; Sat, 22 May 2010 13:13:05 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147515>

If the current working directory is the same as the work tree path
plus a suffix, e.g. 'work' and 'work-xyz', then the suffix '-xyz'
would be interpreted as a subdirectory of 'work'.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Hi Junio,

I am not sure if the tests are really worth it. I do not mind you drop them.

Regards,
Clemens

 dir.c               |    9 +++++++--
 t/t1501-worktree.sh |   12 ++++++++++--
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index cb83332..5615f33 100644
--- a/dir.c
+++ b/dir.c
@@ -958,9 +958,14 @@ char *get_relative_cwd(char *buffer, int size, const char *dir)
 	}
 	if (*dir)
 		return NULL;
-	if (*cwd == '/')
+	switch (*cwd) {
+	case '\0':
+		return cwd;
+	case '/':
 		return cwd + 1;
-	return cwd;
+	default:
+		return NULL;
+	}
 }
 
 int is_inside_dir(const char *dir)
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 9df3012..bd8b607 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -30,6 +30,7 @@ test_rev_parse() {
 
 EMPTY_TREE=$(git write-tree)
 mkdir -p work/sub/dir || exit 1
+mkdir -p work2 || exit 1
 mv .git repo.git || exit 1
 
 say "core.worktree = relative path"
@@ -54,7 +55,9 @@ GIT_DIR=$(pwd)/repo.git
 GIT_CONFIG=$GIT_DIR/config
 git config core.worktree "$(pwd)/work"
 test_rev_parse 'outside'      false false false
-cd work || exit 1
+cd work2
+test_rev_parse 'outside2'     false false false
+cd ../work || exit 1
 test_rev_parse 'inside'       false false true ''
 cd sub/dir || exit 1
 test_rev_parse 'subdirectory' false false true sub/dir/
@@ -67,7 +70,9 @@ git config core.worktree non-existent
 GIT_WORK_TREE=work
 export GIT_WORK_TREE
 test_rev_parse 'outside'      false false false
-cd work || exit 1
+cd work2
+test_rev_parse 'outside'      false false false
+cd ../work || exit 1
 GIT_WORK_TREE=.
 test_rev_parse 'inside'       false false true ''
 cd sub/dir || exit 1
@@ -76,6 +81,7 @@ test_rev_parse 'subdirectory' false false true sub/dir/
 cd ../../.. || exit 1
 
 mv work repo.git/work
+mv work2 repo.git/work2
 
 say "GIT_WORK_TREE=absolute path, work tree below git dir"
 GIT_DIR=$(pwd)/repo.git
@@ -86,6 +92,8 @@ cd repo.git || exit 1
 test_rev_parse 'in repo.git'              false true  false
 cd objects || exit 1
 test_rev_parse 'in repo.git/objects'      false true  false
+cd ../work2 || exit 1
+test_rev_parse 'in repo.git/work2'      false true  false
 cd ../work || exit 1
 test_rev_parse 'in repo.git/work'         false true true ''
 cd sub/dir || exit 1
-- 
1.7.0.5.3.ga76e
