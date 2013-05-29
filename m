From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: avoid ls-remote in certain scenarios
Date: Tue, 28 May 2013 22:20:48 -0500
Message-ID: <1369797648-2921-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:22:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWyN-0007lH-Qr
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759397Ab3E2DWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:22:32 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:64474 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759346Ab3E2DWb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:22:31 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so3021976obc.41
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EVyAADCVPbodg97DIBiDrj7jZXBF2bi4Shzv9j1c8jA=;
        b=rXPJMrRzKC0CbopZQAm7Og5Fl7H84ZJGrYmfMhd1Z5BTGXo/APuoMns5KokTCixYlw
         58SckMBslPeF2cZT5O91qm2obS3pj+obCKKsg9xwp5dJYRRWu1oe0L2rEp2EnhrVUhQx
         ZWlptfXWMwmBYgjLbWQtFYhNz930EYvWKdbqS6pcgV1UXNbC9Q/+Tji7fWIzXpKyKzlY
         gWzvEA/1M7LCCgUFCAjVbUAasYWkf8e9pUd7+eM7uVCOrmA+1VskOQssc08q5o9YKfcC
         LGg6bj2BfeRo56tCDcknugE4zoIHDm/ArWhRI/2EcaEF6Qf15NGAZf/DliPTgdq5uMSA
         5JWQ==
X-Received: by 10.182.108.230 with SMTP id hn6mr471984obb.25.1369797750602;
        Tue, 28 May 2013 20:22:30 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p3sm30656715oel.0.2013.05.28.20.22.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:22:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225710>

It's _very_ slow in many cases, and there's really no point in fetching
*everything* from the remote just for completion. In many cases it might
be faster for the user to type the whole thing.

If the user manually specifies 'refs/*', then the full ls-remote
completion is triggered.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1c35eef..2ce4f7d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -427,14 +427,8 @@ __git_refs ()
 		done
 		;;
 	*)
-		git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 'refs/remotes/*' 2>/dev/null | \
-		while read -r hash i; do
-			case "$i" in
-			*^{}) ;;
-			refs/*) echo "${i#refs/*/}" ;;
-			*) echo "$i" ;;
-			esac
-		done
+		echo "HEAD"
+		git for-each-ref --format="%(refname:short)" -- "refs/remotes/$dir/" | sed -e "s#^$dir/##"
 		;;
 	esac
 }
-- 
1.8.3.rc3.312.g47657de
