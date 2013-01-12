From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 6/8] git-remote-testpy: hash bytes explicitly
Date: Sat, 12 Jan 2013 19:23:44 +0000
Message-ID: <111ef16a926ae37a075304634d3fb2976fe6dee7.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:26:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6iS-000224-4K
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab3ALTZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:25:44 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:60605 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab3ALTZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:25:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id DA27722F7C;
	Sat, 12 Jan 2013 19:25:43 +0000 (GMT)
X-Quarantine-ID: <6W+REICUVENs>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6W+REICUVENs; Sat, 12 Jan 2013 19:25:43 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 5919420014;
	Sat, 12 Jan 2013 19:25:43 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4D74D161E556;
	Sat, 12 Jan 2013 19:25:43 +0000 (GMT)
X-Quarantine-ID: <cMm6NUhCvT+v>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cMm6NUhCvT+v; Sat, 12 Jan 2013 19:25:43 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id CD129161E1F3;
	Sat, 12 Jan 2013 19:25:32 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213307>

Under Python 3 'hasher.update(...)' must take a byte string and not a
unicode string.  Explicitly encode the argument to this method as UTF-8
so that this code works under Python 3.

This moves the required Python version forward to 2.0.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-remote-testpy.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index e4533b1..58aa1ae 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
 from git_remote_helpers.git.importer import GitImporter
 from git_remote_helpers.git.non_local import NonLocalGit
 
-if sys.hexversion < 0x01050200:
-    # os.makedirs() is the limiter
-    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
+if sys.hexversion < 0x02000000:
+    # string.encode() is the limiter
+    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
     sys.exit(1)
 
 def get_repo(alias, url):
@@ -45,7 +45,7 @@ def get_repo(alias, url):
     repo.get_head()
 
     hasher = _digest()
-    hasher.update(repo.path)
+    hasher.update(repo.path.encode('utf-8'))
     repo.hash = hasher.hexdigest()
 
     repo.get_base_path = lambda base: os.path.join(
-- 
1.8.1
