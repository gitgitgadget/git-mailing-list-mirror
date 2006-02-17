From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH] Handle branch names with slashes
Date: Fri, 17 Feb 2006 02:41:17 +0100
Message-ID: <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com>
References: <20060214173509.GA8666@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 02:42:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9uct-0003EV-Cw
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 02:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWBQBlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 20:41:25 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWBQBlY
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 20:41:24 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:19103 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750715AbWBQBlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 20:41:24 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060217014118.JNFR12400.mxfep01.bredband.com@backpacker.hemma.treskal.com>;
          Fri, 17 Feb 2006 02:41:18 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 767DE16AE;
	Fri, 17 Feb 2006 02:41:17 +0100 (CET)
To: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20060214173509.GA8666@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16319>

Let StGIT grok branch names with slashes in them. It used to fall flat
on its face when confronted with them.

I think I've covered all, or at least most cases, but there are
probably some bugs left if you look hard enough.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 stgit/commands/branch.py |    6 +++-
 stgit/git.py             |   12 +++++--
 stgit/stack.py           |   42 ++++++++++---------------
 stgit/utils.py           |   77 ++++++++++++++++++++++++++++++++++++++=
++------
 4 files changed, 97 insertions(+), 40 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index ef44349..d3e8a3c 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -173,7 +173,11 @@ def func(parser, options, args):
         if len(args) !=3D 0:
             parser.error('incorrect number of arguments')
=20
-        branches =3D os.listdir(os.path.join(git.get_base_dir(), 'refs=
', 'heads'))
+        branches =3D []
+        basepath =3D os.path.join(git.get_base_dir(), 'refs', 'heads')
+        for path, dirs, files in os.walk(basepath):
+            branches +=3D [remove_leading_dir(basepath, os.path.join(p=
ath, f))
+                         for f in files]
         branches.sort()
         max_len =3D max([len(i) for i in branches])
=20
diff --git a/stgit/git.py b/stgit/git.py
index 582e803..724b6fd 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -232,7 +232,8 @@ def get_head():
 def get_head_file():
     """Returns the name of the file pointed to by the HEAD link
     """
-    return os.path.basename(_output_one_line('git-symbolic-ref HEAD'))
+    return remove_leading_dir(os.path.join('refs', 'heads'),
+                              _output_one_line('git-symbolic-ref HEAD'=
))
=20
 def set_head_file(ref):
     """Resets HEAD to point to a new ref
@@ -325,7 +326,9 @@ def delete_branch(name):
     branch_head =3D os.path.join('refs', 'heads', name)
     if not branch_exists(branch_head):
         raise GitException, 'Branch "%s" does not exist' % name
-    os.remove(os.path.join(get_base_dir(), branch_head))
+    base =3D get_base_dir()
+    rm_file_and_dirs(os.path.join(base, branch_head),
+                     os.path.join(base, 'refs', 'heads'))
=20
 def rename_branch(from_name, to_name):
     """Rename a git branch
@@ -339,8 +342,9 @@ def rename_branch(from_name, to_name):
=20
     if get_head_file() =3D=3D from_name:
         set_head_file(to_head)
-    os.rename(os.path.join(get_base_dir(), from_head), \
-              os.path.join(get_base_dir(), to_head))
+    base =3D os.path.join(get_base_dir())
+    rename_dirs(os.path.join(base, from_head), os.path.join(base, to_h=
ead),
+                os.path.join(base, 'refs', 'heads'))
=20
 def add(names):
     """Add the files or recursively add the directory contents
diff --git a/stgit/stack.py b/stgit/stack.py
index 556c40e..68a2936 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -406,7 +406,7 @@ class Series:
         """
         if len(self.get_applied()) =3D=3D 0:
             head =3D git.get_head()
-            write_string(self.__base_file, head)
+            write_string(self.__base_file, head, mkdir =3D True)
=20
     def __end_stack_check(self):
         """Remove .git/refs/heads/base if the stack is empty.
@@ -499,9 +499,11 @@ class Series:
         git.rename_branch(self.__name, to_name)
=20
         if os.path.isdir(self.__series_dir):
-            os.rename(self.__series_dir, to_stack.__series_dir)
+            rename_dirs(self.__series_dir, to_stack.__series_dir,
+                        os.path.join(self.__base_dir, 'patches'))
         if os.path.exists(self.__base_file):
-            os.rename(self.__base_file, to_stack.__base_file)
+            rename_dirs(self.__base_file, to_stack.__base_file,
+                        os.path.join(self.__base_dir, 'refs', 'bases')=
)
=20
         self.__init__(to_name)
=20
@@ -543,29 +545,19 @@ class Series:
             for p in patches:
                 Patch(p, self.__patch_dir, self.__refs_dir).delete()
=20
-            if os.path.exists(self.__applied_file):
-                os.remove(self.__applied_file)
-            if os.path.exists(self.__unapplied_file):
-                os.remove(self.__unapplied_file)
-            if os.path.exists(self.__current_file):
-                os.remove(self.__current_file)
-            if os.path.exists(self.__descr_file):
-                os.remove(self.__descr_file)
-            if not os.listdir(self.__patch_dir):
-                os.rmdir(self.__patch_dir)
-            else:
-                print 'Patch directory %s is not empty.' % self.__name
-            if not os.listdir(self.__series_dir):
-                os.rmdir(self.__series_dir)
-            else:
-                print 'Series directory %s is not empty.' % self.__nam=
e
-            if not os.listdir(self.__refs_dir):
-                os.rmdir(self.__refs_dir)
-            else:
-                print 'Refs directory %s is not empty.' % self.__refs_=
dir
+            for f in [self.__applied_file, self.__unapplied_file,
+                      self.__current_file, self.__descr_file]:
+                rm_if_exists(f)
+
+            for (d, n) in [(self.__patch_dir, 'Patch'),
+                           (self.__series_dir, 'Series'),
+                           (self.__refs_dir, 'Refs')]:
+                if os.path.isdir(d) and os.listdir(d):
+                    print '%s directory %s is not empty.' % (n, self._=
_name)
+                rmdir_while_empty(d, self.__base_dir)
=20
-        if os.path.exists(self.__base_file):
-            os.remove(self.__base_file)
+        rm_if_exists(self.__base_file)
+        rmdir_while_empty(os.path.dirname(self.__base_file), self.__ba=
se_dir)
=20
     def refresh_patch(self, files =3D None, message =3D None, edit =3D=
 False,
                       show_patch =3D False,
diff --git a/stgit/utils.py b/stgit/utils.py
index 5749b3b..33c62be 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -18,6 +18,18 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
+import os.path
+
+def mkdir_file(filename, mode, mkdir):
+    """Opens filename with the given mode, creating the directory it's
+    in if it doesn't already exist and mkdir is true
+    """
+    if mkdir:
+        d =3D os.path.dirname(filename)
+        if not os.path.isdir(d):
+            os.makedirs(d)
+    return file(filename, mode)
+
 def read_string(filename, multiline =3D False):
     """Reads the first line from a file
     """
@@ -29,42 +41,87 @@ def read_string(filename, multiline =3D Fa
     f.close()
     return result
=20
-def write_string(filename, line, multiline =3D False):
+def write_string(filename, line, multiline =3D False, mkdir =3D False)=
:
     """Writes 'line' to file and truncates it
     """
-    f =3D file(filename, 'w+')
+    f =3D mkdir_file(filename, 'w+', mkdir)
     if multiline:
         f.write(line)
     else:
         print >> f, line
     f.close()
=20
-def append_strings(filename, lines):
+def append_strings(filename, lines, mkdir =3D False):
     """Appends 'lines' sequence to file
     """
-    f =3D file(filename, 'a+')
+    f =3D mkdir_file(filename, 'a+', mkdir)
     for line in lines:
         print >> f, line
     f.close()
=20
-def append_string(filename, line):
+def append_string(filename, line, mkdir =3D False):
     """Appends 'line' to file
     """
-    f =3D file(filename, 'a+')
+    f =3D mkdir_file(filename, 'a+', mkdir)
     print >> f, line
     f.close()
=20
-def insert_string(filename, line):
+def insert_string(filename, line, mkdir =3D False):
     """Inserts 'line' at the beginning of the file
     """
-    f =3D file(filename, 'r+')
+    f =3D mkdir_file(filename, 'r+', mkdir)
     lines =3D f.readlines()
     f.seek(0); f.truncate()
     print >> f, line
     f.writelines(lines)
     f.close()
=20
-def create_empty_file(name):
+def create_empty_file(name, mkdir =3D False):
     """Creates an empty file
     """
-    file(name, 'w+').close()
+    mkdir_file(name, 'w+', mkdir).close()
+
+def remove_leading_dir(leading, path):
+    """Remove leading directories from a pathname
+    """
+    if not path.startswith(leading):
+        raise Exception('"%s" does not begin with "%s"' % (path, leadi=
ng))
+    path =3D path[len(leading):]
+    if len(path) > 0 and path[0] in [os.path.sep, os.path.altsep]:
+        path =3D path[1:]
+    return path
+
+def rmdir_while_empty(path, stop):
+    """Delete dirs until we reach a directory that isn't empty, or
+    until we reach the path stop
+    """
+    while path.startswith(stop) and len(path) > len(stop):
+        parent =3D os.path.dirname(path)
+        try:
+            os.rmdir(path)
+        except OSError:
+            return # directory not empty
+        path =3D parent
+
+def rm_file_and_dirs(path, stop):
+    """Delete the file, and keep deleting dirs until we reach a
+    directory that isn't empty, or until we reach the path stop
+    """
+    os.remove(path)
+    rmdir_while_empty(os.path.dirname(path), stop)
+
+def rm_if_exists(f):
+    """Delete file if it exists
+    """
+    if os.path.exists(f):
+        os.remove(f)
+
+def rename_dirs(from_path, to_path, stop):
+    """Rename file or directory, creating new directories at to_path
+    as necessary, and removing leftover empty directories at from_path
+    until we reach stop
+    """
+    if not os.path.isdir(os.path.dirname(to_path)):
+        os.makedirs(os.path.dirname(to_path))
+    os.rename(from_path, to_path)
+    rmdir_while_empty(os.path.dirname(from_path), stop)
