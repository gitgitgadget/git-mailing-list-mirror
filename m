From: Ian Wienand <ianw@vmware.com>
Subject: Re: [PATCH] Support different branch layouts in git-p4
Date: Sun, 06 Feb 2011 16:05:12 -0800
Message-ID: <4D4F3738.7010603@vmware.com>
References: <4D489068.2040704@vmware.com> <AANLkTi=ozDk9SqYaYWKHXSjVChV-93-88F_LUCwfSiDc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 01:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmEbZ-0007g2-Gu
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 01:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252Ab1BGAFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 19:05:13 -0500
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:38425 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754024Ab1BGAFN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Feb 2011 19:05:13 -0500
Received: from mailhost4.vmware.com (mailhost4.vmware.com [10.16.67.124])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id B50754;
	Sun,  6 Feb 2011 16:05:12 -0800 (PST)
Received: from [10.20.123.85] (coopers.eng.vmware.com [10.20.123.85])
	by mailhost4.vmware.com (Postfix) with ESMTP id ADA92C9C76;
	Sun,  6 Feb 2011 16:05:12 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Iceowl/1.0b1 Icedove/3.0.11
In-Reply-To: <AANLkTi=ozDk9SqYaYWKHXSjVChV-93-88F_LUCwfSiDc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166216>

Thanks for taking a look

On 04/02/11 16:37, Tor Arvid Lund wrote:
> For starters, I don't think that I like git-p4 being taught to solve
> problems that seem to be caused by a poor/unfortunate perforce layout.

I do think this //depot/project/branch type layout is pretty typical,
although I admit I don't have a lot of experience with alternative p4
setups.

> A solution which I think would work well for everyone, is if files
> would be placed according to the right-hand patterns in the
> client-spec.

I did consider this at first.  My only issue is that it is a bit
confusing to use the client spec for filtering (and in this case
re-writing), but not for actually selecting the depots to clone, which
I still need to replicate on the command line.  However that is a much
larger change.

What do you think of this one?

In this case, my client view is

//depot/project/branch/...  //client/branch/project/...
//depot/project2/branch/...  //client/branch/project2/...

and my git directory layout ends up as

branch/project/...
branch/project2/...

-i

---

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..eb9620c 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -878,6 +878,7 @@ class P4Sync(Command):
         self.cloneExclude = []
         self.useClientSpec = False
         self.clientSpecDirs = []
+        self.clientName = None
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -910,6 +911,22 @@ class P4Sync(Command):
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
 
@@ -1032,7 +1049,7 @@ class P4Sync(Command):
             includeFile = True
             for val in self.clientSpecDirs:
                 if f['path'].startswith(val[0]):
-                    if val[1] <= 0:
+                    if val[1][0] <= 0:
                         includeFile = False
                     break
 
@@ -1474,20 +1491,36 @@ class P4Sync(Command):
         temp = {}
         for entry in specList:
             for k,v in entry.iteritems():
+                if k.startswith("Client"):
+                    self.clientName = v
+            
                 if k.startswith("View"):
                     if v.startswith('"'):
                         start = 1
                     else:
                         start = 0
                     index = v.find("...")
+
+                    # save the "client view"; i.e the RHS of the view
+                    # line that tells the client where to put the
+                    # files for this view.
+                    cv = v[index+4:] # +4 to remove previous '... '
+                    cv_index = cv.find("...")
+                    cv=cv[:cv_index]
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
 
