From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 6/6] stg mail: don't parse To/Cc/Bcc in --git mode
Date: Sat, 28 Nov 2009 12:50:43 -0700
Message-ID: <20091128195042.949.99025.stgit@bob.kio>
References: <20091128194056.949.88791.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Nov 28 20:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETJn-0000Sq-0m
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbZK1Tui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbZK1Tuh
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:50:37 -0500
Received: from g1t0027.austin.hp.com ([15.216.28.34]:21541 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZK1Tuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:50:37 -0500
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g1t0027.austin.hp.com (Postfix) with ESMTP id A60CB38078;
	Sat, 28 Nov 2009 19:50:43 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 79D5E14036;
	Sat, 28 Nov 2009 19:50:43 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 4D276CF0009;
	Sat, 28 Nov 2009 12:50:43 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfxZhGi5-W1n; Sat, 28 Nov 2009 12:50:43 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id 39020CF0007;
	Sat, 28 Nov 2009 12:50:43 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id 2247526172; Sat, 28 Nov 2009 12:50:43 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091128194056.949.88791.stgit@bob.kio>
User-Agent: StGit/0.15-6-g435b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133979>

When using stg mail in --git mode, do not parse command-line To/Cc/Bcc
addresses.

Instead, we pass them directly to git send-email.

This allows us to leverage git send-email's support for email aliases.

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 81ec77e..c01e14b 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -257,12 +257,6 @@ def __send_message_git(msg, options):
     if not options.auto:
         cmd.append("--suppress-cc=body")
 
-    # XXX: hack for now so that we don't duplicate To/Cc/Bcc headers
-    # in the mail, as git send-email inserts those for us.
-    del msg['To']
-    del msg['Cc']
-    del msg['Bcc']
-
     (fd, path) = mkstemp()
     os.write(fd, msg.as_string(options.mbox))
     os.close(fd)
@@ -283,7 +277,8 @@ def __send_message(tmpl, options, *args):
     build = { 1: __build_cover, 4: __build_message }
     msg = build[len(args)](tmpl, msg_id, options, *args)
 
-    from_addr, to_addrs = __parse_addresses(msg)
+    if not options.git:
+        from_addr, to_addrs = __parse_addresses(msg)
     msg_str = msg.as_string(options.mbox)
     if options.mbox:
         out.stdout_raw(msg_str + '\n')
@@ -507,7 +502,8 @@ def __build_cover(tmpl, msg_id, options, patches):
     except Exception, ex:
         raise CmdException, 'template parsing error: %s' % str(ex)
 
-    __build_address_headers(msg, options)
+    if not options.git:
+        __build_address_headers(msg, options)
     __build_extra_headers(msg, msg_id, options.refid)
     __encode_message(msg)
 
@@ -617,7 +613,8 @@ def __build_message(tmpl, msg_id, options, patch, patch_nr, total_nr, ref_id):
     else:
         extra_cc = []
 
-    __build_address_headers(msg, options, extra_cc)
+    if not options.git:
+        __build_address_headers(msg, options, extra_cc)
     __build_extra_headers(msg, msg_id, ref_id)
     __encode_message(msg)
 
