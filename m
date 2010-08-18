From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] submodule sync: Update "submodule.<name>.url"
Date: Wed, 18 Aug 2010 08:58:33 -0700
Message-ID: <1282147113-25816-1-git-send-email-davvid@gmail.com>
References: <4C6BB9E2.4060700@viscovery.net>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 17:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olkvo-0006LL-SZ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 17:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab0HRPvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 11:51:55 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64371 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0HRPvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 11:51:54 -0400
Received: by pvg2 with SMTP id 2so274970pvg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5yKFnqdVYzroBYPcyO2PHielnbfvU3zbzdps3BdEBI4=;
        b=uiW72y3UnVa203wCo79TOCj/MCy55Y+g7alCYzYgLL+Ozn0jlQrgGnL+BoVIRjs9Pp
         gWAfN0kNRuePDxMWh0XuqyIZq+8gIsdz8zE68FT8YDQjLl8AnAlFp00XJHxMo8OOitAn
         aEetekHk/ZhZqeKadssCzb2ejqLmlPCxUztjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jy1tO4Q0hXIj4Tjccm/BpMltoedypqVq1rvBQIWHwzJJQcFnRYRVYE4IA9+cXrXjD8
         VRIsuKvGpt4xaQwzxMR5+YgdjVTie/6h/IjAvAuLjOfrSi99qZYhY/SfYQIdqkDQwRsw
         wiYEVYQXskCVe5sGDkKP13V1kx3SjSfsqib34=
Received: by 10.114.24.1 with SMTP id 1mr9789549wax.76.1282146706215;
        Wed, 18 Aug 2010 08:51:46 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 33sm722551wad.18.2010.08.18.08.51.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 08:51:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.97.g3235b
In-Reply-To: <4C6BB9E2.4060700@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153863>

When "git submodule sync" synchronizes the repository URLs
it only updates submodules' .git/config.  However, the old
URLs still exist in the super-project's .git/config.

Update the super-project's configuration so that commands
such as "git submodule update" use the URLs from .gitmodules.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Changes since v1:
We now call clear_local_git_env after configuring
the super project (thanks Johannes).

 git-submodule.sh          |    3 ++-
 t/t7403-submodule-sync.sh |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 170186f..9ebbab7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -839,10 +839,11 @@ cmd_sync()
 		if test -e "$path"/.git
 		then
 		(
+			say "Synchronizing submodule url for '$name'"
+			git config submodule."$name".url "$url"
 			clear_local_git_env
 			cd "$path"
 			remote=$(get_default_remote)
-			say "Synchronizing submodule url for '$name'"
 			git config remote."$remote".url "$url"
 		)
 		fi
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 7538756..3033c4a 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -58,6 +58,9 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	(cd super-clone/submodule &&
 	 git checkout master &&
 	 git pull
+	) &&
+	(cd super-clone &&
+	 test -d "$(git config submodule.submodule.url)"
 	)
 '
 
-- 
1.7.2.1.97.g3235b
