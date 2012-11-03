From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git p4: catch p4 describe errors
Date: Sat, 3 Nov 2012 19:07:01 -0400
Message-ID: <20121103230701.GA11267@padd.com>
References: <1351593879401-7570219.post@n2.nabble.com>
 <20121103140946.GB4651@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arthur <a.foulon@amesys.fr>, Matt Arsenault <arsenm2@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 00:07:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUmoB-0003JP-Rf
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 00:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab2KCXHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 19:07:06 -0400
Received: from honk.padd.com ([74.3.171.149]:47274 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab2KCXHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 19:07:04 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 4C7F1D27;
	Sat,  3 Nov 2012 16:07:03 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1102522B90; Sat,  3 Nov 2012 19:07:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20121103140946.GB4651@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208985>

Group the two calls to "p4 describe" into a new helper function,
and try to validate the p4 results.  The current behavior when p4
describe fails is to die with a python backtrace.  The new behavior
will print the full response.

Based-on-patch-by: Matt Arsenault <arsenm2@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---

Arthur and Matt, you've both had intermittent "p4 describe"
errors.  I've not been able to repeat this or come up with
a possible root cause.  But it is clear that the error handling
in this area is weak.

Can you continue using git-p4 with this patch applied?  If
it fails again, at least we'll get some interesting output.

This is appropriate for upstream too, since it should do no harm
and might flush out a bug at some point.  It includes "-s" on
both p4 describe calls now as Matt suggested.

		-- Pete

 git-p4.py | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 882b1bb..e51a081 100755
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
1.7.12.1.457.g468b3ef
