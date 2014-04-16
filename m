From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH v2] git-rebase: Print name of rev when using shorthand
Date: Wed, 16 Apr 2014 17:31:48 +0900
Message-ID: <1397637108-51129-1-git-send-email-modocache@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 10:32:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaLGN-0006sf-O3
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 10:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaDPIcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 04:32:03 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48936 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaDPIb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 04:31:59 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so10509910pdi.35
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VsIjqqiunhbnDVddZHMBBLbBSE0bywYIxY01sEjbCM0=;
        b=G6c5BVHAyk8iLIqHG9CupW1CDkoB9V3ue7lVyF0vPizsxPdg/HbTlzxg+gfnVKq9k9
         1+Yadg9QnPc4JdNHTMHprp48lan9LXVKs8/L5yy64LW2BDiwzLPbLd6S8qXbN+ta9WRo
         zzf2iDHs4bzRNgHujTxXBanJ3ovN7JOzZoUZIKrrGMPpVhGScmDcjlX7VFiwaURLQUjB
         swRnx0VoP+MbnVnGGdEhTXiQADzOo59pgEJvJZEp9gsfl8BzFpRpXcQ87KWGR+DXO8dC
         FTZzYf6/exR9h/lhWgRuT0vpoF2jzIPXbRxGk8WWIKqGurt2iPiEO9dzkxUkGmOTZL48
         7OoA==
X-Received: by 10.69.21.106 with SMTP id hj10mr7022827pbd.87.1397637119227;
        Wed, 16 Apr 2014 01:31:59 -0700 (PDT)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id dy7sm107830474pad.9.2014.04.16.01.31.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 01:31:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.259.gc5d75e8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246318>

The output from a successful invocation of the shorthand command
"git rebase -" is something like "Fast-forwarded HEAD to @{-1}",
which includes a relative reference to a revision. Other commands
that use the shorthand "-", such as "git checkout -", typically
display the symbolic name of the revision.

Change rebase to output the symbolic name of the revision when using
the shorthand. For the example above, the new output is
"Fast-forwarded HEAD to master", assuming "@{-1}" is a reference to
"master".

- Use "git rev-parse" to retreive the name of the rev.
- Update the tests in light of this new behavior.

Requested-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 git-rebase.sh     | 8 +++++++-
 t/t3400-rebase.sh | 4 +---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2c75e9f..42d34a6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -455,7 +455,13 @@ then
 	*)	upstream_name="$1"
 		if test "$upstream_name" = "-"
 		then
-			upstream_name="@{-1}"
+			upstream_name=`git rev-parse --symbolic-full-name @{-1}`
+			if test -n "$upstream_name"
+			then
+				upstream_name=${upstream_name#refs/heads/}
+			else
+				upstream_name="@{-1}"
+			fi
 		fi
 		shift
 		;;
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 80e0a95..2b99940 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -91,7 +91,7 @@ test_expect_success 'rebase from ambiguous branch name' '
 test_expect_success 'rebase off of the previous branch using "-"' '
 	git checkout master &&
 	git checkout HEAD^ &&
-	git rebase @{-1} >expect.messages &&
+	git rebase master >expect.messages &&
 	git merge-base master HEAD >expect.forkpoint &&
 
 	git checkout master &&
@@ -100,8 +100,6 @@ test_expect_success 'rebase off of the previous branch using "-"' '
 	git merge-base master HEAD >actual.forkpoint &&
 
 	test_cmp expect.forkpoint actual.forkpoint &&
-	# the next one is dubious---we may want to say "-",
-	# instead of @{-1}, in the message
 	test_i18ncmp expect.messages actual.messages
 '
 
-- 
1.9.0.259.gc5d75e8.dirty
