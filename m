From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/3] Parse the date instead of treating it as an opaque
	string
Date: Fri, 01 Feb 2008 08:50:08 +0100
Message-ID: <20080201074957.7905.52335.stgit@yoghurt>
References: <20080201074708.7905.98305.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 08:53:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKqia-0005Z8-7U
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 08:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934005AbYBAHvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Feb 2008 02:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934901AbYBAHvF
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 02:51:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2336 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936138AbYBAHvB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 02:51:01 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JKqf0-0008JC-00; Fri, 01 Feb 2008 07:50:06 +0000
In-Reply-To: <20080201074708.7905.98305.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72154>

This is needed for when we want to display it, since the
seconds-since-the-epoch format isn't that human-friendly.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |   76 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 files changed, 72 insertions(+), 4 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index d75f724..50dc4f1 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -1,10 +1,17 @@
 import os, os.path, re
+from datetime import datetime, timedelta, tzinfo
+
 from stgit import exception, run, utils
 from stgit.config import config
=20
 class RepositoryException(exception.StgException):
     pass
=20
+class DateException(exception.StgException):
+    def __init__(self, string, type):
+        exception.StgException.__init__(
+            self, '"%s" is not a valid %s' % (string, type))
+
 class DetachedHeadException(RepositoryException):
     def __init__(self):
         RepositoryException.__init__(self, 'Not on any branch')
@@ -26,6 +33,65 @@ def make_defaults(defaults):
             return None
     return d
=20
+class TimeZone(tzinfo, Repr):
+    def __init__(self, tzstring):
+        m =3D re.match(r'^([+-])(\d{2}):?(\d{2})$', tzstring)
+        if not m:
+            raise DateException(tzstring, 'time zone')
+        sign =3D int(m.group(1) + '1')
+        try:
+            self.__offset =3D timedelta(hours =3D sign*int(m.group(2))=
,
+                                      minutes =3D sign*int(m.group(3))=
)
+        except OverflowError:
+            raise DateException(tzstring, 'time zone')
+        self.__name =3D tzstring
+    def utcoffset(self, dt):
+        return self.__offset
+    def tzname(self, dt):
+        return self.__name
+    def dst(self, dt):
+        return timedelta(0)
+    def __str__(self):
+        return self.__name
+
+class Date(Repr):
+    """Immutable."""
+    def __init__(self, datestring):
+        # Try git-formatted date.
+        m =3D re.match(r'^(\d+)\s+([+-]\d\d:?\d\d)$', datestring)
+        if m:
+            try:
+                self.__time =3D datetime.fromtimestamp(int(m.group(1))=
,
+                                                     TimeZone(m.group(=
2)))
+            except ValueError:
+                raise DateException(datestring, 'date')
+            return
+
+        # Try iso-formatted date.
+        m =3D re.match(r'^(\d{4})-(\d{2})-(\d{2})\s+(\d{2}):(\d{2}):(\=
d{2})\s+'
+                     + r'([+-]\d\d:?\d\d)$', datestring)
+        if m:
+            try:
+                self.__time =3D datetime(
+                    *[int(m.group(i + 1)) for i in xrange(6)],
+                    **{'tzinfo': TimeZone(m.group(7))})
+            except ValueError:
+                raise DateException(datestring, 'date')
+            return
+
+        raise DateException(datestring, 'date')
+    def __str__(self):
+        return self.isoformat()
+    def isoformat(self):
+        """Human-friendly ISO 8601 format."""
+        return '%s %s' % (self.__time.replace(tzinfo =3D None).isoform=
at(' '),
+                          self.__time.tzinfo)
+    @classmethod
+    def maybe(cls, datestring):
+        if datestring in [None, NoValue]:
+            return datestring
+        return cls(datestring)
+
 class Person(Repr):
     """Immutable."""
     def __init__(self, name =3D NoValue, email =3D NoValue,
@@ -34,6 +100,7 @@ class Person(Repr):
         self.__name =3D d(name, 'name')
         self.__email =3D d(email, 'email')
         self.__date =3D d(date, 'date')
+        assert isinstance(self.__date, Date) or self.__date in [None, =
NoValue]
     name =3D property(lambda self: self.__name)
     email =3D property(lambda self: self.__email)
     date =3D property(lambda self: self.__date)
@@ -51,7 +118,7 @@ class Person(Repr):
         assert m
         name =3D m.group(1).strip()
         email =3D m.group(2)
-        date =3D m.group(3)
+        date =3D Date(m.group(3))
         return cls(name, email, date)
     @classmethod
     def user(cls):
@@ -65,7 +132,7 @@ class Person(Repr):
             cls.__author =3D cls(
                 name =3D os.environ.get('GIT_AUTHOR_NAME', NoValue),
                 email =3D os.environ.get('GIT_AUTHOR_EMAIL', NoValue),
-                date =3D os.environ.get('GIT_AUTHOR_DATE', NoValue),
+                date =3D Date.maybe(os.environ.get('GIT_AUTHOR_DATE', =
NoValue)),
                 defaults =3D cls.user())
         return cls.__author
     @classmethod
@@ -74,7 +141,8 @@ class Person(Repr):
             cls.__committer =3D cls(
                 name =3D os.environ.get('GIT_COMMITTER_NAME', NoValue)=
,
                 email =3D os.environ.get('GIT_COMMITTER_EMAIL', NoValu=
e),
-                date =3D os.environ.get('GIT_COMMITTER_DATE', NoValue)=
,
+                date =3D Date.maybe(
+                    os.environ.get('GIT_COMMITTER_DATE', NoValue)),
                 defaults =3D cls.user())
         return cls.__committer
=20
@@ -301,7 +369,7 @@ class Repository(RunWithEnv):
                 for attr, v2 in (('name', 'NAME'), ('email', 'EMAIL'),
                                  ('date', 'DATE')):
                     if getattr(p, attr) !=3D None:
-                        env['GIT_%s_%s' % (v1, v2)] =3D getattr(p, att=
r)
+                        env['GIT_%s_%s' % (v1, v2)] =3D str(getattr(p,=
 attr))
         sha1 =3D self.run(c, env =3D env).raw_input(commitdata.message
                                                 ).output_one_line()
         return self.get_commit(sha1)
