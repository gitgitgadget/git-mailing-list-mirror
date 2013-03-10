From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 12/23] contrib/subtree: Add command prune
Date: Sun, 10 Mar 2013 23:41:20 +0000
Message-ID: <1362958891-26941-13-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>, Nate Jones <nate@endot.org>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Matt Hoffman" <matt.hoffman@quantumretail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>, "bibendi" <bibendi@bk.ru>,
	"Win Treese" <treese@acm.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpvW-0004ag-TR
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab3CJXos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:44:48 -0400
Received: from mail-we0-f180.google.com ([74.125.82.180]:55491 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab3CJXor (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:44:47 -0400
Received: by mail-we0-f180.google.com with SMTP id k14so2859072wer.39
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=kfjJQuhHd6JwUqFk+NXNUGqG6lLQX6u/Fo5rn6Yz2uA=;
        b=ENSwLjfcyDNgooBMQ5Ts9pXtjw4qliQVXbzOH97YH4t/2rTpglbEHF64EFLstZlIqC
         EzHhdtFl5WCXQc0v+Pz2LqA3cpZaOxho80e1qH5uZbZkUeJ2R3kxBnnVHq37z30tYpt7
         Tlhh2dN+K1fbEdOF67oSoI06X6pXDewMyirzNSkakIlp/H8Fe6lKD7y7YEjl8YMRtnYI
         uZHKvh2uQKkuYbtKfetu7LxcHBaUfAlh0XLCfS/nhpf1K2msb7dMsALSGYxryVdI8DhD
         xTaExqKQ68n+xRk1qinBSQNsn5M9aYSp0babAzDYActGAcxrl+P0+JKQIsEOleFbLEdB
         kGJA==
X-Received: by 10.194.103.72 with SMTP id fu8mr15613539wjb.42.1362959086795;
        Sun, 10 Mar 2013 16:44:46 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.44.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:44:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQmm+iUcRTu9bDLP3m35XhWgYg5pA+9/P1UK2IQp8XKB0t90AxAlg1FrdgLvYsFa3jMb+1Nb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217832>

From: Nate Jones <nate@endot.org>

Removes entries in .gittrees where the subtree files are
no longer present on disk.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	git-subtree.sh
---
 contrib/subtree/git-subtree.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7d08064..0c41383 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -105,12 +105,12 @@ done
 command="$1"
 shift
 case "$command" in
-	add|merge|pull|from-submodule|pull-all|push-all) default= ;;
+    add|merge|pull|from-submodule|pull-all|push-all|prune) default= ;;
 	*) die "Unknown command '$command'" ;;
     split|push|diff|list) default="--default HEAD" ;;
 esac
 
-if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" != "push-all" -a "$command" != "list" ]; then
+if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" != "push-all" -a "$command" != "list" -a "$command" != "prune" ]; then
 	die "You must provide the --prefix option."
 fi
 
@@ -839,6 +839,17 @@ cmd_list()
   subtree_list 
 }
 
+cmd_prune()
+{
+    git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
+    while read path; do
+        if [ ! -e "$path" ]; then
+            echo "pruning $path"
+            git config -f .gittrees --remove-section subtree.$path
+        fi
+    done
+}
+
 cmd_pull-all()
 {
     git config -f .gittrees -l | grep subtree | grep path | grep -o '=.*' | grep -o '[^=].*' |
-- 
1.8.2.rc1
