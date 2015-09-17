From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/10] git submodule update: cmd_update_recursive
Date: Wed, 16 Sep 2015 18:39:06 -0700
Message-ID: <1442453948-9885-9-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAo-0006Ku-C5
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbbIQBjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36785 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbbIQBjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:23 -0400
Received: by padhk3 with SMTP id hk3so4582420pad.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0qtwT9c9HELpQseOlcAlPf8s4/0uWn2O0eL7f2ml9nQ=;
        b=Y0SlEiHOrHwxKIfIoLe9xd/01es2GR3P7HI3LrAMip/70/vRAIQb9/9Jo7onMHhuWF
         wpIbmMdZ4ozLfrGpEM4AP47vg0cYGIcmYTzyu/hK+/m4nM+7eOXdmNWjwOfnmidLBm0B
         v7c4+0FS1LyQWGAXaGWE/A7rYulVCLQjUGgHd5ca1DCtKe5iqehpoJMUP3jYhqJ9RtYi
         M9j6pvwBVMblpPzcmXyGVWi5blyd+nLnqLyYeBSSrD6/HjuhyDXo4qZ97DPXABHv52Ez
         LkgkIVCEgFU5Q4quLfLxDt/onE6LOBMKJIEb12KmDDfj5UUwstNcc5BLe/jv9pTlxpos
         XTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0qtwT9c9HELpQseOlcAlPf8s4/0uWn2O0eL7f2ml9nQ=;
        b=j2Ik1EXaEaLJ/VF742LztEngj1tngQbu9yDnMN1uAP1+SxY0wJ+ctOiMR3wxTlX1iV
         0vVN/dNGoNMP/rnYH4eJcrjLgOQCJL96iQXfF1+Ef8VClgVhT/BcTrA2HX1VnlQTn2Hd
         Fw8ik50eqq7JiCOjWG5AewbLwPoABBkC4QoeytJmmCUwQ9LX+yix7w2LZc6/+5iswdh+
         gif2zaO7ekuk+qkrGndAlUBIUl3ngDnIaBpwTe9UFUTQfMgEMWgjmnFng6x2ypPXe1is
         qULdbvtibszOivfDQwO8191xGCvtXJEvbi7N3GIRZJe8uKBnML+mTU7+3Kp1EBijJqIJ
         jDlQ==
X-Gm-Message-State: ALoCoQmyR+SHjZxKdlXFLoOa8suU0Nvk/XMBdzG2zMGIt+K3uRJv6690a+LV/+HUSVxaBC+h/D9D
X-Received: by 10.68.69.79 with SMTP id c15mr13714963pbu.90.1442453962646;
        Wed, 16 Sep 2015 18:39:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id lc9sm562479pbc.52.2015.09.16.18.39.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:22 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278099>

split the recursion part out to its own function

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3ccb0b6..52c2967 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -582,6 +582,31 @@ cmd_deinit()
 	done
 }
 
+
+cmd_update_recursive()
+{
+	if test -n "$recursive"
+	then
+		(
+			prefix="$prefix$sm_path/"
+			clear_local_git_env
+			cd "$sm_path" &&
+			eval cmd_update
+		)
+		res=$?
+		if test $res -gt 0
+		then
+			die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
+			if test $res -eq 1
+			then
+				err="${err};$die_msg"
+			else
+				die_with_status $res "$die_msg"
+			fi
+		fi
+	fi
+}
+
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -790,27 +815,7 @@ Maybe you want to use 'update --init'?")"
 			fi
 		fi
 
-		if test -n "$recursive"
-		then
-			(
-				prefix="$prefix$sm_path/"
-				clear_local_git_env
-				cd "$sm_path" &&
-				eval cmd_update
-			)
-			res=$?
-			if test $res -gt 0
-			then
-				die_msg="$(eval_gettext "Failed to recurse into submodule path '\$displaypath'")"
-				if test $res -eq 1
-				then
-					err="${err};$die_msg"
-					continue
-				else
-					die_with_status $res "$die_msg"
-				fi
-			fi
-		fi
+		cmd_update_recursive
 	done
 
 	if test -n "$err"
-- 
2.6.0.rc0.131.gf624c3d
