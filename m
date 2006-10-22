From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/2] RFC2047-encode email headers
Date: Sun, 22 Oct 2006 14:49:32 +0200
Message-ID: <20061022124931.14051.39810.stgit@localhost>
References: <20061022124551.14051.25145.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:49:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbclm-0007g6-3N
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWJVMtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 08:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWJVMtf
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:49:35 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:64191 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750796AbWJVMte (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:49:34 -0400
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20061022124932.QHTR2091.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:49:32 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport.bredband.com with ESMTP; 22 Oct 2006 14:49:32 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 2E55D4C010;
	Sun, 22 Oct 2006 14:49:32 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022124551.14051.25145.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29727>

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

Having non-ascii characters in email headers is illegal, but StGIT
currently does not care. I'm often bitten by this, since my name
doesn't fit in ascii.

This patch implements an encoding pass just before the email is sent
over the wire -- in particular, it comes after any interactive editing
and templates and such, so the user should never have to see the
rfc2047 encoding.

NOTE: The rfc2047 encoder needs to know the encoding of the input
string. This patch hard-codes this to utf8, since that should be by
far the most common non-ascii encoding, and since utf8 is already the
hardcoded character set for the email body. In the long run, we
probably want to get this from the locale, or from a command line
switch, or both.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/mail.py |   45 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 34504e6..b661308 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -15,7 +15,7 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
=20
-import sys, os, re, time, datetime, smtplib, email.Utils
+import sys, os, re, time, datetime, smtplib, email.Header, email.Utils
 from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
@@ -403,6 +403,42 @@ def __build_message(tmpl, patch, patch_n
=20
     return msg.strip('\n')
=20
+def encode_header(s, enc):
+    """Take an entire e-mail header line, encoded in enc, and
+    rfc2047-encode it."""
+    def trans(s):
+        return str(email.Header.Header(unicode(s, enc)))
+    words =3D s.split(' ')
+    first_encode =3D len(words)
+    last_encode =3D -1
+    for i in xrange(len(words)):
+        ew =3D trans(words[i])
+        if ew !=3D words[i]:
+            first_encode =3D min(first_encode, i)
+            last_encode =3D max(last_encode, i)
+    if first_encode <=3D last_encode:
+        return ' '.join(filter(
+            None,
+            [' '.join(words[:first_encode]),
+             trans(' '.join(words[first_encode:last_encode+1])),
+             ' '.join(words[last_encode+1:])]))
+    else:
+        return s
+
+def encode_headers(msg, enc):
+    """rfc2047-encode the headers of msg, assuming it is encoded in
+    enc."""
+    in_header =3D True
+    lines =3D []
+    for line in msg.splitlines(True):
+        if in_header:
+            if line.strip():
+                line =3D encode_header(line, enc)
+            else:
+                in_header =3D False
+        lines.append(line)
+    return ''.join(lines)
+
 def func(parser, options, args):
     """Send the patches by e-mail using the patchmail.tmpl file as
     a template
@@ -461,7 +497,8 @@ def func(parser, options, args):
                 raise CmdException, 'No cover message template file found'
=20
         msg_id =3D email.Utils.make_msgid('stgit')
-        msg =3D __build_cover(tmpl, total_nr, msg_id, options)
+        msg =3D encode_headers(__build_cover(tmpl, total_nr, msg_id, optio=
ns),
+                             'UTF-8')
         from_addr, to_addr_list =3D __parse_addresses(msg)
=20
         # subsequent e-mails are seen as replies to the first one
@@ -487,8 +524,8 @@ def func(parser, options, args):
=20
     for (p, patch_nr) in zip(patches, range(1, len(patches) + 1)):
         msg_id =3D email.Utils.make_msgid('stgit')
-        msg =3D __build_message(tmpl, p, patch_nr, total_nr, msg_id, ref_i=
d,
-                              options)
+        msg =3D encode_headers(__build_message(tmpl, p, patch_nr, total_nr,
+                                             msg_id, ref_id, options), 'UT=
F-8')
         from_addr, to_addr_list =3D __parse_addresses(msg)
=20
         # subsequent e-mails are seen as replies to the first one
