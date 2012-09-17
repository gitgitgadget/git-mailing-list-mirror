From: Ammon Riley <ammon.riley@gmail.com>
Subject: [PATCH] Allow fancy globs in git-svn init branches
Date: Mon, 17 Sep 2012 16:46:38 -0700
Message-ID: <1347925598-23907-1-git-send-email-ammon.riley@gmail.com>
Cc: normalperson@yhbt.net, marcin@owsiany.pl, schwern@pobox.com,
	Ammon Riley <ammon.riley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 01:47:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDl2A-0002Sc-64
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 01:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626Ab2IQXrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 19:47:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52580 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab2IQXrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 19:47:11 -0400
Received: by pbbrr13 with SMTP id rr13so9827530pbb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4baYWw42n6O8eTvUjcS82RxB+BACflwm7u40EJNMwIc=;
        b=IzEhh4+QRF07lHMhRplxi8FVVhCyZRaovqaCaloMOGGmCpO4UrZeq07y32BlJZsa53
         gytthnT/HlRnEPIoggVkINJC9a+TTF8xgTJwgxkhdlxqHGFtJ0PtUQe/amW/MTkokZh/
         ri25RPdYNDCmkT20ctnAtS6PGtcnGMP11UIBHN3N0z/iimSefP3o00a0QKc6DZ56zLgS
         HKkooRbulGJTK8R9FBgfX37Y1xaZUgo5wJNXK67Xf8itOaggH3bDZ/SNUUIT0Z0OEEru
         03sQtjBU7FWcfAde0Bjv+lcymgPYYWMz7SjNxvbh1byfW9F88uWx1uvZRF0TqSM39H5C
         HxDg==
Received: by 10.66.77.40 with SMTP id p8mr22414912paw.78.1347925631156;
        Mon, 17 Sep 2012 16:47:11 -0700 (PDT)
Received: from igloo.hlit.local ([12.108.21.226])
        by mx.google.com with ESMTPS id l3sm48534pay.2.2012.09.17.16.47.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 16:47:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.442.g5b277db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205768>

Branches passed to 'git-svn init' via the -b/--branches flag
automatically had a /* appended to them.  When the branch contained
a fancy glob with a {} pattern, this is incorrect behaviour, and
leads to odd branches being created in the git repository.

Signed-off-by: Ammon Riley <ammon.riley@gmail.com>
---
 git-svn.perl                         |  2 +-
 t/t9141-git-svn-multiple-branches.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0d77ffb..f8e8558 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1678,7 +1678,7 @@ sub complete_url_ls_init {
 	my $remote_path = join_paths( $gs->path, $repo_path );
 	$remote_path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
 	$remote_path =~ s#^/##g;
-	$remote_path .= "/*" if $remote_path !~ /\*/;
+	$remote_path .= "/*" if $remote_path !~ m#\*|\{[^/]+\}#;
 	my ($n) = ($switch =~ /^--(\w+)/);
 	if (length $pfx && $pfx !~ m#/$#) {
 		die "--prefix='$pfx' must have a trailing slash '/'\n";
diff --git a/t/t9141-git-svn-multiple-branches.sh b/t/t9141-git-svn-multiple-branches.sh
index 3cd0671..1b872a9 100755
--- a/t/t9141-git-svn-multiple-branches.sh
+++ b/t/t9141-git-svn-multiple-branches.sh
@@ -119,4 +119,16 @@ test_expect_success 'create new branches and tags' '
 		svn_cmd up && test -e tags_B/Tag2/a.file )
 '
 
+test_expect_success 'clone multiple branch paths using fancy glob' '
+	git svn clone -T trunk \
+		      -b b_one/{first} --branches b_two \
+		      "$svnrepo/project" git_project2 &&
+	( cd git_project2 &&
+		git rev-parse refs/remotes/first &&
+		test_must_fail git rev-parse refs/remotes/second &&
+		git rev-parse refs/remotes/1 &&
+		git rev-parse refs/remotes/2
+	)
+'
+
 test_done
-- 
1.7.12.465.gb319926
