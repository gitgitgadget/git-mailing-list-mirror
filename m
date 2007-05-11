From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/5] Make the "name" argument to "stg new" optional
Date: Fri, 11 May 2007 03:40:05 +0200
Message-ID: <20070511014004.13161.39982.stgit@yoghurt>
References: <20070511013400.13161.9160.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 03:47:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmKES-0005OB-VY
	for gcvg-git@gmane.org; Fri, 11 May 2007 03:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbXEKBrj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 May 2007 21:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756840AbXEKBrj
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 21:47:39 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:41807 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755239AbXEKBri (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 21:47:38 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:38577 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HmKEH-00082E-8U; Fri, 11 May 2007 03:47:37 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HmK73-0003TB-FO; Fri, 11 May 2007 03:40:05 +0200
In-Reply-To: <20070511013400.13161.9160.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HmKEH-00082E-8U.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HmKEH-00082E-8U b1bad257cf949d44565f71a42e6874ee
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46925>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

If no name is given, one is generated from the commit message. This
can be very handy.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 Documentation/stg-new.txt  |    5 +++--
 stgit/commands/common.py   |   25 -------------------------
 stgit/commands/new.py      |   15 +++++++++++----
 stgit/commands/pick.py     |    2 +-
 stgit/commands/uncommit.py |    3 +--
 stgit/stack.py             |   17 +++++++++++------
 stgit/utils.py             |   27 ++++++++++++++++++++++++++-
 t/t1003-new.sh             |   29 +++++++++++++++++++++++++++++
 8 files changed, 82 insertions(+), 41 deletions(-)

diff --git a/Documentation/stg-new.txt b/Documentation/stg-new.txt
index 009659a..fbf2f67 100644
--- a/Documentation/stg-new.txt
+++ b/Documentation/stg-new.txt
@@ -10,7 +10,7 @@ stg-new - stgdesc:new[]
 SYNOPSIS
 --------
 [verse]
-'stg' new [OPTIONS] <name>
+'stg' new [OPTIONS] [name]
=20
 DESCRIPTION
 -----------
@@ -22,7 +22,8 @@ tree are not included in the patch. A stglink:refresh=
[] command is
 needed for this.
=20
 The given <name> must be unique in the stack, and may only contain
-alphanumeric characters, dashes and underscores.
+alphanumeric characters, dashes and underscores. If no name is given,
+one is generated from the first line of the commit message.
=20
 An editor will be launched to edit the commit message to be used for
 the patch, unless the '--message' flag already specified one.  The
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 674d8c1..28026da 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -323,31 +323,6 @@ def address_or_alias(addr_str):
                  for addr in addr_str.split(',')]
     return ', '.join([addr for addr in addr_list if addr])
=20
-def patch_name_from_msg(msg):
-    """Return a string to be used as a patch name. This is generated
-    from the first 30 characters of the top line of the string passed
-    as argument."""
-    if not msg:
-        return None
-
-    subject_line =3D msg[:30].lstrip().split('\n', 1)[0].lower()
-    return re.sub('[\W]+', '-', subject_line).strip('-')
-
-def make_patch_name(msg, unacceptable, default_name =3D 'patch',
-                    alternative =3D True):
-    """Return a patch name generated from the given commit message,
-    guaranteed to make unacceptable(name) be false. If the commit
-    message is empty, base the name on default_name instead."""
-    patchname =3D patch_name_from_msg(msg)
-    if not patchname:
-        patchname =3D default_name
-    if alternative and unacceptable(patchname):
-        suffix =3D 0
-        while unacceptable('%s-%d' % (patchname, suffix)):
-            suffix +=3D 1
-        patchname =3D '%s-%d' % (patchname, suffix)
-    return patchname
-
 def prepare_rebase(real_rebase, force=3DNone):
     if not force:
         # Be sure we won't loose results of stg-(un)commit by error.
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 2c1e94b..f192e34 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -25,7 +25,7 @@ from stgit import stack, git
=20
=20
 help =3D 'create a new patch and make it the topmost one'
-usage =3D """%prog [options] <name>
+usage =3D """%prog [options] [name]
=20
 Create a new, empty patch and make it the topmost one. If the
 '--message' option is not passed, an editor is invoked with the
@@ -33,7 +33,10 @@ Create a new, empty patch and make it the topmost on=
e. If the
 /usr/share/stgit/templates/patchdescr.tmpl file used a as template,
 together with generated lines. By default, the local changes in the
 working tree are not included in the patch. A 'refresh' command is
-needed for this."""
+needed for this.
+
+If no name is given for the new patch, one is generated from the first
+line of the commit message."""
=20
 options =3D [make_option('-m', '--message',
                        help =3D 'use MESSAGE as the patch description'=
),
@@ -57,7 +60,11 @@ options =3D [make_option('-m', '--message',
 def func(parser, options, args):
     """Creates a new patch
     """
-    if len(args) !=3D 1:
+    if len(args) =3D=3D 0:
+        name =3D None # autogenerate a name
+    elif len(args) =3D=3D 1:
+        name =3D args[0]
+    else:
         parser.error('incorrect number of arguments')
=20
     check_conflicts()
@@ -66,7 +73,7 @@ def func(parser, options, args):
     if options.author:
         options.authname, options.authemail =3D name_email(options.aut=
hor)
=20
-    crt_series.new_patch(args[0], message =3D options.message,
+    crt_series.new_patch(name, message =3D options.message,
                          show_patch =3D options.showpatch,
                          author_name =3D options.authname,
                          author_email =3D options.authemail,
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index edd614d..75def2a 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -75,7 +75,7 @@ def func(parser, options, args):
         elif len(patch_branch) =3D=3D 2:
             patch =3D patch_branch[0]
         else:
-            patch =3D make_patch_name(commit.get_log(), crt_series.pat=
ch_exists)
+            patch =3D None
=20
     if options.parent:
         parent =3D git_id(options.parent)
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 462846c..04c7e52 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -95,8 +95,7 @@ def func(parser, options, args):
         if patchnames:
             patchname =3D patchnames[n]
         else:
-            patchname =3D make_patch_name(commit.get_log(),
-                                        crt_series.patch_exists)
+            patchname =3D None
=20
         crt_series.new_patch(patchname,
                              can_edit =3D False, before_existing =3D T=
rue,
diff --git a/stgit/stack.py b/stgit/stack.py
index 76704e8..d0008bc 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -777,20 +777,25 @@ class Series(StgitObject):
                   before_existing =3D False, refresh =3D True):
         """Creates a new patch
         """
-        self.__patch_name_valid(name)
=20
-        if self.patch_applied(name) or self.patch_unapplied(name):
-            raise StackException, 'Patch "%s" already exists' % name
+        if name !=3D None:
+            self.__patch_name_valid(name)
+            if self.patch_applied(name) or self.patch_unapplied(name):
+                raise StackException, 'Patch "%s" already exists' % na=
me
=20
         if not message and can_edit:
-            descr =3D edit_file(self, None, \
-                              'Please enter the description for patch =
"%s" ' \
-                              'above.' % name, show_patch)
+            descr =3D edit_file(
+                self, None,
+                'Please enter the description for the patch above.',
+                show_patch)
         else:
             descr =3D message
=20
         head =3D git.get_head()
=20
+        if name =3D=3D None:
+            name =3D make_patch_name(descr, self.patch_exists)
+
         patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
         patch.create()
=20
diff --git a/stgit/utils.py b/stgit/utils.py
index d04d077..18198c0 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -1,7 +1,7 @@
 """Common utility functions
 """
=20
-import errno, os, os.path, sys
+import errno, os, os.path, re, sys
 from stgit.config import config
=20
 __copyright__ =3D """
@@ -172,3 +172,28 @@ def call_editor(filename):
     if err:
         raise EditorException, 'editor failed, exit code: %d' % err
     print 'done'
+
+def patch_name_from_msg(msg):
+    """Return a string to be used as a patch name. This is generated
+    from the first 30 characters of the top line of the string passed
+    as argument."""
+    if not msg:
+        return None
+
+    subject_line =3D msg[:30].lstrip().split('\n', 1)[0].lower()
+    return re.sub('[\W]+', '-', subject_line).strip('-')
+
+def make_patch_name(msg, unacceptable, default_name =3D 'patch',
+                    alternative =3D True):
+    """Return a patch name generated from the given commit message,
+    guaranteed to make unacceptable(name) be false. If the commit
+    message is empty, base the name on default_name instead."""
+    patchname =3D patch_name_from_msg(msg)
+    if not patchname:
+        patchname =3D default_name
+    if alternative and unacceptable(patchname):
+        suffix =3D 0
+        while unacceptable('%s-%d' % (patchname, suffix)):
+            suffix +=3D 1
+        patchname =3D '%s-%d' % (patchname, suffix)
+    return patchname
diff --git a/t/t1003-new.sh b/t/t1003-new.sh
new file mode 100755
index 0000000..0be5d9b
--- /dev/null
+++ b/t/t1003-new.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Karl Hasselstr=C3=B6m
+#
+
+test_description=3D'Test the new command.
+
+'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'Initialize the StGIT repository' '
+    stg init
+'
+
+test_expect_success \
+    'Create a named patch' '
+    stg new foo -m foobar &&
+    [ $(stg applied -c) -eq 1 ]
+'
+
+test_expect_success \
+    'Create a patch without giving a name' '
+    stg new -m yo &&
+    [ $(stg applied -c) -eq 2 ]
+'
+
+test_done
