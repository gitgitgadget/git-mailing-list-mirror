From: Csaba Henk <csaba@gluster.com>
Subject: [PATCH] filter-branch: retire --remap-to-ancestor
Date: Thu, 26 Aug 2010 14:52:33 +0530
Message-ID: <20100826092233.GA32617@acharya.in.gluster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 11:22:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoYfY-0005CZ-Tr
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 11:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab0HZJWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 05:22:41 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51493 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab0HZJWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 05:22:39 -0400
Received: by pvg2 with SMTP id 2so559788pvg.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=AxpTBfJMUv0TaGpUle8VOZftqNP/Ms8ayOLDxyyWPYY=;
        b=WHvmMWDapHPhT1WClA/+jDXQzysm1WqhAt7E707+gtYjRTv4GQxwFmwwUpZaHo1NJy
         sMb09cJaaORVSg4Hie2GmRq7eaCLAPW0+6OspVnbOO2xYOh3mRoQlyREQRM8ECOlk0+o
         /lzTBZaUoke48k3AhYR4pAMIexPhF11X3+/vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=jyVgLLu5nRKdyD/aAIj+M2Kvn4mna1geJaOyiya0ydbFJ2oRZMHlLrjk7Zyq33HTEK
         l6skoNUfQ1AYJ0ZqjeZEDTCgIBcJrARwO6QVaC3keCWAvNammi9Y1gTe24Wv0g4tTsLN
         ntvhZbiOzZy15lFeXD+3eapMIbn1msJ2fR5XE=
Received: by 10.114.102.11 with SMTP id z11mr10942045wab.13.1282814559235;
        Thu, 26 Aug 2010 02:22:39 -0700 (PDT)
Received: from acharya.in.gluster.com ([122.181.163.210])
        by mx.google.com with ESMTPS id c10sm4070728wam.1.2010.08.26.02.22.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 02:22:38 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154534>

We can be clever and know by ourselves when we need the behavior
implied by "--remap-to-ancestor". No need to encumber users by having
them exposed to it as a tunable.
---
 git-filter-branch.sh     |   14 ++++++++------
 t/t7003-filter-branch.sh |    4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 88fb0f0..fd5caaa 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -138,11 +138,6 @@ do
 		force=t
 		continue
 		;;
-	--remap-to-ancestor)
-		shift
-		remap_to_ancestor=t
-		continue
-		;;
 	--prune-empty)
 		shift
 		prune_empty=t
@@ -265,7 +260,14 @@ mkdir ../map || die "Could not create map/ directory"
 
 # we need "--" only if there are no path arguments in $@
 nonrevs=$(git rev-parse --no-revs "$@") || exit
-test -z "$nonrevs" && dashdash=-- || dashdash=
+if test -z "$nonrevs"
+then
+	dashdash=--
+else
+	dashdash=
+	remap_to_ancestor=t
+fi
+
 rev_args=$(git rev-parse --revs-only "$@")
 
 case "$filter_subdir" in
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 2c55801..486c453 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -289,7 +289,7 @@ test_expect_success 'Prune empty commits' '
 	test_cmp expect actual
 '
 
-test_expect_success '--remap-to-ancestor with filename filters' '
+test_expect_success 'filename filters work even if the given files are not changed in branch head' '
 	git checkout master &&
 	git reset --hard A &&
 	test_commit add-foo foo 1 &&
@@ -299,7 +299,7 @@ test_expect_success '--remap-to-ancestor with filename filters' '
 	orig_invariant=$(git rev-parse invariant) &&
 	git branch moved-bar &&
 	test_commit change-foo foo 2 &&
-	git filter-branch -f --remap-to-ancestor \
+	git filter-branch -f \
 		moved-foo moved-bar A..master \
 		-- -- foo &&
 	test $(git rev-parse moved-foo) = $(git rev-parse moved-bar) &&
-- 
1.7.2.2
