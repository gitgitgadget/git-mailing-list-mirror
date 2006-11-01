X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Allow hand-editing of patches before sending
Date: Wed, 01 Nov 2006 10:00:46 +0100
Message-ID: <20061101090046.1107.81105.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
NNTP-Posting-Date: Wed, 1 Nov 2006 09:03:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30625>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfC0M-0007TF-3I for gcvg-git@gmane.org; Wed, 01 Nov
 2006 10:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946563AbWKAJDW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 04:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423959AbWKAJDW
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 04:03:22 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:18306 "EHLO
 mxfep02.bredband.com") by vger.kernel.org with ESMTP id S1423960AbWKAJDU
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 04:03:20 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep02.bredband.com with ESMTP id
 <20061101090318.HFRJ9734.mxfep02.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Wed, 1 Nov 2006 10:03:18 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 01 Nov 2006 10:03:18 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id D6DC04CB5A; Wed,  1 Nov
 2006 10:03:17 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

This adds a new flag to 'stg mail', allowing the user to hand-edit
each patch e-mail before it is sent, just like it is currently
possible to edit the cover message.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

Intended use is to allow the user to write comments like this, when
there is only one patch and a cover mail would be overkill.

 stgit/commands/mail.py |   59 ++++++++++++++++++++++++++++----------------=
----
 1 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 970ae3e..26c711d 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -108,6 +108,9 @@ options =3D [make_option('-a', '--all',
            make_option('-e', '--edit',
                        help =3D 'edit the cover message before sending',
                        action =3D 'store_true'),
+           make_option('-E', '--edit-patches',
+                       help =3D 'edit each patch before sending',
+                       action =3D 'store_true'),
            make_option('-s', '--sleep', type =3D 'int', metavar =3D 'SECON=
DS',
                        help =3D 'sleep for SECONDS between e-mails sending=
'),
            make_option('--refid',
@@ -276,6 +279,34 @@ def __build_extra_headers():
=20
     return headers
=20
+def edit_message(msg):
+    fname =3D '.stgitmail.txt'
+
+    # create the initial file
+    f =3D file(fname, 'w')
+    f.write(msg)
+    f.close()
+
+    # the editor
+    if config.has_option('stgit', 'editor'):
+        editor =3D config.get('stgit', 'editor')
+    elif 'EDITOR' in os.environ:
+        editor =3D os.environ['EDITOR']
+    else:
+        editor =3D 'vi'
+    editor +=3D ' %s' % fname
+
+    print 'Invoking the editor: "%s"...' % editor,
+    sys.stdout.flush()
+    print 'done (exit code: %d)' % os.system(editor)
+
+    # read the message back
+    f =3D file(fname)
+    msg =3D f.read()
+    f.close()
+
+    return msg
+
 def __build_cover(tmpl, total_nr, msg_id, options):
     """Build the cover message (series description) to be sent via SMTP
     """
@@ -326,30 +357,7 @@ def __build_cover(tmpl, total_nr, msg_id
               'supported in the patch template'
=20
     if options.edit:
-        fname =3D '.stgitmail.txt'
-
-        # create the initial file
-        f =3D file(fname, 'w+')
-        f.write(msg)
-        f.close()
-
-        # the editor
-        if config.has_option('stgit', 'editor'):
-            editor =3D config.get('stgit', 'editor')
-        elif 'EDITOR' in os.environ:
-            editor =3D os.environ['EDITOR']
-        else:
-            editor =3D 'vi'
-        editor +=3D ' %s' % fname
-
-        print 'Invoking the editor: "%s"...' % editor,
-        sys.stdout.flush()
-        print 'done (exit code: %d)' % os.system(editor)
-
-        # read the message back
-        f =3D file(fname)
-        msg =3D f.read()
-        f.close()
+        msg =3D edit_message(msg)
=20
     return msg.strip('\n')
=20
@@ -431,6 +439,9 @@ def __build_message(tmpl, patch, patch_n
         raise CmdException, 'Only "%(name)s" variables are ' \
               'supported in the patch template'
=20
+    if options.edit_patches:
+        msg =3D edit_message(msg)
+
     return msg.strip('\n')
=20
