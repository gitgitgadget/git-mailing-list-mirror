From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH] git-rebase: Print name of rev when using shorthand
Date: Mon, 14 Apr 2014 05:04:34 +0900
Message-ID: <1397419474-31999-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 22:04:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZQe3-0000Bf-J1
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 22:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbaDMUEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2014 16:04:46 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:53971 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbaDMUEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2014 16:04:45 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so7413430pbb.14
        for <git@vger.kernel.org>; Sun, 13 Apr 2014 13:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=H0aGpIMLB+ZQSlZKLyN+82Q+4o7SxoqSAvBIHsiANJM=;
        b=yrYZWMOghGrW+Zai7BGKjrS7mNMP3kuY92bG1kt+oYbGlGv3tXIzzkK+agkDyY82Ch
         Fn/bvqdVPBp2AP6QW8tXTGH/zLq66XOKRzKY8SL3T97qIyfGJJ9AixPLA4x1Ti0VUrry
         R7eZIu06lnQYg0UOddpGQ2XjzBUumX8rbcOPZOFbhTGqd3wBZjNrwqZlxbDD2a9WpXFn
         +AiFJ02eJO9gEyauessX3KefwqWj0U0eih9stf3Oeq6XkJ7Bweem7fLggMc/FLumg8We
         fQrTmd4Lc9fra4nUqvUI3jdMs0AZOcurJc+2SfNfYyzDvx+q0xhKkIi7ZEkVcko/ZwjC
         iEmg==
X-Received: by 10.68.213.97 with SMTP id nr1mr39946742pbc.52.1397419485209;
        Sun, 13 Apr 2014 13:04:45 -0700 (PDT)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id ss2sm69669489pab.8.2014.04.13.13.04.44
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 13 Apr 2014 13:04:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.259.gc5d75e8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246211>

The output from a successful invocation of the shorthand command
"git rebase -" is something like "Fast-forwarded HEAD to @{-1}",
which includes a relative reference to a revision. Other commands
that use the shorthand "-", such as "git checkout -", typically
display the symbolic name of the revision.

Change rebase to output the symbolic name of the revision when using
the shorthand. For the example above, the new output is
"Fast-forwarded HEAD to master", assuming "@{-1}" is a reference to
"master".

- Use "git name-rev" to retreive the name of the rev.
- Update the tests in light of this new behavior.

Requested-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
Previous discussion on this issue:
http://article.gmane.org/gmane.comp.version-control.git/244340

 git-rebase.sh     | 2 +-
 t/t3400-rebase.sh | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2c75e9f..ab0e081 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -455,7 +455,7 @@ then
 	*)	upstream_name="$1"
 		if test "$upstream_name" = "-"
 		then
-			upstream_name="@{-1}"
+			upstream_name=`git name-rev --name-only @{-1}`
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
