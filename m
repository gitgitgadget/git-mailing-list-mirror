From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 33/36] rebase: cherry-pick: fix for shell prompt
Date: Sun,  9 Jun 2013 14:24:47 -0500
Message-ID: <1370805890-3453-34-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllI3-00048m-RD
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab3FIT20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:26 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:59811 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab3FIT2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:19 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so9145596obc.34
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UNCNBZdL4IqrnGzPjNVpJV5otdB6t+qIDSSrcikMYF8=;
        b=fP9VZR+wm9n8fzrWCjoqZxeCfbv4xsYX8yatUd7yu2u3bgqQGcbkz1doMiejleKO48
         EAIO6cIhGv5MQb2NR/bt7+7zk65xeF79fYWNK/e7RoIUj7w89VtdnrqZQ5GN79sd0ZvK
         7MTgVeWsCBWyqgGlHQq4rYS1e2wGhPpSYJ9iw8st7wE+qp8SeAWYRVT31P2Xz3FV3xCI
         2mNuWzsEFgofkyPTbe/L7kyVnCiKF0msfhY69kQ6N74uvnluNtE3RY9KJRLuF7+9XHbv
         S/SDL0ugzPzBe0BWId2Wt4rkoQ91A9SdoOqnzvrNutHZePZKtNRx9ZSLVA4dXJeKm3p2
         Rq5Q==
X-Received: by 10.182.200.129 with SMTP id js1mr5653658obc.5.1370806098577;
        Sun, 09 Jun 2013 12:28:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm16240429oeo.8.2013.06.09.12.28.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227144>

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
