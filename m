From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/8] git_remote_helpers: fix input when running under Python 3
Date: Sat, 12 Jan 2013 19:23:40 +0000
Message-ID: <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6hS-0001Ej-TY
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab3ALTYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:24:43 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:55432 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab3ALTYm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:24:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D6FC7CDA59A;
	Sat, 12 Jan 2013 19:24:41 +0000 (GMT)
X-Quarantine-ID: <3PDTx4o6Uq-O>
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
	with ESMTP id 3PDTx4o6Uq-O; Sat, 12 Jan 2013 19:24:41 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 3B6E4CDA583;
	Sat, 12 Jan 2013 19:24:40 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 32413161E559;
	Sat, 12 Jan 2013 19:24:40 +0000 (GMT)
X-Quarantine-ID: <ZlqBqNe-atoH>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZlqBqNe-atoH; Sat, 12 Jan 2013 19:24:40 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id CA1C5161E1F3;
	Sat, 12 Jan 2013 19:24:29 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213303>

Although 2to3 will fix most issues in Python 2 code to make it run under
Python 3, it does not handle the new strict separation between byte
strings and unicode strings.  There is one instance in
git_remote_helpers where we are caught by this.

Fix it by explicitly decoding the incoming byte string into a unicode
string.  In this instance, use the locale under which the application is
running.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git_remote_helpers/git/importer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index e28cc8f..6814003 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -20,7 +20,7 @@ class GitImporter(object):
         """Returns a dictionary with refs.
         """
         args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
-        lines = check_output(args).strip().split('\n')
+        lines = check_output(args).decode().strip().split('\n')
         refs = {}
         for line in lines:
             value, name = line.split(' ')
-- 
1.8.1
