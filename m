From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] RFC2047-encode email headers
Date: Sun, 22 Oct 2006 14:02:17 +0200
Message-ID: <20061022120217.7650.23715.stgit@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:02:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbc2E-0001Ne-F7
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJVMCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 08:02:21 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWJVMCV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:02:21 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:50054 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750700AbWJVMCU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:02:20 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep01.bredband.com with ESMTP
          id <20061022120218.PHVT953.mxfep01.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:02:18 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 14:02:18 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 1DFDF4C010;
	Sun, 22 Oct 2006 14:02:18 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29723>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

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

 stgit/commands/mail.py |   45 ++++++++++++++++++++++++++++++++++++++++=
+----
 1 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 34504e6..b661308 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -15,7 +15,7 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
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
                 raise CmdException, 'No cover message template file fo=
und'
=20
         msg_id =3D email.Utils.make_msgid('stgit')
-        msg =3D __build_cover(tmpl, total_nr, msg_id, options)
+        msg =3D encode_headers(__build_cover(tmpl, total_nr, msg_id, o=
ptions),
+                             'UTF-8')
         from_addr, to_addr_list =3D __parse_addresses(msg)
=20
         # subsequent e-mails are seen as replies to the first one
@@ -487,8 +524,8 @@ def func(parser, options, args):
=20
     for (p, patch_nr) in zip(patches, range(1, len(patches) + 1)):
         msg_id =3D email.Utils.make_msgid('stgit')
-        msg =3D __build_message(tmpl, p, patch_nr, total_nr, msg_id, r=
ef_id,
-                              options)
+        msg =3D encode_headers(__build_message(tmpl, p, patch_nr, tota=
l_nr,
+                                             msg_id, ref_id, options),=
 'UTF-8')
         from_addr, to_addr_list =3D __parse_addresses(msg)
=20
         # subsequent e-mails are seen as replies to the first one
