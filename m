From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 07/23] git_remote_helpers: push all refs during a non-local export
Date: Sat, 16 Jul 2011 15:03:27 +0200
Message-ID: <1310821424-4750-8-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:09:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4d4-0007Qy-C9
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127Ab1GPNJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:09:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56467 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082Ab1GPNJw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:09:52 -0400
Received: by ewy4 with SMTP id 4so996949ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=26jVJbmp/i4gepGm+xwY13yp/sYuuRGqfn8vp9u5YiI=;
        b=Mx0uD56ElnNDoFDunhWhRu49kgl3Mb1DqwV8ChOYFiI3pjyvN9wD8cnBXNcVH/2XSD
         aNrznWvVPC0U0ONyGHmM/g7T3RNfXzFgS8K3bp4ylkHgF8C17jDIkhGWo7C8eocIgYNX
         kxC083tY3e6zseETH2mc8cpJ62MuvQ2qTPy+Q=
Received: by 10.14.42.148 with SMTP id j20mr1524544eeb.248.1310821476650;
        Sat, 16 Jul 2011 06:04:36 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177271>

From: Jeff King <peff@peff.net>

When a remote helper exports to a non-local git repo, the
steps are roughly:

  1. fast-export into a local staging area; the set of
     interesting refs is defined by what is in the fast-export
     stream

  2. git push from the staging area to the non-local repo

In the second step, we should explicitly push all refs, not
just matching ones. This will let us push refs that do not
yet exist in the remote repo.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged

 git_remote_helpers/git/non_local.py |    2 +-
 t/t5800-remote-helpers.sh           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git_remote_helpers/git/non_local.py b/git_remote_helpers/git/non_local.py
index f27389b..c53e074 100644
--- a/git_remote_helpers/git/non_local.py
+++ b/git_remote_helpers/git/non_local.py
@@ -63,7 +63,7 @@ class NonLocalGit(object):
         if not os.path.exists(path):
             die("could not find repo at %s", path)
 
-        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath]
+        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath, "--all"]
         child = subprocess.Popen(args)
         if child.wait() != 0:
             raise CalledProcessError
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index ceb0010..12f471c 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -115,7 +115,7 @@ test_expect_success 'push when remote has extra refs' '
 	compare_refs clone master server master
 '
 
-test_expect_failure 'push new branch by name' '
+test_expect_success 'push new branch by name' '
 	(cd clone &&
 	 git checkout -b new-name  &&
 	 echo content >>file &&
-- 
1.7.5.1.292.g728120
