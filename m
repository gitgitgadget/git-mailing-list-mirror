From: Johan Herland <johan@herland.net>
Subject: [RFD/PATCH 5/5] RFD: Disallow out-of-refspec refs within refs/remotes/* to be used as upstream
Date: Fri, 19 Apr 2013 08:20:42 +0200
Message-ID: <1366352442-501-6-git-send-email-johan@herland.net>
References: <1366352442-501-1-git-send-email-johan@herland.net>
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 08:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4hl-0002ou-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 08:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967886Ab3DSGVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 02:21:48 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:63962 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756965Ab3DSGVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 02:21:47 -0400
Received: by mail-la0-f46.google.com with SMTP id ej20so1065987lab.33
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 23:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wwCA6LfpevHKLVRWPkkMkr/eXp93+BH/TTcyvqOvGs4=;
        b=CyJRRdSS2geLF3mtTVYIQ77+wJRnanUW/bJJhJRatkizP5PfNamiuJoEXXk7ag92YX
         zTyEN0SXONF3FfVh1sKE1wdHv/kN7KNPSmmEUy6vzvLXwWPHRtjpoMChKukD8Bd8GQlX
         ieYEHQZo8ng6j4dG4+OrmILv4YVyCWkvhLk4hZajKqCTrvaHsSAnq2ArojS6MIxU5mM+
         hZOijoTGnfUrqv3p6SXf6U+NNk8issaIVISBIYdT9INRE565DnJTgkXlf/xzdM5uJ2w3
         ipVb0zOMK48ZEsrKCxGeeW0lXbG2INlzUfQlJSthmMu5CePdIwBMHv5FwLVg5r2CQ1EB
         Vx6Q==
X-Received: by 10.152.116.52 with SMTP id jt20mr7394889lab.52.1366352505341;
        Thu, 18 Apr 2013 23:21:45 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id f4sm2076904lbw.6.2013.04.18.23.21.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 23:21:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366352442-501-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221746>

The previous patch adds validation of upstream remote-tracking branches by
parsing the configured refspecs, and making sure that the candidate upstream
(if not already matching refs/heads/* or refs/remotes/*) is indeed a
remote-tracking branch according to some remote's refspec. For a
default/conventional setup, this check would automatically also cover
everything within refs/remotes/*, meaning that the preceding check for
refs/remotes/* is redundant (although quicker than the validation against
refspecs). One could also argue that not everything inside refs/remotes/*
should be automatically acceptable as an upstream, if one were to keep
other (non-branch) type of remote-tracking refs there.

This patch removes the simple check for refs/remotes/*, to make sure that
_only_ validated remote-tracking branches (in addition to local branches)
are allowed as upstreams.

However, this means that for unconventional setups that place refs within
refs/remotes/* without configuring a corresponding refspec, those refs will
no longer be usable as upstreams. This breaks a few existing tests, which
are marked as test_expect_failure by this patch, to make them easy to find.
---
 branch.c                         | 1 -
 t/t3200-branch.sh                | 2 +-
 t/t7201-co.sh                    | 2 +-
 t/t9114-git-svn-dcommit-merge.sh | 8 ++++----
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index c9f9dec..beaf11d 100644
--- a/branch.c
+++ b/branch.c
@@ -274,7 +274,6 @@ void create_branch(const char *head,
 	case 1:
 		/* Unique completion -- good, only if it is a real branch */
 		if (prefixcmp(real_ref, "refs/heads/") &&
-		    prefixcmp(real_ref, "refs/remotes/") &&
 		    validate_remote_tracking_branch(real_ref)) {
 			if (explicit_tracking)
 				die(_(upstream_not_branch), start_name);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d969f0e..41d293d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -317,7 +317,7 @@ test_expect_success 'test tracking setup (non-wildcard, matching)' '
 	test $(git config branch.my4.merge) = refs/heads/master
 '
 
-test_expect_success 'test tracking setup (non-wildcard, not matching)' '
+test_expect_failure 'test tracking setup (non-wildcard, not matching)' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
 	(git show-ref -q refs/remotes/local/master || git fetch local) &&
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index be9672e..7267ee2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -429,7 +429,7 @@ test_expect_success 'detach a symbolic link HEAD' '
     test "z$(git rev-parse --verify refs/heads/master)" = "z$here"
 '
 
-test_expect_success \
+test_expect_failure \
     'checkout with --track fakes a sensible -b <name>' '
     git update-ref refs/remotes/origin/koala/bear renamer &&
 
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 3077851..ef274fd 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -45,7 +45,7 @@ test_expect_success 'setup svn repository' '
 	)
 	'
 
-test_expect_success 'setup git mirror and merge' '
+test_expect_failure 'setup git mirror and merge' '
 	git svn init "$svnrepo" -t tags -T trunk -b branches &&
 	git svn fetch &&
 	git checkout --track -b svn remotes/trunk &&
@@ -67,7 +67,7 @@ test_expect_success 'setup git mirror and merge' '
 
 test_debug 'gitk --all & sleep 1'
 
-test_expect_success 'verify pre-merge ancestry' "
+test_expect_failure 'verify pre-merge ancestry' "
 	test x\`git rev-parse --verify refs/heads/svn^2\` = \
 	     x\`git rev-parse --verify refs/heads/merge\` &&
 	git cat-file commit refs/heads/svn^ | grep '^friend$'
@@ -79,7 +79,7 @@ test_expect_success 'git svn dcommit merges' "
 
 test_debug 'gitk --all & sleep 1'
 
-test_expect_success 'verify post-merge ancestry' "
+test_expect_failure 'verify post-merge ancestry' "
 	test x\`git rev-parse --verify refs/heads/svn\` = \
 	     x\`git rev-parse --verify refs/remotes/trunk \` &&
 	test x\`git rev-parse --verify refs/heads/svn^2\` = \
@@ -87,7 +87,7 @@ test_expect_success 'verify post-merge ancestry' "
 	git cat-file commit refs/heads/svn^ | grep '^friend$'
 	"
 
-test_expect_success 'verify merge commit message' "
+test_expect_failure 'verify merge commit message' "
 	git rev-list --pretty=raw -1 refs/heads/svn | \
 	  grep \"    Merge branch 'merge' into svn\"
 	"
-- 
1.8.1.3.704.g33f7d4f
