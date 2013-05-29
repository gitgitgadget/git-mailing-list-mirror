From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 2/8] rebase: cherry-pick: fix mode storage
Date: Tue, 28 May 2013 23:16:34 -0500
Message-ID: <1369801000-3705-3-git-send-email-felipe.contreras@gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 06:18:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXqL-0002DH-6E
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 06:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab3E2ES2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 00:18:28 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:44855 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3E2ES1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 00:18:27 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so3540333obb.0
        for <git@vger.kernel.org>; Tue, 28 May 2013 21:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OMGNfxYqwVdT6A8E7AOKFtuYLwumGiJM2FbMQFvLfbg=;
        b=V7+aFGCOMHV8XWNNXdZL9lLNmrDuNVL1tJmHJRvuz7lMsrBdOEJyaEf3whkIO5pEvO
         4GmLiXkSZ0No/P3smrClPC1sXep2lfiLs3Y7F4JnqWmAhNby1En5NL+89D2FRdqEsk/2
         2gYZyEoxk1+9HeHF/xaYrEkyg/hA2vt+HJGqSiXLZ+ELGgPYJ7ng7n1Ej+DigrLcfh4Y
         TX+OFQR7KFsTI9NuMQKBomPCuz7j41AxPrC8LEYstiOrRlroyjqA1c5cMCTnj2vgGYyP
         mEtlbFExmxcQzkF7rsZMxMZDhbJRiIHilY62105e8TzReZImmPmWQR4OZP3TeZUVxens
         mUWg==
X-Received: by 10.60.16.69 with SMTP id e5mr546534oed.46.1369801107101;
        Tue, 28 May 2013 21:18:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm27906630oeo.8.2013.05.28.21.18.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 21:18:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225725>

We don't use the 'rebase-apply'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 4 ++++
 git-rebase.sh             | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index cbf80f9..51354af 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -18,6 +18,9 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
+mkdir "$state_dir" || die "Could not create temporary $state_dir"
+: > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
+
 # we have to do this the hard way.  git format-patch completely squashes
 # empty commits and even if it didn't the format doesn't really lend
 # itself well to recording empty patches.  fortunately, cherry-pick
@@ -32,3 +35,4 @@ then
 fi
 
 move_to_original_branch
+rm -rf "$state_dir"
diff --git a/git-rebase.sh b/git-rebase.sh
index f929ca3..76900a0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -174,6 +174,9 @@ then
 	then
 		type=interactive
 		interactive_rebase=explicit
+	elif test -f "$merge_dir"/cherrypick
+	then
+		type=cherrypick
 	else
 		type=merge
 	fi
@@ -382,7 +385,7 @@ then
 elif test -n "$keep_empty"
 then
 	type=cherrypick
-	state_dir="$apply_dir"
+	state_dir="$merge_dir"
 else
 	type=am
 	state_dir="$apply_dir"
-- 
1.8.3.rc3.312.g47657de
