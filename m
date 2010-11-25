From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 06/20] rebase: collect check for existing rebase
Date: Thu, 25 Nov 2010 20:57:49 +0100
Message-ID: <1290715083-16919-7-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnb1-00026e-WB
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab0KZB7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:59:02 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab0KZB6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:12 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347966vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=N2PPX9dG4difoAD2JUMJl8X3ksaVfOpXfQWZGtXa4+I=;
        b=QpPFV8TUkKes+cQZFFlThgYInk3LR7CWFLks3E7rwnlRhjoZl9TbFsFNRGvuGvf/z0
         xT2YbnnQOhdWVsBavyjaAIfQuSXq81F9UJtWmxYgj3QCUeFf5+KC4JTy6Y1dgOCWcUtw
         2ivZiOZ3dmZJoG6gVCckBodKB35hoLbYJRb2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D8Fr4cTLdtQRK4OvL4ZjlQCtgzqXnyXshLUfE2QDTpCbfkcZeKJFIRS9Js5zB0QphL
         IWD056kp68ao4y1A4nwoXIALGNaxdrmwjzzkn+AnUD3SsKPsUoKS6H7yoc5+gxqB8RJf
         l3FAFQEV2bCt+nNK0BDVHaIbxf609XNwYhctQ=
Received: by 10.220.202.6 with SMTP id fc6mr116942vcb.10.1290736692349;
        Thu, 25 Nov 2010 17:58:12 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:12 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162176>

Put the code that checks for rebase in progress in one place.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   56 +++++++++++++++++++++++++-------------------------------
 1 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 52e1c6e..2358e2f 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -318,6 +318,31 @@ test $# -gt 2 && usage
 if test -n "$action"
 then
 	test -d "$merge_dir" -o -d "$apply_dir" || die "No rebase in progress?"
+else
+	# Make sure we do not have $apply_dir or $merge_dir
+	if test -z "$do_merge"
+	then
+		if mkdir "$apply_dir" 2>/dev/null
+		then
+			rmdir "$apply_dir"
+		else
+			echo >&2 '
+It seems that I cannot create a rebase-apply directory, and
+I wonder if you are in the middle of patch application or another
+rebase.  If that is not the case, please
+	rm -fr '"$apply_dir"'
+and run me again.  I am stopping in case you still have something
+valuable there.'
+		exit 1
+		fi
+	else
+		if test -d "$merge_dir"
+		then
+			die "previous rebase directory $merge_dir still exists." \
+				'Try git rebase (--continue | --abort | --skip)'
+		fi
+	fi
+	test $# -eq 0 && test -z "$rebase_root" && usage
 fi
 
 case "$action" in
@@ -378,37 +403,6 @@ abort)
 	;;
 esac
 
-if test $# -eq 0 && test -z "$rebase_root"
-then
-	test -d "$merge_dir" -o -d "$apply_dir" || usage
-	test -d "$merge_dir" -o -f "$apply_dir"/rebasing &&
-		die 'A rebase is in progress, try --continue, --skip or --abort.'
-fi
-
-# Make sure we do not have $apply_dir or $merge_dir
-if test -z "$do_merge"
-then
-	if mkdir "$apply_dir" 2>/dev/null
-	then
-		rmdir "$apply_dir"
-	else
-		echo >&2 '
-It seems that I cannot create a rebase-apply directory, and
-I wonder if you are in the middle of patch application or another
-rebase.  If that is not the case, please
-	rm -fr '"$apply_dir"'
-and run me again.  I am stopping in case you still have something
-valuable there.'
-		exit 1
-	fi
-else
-	if test -d "$merge_dir"
-	then
-		die "previous rebase directory $merge_dir still exists." \
-			'Try git rebase (--continue | --abort | --skip)'
-	fi
-fi
-
 require_clean_work_tree "rebase" "Please commit or stash them."
 
 if test -z "$rebase_root"
-- 
1.7.3.2.864.gbbb96
