From: Ian Wienand <ianw@vmware.com>
Subject: [PATCH] Obey p4 views when using client spec
Date: Fri, 11 Feb 2011 16:33:48 -0800
Message-ID: <4D55D56C.6050207@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tor Arvid Lund <torarvid@gmail.com>, Pete Wyckoff <pw@padd.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 12 01:34:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po3Rw-0007fT-GD
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 01:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060Ab1BLAeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 19:34:44 -0500
Received: from [65.115.85.73] ([65.115.85.73]:55438 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755684Ab1BLAeo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 19:34:44 -0500
Received: from mailhost3.vmware.com (mailhost3.vmware.com [10.16.27.45])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id CDCAF6012;
	Fri, 11 Feb 2011 16:33:48 -0800 (PST)
Received: from [10.20.120.121] (promd-2n-dhcp121.eng.vmware.com [10.20.120.121])
	by mailhost3.vmware.com (Postfix) with ESMTP id ABD38CD9B8;
	Fri, 11 Feb 2011 16:33:48 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166581>

When using the p4 client spec, this attempts to obey the client's
output preferences.

For example, a view like

//depot/foo/branch/... //client/branch/foo/...
//depot/bar/branch/... //client/branch/bar/...

will result in a directory layout in the git tree of

branch/
branch/foo
branch/bar

p4 can do various other reordering that this change doesn't support,
but we should detect it and at least fail nicely.

Signed-off-by: Ian Wienand <ianw@vmware.com>
---
 contrib/fast-import/git-p4     |   50 ++++++++++++++++++++++++++++++++++++---
 contrib/fast-import/git-p4.txt |    5 ++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..a92beb6 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -910,6 +910,22 @@ class P4Sync(Command):
         return files
 
     def stripRepoPath(self, path, prefixes):
+        if self.useClientSpec:
+
+            # if using the client spec, we use the output directory
+            # specified in the client.  For example, a view
+            #   //depot/foo/branch/... //client/branch/foo/...
+            # will end up putting all foo/branch files into
+            #  branch/foo/
+            for val in self.clientSpecDirs:
+                if path.startswith(val[0]):
+                    # replace the depot path with the client path
+                    path = path.replace(val[0], val[1][1])
+                    # now strip out the client (//client/...)
+                    path = re.sub("^(//[^/]+/)", '', path)
+                    # the rest is all path
+                    return path
+
         if self.keepRepoPath:
             prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
 
@@ -1032,7 +1048,7 @@ class P4Sync(Command):
             includeFile = True
             for val in self.clientSpecDirs:
                 if f['path'].startswith(val[0]):
-                    if val[1] <= 0:
+                    if val[1][0] <= 0:
                         includeFile = False
                     break
 
@@ -1475,19 +1491,45 @@ class P4Sync(Command):
         for entry in specList:
             for k,v in entry.iteritems():
                 if k.startswith("View"):
+
+                    # p4 has these %%1 to %%9 arguments in specs to
+                    # reorder paths; which we can't handle (yet :)
+                    if re.match('%%\d', v) != None:
+                        print "Sorry, can't handle %%n arguments in client specs"
+                        sys.exit(1)
+
                     if v.startswith('"'):
                         start = 1
                     else:
                         start = 0
                     index = v.find("...")
+
+                    # save the "client view"; i.e the RHS of the view
+                    # line that tells the client where to put the
+                    # files for this view.
+                    cv = v[index+3:].strip() # +3 to remove previous '...'
+
+                    # if the client view doesn't end with a
+                    # ... wildcard, then we're going to mess up the
+                    # output directory, so fail gracefully.
+                    if not cv.endswith('...'):
+                        print 'Sorry, client view in "%s" needs to end with wildcard' % (k)
+                        sys.exit(1)
+                    cv=cv[:-3]
+
+                    # now save the view; +index means included, -index
+                    # means it should be filtered out.
                     v = v[start:index]
                     if v.startswith("-"):
                         v = v[1:]
-                        temp[v] = -len(v)
+                        include = -len(v)
                     else:
-                        temp[v] = len(v)
+                        include = len(v)
+
+                    temp[v] = (include, cv)
+
         self.clientSpecDirs = temp.items()
-        self.clientSpecDirs.sort( lambda x, y: abs( y[1] ) - abs( x[1] ) )
+        self.clientSpecDirs.sort( lambda x, y: abs( y[1][0] ) - abs( x[1][0] ) )
 
     def run(self, args):
         self.depotPaths = []
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 49b3359..e09da44 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -191,6 +191,11 @@ git-p4.useclientspec
 
   git config [--global] git-p4.useclientspec false
 
+The P4CLIENT environment variable should be correctly set for p4 to be
+able to find the relevant client.  This client spec will be used to
+both filter the files cloned by git and set the directory layout as
+specified in the client (this implies --keep-path style semantics).
+
 Implementation Details...
 =========================
 
-- 
1.7.3.2
