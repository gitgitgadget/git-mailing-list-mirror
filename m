From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH] mail: Use space rather than tab for long header
 folding
Date: Fri, 12 Feb 2010 15:39:05 +0000
Message-ID: <20100212153905.11578.83879.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 16:39:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfxbx-00005G-5T
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 16:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab0BLPjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 10:39:12 -0500
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35675 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756539Ab0BLPjL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 10:39:11 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o1CFd5eI028492;
	Fri, 12 Feb 2010 15:39:05 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 12 Feb 2010 15:39:05 +0000
User-Agent: StGit/0.15-53-gecb05
X-OriginalArrivalTime: 12 Feb 2010 15:39:05.0477 (UTC) FILETIME=[824CFB50:01CAABF9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139715>

The default Python implementation (at least 2.5 and earlier) fold long
e-mail header lines by inserting "\n\t". This causes issues with some
e-mail clients that remove both "\n\t". The RFC2822 shows that folding
should be done with "\n ". The Python workaround is to use a Header
object instead of a string when setting the message headers.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/mail.py |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index e1de847..34262d3 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -170,7 +170,7 @@ def __get_sender():
 
 def __addr_list(msg, header):
     return [addr for name, addr in
-            email.Utils.getaddresses(msg.get_all(header, []))]
+            email.Utils.getaddresses(map(str, msg.get_all(header, [])))]
 
 def __parse_addresses(msg):
     """Return a two elements tuple: (from, [to])
@@ -304,7 +304,8 @@ def __send_message(type, tmpl, options, *args):
 
 def __update_header(msg, header, addr = '', ignore = ()):
     def __addr_pairs(msg, header, extra):
-        pairs = email.Utils.getaddresses(msg.get_all(header, []) + extra)
+        pairs = email.Utils.getaddresses(map(str,
+                                             msg.get_all(header, []) + extra))
         # remove pairs without an address and resolve the aliases
         return [address_or_alias(p) for p in pairs if p[1]]
 
@@ -408,7 +409,8 @@ def __encode_message(msg):
                 pass
             words.append(email.Header.Header(uword).encode())
         new_val = ' '.join(words)
-        msg.replace_header(header, new_val)
+        msg.replace_header(header,
+                           email.Header.Header(new_val, header_name = header))
 
     # encode the body and set the MIME and encoding headers
     if msg.is_multipart():
