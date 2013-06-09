From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 24/45] rebase: cherry-pick: fix mode storage
Date: Sun,  9 Jun 2013 11:40:36 -0500
Message-ID: <1370796057-25312-25-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uliiy-00074a-Gz
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab3FIQoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:03 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:44007 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3FIQn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:59 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so5043421oag.1
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NVm4wmwjeWHX5NGQbqDEuMXeHo6fbL8QWIhoCmnFdw8=;
        b=Gi8qc3KDObWqdulDOEbjZtx6E4KYRJxoewkYHbojJiHLN2mMnOync/SptJbgiBAdlG
         TGj1sDhn5eJda2nvcBRkAAOwamGSXwsBXKxGA9sNRPn+gV07olxSl9rzKKRId1IVNe17
         U16+5LQmTTjETtban2CwM4LV9Sa3GipoviJC5yf5EN4eJRDCmmPYHGASDRjfiPIPSVRO
         HVUEyQbgRdedpCZkzSgjUgDGmldYX1hKSkATdbB0SpyjbIjLRayZdvnY+BWApx9mtvmi
         /Z6IrYtTWrFo/uceTFmn7aJVYD1OsGo6DE8x8PAMyrSe64PGHD+QVIcmmMGKadoDcIRh
         Rtmw==
X-Received: by 10.60.84.67 with SMTP id w3mr5214985oey.59.1370796239258;
        Sun, 09 Jun 2013 09:43:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d5sm15213886oex.0.2013.06.09.09.43.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226993>

We don't use the 'rebase-apply'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 5 ++++-
 git-rebase.sh             | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 2c16995..e142cfb 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -18,12 +18,15 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
+mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
+: > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
+
 git cherry-pick --allow-empty "$revisions"
 ret=$?
 
 if test 0 != $ret
 then
-	test -d "$state_dir" && write_basic_state
+	write_basic_state
 	return $ret
 fi
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 70762f1..4465daf 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -205,6 +205,9 @@ then
 	then
 		type=interactive
 		interactive_rebase=explicit
+	elif test -f "$merge_dir"/cherrypick
+	then
+		type=cherrypick
 	else
 		type=merge
 	fi
@@ -416,7 +419,7 @@ then
 elif test -n "$keep_empty"
 then
 	type=cherrypick
-	state_dir="$apply_dir"
+	state_dir="$merge_dir"
 else
 	type=am
 	state_dir="$apply_dir"
-- 
1.8.3.698.g079b096
