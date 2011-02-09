From: Ian Wienand <ianw@vmware.com>
Subject: Re: [PATCH] Support different branch layouts in git-p4
Date: Tue, 08 Feb 2011 19:46:51 -0800
Message-ID: <4D520E2B.2080200@vmware.com>
References: <4D489068.2040704@vmware.com>	<AANLkTi=ozDk9SqYaYWKHXSjVChV-93-88F_LUCwfSiDc@mail.gmail.com>	<4D4F3738.7010603@vmware.com> <AANLkTimGKc4MTwb=AnZ_Bv1EGS7yfgrFupxBOVVSm4s8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 04:46:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn117-0004BC-Cf
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 04:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239Ab1BIDqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 22:46:52 -0500
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:24939 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756227Ab1BIDqv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 22:46:51 -0500
Received: from mailhost3.vmware.com (mailhost3.vmware.com [10.16.27.45])
	by smtp-outbound-1.vmware.com (Postfix) with ESMTP id 389435000;
	Tue,  8 Feb 2011 19:46:51 -0800 (PST)
Received: from [10.20.123.85] (coopers.eng.vmware.com [10.20.123.85])
	by mailhost3.vmware.com (Postfix) with ESMTP id 2E3BCCD9AF;
	Tue,  8 Feb 2011 19:46:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Iceowl/1.0b1 Icedove/3.0.11
In-Reply-To: <AANLkTimGKc4MTwb=AnZ_Bv1EGS7yfgrFupxBOVVSm4s8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166389>

Thanks for the review

On 07/02/11 15:27, Tor Arvid Lund wrote:
> I'm just guessing from memory regarding these patterns, but assuming
> that the section separator is exactly the string '... ' seems risky,
> no? :)

Good point.  If we go past the end of the depot ...'s, then the rest
of the line strip()ed should just be the client I guess.
 
> What if a line doesn't end with "..." ? Maybe add an "if cv_index>= 0"

I think it would mess us up.  I put in a failure case for this.

On 07/02/11 17:22, Pete Wyckoff wrote:
> If you look at "p4 help views", they have lots of oddities
> that in theory should be accounted for here.  It doesn't
> even mention the thing about quotes, but obviously that is
> supported.  Wildcards ... and * can appear multiple
> times.  And %%[1-9] can be used to reorder the path.  Also the
> order of lines matters, and "+" can be used to merge entries.
> Whew.

Those %%'s would also mess us up, I put in an escape hatch for that
too.

I'm pretty sure this covers the majority of cases; if people have
really weird clients I guess they're going to have to do some more
work to get git-p4 to recognise it properly.  Personally, I struggle
to see why it is a feature to have every user re-organsing their views
of the tree -- it seems to move a lot of uncaptured state to the
client side.  anyway...

So here's another version; I agree some testing would be good as I've
only run it locally on //depot/proj/branch clients

-i

---

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..3304f36 100755
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
+                    if re.match('\%\%d', v) != None:
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
 
