From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: [STG PATCH] add a --index option to refresh which takes the contents of the index as the new commit
Date: Tue, 8 Jan 2008 21:42:46 +0100
Message-ID: <200801082142.47060.kumbayo84@arcor.de>
References: <200712302003.33478.kumbayo84@arcor.de> <200801022039.27611.kumbayo84@arcor.de> <20080107105612.GA20981@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLHK-0003pg-Iz
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbYAHUl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 15:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYAHUl4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:41:56 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:33113 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752325AbYAHUly convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 15:41:54 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 2FB9A24ADB5;
	Tue,  8 Jan 2008 21:41:52 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 19088346CE6;
	Tue,  8 Jan 2008 21:41:52 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id A714F29D4ED;
	Tue,  8 Jan 2008 21:41:51 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080107105612.GA20981@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.2/5443/Tue Jan  8 18:35:47 2008 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69917>


This allows to stage only certain changes to a file by only adding
the desired parts to the index with git-gui, ugit, git add -i or anothe=
r tool
that manipulates the index and then run stg refresh --index
it also allows removing a file from a patch by running git reset HEAD^ =
-- file_to_remove
followed by a stg refresh --index

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---

On Montag 07 Januar 2008, Karl Hasselstr=F6m wrote:
> On 2008-01-02 20:39:27 +0100, Peter Oberndorfer wrote:
>=20
> > On Sonntag 30 Dezember 2007, Peter Oberndorfer wrote:
> >
> > > Do you think this would be a useful/good idea? Or do we want a
> > > separate command for removing files from a patch anyway?
> >
> > The question is still open if this is useful for somebody else.
>=20
> I think it's a useful addition. Thanks!
Good since it was useful for me too even while writing this patch :-)

> So the use_index parameter to refresh_patch is actually not necessary=
?
> In that case I'd rather you didn't add it, since the functions in
> stgit/stack.py have quite enough parameters already.
>=20
In the beginning i was afraid it would be to obscure to call it this wa=
y
with all parameters set to some specific values.
But having more parameters does not make it better :-)
Done
> > diff --git a/t/t2700-refresh.sh b/t/t2700-refresh.sh
> > index 2e7901c..9eae85d 100755
> > --- a/t/t2700-refresh.sh
> > +++ b/t/t2700-refresh.sh
>=20
> Bonus points for adding a test case!
>=20
> I still haven't rebased my patch stack since Catalin accepted most of
> it just before Christmas. Once I've gotten around to that, I'll take
> your patch -- hopefully by then updated to not add the exra argument
> to refresh_patch(). :-)
>=20

Patch now comes with a Signed-off-by and a log message that explains
how this feature could be used.
It was tested with the testcase, used during development of this patch
and on another repo, but still take care when using it :-)

 stgit/commands/refresh.py |   25 ++++++++++++++++---
 t/t2700-refresh.sh        |   57 +++++++++++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 6e8ed0c..952b1b6 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -45,6 +45,9 @@ options =3D [make_option('-f', '--force',
            make_option('--update',
                        help =3D 'only update the current patch files',
                        action =3D 'store_true'),
+           make_option('--index',
+                       help =3D 'use the current contents of the index=
 instead of looking at the working directory',
+                       action =3D 'store_true'),
            make_option('--undo',
                        help =3D 'revert the commit generated by the la=
st refresh',
                        action =3D 'store_true'),
@@ -76,6 +79,14 @@ def func(parser, options, args):
         if not patch:
             raise CmdException, 'No patches applied'
=20
+    if options.index:
+        if args or options.update:
+            raise CmdException, \
+                  'Only full refresh is available with the --index opt=
ion'
+        if options.patch:
+            raise CmdException, \
+                  '--patch is not compatible with the --index option'
+
     if not options.force:
         check_head_top_equal(crt_series)
=20
@@ -85,9 +96,10 @@ def func(parser, options, args):
         out.done()
         return
=20
-    files =3D [path for (stat, path) in git.tree_status(files =3D args=
, verbose =3D True)]
+    if not options.index:
+        files =3D [path for (stat, path) in git.tree_status(files =3D =
args, verbose =3D True)]
=20
-    if files or not crt_series.head_top_equal():
+    if options.index or files or not crt_series.head_top_equal():
         if options.patch:
             applied =3D crt_series.get_applied()
             between =3D applied[:applied.index(patch):-1]
@@ -105,8 +117,13 @@ def func(parser, options, args):
=20
         if autoresolved =3D=3D 'yes':
             resolved_all()
-        crt_series.refresh_patch(files =3D files,
-                                 backup =3D True, notes =3D options.an=
notate)
+
+        if options.index:
+            crt_series.refresh_patch(cache_update =3D False,
+                                     backup =3D True, notes =3D option=
s.annotate)
+        else:
+            crt_series.refresh_patch(files =3D files,
+                                     backup =3D True, notes =3D option=
s.annotate)
=20
         if crt_series.empty_patch(patch):
             out.done('empty patch')
diff --git a/t/t2700-refresh.sh b/t/t2700-refresh.sh
index 2e7901c..9eae85d 100755
--- a/t/t2700-refresh.sh
+++ b/t/t2700-refresh.sh
@@ -6,8 +6,10 @@ test_description=3D'Run "stg refresh"'
=20
 test_expect_success 'Initialize StGit stack' '
     stg init &&
-    echo expected.txt >> .git/info/exclude &&
+    echo expected*.txt >> .git/info/exclude &&
     echo patches.txt >> .git/info/exclude &&
+    echo show.txt >> .git/info/exclude &&
+    echo diff.txt >> .git/info/exclude &&
     stg new p0 -m "base" &&
     for i in 1 2 3; do
         echo base >> foo$i.txt &&
@@ -62,4 +64,57 @@ test_expect_success 'Refresh bottom patch' '
     diff -u expected.txt patches.txt
 '
=20
+cat > expected.txt <<EOF
+p0
+p1
+p4
+EOF
+cat > expected2.txt <<EOF
+diff --git a/foo1.txt b/foo1.txt
+index 728535d..6f34984 100644
+--- a/foo1.txt
++++ b/foo1.txt
+@@ -1,3 +1,4 @@
+ base
+ foo 1
+ bar 1
++baz 1
+EOF
+cat > expected3.txt <<EOF
+diff --git a/foo1.txt b/foo1.txt
+index 6f34984..a80eb63 100644
+--- a/foo1.txt
++++ b/foo1.txt
+@@ -2,3 +2,4 @@ base
+ foo 1
+ bar 1
+ baz 1
++blah 1
+diff --git a/foo2.txt b/foo2.txt
+index 415c9f5..43168f2 100644
+--- a/foo2.txt
++++ b/foo2.txt
+@@ -1,3 +1,4 @@
+ base
+ foo 2
+ bar 2
++baz 2
+EOF
+test_expect_success 'Refresh --index' '
+    stg status &&
+    stg new p4 -m "refresh_index" &&
+    echo baz 1 >> foo1.txt &&
+    git add foo1.txt &&
+    echo blah 1 >> foo1.txt &&
+    echo baz 2 >> foo2.txt &&
+    stg refresh --index &&
+    stg patches foo1.txt > patches.txt &&
+    git diff HEAD^..HEAD > show.txt &&
+    stg diff > diff.txt &&
+    diff -u expected.txt patches.txt &&
+    diff -u expected2.txt show.txt &&
+    diff -u expected3.txt diff.txt &&
+    stg new p5 -m "cleanup again" &&
+    stg refresh
+'
 test_done
--=20
1.5.4.rc2
