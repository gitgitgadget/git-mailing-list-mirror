From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] prompt: clean up describe logic
Date: Tue, 18 Jun 2013 22:43:24 +0530
Message-ID: <1371575608-9980-2-git-send-email-artagnon@gmail.com>
References: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:16:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozWZ-0003FH-1l
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205Ab3FRRQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:16:41 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41744 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab3FRRQk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:16:40 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so4235860pac.15
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZPBrnd+y7cUCiGXI1G4A4Z7VKhJSZwryTBOxCFfEqOM=;
        b=GzXztx2rUgHsXfQoEj0KLh/o1/2XF54n2ymwJH2lr77+SZmavKwlFB4oG8xFooluN2
         ZRT6ko5BZ/UJD/58+dbS9QATBP3+F8/u1MOJsTZRLIzCJtwim5hUAs0VoSsB61jGH9Y9
         Qq9kJJp9Bz5ZkGMAZlljqYCfHGaoeIRpdPm1w5KG8A8Sk32kzHxgLNwjmIYvH/53zlta
         3pr5sJMBOBYIuCEdWPJqszdlvetTwtBcv6rE/fuW4ajfs1/cJEaU/iimj2wBNWzcfVh2
         OZcn6OJeLmm2frqCKZbKV8gffySLPZIaoj/EDAmh7LItzuKtN4NqmepbhC0X3vpaSFfO
         6Nig==
X-Received: by 10.66.160.163 with SMTP id xl3mr2940564pab.201.1371575799729;
        Tue, 18 Jun 2013 10:16:39 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm20498303pac.20.2013.06.18.10.16.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 10:16:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6.dirty
In-Reply-To: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228279>

The describe logic is convoluted and unclean:

1. Reading .git/HEAD by hand and using the first 7 characters, of the
   SHA-1 does not guarantee an unambiguous output; we can use rev-parse
   --short in its place to get a unique SHA-1.

2. Use the --always option of describe to automatically output the short
   SHA-1 when everything else fails.

The patch introduces one small change: since we are not checking the
return value of describe (with --always, it always returns something
valid), we cannot discriminate a raw SHA-1 from everything else and
suffix it with a "...".

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh | 16 +++++++---------
 t/t9903-bash-prompt.sh           |  2 +-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 86a4f3f..9ed6ff1 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -380,20 +380,18 @@ __git_ps1 ()
 			test -n "$b" ||
 			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
 				detached=yes
-				b="$(
 				case "${GIT_PS1_DESCRIBE_STYLE-}" in
 				(contains)
-					git describe --contains HEAD ;;
+					b=$(git describe --always --contains HEAD) ;;
 				(branch)
-					git describe --contains --all HEAD ;;
+					b=$(git describe --always --contains --all HEAD) ;;
 				(describe)
-					git describe HEAD ;;
+					b=$(git describe --always HEAD) ;;
 				(* | default)
-					git describe --tags --exact-match HEAD ;;
-				esac 2>/dev/null)" ||
-
-				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-				b="unknown"
+					b=$(git describe --tags --exact-match HEAD 2>/dev/null)
+					test -z $b && b="$(git rev-parse --short HEAD)"
+					;;
+				esac
 				b="($b)"
 			}
 		fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 15521cc..b0ad477 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -169,7 +169,7 @@ test_expect_success 'prompt - branch name' '
 '
 
 test_expect_success 'prompt - detached head' '
-	printf " ((%s...))" $(git log -1 --format="%h" b1^) > expected &&
+	printf " ((%s))" $(git log -1 --format="%h" b1^) > expected &&
 	git checkout b1^ &&
 	test_when_finished "git checkout master" &&
 	__git_ps1 > "$actual" &&
-- 
1.8.3.1.456.gb7f4cb6.dirty
