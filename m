From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] rebase: prepare to do generic housekeeping
Date: Sun, 12 May 2013 17:26:37 +0530
Message-ID: <1368359801-28121-4-git-send-email-artagnon@gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 12 13:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUt4-00023w-Vl
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab3ELL4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:56:16 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:46969 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab3ELL4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:56:14 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so3777540pbc.31
        for <git@vger.kernel.org>; Sun, 12 May 2013 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=MkAFtZpuAemFkBlqlnbij3W2Z0xm+wMFGH36PIAnmfU=;
        b=o/uhEfc5rX9FPcCuSEwNJJRSIrUgzmzfQ4vNfTUl8yW6AnBjncvJi/we0XOEfDNPSn
         b3eTw0aXOvWvx8vZOzedYuh4ythSAD6a73KSZ05TjMQBNUeDGLgsgOzBH+wV+nKk3gm2
         xXZ45z8VTvoiSNKNsO4iIkPWEk1+1I/VGnyXoO+w+XAEGCWrd/nZGZ0V/KbVGrxiQfve
         AIKS9gJzSQiGCIbgKumqtH9lhlZWZJkhrhM5KIWE4L2xNAqjWJGspynJBmXjLJ3YePuB
         h1Gd7uwNYIneRheWZQ6rw/Az3pOGVvfJ84v1aQlbc4krBCGCf23ndhHkwYfk/zyEeas2
         R8dw==
X-Received: by 10.68.216.165 with SMTP id or5mr10652133pbc.152.1368359774265;
        Sun, 12 May 2013 04:56:14 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.41])
        by mx.google.com with ESMTPSA id iy2sm9911078pbb.31.2013.05.12.04.56.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 04:56:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.51.gd7a04de
In-Reply-To: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224038>

On successful completion of a rebase in git-rebase--$backend.sh, the
$backend script cleans up on its own and exits.  The cleanup routine
is however, independent of the $backend, and each $backend script
unnecessarily duplicates this work:

    rm -rf "$state_dir"
    git gc --auto

Prepare git-rebase.sh for later patches that return control from each
$backend script back to us, for performing this generic cleanup
routine.  The code that this patch adds is currently unreachable, and
will only start to be used when git-rebase--$backend.sh scripts are
taught to return control in later patches.

Another advantage is that git-rebase.sh can implement a generic
finish_rebase() to possibly do additional tasks in addition to the
cleanup.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2c692c3..f8b533d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -150,6 +150,13 @@ run_specific_rebase () {
 		autosquash=
 	fi
 	. git-rebase--$type
+	ret=$?
+	if test $ret -eq 0
+	then
+		git gc --auto &&
+		rm -rf "$state_dir"
+	fi
+	exit $ret
 }
 
 run_pre_rebase_hook () {
-- 
1.8.3.rc1.51.gd7a04de
