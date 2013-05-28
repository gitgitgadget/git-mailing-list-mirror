From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] rebase: fix 'cherry' mode storage
Date: Tue, 28 May 2013 08:29:14 -0500
Message-ID: <1369747757-10192-3-git-send-email-felipe.contreras@gmail.com>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:31:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJzj-0007ZK-PM
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934169Ab3E1NbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:31:10 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:60005 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933952Ab3E1NbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:31:06 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so2520707obb.28
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZImCo8VeCLEMcI83Pw9gZN1H5PsSwVapeldbb0nPJRk=;
        b=TI3zPz0S6hWGVG8tlqHzUUN9N43eCvrTCnCuQSU0bN5VnaapKsBR3aNQpwF6CIcabw
         ShXeF2xSP0wEOgLDtOIwIh27gYyniiYSUpunBOO9mCaysgWxAiqXeQ1KtdxmgWn+edF1
         00NznwRWTCihCGlKEM737Ow6jEPSdh7j5fLzE7balokphVkhWgq4RKH6BW5MwgBzshKj
         9rN/e7Ym6WQHUgkVE0aIBj8M7RdEhqUBtbWisBGaOlhxe3PYvha/R5wK1IGzxT4ApgAx
         WgcGCgsSxzlmXxNXiQuzLS85Eyw+ax8LFy/35AEo/nOexBRMPXtBJ8qk+lx0WAq0/Qnn
         9Fzw==
X-Received: by 10.60.93.105 with SMTP id ct9mr7759814oeb.115.1369747865844;
        Tue, 28 May 2013 06:31:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm34588655obx.9.2013.05.28.06.31.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:31:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225649>

We don't use the 'rebase-apply'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherry.sh | 4 ++++
 git-rebase.sh         | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
index cbf80f9..ab1f8b7 100644
--- a/git-rebase--cherry.sh
+++ b/git-rebase--cherry.sh
@@ -18,6 +18,9 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
+mkdir "$state_dir" || die "Could not create temporary $state_dir"
+: > "$state_dir"/cherry || die "Could not mark as cherry"
+
 # we have to do this the hard way.  git format-patch completely squashes
 # empty commits and even if it didn't the format doesn't really lend
 # itself well to recording empty patches.  fortunately, cherry-pick
@@ -32,3 +35,4 @@ then
 fi
 
 move_to_original_branch
+rm -rf "$state_dir"
diff --git a/git-rebase.sh b/git-rebase.sh
index 2754985..b7759d5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -174,6 +174,9 @@ then
 	then
 		type=interactive
 		interactive_rebase=explicit
+	elif test -f "$merge_dir"/cherry
+	then
+		type=cherry
 	else
 		type=merge
 	fi
@@ -382,7 +385,7 @@ then
 elif test -n "$keep_empty"
 then
 	type=cherry
-	state_dir="$apply_dir"
+	state_dir="$merge_dir"
 else
 	type=am
 	state_dir="$apply_dir"
-- 
1.8.3.rc3.312.g47657de
