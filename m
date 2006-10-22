From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/2] QP-encode email body
Date: Sun, 22 Oct 2006 14:49:37 +0200
Message-ID: <20061022124937.14051.37985.stgit@localhost>
References: <20061022124551.14051.25145.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:49:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbclr-0007hB-2W
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWJVMtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWJVMtj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:49:39 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:24000 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750838AbWJVMtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:49:39 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep02.bredband.com with ESMTP
          id <20061022124937.QHTU2091.mxfep02.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:49:37 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 14:49:37 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 595B14C010;
	Sun, 22 Oct 2006 14:49:37 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022124551.14051.25145.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29728>

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

Some mail servers dislike the 8bit transfer encoding, so use
quoted-printable instead.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/mail.py |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index b661308..885d5e9 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -15,7 +15,7 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
=20
-import sys, os, re, time, datetime, smtplib, email.Header, email.Utils
+import sys, os, re, time, datetime, quopri, smtplib, email.Header, email.U=
tils
 from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
@@ -253,7 +253,7 @@ def __build_extra_headers():
     """Build extra headers like content-type etc.
     """
     headers  =3D 'Content-Type: text/plain; charset=3Dutf-8; format=3Dfixe=
d\n'
-    headers +=3D 'Content-Transfer-Encoding: 8bit\n'
+    headers +=3D 'Content-Transfer-Encoding: quoted-printable\n'
     headers +=3D 'User-Agent: StGIT/%s\n' % version.version
=20
     return headers
@@ -425,9 +425,9 @@ def encode_header(s, enc):
     else:
         return s
=20
-def encode_headers(msg, enc):
-    """rfc2047-encode the headers of msg, assuming it is encoded in
-    enc."""
+def encode_message(msg, enc):
+    """rfc2047-encode the headers of msg, and quoted-printable-encode
+    the body. msg is assumed to be encoded in enc."""
     in_header =3D True
     lines =3D []
     for line in msg.splitlines(True):
@@ -436,6 +436,8 @@ def encode_headers(msg, enc):
                 line =3D encode_header(line, enc)
             else:
                 in_header =3D False
+        else:
+            line =3D quopri.encodestring(line)
         lines.append(line)
     return ''.join(lines)
=20
@@ -497,7 +499,7 @@ def func(parser, options, args):
                 raise CmdException, 'No cover message template file found'
=20
         msg_id =3D email.Utils.make_msgid('stgit')
-        msg =3D encode_headers(__build_cover(tmpl, total_nr, msg_id, optio=
ns),
+        msg =3D encode_message(__build_cover(tmpl, total_nr, msg_id, optio=
ns),
                              'UTF-8')
         from_addr, to_addr_list =3D __parse_addresses(msg)
=20
@@ -524,7 +526,7 @@ def func(parser, options, args):
=20
     for (p, patch_nr) in zip(patches, range(1, len(patches) + 1)):
         msg_id =3D email.Utils.make_msgid('stgit')
-        msg =3D encode_headers(__build_message(tmpl, p, patch_nr, total_nr,
+        msg =3D encode_message(__build_message(tmpl, p, patch_nr, total_nr,
                                              msg_id, ref_id, options), 'UT=
F-8')
         from_addr, to_addr_list =3D __parse_addresses(msg)
=20
