From: Pete Wyckoff <pw@padd.com>
Subject: Re: P4 Sync problem
Date: Sun, 15 Nov 2009 08:00:22 -0500
Message-ID: <20091115130022.GA20136@arf.padd.com>
References: <loom.20091110T145046-137@post.gmane.org>
 <1a6be5fa0911110043i63b5c032s7924f9f1cdfe32ee@mail.gmail.com>
 <loom.20091111T100646-406@post.gmane.org>
 <1a6be5fa0911110400l1fe931afmbb53ceba8704e029@mail.gmail.com>
 <loom.20091111T131837-901@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 14:10:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9erm-0001Df-N1
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 14:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbZKONJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 08:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbZKONJy
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 08:09:54 -0500
Received: from adsl-99-93-132-94.dsl.pltn13.sbcglobal.net ([99.93.132.94]:39965
	"EHLO marge.padd.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZKONJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 08:09:53 -0500
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2009 08:09:53 EST
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by marge.padd.com (Postfix) with ESMTPSA id B1F4B121A26B;
	Sun, 15 Nov 2009 05:00:44 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BDB5831D38; Sun, 15 Nov 2009 08:00:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <loom.20091111T131837-901@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132935>

divis1969@gmail.com wrote on Wed, 11 Nov 2009 12:39 +0000:
> i would propose to use both command-line arguments and a client spec 
> to create a correct filter of what should be synced/cloned.
> BTW, it looks this script does not honor neither the order of paths 
> in the spec (which can be important) nor mapping of the files to a local tree.

Here's a hack that I've been using to at least read the repo
locations out of the client spec.  In the useclientspec case, it
takes all the info on paths from an existing p4 client spec.  No
command line argument to git p4 sync.  Hack out the test for P4ENV;
that is site specific for me.

We've moved away from using client specs with more than 1 line, so
I'm not interested in this patch anymore.  Also, the long term
solution will probably be based on the foreign remote work that
Daniel and others are doing, so don't invest too much time in fixing
this up.  That said, if there is a clean way to support both your
client specs and how Tor and others use them, it is worth putting
in now.

Good luck.

		-- Pete

>From 55e8f6323894031119c755f2c3b3214c1c74b824 Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <pw@padd.com>
Date: Wed, 26 Nov 2008 12:28:09 -0500
Subject: [PATCH] honor git client spec

Destination directories for parts of the depot are specified in the
client spec.  Use them as given.  Also read the entire client spec to
figure out what to do.
---
 contrib/fast-import/git-p4 |  108 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 86 insertions(+), 22 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 1cecae2..28fa95f 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -456,6 +456,26 @@ def p4ChangesForPaths(depotPaths, changeRange):
     changelist.sort()
     return changelist
 
+#
+# Sort by number of slashes first:  more specific at the top.  Then
+# sort by alpha within a given number of path components.
+#
+def clientSortFunc(a, b):
+    asrc = a[0]
+    bsrc = b[0]
+    asrclen = asrc.count("/")
+    bsrclen = bsrc.count("/")
+    if asrclen > bsrclen:
+	return -1
+    elif asrclen < bsrclen:
+	return 1
+    elif asrc > bsrc:
+	return 1
+    elif asrc < bsrc:
+	return -1
+    else:
+	return 0
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -915,6 +935,11 @@ class P4Sync(Command):
         return files
 
     def stripRepoPath(self, path, prefixes):
+	if self.clientSpecDirs:
+	    for val in self.clientSpecDirs:
+		if path.startswith(val[0]):
+		    return val[1] + path[len(val[0]):]
+
         if self.keepRepoPath:
             prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
 
@@ -1038,7 +1063,7 @@ class P4Sync(Command):
             includeFile = True
             for val in self.clientSpecDirs:
                 if f['path'].startswith(val[0]):
-                    if val[1] <= 0:
+                    if val[1] == '-':
                         includeFile = False
                     break
 
@@ -1115,6 +1140,7 @@ class P4Sync(Command):
             self.gitStream.write("from %s\n" % parent)
 
         self.streamP4Files(new_files)
+
         self.gitStream.write("\n")
 
         change = int(details["change"])
@@ -1476,24 +1502,54 @@ class P4Sync(Command):
 
 
     def getClientSpec(self):
-        specList = p4CmdList( "client -o" )
+        specList = p4CmdList("client -o")
         temp = {}
+	client = ""
+        for entry in specList:
+            for k,v in entry.iteritems():
+		if k.startswith("Client"):
+		    client = v
+		    print "client is", client
+	if not client:
+	    sys.stderr.write("no client found\n")
+	    sys.exit(1)
+	client = "//" + client + "/"
         for entry in specList:
             for k,v in entry.iteritems():
                 if k.startswith("View"):
-                    if v.startswith('"'):
-                        start = 1
-                    else:
-                        start = 0
-                    index = v.find("...")
-                    v = v[start:index]
-                    if v.startswith("-"):
-                        v = v[1:]
-                        temp[v] = -len(v)
-                    else:
-                        temp[v] = len(v)
-        self.clientSpecDirs = temp.items()
-        self.clientSpecDirs.sort( lambda x, y: abs( y[1] ) - abs( x[1] ) )
+		    if v.startswith('"'):
+			v = v[1:]
+		    if v.endswith('"'):
+			v = v[:-1]
+		    d = v.split(" ");
+		    if len(d) != 2:
+			sys.stderr.write( \
+			    "expecting two fields in view, got: %s\n" % v)
+			sys.exit(1)
+		    if not d[0].endswith("..."):
+			sys.stderr.write(\
+			    "expecting trailing ..., got: %s\n" % d[0])
+			sys.exit(1)
+		    d[0] = d[0][:-3]
+		    if not d[1].endswith("..."):
+			sys.stderr.write(\
+			    "expecting trailing ..., got: %s\n" % d[1])
+			sys.exit(1)
+		    d[1] = d[1][:-3]
+		    if not d[1].startswith(client):
+			sys.stderr.write(\
+			    "expecting dest to start with %s, got: %s\n" % \
+			    (client, d[1]))
+			sys.exit(1)
+		    d[1] = d[1][len(client):]
+		    # negated items do not appear in tree
+		    if d[0].startswith("-"):
+			d[0] = d[0][1:]
+			d[1] = ""
+		    temp[d[0]] = d[1]
+
+	self.clientSpecDirs = temp.items()
+	self.clientSpecDirs.sort(clientSortFunc)
 
     def run(self, args):
         self.depotPaths = []
@@ -1755,7 +1811,7 @@ class P4Clone(P4Sync):
     def __init__(self):
         P4Sync.__init__(self)
         self.description = "Creates a new git repository and imports from Perforce into it"
-        self.usage = "usage: %prog [options] //depot/path[@revRange]"
+        self.usage = "usage: %prog [options] [//depot/path[@revRange]]"
         self.options += [
             optparse.make_option("--destination", dest="cloneDestination",
                                  action='store', default=None,
@@ -1783,18 +1839,26 @@ class P4Clone(P4Sync):
         return os.path.split(depotDir)[1]
 
     def run(self, args):
-        if len(args) < 1:
-            return False
-
         if self.keepRepoPath and not self.cloneDestination:
             sys.stderr.write("Must specify destination for --keep-path\n")
             sys.exit(1)
 
         depotPaths = args
 
-        if not self.cloneDestination and len(depotPaths) > 1:
-            self.cloneDestination = depotPaths[-1]
-            depotPaths = depotPaths[:-1]
+	if gitConfig("git-p4.useclientspec") == "true":
+	    if not os.path.exists("P4ENV"):
+		sys.stderr.write("Must copy P4ENV file from a valid client\n")
+		sys.exit(1)
+	    self.getClientSpec()
+	    if not depotPaths:
+		depotPaths = [p[0] for p in self.clientSpecDirs]
+	else:
+	    if not depotPaths:
+		sys.stderr.write("Must specify depot path if no client spec\n")
+		sys.exit(1)
+
+        if not self.cloneDestination:
+		self.cloneDestination = "."
 
         self.cloneExclude = ["/"+p for p in self.cloneExclude]
         for p in depotPaths:
-- 
1.6.2.5
