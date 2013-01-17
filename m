From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 7/8] git-remote-testpy: don't do unbuffered text I/O
Date: Thu, 17 Jan 2013 18:54:00 +0000
Message-ID: <6bc90f3afc86d53eb6e4b4d6b87f6afd20023769.1358448207.git.john@keeping.me.uk>
References: <cover.1358448207.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:57:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvueW-0005zQ-1V
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 19:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317Ab3AQS5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 13:57:00 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:36319 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039Ab3AQS47 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 13:56:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id EFED2606570;
	Thu, 17 Jan 2013 18:56:58 +0000 (GMT)
X-Quarantine-ID: <r43j5c8k39oE>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r43j5c8k39oE; Thu, 17 Jan 2013 18:56:53 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 0293A606565;
	Thu, 17 Jan 2013 18:56:53 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id DABCE276DFE;
	Thu, 17 Jan 2013 18:56:52 +0000 (GMT)
X-Quarantine-ID: <wANx6kgG8gOZ>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wANx6kgG8gOZ; Thu, 17 Jan 2013 18:56:52 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 4A1F5276DFB;
	Thu, 17 Jan 2013 18:56:38 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213869>

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
index f8dc196..bc5e3cf 100644
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
@@ -277,7 +277,7 @@ def main(args):
 
     more = True
 
-    sys.stdin = os.fdopen(sys.stdin.fileno(), 'r', 0)
+    sys.stdin = os.fdopen(sys.stdin.fileno(), 'rb', 0)
     while (more):
         more = read_one_line(repo)
 
-- 
1.8.1.1.260.g99b33f4.dirty
