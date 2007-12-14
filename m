From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] Make generic --message/--file/--save-template flags
Date: Fri, 14 Dec 2007 07:25:21 +0100
Message-ID: <20071214062521.29148.66456.stgit@yoghurt>
References: <20071214062251.29148.86191.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33zc-0001zI-Hd
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbXLNGZ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbXLNGZ3
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:25:29 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3015 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbXLNGZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:25:27 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J33z6-0002it-00; Fri, 14 Dec 2007 06:25:20 +0000
In-Reply-To: <20071214062251.29148.86191.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68238>

And let "stg edit" use them.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/edit.py |   77 +++++++++++++++++++---------------------=
--------
 stgit/utils.py         |   45 ++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 47 deletions(-)


diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index 65b54d9..b9699d5 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -61,8 +61,6 @@ directory =3D DirectoryGotoToplevel()
 options =3D [make_option('-d', '--diff',
                        help =3D 'edit the patch diff',
                        action =3D 'store_true'),
-           make_option('-f', '--file',
-                       help =3D 'use FILE instead of invoking the edit=
or'),
            make_option('-O', '--diff-opts',
                        help =3D 'options to pass to git-diff'),
            make_option('--undo',
@@ -70,10 +68,6 @@ options =3D [make_option('-d', '--diff',
                        action =3D 'store_true'),
            make_option('-a', '--annotate', metavar =3D 'NOTE',
                        help =3D 'annotate the patch log entry'),
-           make_option('-m', '--message',
-                       help =3D 'replace the patch description with ME=
SSAGE'),
-           make_option('--save-template', metavar =3D 'FILE',
-                       help =3D 'save the patch to FILE in the format =
used by -f'),
            make_option('--author', metavar =3D '"NAME <EMAIL>"',
                        help =3D 'replae the author details with "NAME =
<EMAIL>"'),
            make_option('--authname',
@@ -86,47 +80,48 @@ options =3D [make_option('-d', '--diff',
                        help =3D 'replace the committer name with COMMN=
AME'),
            make_option('--commemail',
                        help =3D 'replace the committer e-mail with COM=
MEMAIL')
-           ] + make_sign_options()
+           ] + make_sign_options() + make_message_options()
=20
-def __update_patch(pname, fname, options):
-    """Update the current patch from the given file.
+def __update_patch(pname, text, options):
+    """Update the current patch from the given text.
     """
     patch =3D crt_series.get_patch(pname)
=20
     bottom =3D patch.get_bottom()
     top =3D patch.get_top()
=20
-    if fname =3D=3D '-':
-        f =3D sys.stdin
-    else:
-        f =3D open(fname)
-    (message, author_name, author_email, author_date, diff
-     ) =3D parse_patch(f.read())
-    f.close()
+    message, author_name, author_email, author_date, diff =3D parse_pa=
tch(text)
=20
     out.start('Updating patch "%s"' % pname)
=20
     if options.diff:
         git.switch(bottom)
         try:
-            git.apply_patch(fname)
+            git.apply_patch(diff =3D diff)
         except:
             # avoid inconsistent repository state
             git.switch(top)
             raise
=20
+    def c(a, b):
+        if a !=3D None:
+            return a
+        return b
     crt_series.refresh_patch(message =3D message,
-                             author_name =3D author_name,
-                             author_email =3D author_email,
-                             author_date =3D author_date,
-                             backup =3D True, log =3D 'edit')
+                             author_name =3D c(options.authname, autho=
r_name),
+                             author_email =3D c(options.authemail, aut=
hor_email),
+                             author_date =3D c(options.authdate, autho=
r_date),
+                             committer_name =3D options.commname,
+                             committer_email =3D options.commemail,
+                             backup =3D True, sign_str =3D options.sig=
n_str,
+                             log =3D 'edit', notes =3D options.annotat=
e)
=20
     if crt_series.empty_patch(pname):
         out.done('empty patch')
     else:
         out.done()
=20
-def __generate_file(pname, fname, options):
+def __generate_file(pname, write_fn, options):
     """Generate a file containing the description to edit
     """
     patch =3D crt_series.get_patch(pname)
@@ -175,12 +170,7 @@ def __generate_file(pname, fname, options):
     text =3D tmpl % tmpl_dict
=20
     # write the file to be edited
-    if fname =3D=3D '-':
-        sys.stdout.write(text)
-    else:
-        f =3D open(fname, 'w+')
-        f.write(text)
-        f.close()
+    write_fn(text)
=20
 def __edit_update_patch(pname, options):
     """Edit the given patch interactively.
@@ -189,13 +179,17 @@ def __edit_update_patch(pname, options):
         fname =3D '.stgit-edit.diff'
     else:
         fname =3D '.stgit-edit.txt'
+    def write_fn(text):
+        f =3D file(fname, 'w')
+        f.write(text)
+        f.close()
=20
-    __generate_file(pname, fname, options)
+    __generate_file(pname, write_fn, options)
=20
     # invoke the editor
     call_editor(fname)
=20
-    __update_patch(pname, fname, options)
+    __update_patch(pname, file(fname).read(), options)
=20
 def func(parser, options, args):
     """Edit the given patch or the current one.
@@ -232,25 +226,14 @@ def func(parser, options, args):
         out.start('Undoing the editing of "%s"' % pname)
         crt_series.undo_refresh()
         out.done()
-    elif options.message or options.authname or options.authemail \
-             or options.authdate or options.commname or options.commem=
ail \
-             or options.sign_str:
-        # just refresh the patch with the given information
-        out.start('Updating patch "%s"' % pname)
-        crt_series.refresh_patch(message =3D options.message,
-                                 author_name =3D options.authname,
-                                 author_email =3D options.authemail,
-                                 author_date =3D options.authdate,
-                                 committer_name =3D options.commname,
-                                 committer_email =3D options.commemail=
,
-                                 backup =3D True, sign_str =3D options=
=2Esign_str,
-                                 log =3D 'edit',
-                                 notes =3D options.annotate)
-        out.done()
     elif options.save_template:
         __generate_file(pname, options.save_template, options)
-    elif options.file:
-        __update_patch(pname, options.file, options)
+    elif any([options.message, options.authname, options.authemail,
+              options.authdate, options.commname, options.commemail,
+              options.sign_str]):
+        out.start('Updating patch "%s"' % pname)
+        __update_patch(pname, options.message, options)
+        out.done()
     else:
         __edit_update_patch(pname, options)
=20
diff --git a/stgit/utils.py b/stgit/utils.py
index 3a480c0..837c6c2 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -256,3 +256,48 @@ def add_sign_line(desc, sign_str, name, email):
     if not any(s in desc for s in ['\nSigned-off-by:', '\nAcked-by:'])=
:
         desc =3D desc + '\n'
     return '%s\n%s\n' % (desc, sign_str)
+
+def make_message_options():
+    def no_dup(parser):
+        if parser.values.message !=3D None:
+            raise optparse.OptionValueError(
+                'Cannot give more than one --message or --file')
+    def no_combine(parser):
+        if (parser.values.message !=3D None
+            and parser.values.save_template !=3D None):
+            raise optparse.OptionValueError(
+                'Cannot give both --message/--file and --save-template=
')
+    def msg_callback(option, opt_str, value, parser):
+        no_dup(parser)
+        parser.values.message =3D value
+        no_combine(parser)
+    def file_callback(option, opt_str, value, parser):
+        no_dup(parser)
+        if value =3D=3D '-':
+            parser.values.message =3D sys.stdin.read()
+        else:
+            f =3D file(value)
+            parser.values.message =3D f.read()
+            f.close()
+        no_combine(parser)
+    def templ_callback(option, opt_str, value, parser):
+        if value =3D=3D '-':
+            def w(s):
+                sys.stdout.write(s)
+        else:
+            def w(s):
+                f =3D file(value, 'w+')
+                f.write(s)
+                f.close()
+        parser.values.save_template =3D w
+        no_combine(parser)
+    m =3D optparse.make_option
+    return [m('-m', '--message', action =3D 'callback', callback =3D m=
sg_callback,
+              dest =3D 'message', type =3D 'string',
+              help =3D 'use MESSAGE instead of invoking the editor'),
+            m('-f', '--file', action =3D 'callback', callback =3D file=
_callback,
+              dest =3D 'message', type =3D 'string', metavar =3D 'FILE=
',
+              help =3D 'use FILE instead of invoking the editor'),
+            m('--save-template', action =3D 'callback', callback =3D t=
empl_callback,
+              metavar =3D 'FILE', dest =3D 'save_template', type =3D '=
string',
+              help =3D 'save the message template to FILE and exit')]
