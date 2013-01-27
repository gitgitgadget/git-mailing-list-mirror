From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 09/21] git p4: remove unreachable windows \r\n conversion code
Date: Sat, 26 Jan 2013 22:11:12 -0500
Message-ID: <1359256284-5660-10-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIhl-0005Yb-PB
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab3A0DO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:14:29 -0500
Received: from honk.padd.com ([74.3.171.149]:58716 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:14:28 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id D9CC72F3F;
	Sat, 26 Jan 2013 19:14:27 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 89FA022838; Sat, 26 Jan 2013 22:14:24 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214659>

Replacing \r\n with \n on windows was added in c1f9197 (Replace
\r\n with \n when importing from p4 on Windows, 2007-05-24), to
work around an oddity with "p4 print" on windows.  Text files
are printed with "\r\r\n" endings, regardless of whether they
were created on unix or windows, and regardless of the client
LineEnd setting.

As of d2c6dd3 (use p4CmdList() to get file contents in Python
dicts. This is more robust., 2007-05-23), git-p4 uses "p4 -G
print", which generates files in a raw format.  As the native
line ending format if p4 is \n, there will be no \r\n in the
raw text.

Actually, it is possible to generate a text file so that the
p4 representation includes embedded \r\n, even though this is not
normal on either windows or unix.  In that case the code would
have mistakenly stripped them out, but now they will be left
intact.

More information on how p4 deals with line endings is here:

    http://kb.perforce.com/article/63

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index cbf8525..445d704 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2134,15 +2134,6 @@ class P4Sync(Command, P4UserMap):
             print "\nIgnoring apple filetype file %s" % file['depotFile']
             return
 
-        # Perhaps windows wants unicode, utf16 newlines translated too;
-        # but this is not doing it.
-        if self.isWindows and type_base == "text":
-            mangled = []
-            for data in contents:
-                data = data.replace("\r\n", "\n")
-                mangled.append(data)
-            contents = mangled
-
         # Note that we do not try to de-mangle keywords on utf16 files,
         # even though in theory somebody may want that.
         pattern = p4_keywords_regexp_for_type(type_base, type_mods)
-- 
1.8.1.1.460.g6fa8886
