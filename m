From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] submodule sync: Update "submodule.<name>.url"
Date: Wed, 18 Aug 2010 03:01:13 -0700
Message-ID: <1282125673-22956-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 11:54:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlfLp-0004os-HQ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 11:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab0HRJyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 05:54:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64738 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab0HRJyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 05:54:23 -0400
Received: by pwi4 with SMTP id 4so233234pwi.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9besm/Ya1KTfgQhFHX4vMpUMmByLcS81w1QD5k0/yfk=;
        b=Ilj+AcgRX4gqKQui6r78paCcv8iCgL8sPO8IfZJQdsHPwMyjVUF0dwgpdr+29EKExP
         3cwVzz1WP3epY4FJid3eS9Yi90vJdWHw43hmdol7EH2VUfYZlses3UKESKHfKBOCCLGP
         aKR4JxL3eDUWX7iMKEskMxWnJBTaCzuSkG/xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xlSCKzoj45cHLaGO7X1fX0nOHh69gGGa4Q0vl6Sg1SLorh4Tifblq/Pt+aV8uLHR2s
         yvI8ci+GBDNsHonBQ9T2/HZ8QPwBUYCInX9gRmtSPJvdQNldHEbwAOovz+Slb4Uw7N9m
         Nueya020nP+FWSa9PNlTOYyi8ygay1bSrz61w=
Received: by 10.114.67.11 with SMTP id p11mr9356595waa.170.1282125263367;
        Wed, 18 Aug 2010 02:54:23 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id x9sm155986waj.3.2010.08.18.02.54.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 02:54:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.97.g3235b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153826>

When "git submodule sync" synchronizes the repository URLs
it only updates submodules' .git/config.  However, the old
URLs still exist in the super-project's .git/config.

Update the super-project's configuration so that commands
such as "git submodule update" use the URLs from .gitmodules.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-submodule.sh          |    3 ++-
 t/t7403-submodule-sync.sh |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 170186f..be7e478 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -840,9 +840,10 @@ cmd_sync()
 		then
 		(
 			clear_local_git_env
+			say "Synchronizing submodule url for '$name'"
+			git config submodule."$name".url "$url"
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
1.7.2.1.97.g3235b.dirty
