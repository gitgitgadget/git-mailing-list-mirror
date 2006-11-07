X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Generate unique patch names
Date: Tue, 07 Nov 2006 07:59:31 +0100
Message-ID: <20061107065931.10728.66377.stgit@localhost>
References: <20061107065710.10728.85618.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=fixed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 7 Nov 2006 06:59:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061107065710.10728.85618.stgit@localhost>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31048>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhKvn-00061P-LE for gcvg-git@gmane.org; Tue, 07 Nov
 2006 07:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753204AbWKGG7e convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006 01:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbWKGG7d
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 01:59:33 -0500
Received: from mxfep03.bredband.com ([195.54.107.76]:32491 "EHLO
 mxfep03.bredband.com") by vger.kernel.org with ESMTP id S1753204AbWKGG7c
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 01:59:32 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep03.bredband.com with ESMTP id
 <20061107065931.MWUN25623.mxfep03.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Tue, 7 Nov 2006 07:59:31 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 07 Nov 2006 07:59:31 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 240644C04D; Tue,  7 Nov
 2006 07:59:31 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

"stg assimilate" was already making sure that automatically generated
patch names were non-empty and unique, by suffixing them with a dash
and a number if necessary. This patch moves that functionality into
the autogeneration function itself, so that all its callers can
benefit from it (and the user can benefit from uniform behavior from
all stgit commands).

As an added bonus, this permits the removal of a number of checks that
would abort with an error if the automatically generated name was
empty.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/assimilate.py |    9 +--------
 stgit/commands/common.py     |   16 +++++++++++++++-
 stgit/commands/imprt.py      |    4 +---
 stgit/commands/pick.py       |    4 +---
 stgit/commands/uncommit.py   |    5 ++---
 5 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/stgit/commands/assimilate.py b/stgit/commands/assimilate.p=
y
index 0821024..a8b3bfe 100644
--- a/stgit/commands/assimilate.py
+++ b/stgit/commands/assimilate.py
@@ -73,14 +73,7 @@ def func(parser, options, args):
         return name in name2patch or crt_series.patch_exists(name)
=20
     for victim in victims:
-        patchname =3D make_patch_name(victim.get_log())
-        if not patchname:
-            patchname =3D 'patch'
-        if name_taken(patchname):
-            suffix =3D 0
-            while name_taken('%s-%d' % (patchname, suffix)):
-                suffix +=3D 1
-            patchname =3D '%s-%d' % (patchname, suffix)
+        patchname =3D make_patch_name(victim.get_log(), name_taken)
         patch2name[victim] =3D patchname
         name2patch[patchname] =3D victim
=20
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 0e1bb44..d986711 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -284,7 +284,7 @@ def name_email_date(address):
=20
     return str_list[0]
=20
-def make_patch_name(msg):
+def patch_name_from_msg(msg):
     """Return a string to be used as a patch name. This is generated
     from the first 30 characters of the top line of the string passed
     as argument."""
@@ -293,3 +293,17 @@ def make_patch_name(msg):
=20
     subject_line =3D msg[:30].lstrip().split('\n', 1)[0].lower()
     return re.sub('[\W]+', '-', subject_line).strip('-')
+
+def make_patch_name(msg, unacceptable, default_name =3D 'patch'):
+    """Return a patch name generated from the given commit message,
+    guaranteed to make unacceptable(name) be false. If the commit
+    message is empty, base the name on default_name instead."""
+    patchname =3D patch_name_from_msg(msg)
+    if not patchname:
+        patchname =3D 'patch'
+    if unacceptable(patchname):
+        suffix =3D 0
+        while unacceptable('%s-%d' % (patchname, suffix)):
+            suffix +=3D 1
+        patchname =3D '%s-%d' % (patchname, suffix)
+    return patchname
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index c8cf42b..34cbf38 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -240,9 +240,7 @@ def __import_patch(patch, filename, opti
                  __parse_patch(filename)
=20
     if not patch:
-        patch =3D make_patch_name(message)
-        if not patch:
-            raise CmdException, 'Unknown patch name'
+        patch =3D make_patch_name(message, crt_series.patch_exists)
=20
     # refresh_patch() will invoke the editor in this case, with correc=
t
     # patch content
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index f8f3577..996e789 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -71,9 +71,7 @@ def func(parser, options, args):
         elif len(patch_branch) =3D=3D 2:
             patch =3D patch_branch[0]
         else:
-            patch =3D make_patch_name(commit.get_log())
-            if not patch:
-                raise CmdException, 'Unknown patch name'
+            patch =3D make_patch_name(commit.get_log(), crt_series.pat=
ch_exists)
=20
     if options.parent:
         parent =3D git_id(options.parent)
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 45a2087..9798f19 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -97,9 +97,8 @@ def func(parser, options, args):
         if patchnames:
             patchname =3D patchnames[n]
         else:
-            patchname =3D make_patch_name(commit.get_log())
-        if not patchname:
-            raise CmdException, 'Unknown patch name for commit %s' % c=
ommit_id
+            patchname =3D make_patch_name(commit.get_log(),
+                                        crt_series.patch_exists)
=20
         crt_series.new_patch(patchname,
                              can_edit =3D False, before_existing =3D T=
