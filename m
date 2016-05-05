From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] git-gui: Do not reset author details on amend
Date: Thu,  5 May 2016 17:23:02 +0300
Message-ID: <1462458182-4488-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 16:23:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayKBn-0003q4-2m
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 16:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbcEEOXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 10:23:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36250 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbcEEOXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 10:23:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id w143so3762730wmw.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IonPhCaUoFoP6uWoAIORSNIJEOfUfn4oFFSBxiqmpVc=;
        b=ppzk+P0O3sZTyxsYcFplwtHEsLA8uQe9BH54fF7qy22f+GlqYYATfcWeOhf2sApTAR
         BlRhv7GZXoJU0HzA0QfktDhd1bU4M92f8pO1eY4cklfBqU2om5F3/L5hiA6ylpi1/tM5
         UxcfMRQFzzs13xijuf2wBTHLWZug+02NrCt43A7RArmwcub2IRCYAKBNQBgeCb2/MG8z
         tq0yrvZYiNXlODaroG/CblYAzKux2eBe0emS8gY26efxiU1VaD0wUImyCY3TV4ZvwoNh
         rZ+k912DHRjTXlHjhFU3Zu9qJ5MVJfwjWXTfl+vcnxp1kyl2YDnYTfb8KPJEntSY8Uhr
         O3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IonPhCaUoFoP6uWoAIORSNIJEOfUfn4oFFSBxiqmpVc=;
        b=i4GaBEknOec9HJ/n2NEPLnU4lN1Z2jhyvfyv/t+20SRLv82JvohcdZ8wnOOee1U7VC
         yFJJVla8ND4C5T3ZVJR46Fp3AXAIh2J28T7QpqvrHZTnyt/wMQu8AX1Vct+JFywRUlZF
         GfwQ+9l6oQuSfhWhoMRNUl18gkqm90w8u+p2/XxHH3XxmH3CulmJ8h29+haQzB8KlFpB
         M7qI1VmxuvvNDi7QU9HAR3EoY7bIPoN7FQGGO2lGhFFgY5Z8Qa7N+vxFcYn79m1nB+Qg
         xGBUXyDRFUWxDf2wSf7nOBI+vCbU9V6jbBN+QZKMT0OdQX0MtVPVoxfNwMdXwj2xKz4T
         YiYg==
X-Gm-Message-State: AOPr4FV3Mr4FtGrLXHsYGaJ2JtDIsVR8ILqayBEpytrJGsmADNSpF3FFJ2MNtat9dSCpYA==
X-Received: by 10.28.144.11 with SMTP id s11mr3621969wmd.72.1462458213355;
        Thu, 05 May 2016 07:23:33 -0700 (PDT)
Received: from localhost.localdomain ([95.86.77.111])
        by smtp.gmail.com with ESMTPSA id u4sm10025456wjz.4.2016.05.05.07.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 May 2016 07:23:31 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293648>

git commit --amend preserves the author details unless --reset-author is
given.

git-gui discards the author details on amend.

Fix by reading the author details along with the commit message, and
setting the appropriate environment variables required for preserving
them.

Reported long ago in the mailing list[1].

[1] http://article.gmane.org/gmane.comp.version-control.git/243921

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 git-gui/lib/commit.tcl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 864b687..60edf99 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -1,8 +1,13 @@
 # git-gui misc. commit reading/writing support
 # Copyright (C) 2006, 2007 Shawn Pearce
 
+set author_name ""
+set author_email ""
+set author_date ""
+
 proc load_last_commit {} {
 	global HEAD PARENT MERGE_HEAD commit_type ui_comm
+	global author_name author_email author_date
 	global repo_config
 
 	if {[llength $PARENT] == 0} {
@@ -34,6 +39,10 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 					lappend parents [string range $line 7 end]
 				} elseif {[string match {encoding *} $line]} {
 					set enc [string tolower [string range $line 9 end]]
+				} elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} {
+					set author_name $name
+					set author_email $email
+					set author_date $time
 				}
 			}
 			set msg [read $fd]
@@ -107,8 +116,12 @@ proc do_signoff {} {
 
 proc create_new_commit {} {
 	global commit_type ui_comm
+	global author_name author_email author_date
 
 	set commit_type normal
+	set author_name ""
+	set author_email ""
+	set author_date ""
 	$ui_comm delete 0.0 end
 	$ui_comm edit reset
 	$ui_comm edit modified false
@@ -327,6 +340,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
 	global ui_comm selected_commit_type
 	global file_states selected_paths rescan_active
 	global repo_config
+	global env author_name author_email author_date
 
 	gets $fd_wt tree_id
 	if {[catch {close $fd_wt} err]} {
@@ -366,6 +380,11 @@ A rescan will be automatically started now.
 		}
 	}
 
+	if {$author_name ne ""} {
+		set env(GIT_AUTHOR_NAME) $author_name
+		set env(GIT_AUTHOR_EMAIL) $author_email
+		set env(GIT_AUTHOR_DATE) $author_date
+	}
 	# -- Create the commit.
 	#
 	set cmd [list commit-tree $tree_id]
-- 
2.8.1
