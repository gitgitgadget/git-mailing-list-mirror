From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sun, 20 Jan 2013 13:15:36 +0000
Message-ID: <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:17:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twull-0003BU-Jq
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab3ATNQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:45 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:53091 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:16:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 3296ECDA5B7;
	Sun, 20 Jan 2013 13:16:44 +0000 (GMT)
X-Quarantine-ID: <BDBsukIJ4PS6>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BDBsukIJ4PS6; Sun, 20 Jan 2013 13:16:42 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id B0ECE866003;
	Sun, 20 Jan 2013 13:16:41 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A84EC161E557;
	Sun, 20 Jan 2013 13:16:41 +0000 (GMT)
X-Quarantine-ID: <AU8mNH+AAUqT>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AU8mNH+AAUqT; Sun, 20 Jan 2013 13:16:41 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 81786161E480;
	Sun, 20 Jan 2013 13:16:34 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214016>

Under Python 3 'hasher.update(...)' must take a byte string and not a
unicode string.  Explicitly encode the argument to this method to hex
bytes so that we don't need to worry about failures to encode that might
occur if we chose a textual encoding.

This changes the directory used by git-remote-testpy for its git mirror
of the remote repository, but this tool should not have any serious
users as it is used primarily to test the Python remote helper
framework.

The use of encode() moves the required Python version forward to 2.0.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-remote-testpy.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index d94a66a..197b7be 100644
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
+    hasher.update(repo.path.encode('hex'))
     repo.hash = hasher.hexdigest()
 
     repo.get_base_path = lambda base: os.path.join(
-- 
1.8.1.353.gc992d5a.dirty
