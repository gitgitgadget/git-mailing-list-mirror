From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 p1 02/13] remote-testgit: fix direction of marks
Date: Wed, 28 Nov 2012 23:10:58 +0100
Message-ID: <1354140669-23533-3-git-send-email-felipe.contreras@gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdprE-0002iy-AZ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 23:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195Ab2K1WLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 17:11:33 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43342 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab2K1WLc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 17:11:32 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5972393bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 14:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=m1U6T78LMHCSz9ZFnY6sZs8zzMrMCx9DKJL1eBicdzo=;
        b=AQTBBnr15cZKlaVdVvXWUjrsshymevPS6G/UKCeKhng0+nunYYo4/QJ2MW5wkxQUto
         sunaDFygYeY3NSKKkGxPEdAFsiqdNm5BxylEArBUuOt5g8CwOj7xkkLwevDt1/4O+fF4
         P9wgzK+YMGAA4dMat2pp+03eGOr6OKx7kiYmKUgIke3tEXPKNw3Iqg2BBYID5dEr/1bN
         CfK+aTPKX2h+mvm1G3XFG6xan6g5L5d9kbRjOIcwKLh8EJLPvUKh2lFKGIWCQKDas2K2
         vEq9Mb9TVIzv4E/wY20Yv4eLLVW7LW4OPjXaXkJ6j6zjxc6TgN46ZHjKmy6K2BmBRC9+
         7SdQ==
Received: by 10.204.150.213 with SMTP id z21mr6352190bkv.45.1354140691417;
        Wed, 28 Nov 2012 14:11:31 -0800 (PST)
Received: from localhost (ip-109-43-0-26.web.vodafone.de. [109.43.0.26])
        by mx.google.com with ESMTPS id z5sm185077bkv.11.2012.11.28.14.11.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Nov 2012 14:11:30 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210786>

Basically this is what we want:

  == pull ==

	testgit			transport-helper

	* export ->		import

	# testgit.marks		git.marks

  == push ==

	testgit			transport-helper

	* import		<- export

	# testgit.marks		git.marks

Each side should be agnostic of the other side. Because testgit.marks
(our helper marks) could be anything, not necessarily a format parsable
by fast-export or fast-import. In this test they happen to be compatible,
because we use those tools, but in the real world it would be something
completely different. For example, they might be mapping marks to
mercurial revisions (certainly not parsable by fast-import/export).

This is what we have:

  == pull ==

	testgit			transport-helper

	* export ->		import

	# testgit.marks		git.marks

  == push ==

	testgit			transport-helper

	* import		<- export

	# git.marks		testgit.marks

The only reason this is working is that git.marks and testgit.marks are
roughly the same.

This new behavior used to not be possible before due to a bug in
fast-export, but with the bug fixed, it works fine.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-remote-testgit.py              | 2 +-
 git_remote_helpers/git/importer.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 5f3ebd2..ade797b 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -91,7 +91,7 @@ def do_capabilities(repo, args):
     if not os.path.exists(dirname):
         os.makedirs(dirname)
 
-    path = os.path.join(dirname, 'testgit.marks')
+    path = os.path.join(dirname, 'git.marks')
 
     print "*export-marks %s" % path
     if os.path.exists(path):
diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index 5c6b595..e28cc8f 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -39,7 +39,7 @@ class GitImporter(object):
             gitdir = self.repo.gitpath
         else:
             gitdir = os.path.abspath(os.path.join(dirname, '.git'))
-        path = os.path.abspath(os.path.join(dirname, 'git.marks'))
+        path = os.path.abspath(os.path.join(dirname, 'testgit.marks'))
 
         if not os.path.exists(dirname):
             os.makedirs(dirname)
-- 
1.8.0.1
