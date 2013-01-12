From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 7/8] git-remote-testpy: don't do unbuffered text I/O
Date: Sat, 12 Jan 2013 19:23:45 +0000
Message-ID: <d6f040809ad7457ff5f97fb23a2531988938a96a.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:26:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6if-0002Bh-Cm
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab3ALTZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:25:57 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:33806 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab3ALTZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:25:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 099C8CDA5B3;
	Sat, 12 Jan 2013 19:25:57 +0000 (GMT)
X-Quarantine-ID: <TXBazFniLltf>
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
	with ESMTP id TXBazFniLltf; Sat, 12 Jan 2013 19:25:56 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 934EECDA5AE;
	Sat, 12 Jan 2013 19:25:56 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 88493161E559;
	Sat, 12 Jan 2013 19:25:56 +0000 (GMT)
X-Quarantine-ID: <Nh20c4FM30dk>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nh20c4FM30dk; Sat, 12 Jan 2013 19:25:56 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 75E3F161E556;
	Sat, 12 Jan 2013 19:25:43 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213308>

Python 3 forbids unbuffered I/O in text mode.  Change the reading of
stdin in git-remote-testpy so that we read the lines as bytes and then
decode them a line at a time.

This allows us to keep the I/O unbuffered in order to avoid
reintroducing the bug fixed by commit 7fb8e16 (git-remote-testgit: fix
race when spawning fast-import).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-remote-testpy.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index 58aa1ae..815222f 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -154,7 +154,7 @@ def do_import(repo, args):
     refs = [ref]
 
     while True:
-        line = sys.stdin.readline()
+        line = sys.stdin.readline().decode()
         if line == '\n':
             break
         if not line.startswith('import '):
@@ -217,7 +217,7 @@ def read_one_line(repo):
 
     line = sys.stdin.readline()
 
-    cmdline = line
+    cmdline = line.decode()
 
     if not cmdline:
         warn("Unexpected EOF")
@@ -269,7 +269,7 @@ def main(args):
 
     more = True
 
-    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
+    sys.stdin = os.fdopen(sys.stdin.fileno(), 'rb', 0)
     while (more):
         more = read_one_line(repo)
 
-- 
1.8.1
