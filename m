From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 05/20] teach remote-testgit to import non-HEAD refs
Date: Sun, 19 Jun 2011 17:18:30 +0200
Message-ID: <1308496725-22329-6-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJn2-0003jn-HS
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355Ab1FSPTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52873 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab1FSPTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:40 -0400
Received: by eyx24 with SMTP id 24so294388eyx.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=/P2DtVFSBNP+OohB3FG/RLdYbY1gZaT302YOXsGPTIU=;
        b=dMdFSWgflsDs4xUwIz+KYIkQzFhamrcPEGaD+qf8dfiAgxeYByg0NKuuAJHAdo8pXN
         NobtQNzCCmgkDHuXXwxL7OmF2lwrBHJUumG6OVwBS1jvefpmKBh43haAFhgL2w4//63b
         p9D9zBs/HeA+Qt+GX5K5y4PDrE9V8Gjqed9pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HEL54cr+Jp7KaLY66sTmnEyI3J6URnD4YxX3rDcy85L4kJxzMM7fZYg4XF1vL4pArP
         Ev0eCPas+a2tBz1NYZDJ/HMyNgtaxwV4mAflnY7+qZYTW6l/Pr6l3J+dAV1HVLJ1eAuW
         jXRsxetTIr59UfiDnOV5Q+xNXFFfBCL8JXyJQ=
Received: by 10.213.14.7 with SMTP id e7mr401906eba.29.1308496778651;
        Sun, 19 Jun 2011 08:19:38 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176008>

From: Jeff King <peff@peff.net>

Upon receiving an "import" command, the testgit remote
helper would ignore the ref asked for by git and generate a
fast-export stream based on HEAD. Instead, we should
actually give git the ref it asked for.

This requires adding a new parameter to the export_repo
method in the remote-helpers python library, which may be
used by code outside of git.git. We use a default parameter
so that callers without the new parameter will get the same
behavior as before.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Fixed spurious appending of "HEAD" noticed by Junio.

 git-remote-testgit.py              |    2 +-
 git_remote_helpers/git/exporter.py |    9 +++++++--
 t/t5800-remote-helpers.sh          |    2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index df9d512..e4a99a3 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -122,7 +122,7 @@ def do_import(repo, args):
         die("Need gitdir to import")
 
     repo = update_local_repo(repo)
-    repo.exporter.export_repo(repo.gitdir)
+    repo.exporter.export_repo(repo.gitdir, args)
 
 
 def do_export(repo, args):
diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
index f40f9d6..bc39163 100644
--- a/git_remote_helpers/git/exporter.py
+++ b/git_remote_helpers/git/exporter.py
@@ -15,7 +15,7 @@ class GitExporter(object):
 
         self.repo = repo
 
-    def export_repo(self, base):
+    def export_repo(self, base, refs=None):
         """Exports a fast-export stream for the given directory.
 
         Simply delegates to git fast-epxort and pipes it through sed
@@ -23,8 +23,13 @@ class GitExporter(object):
         default refs/heads. This is to demonstrate how the export
         data can be stored under it's own ref (using the refspec
         capability).
+
+        If None, refs defaults to ["HEAD"].
         """
 
+        if not refs:
+            refs = ["HEAD"]
+
         dirname = self.repo.get_base_path(base)
         path = os.path.abspath(os.path.join(dirname, 'testgit.marks'))
 
@@ -42,7 +47,7 @@ class GitExporter(object):
         if os.path.exists(path):
             args.append("--import-marks=" + path)
 
-        args.append("HEAD")
+        args.extend(refs)
 
         p1 = subprocess.Popen(args, stdout=subprocess.PIPE)
 
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 9db8ca8..ca115cc 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -85,7 +85,7 @@ test_expect_success 'pushing remote local repo' '
 	compare_refs clone HEAD server HEAD
 '
 
-test_expect_failure 'fetch new branch' '
+test_expect_success 'fetch new branch' '
 	(cd public &&
 	 git checkout -b new &&
 	 echo content >>file &&
-- 
1.7.5.1.292.g728120
