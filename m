From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 33/45] rebase: cherry-pick: fix for shell prompt
Date: Sun,  9 Jun 2013 11:40:45 -0500
Message-ID: <1370796057-25312-34-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlijH-0007I4-EH
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab3FIQo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:26 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:62992 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab3FIQoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:24 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so418128oag.40
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UNCNBZdL4IqrnGzPjNVpJV5otdB6t+qIDSSrcikMYF8=;
        b=lh9Xwzlc7b6QJzNTetIEv4UZLuMu9Z9ka6SMVrL3bweiNdZYWpPJr2PdtbaYyYcazt
         xlJ6PSy7P+L28VWoHxRIJ9eTob2OU7V0CuhwebCpgOlzno2PwJcHPq1tDYMj9OHuddxZ
         FciTUQ32C4f+DAZ0+BY7DfMtGGmA4p2isMW3C98YC/ErK9gocDwoNr37Q+LINwvv7/8l
         jF1RnD/u0JVR1kHAnDFfFS+gZGlc0Q2WW10c7gcG4mhds7iB+noGeqH7EsyQrsteudJB
         3focKVGPudhL/hV20lg2Lzt0aN52Bj+yUk0fHyqaUtx9r15xPdDdaK1Tern0cs95umbv
         QrBw==
X-Received: by 10.182.233.137 with SMTP id tw9mr5406586obc.2.1370796264477;
        Sun, 09 Jun 2013 09:44:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm14859440obb.13.2013.06.09.09.44.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227002>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh |  2 ++
 git-rebase--cherrypick.sh        | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 3a14665..3d10f21 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -354,6 +354,8 @@ __git_ps1 ()
 				r="|REBASE-i"
 			elif [ -f "$g/rebase-merge/cherrypick" ]; then
 				r="|REBASE"
+				step=$(cat "$g/sequencer/rewritten" | wc -l)
+				let step+=1
 			else
 				r="|REBASE-m"
 			fi
diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index d36b0dc..6f63618 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -37,19 +37,26 @@ else
 	revisions="$upstream...$orig_head"
 fi
 
+rev_args="--no-merges --right-only --topo-order --do-walk "$revisions""
+
 if test -n "$keep_empty"
 then
 	extra="--allow-empty"
 else
-	extra="--skip-empty --cherry-pick"
+	extra="--skip-empty"
+	rev_args="--cherry-pick $rev_args"
 fi
 test -n "$GIT_QUIET" && extra="$extra -q"
 test -z "$force_rebase" && extra="$extra --ff"
-git cherry-pick --no-merges --right-only --topo-order --do-walk --action-name rebase $extra "$revisions"
+
+git rev-list $rev_args > "$state_dir"/list
+git cherry-pick --action-name rebase $extra $rev_args
 ret=$?
 
 if test 0 != $ret
 then
+	# for shell prompt
+	cat "$state_dir"/list | wc -l > "$state_dir"/end
 	write_basic_state
 	return $ret
 fi
-- 
1.8.3.698.g079b096
