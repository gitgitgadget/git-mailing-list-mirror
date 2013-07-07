From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] prompt: do not double-discriminate detached HEAD
Date: Sun,  7 Jul 2013 18:22:45 +0530
Message-ID: <1373201565-14030-1-git-send-email-artagnon@gmail.com>
Cc: "Eduardo R. D'Avila" <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 14:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvoWC-0006gJ-9m
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 14:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759Ab3GGM4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 08:56:39 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:55953 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab3GGM4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 08:56:39 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so3226917pde.4
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=OUTjn1xX4VvRQOTtijFddWD4gDHxd08OdaAwOdjyLD8=;
        b=rzUgqa3tdjTsbwhZwzMPw+GJE3qz5igplztfjJccUM/CBJkU8x5B4DILlQHuuzCddZ
         TO9f0gYWpOeVLLvEqGDdGqrYnGPLaCoxEWOzHCFaCxGb2CRTdSA1YwpMmiOvviqiryXo
         etw+9oI2DVrR4rTA5dGVeNwdYNxhUtuRrr47Br/im3YRftHKsUwXmbgZp6o5Pa0oEV5b
         NcLxsuQhE50MKuRk9s/T/fQ7/weYUvKj9H/DhGGZv6jrpPWb7onYgHtPHg8NXRbTTfi8
         UzJZ1WkDcTiZZIcKkDTFtFqKDcf2AD2CgAO5jqJjYJfd9Qd4dhXWxftBEfkAwRi+Pt7N
         Pz0w==
X-Received: by 10.66.249.202 with SMTP id yw10mr18544865pac.145.1373201798642;
        Sun, 07 Jul 2013 05:56:38 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id ix3sm17024215pbc.37.2013.07.07.05.56.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 05:56:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.737.gcbc076a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229773>

When GIT_PS1_SHOWCOLORHINTS is turned on, there is no need to put a
detached HEAD within parenthesis: the color can be used to discriminate
the detached HEAD.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 For cuteness :)

 contrib/completion/git-prompt.sh | 5 ++++-
 t/t9903-bash-prompt.sh           | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index a81ef5a..37e66a2 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -372,7 +372,10 @@ __git_ps1 ()
 				esac 2>/dev/null)" ||
 
 				b="$short_sha..."
-				b="($b)"
+				# if there is no color, use
+				# parenthesis to indicate that the
+				# HEAD is detached
+				test -n "${GIT_PS1_SHOWCOLORHINTS-}" || b="($b)"
 			fi
 		fi
 	fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 3c3e4e8..c44b1a6 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -450,7 +450,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 '
 
 test_expect_success 'prompt - bash color pc mode - detached head' '
-	printf "BEFORE: (${c_red}(%s...)${c_clear}):AFTER" $(git log -1 --format="%h" b1^) >expected &&
+	printf "BEFORE: (${c_red}%s...${c_clear}):AFTER" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	(
-- 
1.8.3.2.737.gcbc076a.dirty
