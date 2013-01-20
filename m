From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 7/8] git-remote-testpy: don't do unbuffered text I/O
Date: Sun, 20 Jan 2013 13:15:37 +0000
Message-ID: <c73b8e6e762bbf19e840994e4ff6e99de465051c.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:17:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twulr-0003Bs-MQ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab3ATNQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:51 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:40298 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNQu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:16:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 1443722F49;
	Sun, 20 Jan 2013 13:16:50 +0000 (GMT)
X-Quarantine-ID: <brbu+H-ZQ6sp>
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
	with ESMTP id brbu+H-ZQ6sp; Sun, 20 Jan 2013 13:16:49 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 79B4422F0B;
	Sun, 20 Jan 2013 13:16:49 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 6F550161E560;
	Sun, 20 Jan 2013 13:16:49 +0000 (GMT)
X-Quarantine-ID: <4TLQBKUarAG3>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4TLQBKUarAG3; Sun, 20 Jan 2013 13:16:49 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7EAED161E509;
	Sun, 20 Jan 2013 13:16:41 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214017>

Python 3 forbids unbuffered I/O in text mode.  Change the reading of
stdin in git-remote-testpy so that we read the lines as bytes and then
decode them a line at a time.

This allows us to keep the I/O unbuffered in order to avoid
reintroducing the bug fixed by commit 7fb8e16 (git-remote-testgit: fix
race when spawning fast-import).

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-remote-testpy.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index 197b7be..5dbf1cc 100644
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
@@ -225,7 +225,7 @@ def read_one_line(repo):
 
     line = sys.stdin.readline()
 
-    cmdline = line
+    cmdline = line.decode()
 
     if not cmdline:
         warn("Unexpected EOF")
@@ -277,7 +277,11 @@ def main(args):
 
     more = True
 
-    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
+    # Use binary mode since Python 3 does not permit unbuffered I/O in text
+    # mode.  Unbuffered I/O is required to avoid data that should be going
+    # to git-fast-import after an "export" command getting caught in our
+    # stdin buffer instead.
+    sys.stdin = os.fdopen(sys.stdin.fileno(), 'rb', 0)
     while (more):
         more = read_one_line(repo)
 
-- 
1.8.1.353.gc992d5a.dirty
