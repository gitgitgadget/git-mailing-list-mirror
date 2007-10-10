From: Brian Ewins <brian.ewins@gmail.com>
Subject: [PATCH 2/2] Add a --dry-run option to git-push.
Date: Thu, 11 Oct 2007 00:34:48 +0100
Message-ID: <6EFBD20E-5071-487E-8167-9FAAEE10A579@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 01:34:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifl4n-0007DR-08
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 01:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbXJJXem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 19:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756914AbXJJXem
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 19:34:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:2104 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917AbXJJXek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 19:34:40 -0400
Received: by ug-out-1314.google.com with SMTP id z38so370752ugc
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-type:message-id:cc:content-transfer-encoding:subject:date:to:x-mailer:from;
        bh=ARiiFN1t5iDuk0iZYLLyrqLlY7R+qJ0xyiJQd/vAi40=;
        b=oOHr7RIYR0j+ik03DUpa1iIV7ET2NRfn5rhmVwx4xcLZb5VBNx6bri8anCUyzdsSeCaxu3pdc7gbrvemqSToQapIWvpKaXxKBIbTT4behEfERjNAtxQYWrS9ykdUQtHy8QR5nJSqe6FLNjGwbAxVLLpvqFcW2f2i9BJ+vpe1gd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-type:message-id:cc:content-transfer-encoding:subject:date:to:x-mailer:from;
        b=l0GlNAf+hK8jhYpa8hxQycUcVJUk5bSJx1x+MoD8KJIhh7zln7ireWP8D0IiiMu4c1EL9lwOCbt2XYjNLt6Zp8rYviscpC9hSYVwIFx5436dzdQV2AEq9erll9w6ID2rznN/BRm2SeUjQ20qomTSGhPqdN5bXKTDCbETuv9D2iQ=
Received: by 10.66.252.18 with SMTP id z18mr2498880ugh.1192059278831;
        Wed, 10 Oct 2007 16:34:38 -0700 (PDT)
Received: from ?10.0.1.2? ( [86.0.198.221])
        by mx.google.com with ESMTPS id w28sm1729606uge.2007.10.10.16.34.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2007 16:34:37 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60568>

Signed-off-by: Brian Ewins <brian.ewins@gmail.com>
---
  Documentation/git-push.txt |    6 +++++-
  builtin-push.c             |   10 ++++++++--
  t/t5516-fetch-push.sh      |   10 ++++++++++
  3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6bc559d..2dd95ba 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated  
objects
  SYNOPSIS
  --------
  [verse]
-'git-push' [--all] [--tags] [--receive-pack=<git-receive-pack>]
+'git-push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive- 
pack>]
             [--repo=all] [-f | --force] [-v] [<repository>  
<refspec>...]

  DESCRIPTION
@@ -63,6 +63,10 @@ the remote repository.
  	Instead of naming each ref to push, specifies that all
  	refs under `$GIT_DIR/refs/heads/` be pushed.

+\--dry-run::
+	Show what would have been updated, but do not perform
+	any updates.
+
  \--tags::
  	All refs under `$GIT_DIR/refs/tags` are pushed, in
  	addition to refspecs explicitly listed on the command
diff --git a/builtin-push.c b/builtin-push.c
index 88c5024..141380b 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -7,9 +7,9 @@
  #include "builtin.h"
  #include "remote.h"

-static const char push_usage[] = "git-push [--all] [--tags] [-- 
receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v]  
[<repository> <refspec>...]";
+static const char push_usage[] = "git-push [--all] [--dry-run] [-- 
tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force]  
[-v] [<repository> <refspec>...]";

-static int all, force, thin, verbose;
+static int all, dry_run, force, thin, verbose;
  static const char *receivepack;

  static const char **refspec;
@@ -69,6 +69,8 @@ static int do_push(const char *repo)
  	argc = 1;
  	if (all)
  		argv[argc++] = "--all";
+	if (dry_run)
+		argv[argc++] = "--dry-run";
  	if (force)
  		argv[argc++] = "--force";
  	if (receivepack)
@@ -147,6 +149,10 @@ int cmd_push(int argc, const char **argv, const  
char *prefix)
  			all = 1;
  			continue;
  		}
+		if (!strcmp(arg, "--dry-run")) {
+			dry_run = 1;
+			continue;
+		}
  		if (!strcmp(arg, "--tags")) {
  			add_refspec("refs/tags/*");
  			continue;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index ca46aaf..4fbd5b1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -244,4 +244,14 @@ test_expect_success 'push with colon-less  
refspec (4)' '

  '

+test_expect_success 'push with dry-run' '
+
+	mk_test heads/master &&
+	cd testrepo &&
+	old_commit=$(git show-ref -s --verify refs/heads/master) &&
+	cd .. &&
+	git push --dry-run testrepo &&
+	check_push_result $old_commit heads/master
+'
+
  test_done
-- 
1.5.2.5
