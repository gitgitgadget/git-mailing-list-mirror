From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 10/19] 'prune' command to clear out stale .gittrees info
Date: Sat, 9 Mar 2013 19:27:05 +0000
Message-ID: <CALeLG_=fr1WxO3ckpxsSh-LX3oSMJLQU-za2PEF6BR7sschPfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:27:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPQc-0002Uy-Ov
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237Ab3CIT1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:27:08 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:61639 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CIT1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:27:07 -0500
Received: by mail-ob0-f179.google.com with SMTP id un3so2206836obb.24
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=ikJimPHpRL9pLB3q5oBJbSY1BNl5zVJmkXf5zaIfEhU=;
        b=Ld+5Rz8U9OkYsIvJ27Wqqwy/h03XsdgwiXNdcv/9To94Jx8IBHlqiaBSWU1i2pDmMO
         nX+qcuLMJfqVQFSyDBbatPxtVBmip3aRYVIPRZlrx86fI6K+Z87IcI3/Y+Psfd7vK4k4
         LB2MEw3ktoY8Ie4/GcKrS9RLQPHrVN7VaV9SKNGiYTNJS48LhjdaBX5BlAw5evcNrOBj
         cQdTTf5SnHbzuanR/7WkYcOFdn39eDkwhxCXzivTSgT+FyWkY4U/BNmhGyJqGBx5buqq
         F4RnCwHcgwWQucbSImkqHMqOp74w624G9RoIRV0dcNkS0ikT6J6r6od6tAK8TXCGvi0I
         thsw==
X-Received: by 10.182.116.70 with SMTP id ju6mr5024280obb.48.1362857225869;
 Sat, 09 Mar 2013 11:27:05 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:27:05 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQnvO9YHxN1/70v+vyNUZN3xWfBfHGoICtGSN498Bp3GblEKimeOsBF08Jm4Falwh6Mq/JyC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217747>

>From 1aaa55ff64b3b4d9325568b3bb863748f20c80f3 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:33:33 +0000
Subject: [PATCH 10/19] 'prune' command to clear out stale .gittrees info

Conflicts:
	git-subtree.sh

Original-Author: Nate Jones <nate@endot.org>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
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

-if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" !=
"push-all" -a "$command" != "list" ]; then
+if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" !=
"push-all" -a "$command" != "list" -a "$command" != "prune" ]; then
 	die "You must provide the --prefix option."
 fi

@@ -839,6 +839,17 @@ cmd_list()
   subtree_list
 }

+cmd_prune()
+{
+    git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
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
     git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
