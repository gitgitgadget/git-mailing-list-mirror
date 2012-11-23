From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/6] git p4: catch p4 describe errors
Date: Fri, 23 Nov 2012 17:35:34 -0500
Message-ID: <1353710139-16207-2-git-send-email-pw@padd.com>
References: <1353710139-16207-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 23:36:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc1rA-0005EY-K0
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 23:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756715Ab2KWWgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 17:36:04 -0500
Received: from honk.padd.com ([74.3.171.149]:35226 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756322Ab2KWWgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 17:36:03 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 2E321E9A;
	Fri, 23 Nov 2012 14:36:02 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D672027578; Fri, 23 Nov 2012 17:35:59 -0500 (EST)
X-Mailer: git-send-email 1.8.0.360.gc68af86
In-Reply-To: <1353710139-16207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210275>

Group the two calls to "p4 describe" into a new helper function,
and try to validate the p4 results.  The current behavior when p4
describe fails is to die with a python backtrace.  The new behavior
will print the full response.

This does not solve any particular problem, but adds more
checking in hopes of narrowing down odd behavior seen on
at least two occasions.

Based-on-patch-by: Matt Arsenault <arsenm2@gmail.com>
Reported-by: Arthur <a.foulon@amesys.fr>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7d6c928..cd68e04 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -169,6 +169,29 @@ def p4_reopen(type, f):
 def p4_move(src, dest):
     p4_system(["move", "-k", wildcard_encode(src), wildcard_encode(dest)])
 
+def p4_describe(change):
+    """Make sure it returns a valid result by checking for
+       the presence of field "time".  Return a dict of the
+       results."""
+
+    ds = p4CmdList(["describe", "-s", str(change)])
+    if len(ds) != 1:
+        die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
+
+    d = ds[0]
+
+    if "p4ExitCode" in d:
+        die("p4 describe -s %d exited with %d: %s" % (change, d["p4ExitCode"],
+                                                      str(d)))
+    if "code" in d:
+        if d["code"] == "error":
+            die("p4 describe -s %d returned error code: %s" % (change, str(d)))
+
+    if "time" not in d:
+        die("p4 describe -s %d returned no \"time\": %s" % (change, str(d)))
+
+    return d
+
 #
 # Canonicalize the p4 type and return a tuple of the
 # base type, plus any modifiers.  See "p4 help filetypes"
@@ -2543,7 +2566,7 @@ class P4Sync(Command, P4UserMap):
     def importChanges(self, changes):
         cnt = 1
         for change in changes:
-            description = p4Cmd(["describe", str(change)])
+            description = p4_describe(change)
             self.updateOptionDict(description)
 
             if not self.silent:
@@ -2667,14 +2690,8 @@ class P4Sync(Command, P4UserMap):
 
         # Use time from top-most change so that all git p4 clones of
         # the same p4 repo have the same commit SHA1s.
-        res = p4CmdList("describe -s %d" % newestRevision)
-        newestTime = None
-        for r in res:
-            if r.has_key('time'):
-                newestTime = int(r['time'])
-        if newestTime is None:
-            die("\"describe -s\" on newest change %d did not give a time")
-        details["time"] = newestTime
+        res = p4_describe(newestRevision)
+        details["time"] = res["time"]
 
         self.updateOptionDict(details)
         try:
-- 
1.8.0.276.gd9397fc
