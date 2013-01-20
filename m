From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 2/8] git_remote_helpers: fix input when running under Python 3
Date: Sun, 20 Jan 2013 13:15:32 +0000
Message-ID: <7cd489e5b1b2578b1509232196cd6b21fd684843.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwulL-00033l-Qk
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab3ATNQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:19 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:40093 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:16:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 2FA6A22F76;
	Sun, 20 Jan 2013 13:16:18 +0000 (GMT)
X-Quarantine-ID: <8TvKUp8IA838>
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
	with ESMTP id 8TvKUp8IA838; Sun, 20 Jan 2013 13:16:13 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 927B922F0B;
	Sun, 20 Jan 2013 13:16:13 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 79F35161E509;
	Sun, 20 Jan 2013 13:16:13 +0000 (GMT)
X-Quarantine-ID: <7nkOvkGXFQ7P>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7nkOvkGXFQ7P; Sun, 20 Jan 2013 13:16:13 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 3AA62161E480;
	Sun, 20 Jan 2013 13:16:05 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214012>

Although 2to3 will fix most issues in Python 2 code to make it run under
Python 3, it does not handle the new strict separation between byte
strings and unicode strings.  There is one instance in
git_remote_helpers where we are caught by this, which is when reading
refs from "git for-each-ref".

Fix this by operating on the returned string as a byte string rather
than a unicode string.  As this method is currently only used internally
by the class this does not affect code anywhere else.

Note that we cannot use byte strings in the source as the 'b' prefix is
not supported before Python 2.7 so in order to maintain compatibility
with the maximum range of Python versions we use an explicit call to
encode().

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git_remote_helpers/git/importer.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index e28cc8f..d3f90e1 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -18,13 +18,16 @@ class GitImporter(object):
 
     def get_refs(self, gitdir):
         """Returns a dictionary with refs.
+
+        Note that the keys in the returned dictionary are byte strings as
+        read from git.
         """
         args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
-        lines = check_output(args).strip().split('\n')
+        lines = check_output(args).strip().split('\n'.encode('ascii'))
         refs = {}
         for line in lines:
-            value, name = line.split(' ')
-            name = name.strip('commit\t')
+            value, name = line.split(' '.encode('ascii'))
+            name = name.strip('commit\t'.encode('ascii'))
             refs[name] = value
         return refs
 
-- 
1.8.1.353.gc992d5a.dirty
