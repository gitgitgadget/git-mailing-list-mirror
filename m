From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [StGit PATCH] Refactor --author/--committer options
Date: Wed, 13 Feb 2008 00:08:42 +0100
Message-ID: <20080212230842.GA25839@diana.vm.bytemark.co.uk>
References: <20080210203846.17683.43153.stgit@yoghurt> <20080210204359.17683.41935.stgit@yoghurt> <200802122305.05696.kumbayo84@arcor.de> <20080212224724.GA24993@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP4Gj-0002c7-MB
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 00:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756265AbYBLXIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 18:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbYBLXIz
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 18:08:55 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4450 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759952AbYBLXIw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 18:08:52 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JP4F0-0006kG-00; Tue, 12 Feb 2008 23:08:42 +0000
Content-Disposition: inline
In-Reply-To: <20080212224724.GA24993@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73709>

This refactoring is specific to the new infrastructure, so only new
and edit use it currently, but other commands can start using it as
they are converted.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

On 2008-02-12 23:47:24 +0100, Karl Hasselstr=F6m wrote:

> On 2008-02-12 23:05:05 +0100, Peter Oberndorfer wrote:
>
> > So another way to fix this might be, to not overwrite cd
> > unconditionally.
>
> Yes, this is what we want -- if the user gives --author, we
> shouldn't open the interactive editor even if the given author is
> the same as the patch already had.
>
> Updated patch on the way.

And here it is. The relevant piece of code now reads

    a, c =3D options.author(cd.author), options.committer(cd.committer)
    if (a, c) !=3D (cd.author, cd.committer):
        cd =3D cd.set_author(a).set_committer(c)

This works because the default value for options.author and
options.committer -- used when no commandline options are given -- is
the identity function.

 stgit/commands/common.py |   33 ++++++++++--------------------
 stgit/commands/edit.py   |   26 ++++--------------------
 stgit/commands/new.py    |   40 ++++++++++---------------------------
 stgit/utils.py           |   50 ++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 76 insertions(+), 73 deletions(-)


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 5a1952b..d6df813 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -266,30 +266,19 @@ def parse_patches(patch_args, patch_list, boundar=
y =3D 0, ordered =3D False):
     return patches
=20
 def name_email(address):
-    """Return a tuple consisting of the name and email parsed from a
-    standard 'name <email>' or 'email (name)' string
-    """
-    address =3D re.sub(r'[\\"]', r'\\\g<0>', address)
-    str_list =3D re.findall('^(.*)\s*<(.*)>\s*$', address)
-    if not str_list:
-        str_list =3D re.findall('^(.*)\s*\((.*)\)\s*$', address)
-        if not str_list:
-            raise CmdException('Incorrect "name <email>"/"email (name)=
"'
-                               ' string: %s' % address)
-        return ( str_list[0][1], str_list[0][0] )
-
-    return str_list[0]
+    p =3D parse_name_email(address)
+    if p:
+        return p
+    else:
+        raise CmdException('Incorrect "name <email>"/"email (name)" st=
ring: %s'
+                           % address)
=20
 def name_email_date(address):
-    """Return a tuple consisting of the name, email and date parsed
-    from a 'name <email> date' string
-    """
-    address =3D re.sub(r'[\\"]', r'\\\g<0>', address)
-    str_list =3D re.findall('^(.*)\s*<(.*)>\s*(.*)\s*$', address)
-    if not str_list:
-        raise CmdException, 'Incorrect "name <email> date" string: %s'=
 % address
-
-    return str_list[0]
+    p =3D parse_name_email_date(address)
+    if p:
+        return p
+    else:
+        raise CmdException('Incorrect "name <email> date" string: %s' =
% address)
=20
 def address_or_alias(addr_str):
     """Return the address if it contains an e-mail address or look up
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index 7daf156..436f7ea 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -60,19 +60,8 @@ options =3D [make_option('-d', '--diff',
                        action =3D 'store_true'),
            make_option('-e', '--edit', action =3D 'store_true',
                        help =3D 'invoke interactive editor'),
-           make_option('--author', metavar =3D '"NAME <EMAIL>"',
-                       help =3D 'replae the author details with "NAME =
<EMAIL>"'),
-           make_option('--authname',
-                       help =3D 'replace the author name with AUTHNAME=
'),
-           make_option('--authemail',
-                       help =3D 'replace the author e-mail with AUTHEM=
AIL'),
-           make_option('--authdate',
-                       help =3D 'replace the author date with AUTHDATE=
'),
-           make_option('--commname',
-                       help =3D 'replace the committer name with COMMN=
AME'),
-           make_option('--commemail',
-                       help =3D 'replace the committer e-mail with COM=
MEMAIL')
            ] + (utils.make_sign_options() + utils.make_message_options=
()
+                + utils.make_author_committer_options()
                 + utils.make_diff_opts_option())
=20
 def patch_diff(repository, cd, diff, diff_flags):
@@ -141,16 +130,9 @@ def func(parser, options, args):
                                                    options.message)
=20
     # Modify author and committer data.
-    if options.author !=3D None:
-        options.authname, options.authemail =3D common.name_email(opti=
ons.author)
-    for p, f, val in [('author', 'name', options.authname),
-                      ('author', 'email', options.authemail),
-                      ('author', 'date', gitlib.Date.maybe(options.aut=
hdate)),
-                      ('committer', 'name', options.commname),
-                      ('committer', 'email', options.commemail)]:
-        if val !=3D None:
-            cd =3D getattr(cd, 'set_' + p)(
-                getattr(getattr(cd, p), 'set_' + f)(val))
+    a, c =3D options.author(cd.author), options.committer(cd.committer=
)
+    if (a, c) !=3D (cd.author, cd.committer):
+        cd =3D cd.set_author(a).set_committer(c)
=20
     # Add Signed-off-by: or similar.
     if options.sign_str !=3D None:
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index dd9f93e..d44b8cc 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -39,19 +39,8 @@ line of the commit message."""
 directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-m', '--message',
                        help =3D 'use MESSAGE as the patch description'=
),
-           make_option('-a', '--author', metavar =3D '"NAME <EMAIL>"',
-                       help =3D 'use "NAME <EMAIL>" as the author deta=
ils'),
-           make_option('--authname',
-                       help =3D 'use AUTHNAME as the author name'),
-           make_option('--authemail',
-                       help =3D 'use AUTHEMAIL as the author e-mail'),
-           make_option('--authdate',
-                       help =3D 'use AUTHDATE as the author date'),
-           make_option('--commname',
-                       help =3D 'use COMMNAME as the committer name'),
-           make_option('--commemail',
-                       help =3D 'use COMMEMAIL as the committer e-mail=
')
-           ] + utils.make_sign_options()
+           ] + (utils.make_author_committer_options()
+                + utils.make_sign_options())
=20
 def func(parser, options, args):
     """Create a new patch."""
@@ -72,30 +61,23 @@ def func(parser, options, args):
         parser.error('incorrect number of arguments')
=20
     head =3D directory.repository.refs.get(directory.repository.head)
-    cd =3D gitlib.Commitdata(tree =3D head.data.tree, parents =3D [hea=
d],
-                           message =3D '')
+    cd =3D gitlib.Commitdata(
+        tree =3D head.data.tree, parents =3D [head], message =3D '',
+        author =3D gitlib.Person.author(), committer =3D gitlib.Person=
=2Ecommitter())
=20
     # Set patch commit message from commandline.
     if options.message !=3D None:
         cd =3D cd.set_message(options.message)
=20
-    # Specify author and committer data.
-    if options.author !=3D None:
-        options.authname, options.authemail =3D common.name_email(opti=
ons.author)
-    for p, f, val in [('author', 'name', options.authname),
-                      ('author', 'email', options.authemail),
-                      ('author', 'date', gitlib.Date.maybe(options.aut=
hdate)),
-                      ('committer', 'name', options.commname),
-                      ('committer', 'email', options.commemail)]:
-        if val !=3D None:
-            cd =3D getattr(cd, 'set_' + p)(
-                getattr(getattr(cd, p), 'set_' + f)(val))
+    # Modify author and committer data.
+    cd =3D (cd.set_author(options.author(cd.author))
+            .set_committer(options.committer(cd.committer)))
=20
     # Add Signed-off-by: or similar.
     if options.sign_str !=3D None:
-        cd =3D cd.set_message(utils.add_sign_line(
-                cd.message, options.sign_str, gitlib.Person.committer(=
).name,
-                gitlib.Person.committer().email))
+        cd =3D cd.set_message(
+            utils.add_sign_line(cd.message, options.sign_str,
+                                cd.committer.name, cd.committer.email)=
)
=20
     # Let user edit the commit message manually.
     if not options.message:
diff --git a/stgit/utils.py b/stgit/utils.py
index b75c3b4..947f747 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -322,6 +322,56 @@ def make_diff_opts_option():
         type =3D 'string', metavar =3D 'OPTIONS',
         help =3D 'extra options to pass to "git diff"')]
=20
+def parse_name_email(address):
+    """Return a tuple consisting of the name and email parsed from a
+    standard 'name <email>' or 'email (name)' string."""
+    address =3D re.sub(r'[\\"]', r'\\\g<0>', address)
+    str_list =3D re.findall(r'^(.*)\s*<(.*)>\s*$', address)
+    if not str_list:
+        str_list =3D re.findall(r'^(.*)\s*\((.*)\)\s*$', address)
+        if not str_list:
+            return None
+        return (str_list[0][1], str_list[0][0])
+    return str_list[0]
+
+def parse_name_email_date(address):
+    """Return a tuple consisting of the name, email and date parsed
+    from a 'name <email> date' string."""
+    address =3D re.sub(r'[\\"]', r'\\\g<0>', address)
+    str_list =3D re.findall('^(.*)\s*<(.*)>\s*(.*)\s*$', address)
+    if not str_list:
+        return None
+    return str_list[0]
+
+def make_person_options(person, short):
+    """Sets options.<person> to a function that modifies a Person
+    according to the commandline options."""
+    def short_callback(option, opt_str, value, parser, field):
+        f =3D getattr(parser.values, person)
+        setattr(parser.values, person,
+                lambda p: getattr(f(p), 'set_' + field)(value))
+    def full_callback(option, opt_str, value, parser):
+        ne =3D parse_name_email(value)
+        if not ne:
+            raise optparse.OptionValueError(
+                'Bad %s specification: %r' % (opt_str, value))
+        name, email =3D ne
+        short_callback(option, opt_str, name, parser, 'name')
+        short_callback(option, opt_str, email, parser, 'email')
+    return ([optparse.make_option(
+                '--%s' % person, metavar =3D '"NAME <EMAIL>"', type =3D=
 'string',
+                action =3D 'callback', callback =3D full_callback, des=
t =3D person,
+                default =3D lambda p: p, help =3D 'set the %s details'=
 % person)]
+            + [optparse.make_option(
+                '--%s%s' % (short, f), metavar =3D f.upper(), type =3D=
 'string',
+                action =3D 'callback', callback =3D short_callback, de=
st =3D person,
+                callback_args =3D (f,), help =3D 'set the %s %s' % (pe=
rson, f))
+               for f in ['name', 'email', 'date']])
+
+def make_author_committer_options():
+    return (make_person_options('author', 'auth')
+            + make_person_options('committer', 'comm'))
+
 # Exit codes.
 STGIT_SUCCESS =3D 0        # everything's OK
 STGIT_GENERAL_ERROR =3D 1  # seems to be non-command-specific error


--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
