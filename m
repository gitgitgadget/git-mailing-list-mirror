From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 02/14] remote-testgit: fix direction of marks
Date: Sat, 24 Nov 2012 04:17:02 +0100
Message-ID: <1353727034-24698-3-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:17:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Fa-0001mI-Gs
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577Ab2KXDRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:17:36 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab2KXDRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:34 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KuIkyuEpAjhCoUropqGU0kVjh/Mzs3ShnOhIBYeCOSk=;
        b=vZZ+pJS4QCQ7Jeyjq0FhMns2FDvHCxeUI8TYHNgcOQzRuGownmbiXeImpN14OsI5oo
         g97mvUCCQcQjGDBW1u7MENpT0gSvP9/YdXvOsaIA+p1efcLyC4kJG5dMTQIMjAtQdZwt
         1VQKslj/d0oPirS+OuTk1ueRWA0umKhZnvTJJwVJb8bYW8l9m49n712Jm2h56jCuOvO2
         ogwHeIpOE9FioaoNea4NfnsAjso61JNrLA4U8Mo11xvhTQ1rY8HypweX6yW3eK+c+s98
         f8BHwwM8in3//qP4IM9zCIBv7Mhi9OjWyxXY+s9R6kxqug8vl9MNFzmAy6QHBcVzzidQ
         4xVQ==
Received: by 10.204.147.67 with SMTP id k3mr1651322bkv.117.1353727054144;
        Fri, 23 Nov 2012 19:17:34 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id l17sm5464942bkw.12.2012.11.23.19.17.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:33 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210285>

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
1.8.0
