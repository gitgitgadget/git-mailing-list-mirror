From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 4/7] git-rebase--interactive.sh: look up subject in add_pick_line
Date: Wed, 18 Jul 2012 00:27:32 -0700
Message-ID: <1342596455-17046-5-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:28:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOg3-0008T4-BF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab2GRH2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:28:04 -0400
Received: from mail-ee0-f74.google.com ([74.125.83.74]:51852 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab2GRH1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:51 -0400
Received: by eekb47 with SMTP id b47so68336eek.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=HmxS4wbWBEQL/mcDPpV9mD3Mwy1LUr7fDmfqEjTzzBI=;
        b=MIAsaFBF9bwbS7F14g6UzoqXRE1EQkJ7wheMtFFk+w7EvARNDMsF4b77cmUOdvVfQT
         2GvenjaAttgGNd+uMVJaieqAPeZHNR5H3EkpZMdl2HelcjtwXnfEjmuf9Pl1sUZcvCya
         i63r9jYgJSIGajgFo/rFgGRW/GEjQXzi/0ij6SfYDlzwxo4le6O6EZ9FXij9yNvIfuvH
         yqW9UlJY7kImT4BugnFx4u0E7v69vNj4NufKbWVksEsq4LKU3i4iue1ZHNxileAoH0vi
         srDAxbXGRlxIvIM10ezekFx8rNV+WqXVwm7J1OmB04xvpnZVM6zR708oYcLLEgmKoJ/3
         WBQw==
Received: by 10.14.177.73 with SMTP id c49mr1707756eem.3.1342596469979;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by 10.14.177.73 with SMTP id c49mr1707752eem.3.1342596469931;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id 46si17050085eed.1.2012.07.18.00.27.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id B8C405C0050;
	Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 1267CC165F; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1342596455-17046-4-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQk/ZCs8jnA5EjCR8tHFQfweW7cIx5csFZlb52P3vZsNYmXWsiEo9fjAFqY4W7yYKAg5NCFfiDmsUVJ2BmCTWQhbzTM5M65qJp10MqgPdVoSemL9M6hQKdKrx5HTIRDJ42+XB9f/liM5B2EuvarIndcEW4QE4VY6UEGWHIiiXqxh7NkTEp28E81jnit5iu2X6TXwajYc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201662>

The todo file is generated using (more-or-less) 'git rev-list
$revisions --pretty=oneline --abbrev-commit --abbrev=7', i.e. by
letting 'git rev-list' output both the abbreviated sha1 and the
subject line. To allow us to more easily generate the list of commits
to rebase by using commands that don't support outputting the subject
line, move this logic into add_pick_line.
---
 git-rebase--interactive.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4bb8e3f..9715830 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -814,7 +814,8 @@ add_pick_line () {
 	else
 		comment_out=
 	fi
-	printf '%s\n' "${comment_out}pick $1 $2" >>"$todo"
+	line=$(git rev-list -1 --pretty=oneline --abbrev-commit --abbrev=7 $1)
+	printf '%s\n' "${comment_out}pick $line" >>"$todo"
 }
 
 if test t = "$preserve_merges"
@@ -835,13 +836,10 @@ then
 	# No cherry-pick because our first pass is to determine
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
-	git rev-list --pretty=oneline --abbrev-commit \
-		--abbrev=7 --reverse --left-right --topo-order \
-		$revisions |
+	git rev-list $revisions --reverse --left-right --topo-order |
 	sed -n "s/^>//p" |
-	while read -r shortsha1 rest
+	while read -r sha1
 	do
-		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
 		then
 			preserve=t
@@ -858,7 +856,7 @@ then
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			add_pick_line $shortsha1 "$rest"
+			add_pick_line $sha1
 		fi
 	done
 	# Watch for commits that been dropped by --cherry-pick
@@ -884,13 +882,12 @@ then
 		fi
 	done
 else
-	git rev-list --no-merges --cherry-pick --pretty=oneline --abbrev-commit \
-		--abbrev=7 --reverse --left-right --topo-order \
-		$revisions |
+	git rev-list $revisions --reverse --left-right --topo-order \
+		--no-merges --cherry-pick |
 	sed -n "s/^>//p" |
-	while read -r shortsha1 rest
+	while read -r sha1
 	do
-		add_pick_line $shortsha1 "$rest"
+		add_pick_line $sha1
 	done
 fi
 
-- 
1.7.11.1.104.ge7b44f1
