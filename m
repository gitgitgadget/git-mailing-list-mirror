From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 09/21] git p4: remove unreachable windows \r\n conversion code
Date: Fri, 28 Sep 2012 08:04:13 -0400
Message-ID: <1348833865-6093-10-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZM3-0002UN-DU
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686Ab2I1MHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:07:30 -0400
Received: from honk.padd.com ([74.3.171.149]:34972 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505Ab2I1MH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:07:29 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 1E940637E;
	Fri, 28 Sep 2012 05:07:29 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CD1CA31413; Fri, 28 Sep 2012 08:07:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206566>

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
index d7ee4b4..b773b09 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2064,15 +2064,6 @@ class P4Sync(Command, P4UserMap):
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
1.7.12.1.403.g28165e1
