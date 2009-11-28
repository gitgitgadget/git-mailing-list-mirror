From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 4/6] stg mail: factor out __update_header
Date: Sat, 28 Nov 2009 12:50:32 -0700
Message-ID: <20091128195032.949.31684.stgit@bob.kio>
References: <20091128194056.949.88791.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 28 20:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETJa-0000MT-Ea
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbZK1Tu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZK1Tu2
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:50:28 -0500
Received: from g4t0014.houston.hp.com ([15.201.24.17]:24182 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbZK1Tu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:50:26 -0500
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g4t0014.houston.hp.com (Postfix) with ESMTP id 0859D24186;
	Sat, 28 Nov 2009 19:50:33 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id C29182009C;
	Sat, 28 Nov 2009 19:50:32 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 94CF3CF0009;
	Sat, 28 Nov 2009 12:50:32 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1gX0miXzaMyM; Sat, 28 Nov 2009 12:50:32 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id 77080CF0007;
	Sat, 28 Nov 2009 12:50:32 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id 6DF2726172; Sat, 28 Nov 2009 12:50:32 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091128194056.949.88791.stgit@bob.kio>
User-Agent: StGit/0.15-6-g435b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133976>

Factor __update_header out of __build_address_headers.

Headers like Reply-To, Mail-Reply-To, and Mail-Followup-To are now
handled in __build_extra_headers.

We make this change because in the future, we do not want to call
__build_address_headers if using git send-email but we will always
want to call __build_extra_headers.

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   48 +++++++++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index fe5742e..7f811e8 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -260,25 +260,25 @@ def __send_message(tmpl, options, *args):
     out.done()
     return msg_id
 
-def __build_address_headers(msg, options, extra_cc = []):
-    """Build the address headers and check existing headers in the
-    template.
-    """
+def __update_header(msg, header, addr = '', ignore = ()):
     def __addr_pairs(msg, header, extra):
         pairs = email.Utils.getaddresses(msg.get_all(header, []) + extra)
         # remove pairs without an address and resolve the aliases
         return [address_or_alias(p) for p in pairs if p[1]]
 
-    def __update_header(header, addr = '', ignore = ()):
-        addr_pairs = __addr_pairs(msg, header, [addr])
-        del msg[header]
-        # remove the duplicates and filter the addresses
-        addr_dict = dict((addr, email.Utils.formataddr((name, addr)))
-                         for name, addr in addr_pairs if addr not in ignore)
-        if addr_dict:
-            msg[header] = ', '.join(addr_dict.itervalues())
-        return set(addr_dict.iterkeys())
+    addr_pairs = __addr_pairs(msg, header, [addr])
+    del msg[header]
+    # remove the duplicates and filter the addresses
+    addr_dict = dict((addr, email.Utils.formataddr((name, addr)))
+                     for name, addr in addr_pairs if addr not in ignore)
+    if addr_dict:
+        msg[header] = ', '.join(addr_dict.itervalues())
+    return set(addr_dict.iterkeys())
 
+def __build_address_headers(msg, options, extra_cc = []):
+    """Build the address headers and check existing headers in the
+    template.
+    """
     to_addr = ''
     cc_addr = ''
     extra_cc_addr = ''
@@ -298,18 +298,14 @@ def __build_address_headers(msg, options, extra_cc = []):
         bcc_addr = autobcc
 
     # if an address is on a header, ignore it from the rest
-    to_set = __update_header('To', to_addr)
-    cc_set = __update_header('Cc', cc_addr, to_set)
-    bcc_set = __update_header('Bcc', bcc_addr, to_set.union(cc_set))
+    to_set = __update_header(msg, 'To', to_addr)
+    cc_set = __update_header(msg, 'Cc', cc_addr, to_set)
+    bcc_set = __update_header(msg, 'Bcc', bcc_addr, to_set.union(cc_set))
 
     # --auto generated addresses, don't include the sender
-    from_set = __update_header('From')
-    __update_header('Cc', extra_cc_addr, to_set.union(bcc_set).union(from_set))
-
-    # update other address headers
-    __update_header('Reply-To')
-    __update_header('Mail-Reply-To')
-    __update_header('Mail-Followup-To')
+    from_set = __update_header(msg, 'From')
+    __update_header(msg, 'Cc', extra_cc_addr,
+                    to_set.union(bcc_set).union(from_set))
 
 def __get_signers_list(msg):
     """Return the address list generated from signed-off-by and
@@ -347,6 +343,12 @@ def __build_extra_headers(msg, msg_id, ref_id = None):
         msg['References'] = ref_id
     msg['User-Agent'] = 'StGit/%s' % version.version
 
+    # update other address headers
+    __update_header(msg, 'Reply-To')
+    __update_header(msg, 'Mail-Reply-To')
+    __update_header(msg, 'Mail-Followup-To')
+
+
 def __encode_message(msg):
     # 7 or 8 bit encoding
     charset = email.Charset.Charset('utf-8')
