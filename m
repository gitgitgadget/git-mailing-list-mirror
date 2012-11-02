From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 02/14] remote-testgit: fix direction of marks
Date: Fri,  2 Nov 2012 03:02:06 +0100
Message-ID: <1351821738-17526-3-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:02:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6aw-0000Oj-K6
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762639Ab2KBCCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:02:38 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762620Ab2KBCCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:02:37 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+K+FTBZ55PBiK90B6a58SeBokM/uYvqQQbk6WGVb2GU=;
        b=vFWg+uJQ8wBckHvDjS/W4hi2UJ/CBLSF3Brr/CdlFQ0ovLsJc63suE3GqbLqTqZelE
         dYYOr9DZJyWgWWMpP8LRY+oiZFOKxoLhSmHwJqwCTpdJfxIcLpuTssBeJ3on6fd80GZO
         MWEhLrXVkHeTe7p23bdI7Ynsl+z0mJl7CScafm1ID2XOm3yqp/VwWbvFen8mh0ygwbWm
         Gku0kwjFRJUzv233RjGF+fFYbMrcvmu93wl0DKLZQaxxY8EzyJC4jKHgrB1aDSm5qU7S
         EPfg/IKCCKDXil96/rEqY5ZA+LmaKHkx8dyEVozfks+cdKrBgdjSah+nb38e+JJlcQ5K
         jI8Q==
Received: by 10.204.146.10 with SMTP id f10mr20394bkv.98.1351821756453;
        Thu, 01 Nov 2012 19:02:36 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id x13sm5796718bkv.16.2012.11.01.19.02.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:02:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208898>

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
(our helper marks) could be anything, not necesarily a format parsable
by fast-export or fast-import. In this test hey happen to be compatible,
because we use those tools, but in the real world it would be something
compelely different. For example, they might be mapping marks to
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
