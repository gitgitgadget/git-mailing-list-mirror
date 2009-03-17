From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 workflow suggestions?
Date: Tue, 17 Mar 2009 08:18:15 -0700
Message-ID: <20090317151815.GA2451@padd.com>
References: <20090309142108.GK12880@zoy.org> <20090311125805.GA28155@padd.com> <20090316180108.GE27280@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 16:19:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljb4B-0004HQ-QV
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbZCQPRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 11:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753687AbZCQPRZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:17:25 -0400
Received: from marge.padd.com ([99.188.165.110]:57123 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbZCQPRY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 11:17:24 -0400
Received: from honk.padd.com (honk.padd.com [209.17.171.228])
	by marge.padd.com (Postfix) with ESMTPSA id 91E7F10F81C7;
	Tue, 17 Mar 2009 08:17:22 -0700 (PDT)
Received: by honk.padd.com (Postfix, from userid 7770)
	id C99F51C400CE; Tue, 17 Mar 2009 08:18:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090316180108.GE27280@zoy.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113478>

sam@zoy.org wrote on Mon, 16 Mar 2009 19:01 +0100:
>    Yes, like this. More precisely:
> 
>     //work/framework/example/... //client/...
>     //work/project1/src/...  //client/src/...
>     //work/project1/include/...  //client/include/...
[..]
>    My changes are extremely messy but I will refactor them as time goes.
> There is at least one other important thing my git-p4 does, which is not
> storing the whole commit in memory. Combined with the patches I sent
> last week to this list, it's the only way I can import the p4 repository
> we have at work. (See http://zoy.org/~sam/git/clumsily-hacked-git-p4)

Oh, that is, ahem, a bit site-specific.  The looping over chunks in
the import phase is important, and other people have been thinking
about that.  I'll ignore that aspect for now, though, and we'll see
if we can get the client-spec part worked out.

Can you take a look at the attached.  Its goal is purely to allow
you to clone a complex spec like yours above.  You may have to merge
this in with your perrformance changes.

Edit your ~/.gitconfig to add a section:

	[git-p4]
		useClientSpec = true

Then copy a good P4ENV from a p4 client that has a client spec
checked out as you like.  git-p4 clone will do "p4 client -o",
reading that spec, and use the results to import, hopefully as
you have things laid out in the spec.

If this seems to work for you, we can figure out how to clean up
the patch so it can be used generally by people with and without
client specs.

		-- Pete

---------
From 4a922efcef18e3bb740f88c31ed4d00fa66f4cce Mon Sep 17 00:00:00 2001
From: Pete Wyckoff <petew@netapp.com>
Date: Wed, 26 Nov 2008 12:28:09 -0500
Subject: [PATCH] honor git client spec

Destination directories for parts of the depot are specified in the
client spec.  Use them as given.  Also read the entire client spec to
figure out what to do.
---
 contrib/fast-import/git-p4 |  110 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 332c7f8..d953a1e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -451,6 +451,26 @@ def p4ChangesForPaths(depotPaths, changeRange):
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
@@ -959,8 +979,9 @@ class P4Sync(Command):
             includeFile = True
             for val in self.clientSpecDirs:
                 if f['path'].startswith(val[0]):
-                    if val[1] <= 0:
+                    if val[1] == '-':
                         includeFile = False
+		    f['pathmap'] = val
                     break
 
             if includeFile:
@@ -1056,7 +1077,12 @@ class P4Sync(Command):
                 print "\nfile %s is a strange apple file that forks. Ignoring!" % file['path']
                 continue
 
-            relPath = self.stripRepoPath(file['path'], branchPrefixes)
+	    if 'pathmap' in file:
+		relPath = file['pathmap'][1] + file['path'][len(file['pathmap'][0]):]
+	    else:
+		relPath = self.stripRepoPath(file['path'], branchPrefixes)
+
+	    print "path", file['path'], "->", relPath
             if file["action"] in ("delete", "purge"):
                 self.gitStream.write("D %s\n" % relPath)
             else:
@@ -1439,24 +1465,54 @@ class P4Sync(Command):
 
 
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
@@ -1718,7 +1774,7 @@ class P4Clone(P4Sync):
     def __init__(self):
         P4Sync.__init__(self)
         self.description = "Creates a new git repository and imports from Perforce into it"
-        self.usage = "usage: %prog [options] //depot/path[@revRange]"
+        self.usage = "usage: %prog [options] [//depot/path[@revRange]]"
         self.options += [
             optparse.make_option("--destination", dest="cloneDestination",
                                  action='store', default=None,
@@ -1746,18 +1802,26 @@ class P4Clone(P4Sync):
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
1.6.0.6
