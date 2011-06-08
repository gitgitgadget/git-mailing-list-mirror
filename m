From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 06/19] git_remote_helpers: push all refs during a non-local export
Date: Wed,  8 Jun 2011 20:48:37 +0200
Message-ID: <1307558930-16074-7-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpI-00087c-3o
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455Ab1FHSti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49219 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1FHSth (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:37 -0400
Received: by ewy4 with SMTP id 4so282606ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=XHkFlP/xGkrBr5H4fgU7N4eld7Ho6ufYMAUTrGxUK3g=;
        b=o1aXqcJUS3GQdD8v54Dr/zLXNpmm3uXB0Ubzgxe6zF+LRPlfAY7F60WhfoXutZbbGJ
         w9WklwlDonz4SextaRJKQgYKEJhtDJHL3Dl+RhqjTXHKldVSUx4r0iDua66yBf9pQgX3
         09kkmvFRw1b/aeqeWLHLmkKlnVhgnlvGW5iOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZD9ajRi46+hhbm0jmiJso/KEfhp2km6gH29T6lqJtAqE3hpZWPi7OZtSU1k6b0wuja
         9qct95YeAEg3rfEMKNVTE0QOxIEcPOut8TsV6iGAti1yZxxz2Ol2h6ECvjp5FD0TkSan
         OVrjffIzolDOwT96ezU8cUXayRCIE4NzIzQVs=
Received: by 10.213.35.68 with SMTP id o4mr2154235ebd.104.1307558975667;
        Wed, 08 Jun 2011 11:49:35 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175425>

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

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from Peff's series.

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
index 1abfa5c..a4afe38 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -111,7 +111,7 @@ test_expect_success PYTHON_24 'push when remote has extra refs' '
 	compare_refs clone master server master
 '
 
-test_expect_failure PYTHON_24 'push new branch by name' '
+test_expect_success PYTHON_24 'push new branch by name' '
 	(cd clone &&
 	 git checkout -b new-name  &&
 	 echo content >>file &&
-- 
1.7.5.1.292.g728120
