From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 02/15] remote-testgit: fix direction of marks
Date: Sun, 11 Nov 2012 14:59:39 +0100
Message-ID: <1352642392-28387-3-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
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
X-From: git-owner@vger.kernel.org Sun Nov 11 15:00:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY5k-0007eN-Rv
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab2KKOAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:00:36 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab2KKOAf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:00:35 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+K+FTBZ55PBiK90B6a58SeBokM/uYvqQQbk6WGVb2GU=;
        b=BR6GZzmt+JRjmgin1Vt4SVy2Su8Gyzp4HsoEmLgvqjxYiHfOaoX5xPjQvEylEFFudB
         tWe7GRQ8d1Uz0cMzadkMeEpDu57AsANDaQBQu0JLrwddfcQF//KMpYP2RnpsSsQNmSKq
         KZj1ciKqtHzI84TNTQb1xJ+yo80CqH3KkJfarRdvCGl+uJCLVb2hJgC6lKeBrb7tvJEX
         RhulqymNpMTFREMgow3OG303JA9d7qzKI7vJn6ReOTHtrIkuZ+zaPBS5Oe5hsfdsBJ3y
         AaNkAJpKKVHrXMozpsi2jVLJkXC0+3n/X7m9HZqY6B0gbZLtNeyXYjMp2id3hTPfvpMG
         jLWg==
Received: by 10.204.4.141 with SMTP id 13mr6195643bkr.82.1352642434833;
        Sun, 11 Nov 2012 06:00:34 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id z13sm1489711bkv.8.2012.11.11.06.00.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:00:33 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209358>

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
