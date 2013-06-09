From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 27/36] rebase: cherry-pick: fix command invocations
Date: Sun,  9 Jun 2013 14:24:41 -0500
Message-ID: <1370805890-3453-28-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHl-0003yF-4W
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab3FIT2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:28:06 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55828 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab3FIT2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:28:02 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so9156733obc.31
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Itrz0y/zHLjc2Z+i/EQhhvmU+udg2cpvoeOhzBwkbOk=;
        b=zTk406FkprinRIrLxDFuNJ+q5CI7QM9nIoUNEGqwvz+P8VDqRx98JBIno4rQkTf6Wm
         MqlPez2le7E1k1/l/0cfyFPRjYX6YD/Z4YEKo/vbR/A/k1uvg7uz+9H3VZt3Kczx5txm
         3YJILNZ+fmxbuDt5qAVliCix6JFiy23WoDGlaaHMz3xBNxxMkrnMVgGfzkZaUl6+KgXb
         n9P9PHCkggOsBGO9YBeIu6VTCP5w4IuqC1saLjLGV6FhqxyPFL7LfeZacQVnLE86S2IL
         R5ahR+cKQLRIFX4QFYS3e2+steH1Y1PZViV9Oi2hPAnlHsg/uhqz2FBDZ44of05DW9Uo
         qhgQ==
X-Received: by 10.60.115.73 with SMTP id jm9mr5465104oeb.126.1370806081867;
        Sun, 09 Jun 2013 12:28:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wx1sm15984683obb.8.2013.06.09.12.27.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:28:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227137>

So that all the tests pass.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index d8d32fe..e9ecccc 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -21,7 +21,22 @@ test -n "$rebase_root" && root_flag=--root
 mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
 : > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
 
-git cherry-pick --allow-empty "$revisions"
+if test -n "$rebase_root"
+then
+	revisions="$onto...$orig_head"
+else
+	revisions="$upstream...$orig_head"
+fi
+
+if test -n "$keep_empty"
+then
+	extra="--allow-empty"
+else
+	extra="--skip-empty --cherry-pick"
+fi
+test -n "$GIT_QUIET" && extra="$extra -q"
+test -z "$force_rebase" && extra="$extra --ff"
+git cherry-pick --no-merges --right-only --topo-order --do-walk $extra "$revisions"
 ret=$?
 
 if test 0 != $ret
-- 
1.8.3.698.g079b096
