X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/3] Ask git for author and committer name
Date: Sun, 12 Nov 2006 00:30:46 +0100
Message-ID: <20061111233046.17760.62871.stgit@localhost>
References: <20061111232322.17760.26214.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 23:31:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061111232322.17760.26214.stgit@localhost>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31249>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj2Jn-0006qf-Eg for gcvg-git@gmane.org; Sun, 12 Nov
 2006 00:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947326AbWKKXbH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 18:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947325AbWKKXbG
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 18:31:06 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:35281 "EHLO
 mxfep01.bredband.com") by vger.kernel.org with ESMTP id S1947326AbWKKXbD
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 18:31:03 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep01.bredband.com with ESMTP id
 <20061111233101.YGDC9747.mxfep01.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 00:31:01 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 12 Nov 2006 00:31:01 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 536D54C04D; Sun, 12 Nov
 2006 00:31:01 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Consistently do the following to get hold of default user and
committer:

  1. Use the value specified on the command line, if any.

  1. Otherwise, use the value from stgitrc, if available.

  2. Otherwise, ask git for the value. git will produce the value from
     on of its config files, from environment variables, or make it
     up. It might be asking the spirits of the dead for all we care.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/mail.py |   19 ++------------
 stgit/git.py           |   63 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/stack.py         |   32 ++++--------------------
 3 files changed, 70 insertions(+), 44 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 154df9c..78abfa4 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -127,17 +127,6 @@ options =3D [make_option('-a', '--all',
                        action =3D 'store_true')]
=20
=20
-def __get_maintainer():
-    """Return the 'authname <authemail>' string as read from the
-    configuration file
-    """
-    if config.has_option('stgit', 'authname') \
-           and config.has_option('stgit', 'authemail'):
-        return '%s <%s>' % (config.get('stgit', 'authname'),
-                            config.get('stgit', 'authemail'))
-    else:
-        return None
-
 def __parse_addresses(addresses):
     """Return a two elements tuple: (from, [to])
     """
@@ -301,9 +290,7 @@ def edit_message(msg):
 def __build_cover(tmpl, total_nr, msg_id, options):
     """Build the cover message (series description) to be sent via SMT=
P
     """
-    maintainer =3D __get_maintainer()
-    if not maintainer:
-        maintainer =3D ''
+    maintainer =3D git.user()
=20
     if options.version:
         version_str =3D ' %s' % options.version
@@ -370,9 +357,7 @@ def __build_message(tmpl, patch, patch_n
     short_descr =3D descr_lines[0].rstrip()
     long_descr =3D '\n'.join(descr_lines[1:]).lstrip()
=20
-    maintainer =3D __get_maintainer()
-    if not maintainer:
-        maintainer =3D '%s <%s>' % (p.get_commname(), p.get_commemail(=
))
+    maintainer =3D git.user()
=20
     if options.version:
         version_str =3D ' %s' % options.version
diff --git a/stgit/git.py b/stgit/git.py
index 8d88769..a6e1a63 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -33,6 +33,35 @@ class GitException(Exception):
 #
 # Classes
 #
+
+class Person:
+    """An author, committer, etc."""
+    def __init__(self, name =3D None, email =3D None, date =3D None,
+                 desc =3D None):
+        if name or email or date:
+            assert not desc
+            self.name =3D name
+            self.email =3D email
+            self.date =3D date
+        elif desc:
+            assert not (name or email or date)
+            def parse_desc(s):
+                m =3D re.match(r'^(.+)<(.+)>(.*)$', s)
+                assert m
+                return [x.strip() or None for x in m.groups()]
+            self.name, self.email, self.date =3D parse_desc(desc)
+    def set_name(self, val):
+        if val:
+            self.name =3D val
+    def set_email(self, val):
+        if val:
+            self.email =3D val
+    def __str__(self):
+        if self.name and self.email:
+            return '%s <%s>' % (self.name, self.email)
+        else:
+            raise Exception, 'not enough identity data'
+
 class Commit:
     """Handle the commit objects
     """
@@ -402,6 +431,40 @@ def rm(files, force =3D False):
         if files:
             __run('git-update-index --force-remove --', files)
=20
+def var(key):
+    """Ask git-var for the value of a variable."""
+    return _output_one_line(['git-var', key])
+
+def repo_config(key):
+    """Ask git-repo-config for the value of a variable."""
+    return _output_one_line(['git-repo-config', key])
+
+__cached_git_persons =3D {}
+def __git_person(p):
+    if not p in __cached_git_persons:
+        __cached_git_persons[p] =3D {
+            'author': lambda: Person(desc =3D var('GIT_AUTHOR_IDENT'))=
,
+            'committer': lambda: Person(desc =3D var('GIT_COMMITTER_ID=
ENT')),
+            'user': lambda: Person(repo_config('user.name'),
+                                   repo_config('user.email')),
+            }[p]()
+    return __cached_git_persons[p]
+
+__cached_stgit_persons =3D {}
+def __stgit_person(p, name_key, email_key):
+    if not p in __cached_stgit_persons:
+        person =3D __git_person(p)
+        if config.has_option('stgit', name_key):
+            person.set_name(config.get('stgit', name_key))
+        if config.has_option('stgit', email_key):
+            person.set_email(config.get('stgit', email_key))
+        __cached_stgit_persons[p] =3D person
+    return __cached_stgit_persons[p]
+
+def author(): return __stgit_person('author', 'authname', 'authemail')
+def committer(): return __stgit_person('committer', 'commname', 'comme=
mail')
+def user(): return __stgit_person('user', 'authname', 'authemail')
+
 def update_cache(files =3D None, force =3D False):
     """Update the cache information for the given files
     """
diff --git a/stgit/stack.py b/stgit/stack.py
index a477e7d..fee1316 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -238,53 +238,31 @@ class Patch:
         return self.__get_field('authname')
=20
     def set_authname(self, name):
-        if not name:
-            if config.has_option('stgit', 'authname'):
-                name =3D config.get('stgit', 'authname')
-            elif 'GIT_AUTHOR_NAME' in os.environ:
-                name =3D os.environ['GIT_AUTHOR_NAME']
-        self.__set_field('authname', name)
+        self.__set_field('authname', name or git.author().name)
=20
     def get_authemail(self):
         return self.__get_field('authemail')
=20
     def set_authemail(self, address):
-        if not address:
-            if config.has_option('stgit', 'authemail'):
-                address =3D config.get('stgit', 'authemail')
-            elif 'GIT_AUTHOR_EMAIL' in os.environ:
-                address =3D os.environ['GIT_AUTHOR_EMAIL']
-        self.__set_field('authemail', address)
+        self.__set_field('authemail', address or git.author().email)
=20
     def get_authdate(self):
         return self.__get_field('authdate')
=20
     def set_authdate(self, date):
-        if not date and 'GIT_AUTHOR_DATE' in os.environ:
-            date =3D os.environ['GIT_AUTHOR_DATE']
-        self.__set_field('authdate', date)
+        self.__set_field('authdate', date or git.author().date)
=20
     def get_commname(self):
         return self.__get_field('commname')
=20
     def set_commname(self, name):
-        if not name:
-            if config.has_option('stgit', 'commname'):
-                name =3D config.get('stgit', 'commname')
-            elif 'GIT_COMMITTER_NAME' in os.environ:
-                name =3D os.environ['GIT_COMMITTER_NAME']
-        self.__set_field('commname', name)
+        self.__set_field('commname', name or git.committer().name)
=20
     def get_commemail(self):
         return self.__get_field('commemail')
=20
     def set_commemail(self, address):
-        if not address:
-            if config.has_option('stgit', 'commemail'):
-                address =3D config.get('stgit', 'commemail')
-            elif 'GIT_COMMITTER_EMAIL' in os.environ:
-                address =3D os.environ['GIT_COMMITTER_EMAIL']
-        self.__set_field('commemail', address)
+        self.__set_field('commemail', address or git.committer().email=
)
=20
     def get_log(self):
