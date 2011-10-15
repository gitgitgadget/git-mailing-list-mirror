From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/6] git-p4: recognize all p4 filetypes
Date: Sat, 15 Oct 2011 11:57:54 -0400
Message-ID: <20111015155754.GD29436@arf.padd.com>
References: <20111015155358.GA29436@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 17:58:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF6cy-00012B-3U
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 17:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515Ab1JOP6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 11:58:20 -0400
Received: from honk.padd.com ([74.3.171.149]:35786 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390Ab1JOP6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 11:58:19 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 6F9592822;
	Sat, 15 Oct 2011 08:58:18 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A36C131465; Sat, 15 Oct 2011 11:57:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20111015155358.GA29436@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183666>

The previous code was approximate in the filetypes it recognized.
Put in the canonical list and be more careful about matching
elements of the file type.

This might change behavior in some cases, hopefully for the
better.  Windows newline mangling will now happen on all
text files.  Previously some like "text+ko" were oddly exempt.

Files with multiple combinations of modifiers, like "text+klx",
are now recognized for keyword expansion.  I expect these to be
seen only rarely.

Acked-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   71 ++++++++++++++++++++++++++++++++------------
 1 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e69caf3..0490ca5 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -118,13 +118,41 @@ def p4_system(cmd):
     real_cmd = p4_build_cmd(cmd)
     return system(real_cmd)
 
-def isP4Exec(kind):
-    """Determine if a Perforce 'kind' should have execute permission
+#
+# Canonicalize the p4 type and return a tuple of the
+# base type, plus any modifiers.  See "p4 help filetypes"
+# for a list and explanation.
+#
+def split_p4_type(p4type):
+
+    p4_filetypes_historical = {
+        "ctempobj": "binary+Sw",
+        "ctext": "text+C",
+        "cxtext": "text+Cx",
+        "ktext": "text+k",
+        "kxtext": "text+kx",
+        "ltext": "text+F",
+        "tempobj": "binary+FSw",
+        "ubinary": "binary+F",
+        "uresource": "resource+F",
+        "uxbinary": "binary+Fx",
+        "xbinary": "binary+x",
+        "xltext": "text+Fx",
+        "xtempobj": "binary+Swx",
+        "xtext": "text+x",
+        "xunicode": "unicode+x",
+        "xutf16": "utf16+x",
+    }
+    if p4type in p4_filetypes_historical:
+        p4type = p4_filetypes_historical[p4type]
+    mods = ""
+    s = p4type.split("+")
+    base = s[0]
+    mods = ""
+    if len(s) > 1:
+        mods = s[1]
+    return (base, mods)
 
-    'p4 help filetypes' gives a list of the types.  If it starts with 'x',
-    or x follows one of a few letters.  Otherwise, if there is an 'x' after
-    a plus sign, it is also executable"""
-    return (re.search(r"(^[cku]?x)|\+.*x", kind) != None)
 
 def setP4ExecBit(file, mode):
     # Reopens an already open file and changes the execute bit to match
@@ -1229,16 +1257,18 @@ class P4Sync(Command, P4UserMap):
         if verbose:
             sys.stderr.write("%s\n" % relPath)
 
-        mode = "644"
-        if isP4Exec(file["type"]):
-            mode = "755"
-        elif file["type"] == "symlink":
-            mode = "120000"
-            # p4 print on a symlink contains "target\n", so strip it off
+        (type_base, type_mods) = split_p4_type(file["type"])
+
+        git_mode = "100644"
+        if "x" in type_mods:
+            git_mode = "100755"
+        if type_base == "symlink":
+            git_mode = "120000"
+            # p4 print on a symlink contains "target\n"; remove the newline
             data = ''.join(contents)
             contents = [data[:-1]]
 
-        if file['type'].startswith("utf16"):
+        if type_base == "utf16":
             # p4 delivers different text in the python output to -G
             # than it does when using "print -o", or normal p4 client
             # operations.  utf16 is converted to ascii or utf8, perhaps.
@@ -1247,7 +1277,9 @@ class P4Sync(Command, P4UserMap):
             text = p4_read_pipe('print -q -o - "%s"' % file['depotFile'])
             contents = [ text ]
 
-        if self.isWindows and file["type"].endswith("text"):
+        # Perhaps windows wants unicode, utf16 newlines translated too;
+        # but this is not doing it.
+        if self.isWindows and type_base == "text":
             mangled = []
             for data in contents:
                 data = data.replace("\r\n", "\n")
@@ -1256,12 +1288,13 @@ class P4Sync(Command, P4UserMap):
 
         # Note that we do not try to de-mangle keywords on utf16 files,
         # even though in theory somebody may want that.
-        if file['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
-            contents = map(lambda text: re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text), contents)
-        elif file['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
-            contents = map(lambda text: re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$',r'$\1$', text), contents)
+        if type_base in ("text", "unicode", "binary"):
+            if "ko" in type_mods:
+                contents = map(lambda text: re.sub(r'(?i)\$(Id|Header):[^$]*\$', r'$\1$', text), contents)
+            elif "k" in type_mods:
+                contents = map(lambda text: re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$', r'$\1$', text), contents)
 
-        self.gitStream.write("M %s inline %s\n" % (mode, relPath))
+        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
 
         # total length...
         length = 0
-- 
1.7.6.3
