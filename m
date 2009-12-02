From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH v2 6/6] stg mail: don't parse To/Cc/Bcc in --git mode
Date: Tue,  1 Dec 2009 17:46:33 -0700
Message-ID: <20091202004632.7737.84887.stgit@bob.kio>
References: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Karl Wiberg <kha@treskal.com>
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 02 01:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFdMk-0005qg-K0
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 01:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbZLBAq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 19:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbZLBAq2
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 19:46:28 -0500
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:43894 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbZLBAq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 19:46:26 -0500
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g5t0008.atlanta.hp.com (Postfix) with ESMTP id 7FE0C240B3;
	Wed,  2 Dec 2009 00:46:33 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id 63015200A3;
	Wed,  2 Dec 2009 00:46:33 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 37710CF000A;
	Tue,  1 Dec 2009 17:46:33 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJZN2ufVumuj; Tue,  1 Dec 2009 17:46:33 -0700 (MST)
Received: from eh.fc.hp.com (eh.fc.hp.com [15.11.146.105])
	by ldl (Postfix) with ESMTP id 2333ECF0007;
	Tue,  1 Dec 2009 17:46:33 -0700 (MST)
Received: by eh.fc.hp.com (Postfix, from userid 17609)
	id 0F45C26160; Tue,  1 Dec 2009 17:46:33 -0700 (MST)
X-Mailer: git-send-email 1.6.5.2.74.g610f9
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
User-Agent: StGit/0.15-6-gc6f39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134278>

When using stg mail in --git mode, do not parse command-line To/Cc/Bcc
addresses.

Instead, we pass them directly to git send-email.

This allows us to leverage git send-email's support for email aliases.

Cc: Karl Wiberg <kha@treskal.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
---

 stgit/commands/mail.py |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 8a33c22..d108e75 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -247,12 +247,6 @@ def __send_message_git(msg, options):
         if getattr(options, x):
             cmd.extend('--%s=%s' % (x, a) for a in getattr(options, x))
 
-    # XXX: hack for now so that we don't duplicate To/Cc/Bcc headers
-    # in the mail, as git send-email inserts those for us.
-    del msg['To']
-    del msg['Cc']
-    del msg['Bcc']
-
     (fd, path) = mkstemp()
     os.write(fd, msg.as_string(options.mbox))
     os.close(fd)
@@ -277,13 +271,13 @@ def __send_message(type, tmpl, options, *args):
     msg_id = email.Utils.make_msgid('stgit')
     msg = build(tmpl, msg_id, options, *args)
 
-    from_addr, to_addrs = __parse_addresses(msg)
     msg_str = msg.as_string(options.mbox)
     if options.mbox:
         out.stdout_raw(msg_str + '\n')
         return msg_id
 
     if not options.git:
+        from_addr, to_addrs = __parse_addresses(msg)
         out.start('Sending ' + outstr)
 
     smtpserver = options.smtp_server or config.get('stgit.smtpserver')
@@ -499,7 +493,8 @@ def __build_cover(tmpl, msg_id, options, patches):
     except Exception, ex:
         raise CmdException, 'template parsing error: %s' % str(ex)
 
-    __build_address_headers(msg, options)
+    if not options.git:
+        __build_address_headers(msg, options)
     __build_extra_headers(msg, msg_id, options.refid)
     __encode_message(msg)
 
@@ -609,7 +604,8 @@ def __build_message(tmpl, msg_id, options, patch, patch_nr, total_nr, ref_id):
     else:
         extra_cc = []
 
-    __build_address_headers(msg, options, extra_cc)
+    if not options.git:
+        __build_address_headers(msg, options, extra_cc)
     __build_extra_headers(msg, msg_id, ref_id)
     __encode_message(msg)
 
