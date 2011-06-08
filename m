From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 04/19] teach remote-testgit to import non-HEAD refs
Date: Wed,  8 Jun 2011 20:48:35 +0200
Message-ID: <1307558930-16074-5-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:49:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNou-0007wm-Cl
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab1FHSte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46492 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1FHStd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:33 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so279690eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=gFS6RIB5TXJyUueEf7MH8r4XNtzMpmuwEDtECozJpoA=;
        b=uUzF5bpMDXtWd3KgX1wKwb071L/1w0vxxjMllTHPO5kGZn+QDpIFCbA2dT4R5yvUR4
         Diu1bP5PxHn81MrXmanj9HA1sac8pNAUZhd82d+jt6CAWPeW3SXCQ80HbNoe9HhYjFWw
         oR7EdLK1fO0vBNp0zartLgvQcPd2HdbGxCGC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hzYUa6eJdWCQ5WNQXzPVmFGVhCPEveHTXD8adnAwVRz75IhAYuqAyDTEZT3AwO2kN/
         StXvVWimmY2eU0oL/weO3b8uzaeKfZmu3qTRC8HkXgCAMJ+L7SyichlVXFLMQS4w0LkO
         3ScFmi15NpGgeyDW8plENZL7p2398coajTOpI=
Received: by 10.14.33.148 with SMTP id q20mr2881425eea.91.1307558972645;
        Wed, 08 Jun 2011 11:49:32 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175422>

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

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from Peff's series.

 git-remote-testgit.py              |    2 +-
 git_remote_helpers/git/exporter.py |    8 +++++++-
 t/t5800-remote-helpers.sh          |    2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

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
index f40f9d6..8fd83c7 100644
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
 
@@ -38,6 +43,7 @@ class GitExporter(object):
         sys.stdout.flush()
 
         args = ["git", "--git-dir=" + self.repo.gitpath, "fast-export", "--export-marks=" + path]
+        args.extend(refs)
 
         if os.path.exists(path):
             args.append("--import-marks=" + path)
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index a10a48d..562edf4 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -81,7 +81,7 @@ test_expect_success PYTHON_24 'pushing remote local repo' '
 	compare_refs clone HEAD server HEAD
 '
 
-test_expect_failure PYTHON_24 'fetch new branch' '
+test_expect_success PYTHON_24 'fetch new branch' '
 	(cd public &&
 	 git checkout -b new &&
 	 echo content >>file &&
-- 
1.7.5.1.292.g728120
