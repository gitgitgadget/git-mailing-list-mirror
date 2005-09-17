From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: [PATCH] Better mail handling in stgit
Date: Sat, 17 Sep 2005 15:34:41 +0200
Message-ID: <432C1B71.4090105@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-446-1126964079-0001-2"
X-From: git-owner@vger.kernel.org Sat Sep 17 15:37:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGcrj-0004PJ-6M
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 15:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVIQNel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 09:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVIQNek
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 09:34:40 -0400
Received: from [85.8.12.41] ([85.8.12.41]:45186 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751106AbVIQNek (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 09:34:40 -0400
Received: from [10.45.1.243] (c-4a1b72d5.04-143-6c6b701.cust.bredbandsbolaget.se [::ffff:213.114.27.74])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Sat, 17 Sep 2005 15:34:38 +0200
  id 00062716.432C1B6F.000001BE
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8764>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-446-1126964079-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Fix some issues with the mail function in StGIT:

 * Allow multiple To/Cc/Bcc command line options.

 * Better parsing of mail addresses.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-446-1126964079-0001-2
Content-Type: text/x-patch; name="mailfix.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mailfix.patch"

--- stgit.orig/commands/mail.py	2005-08-03 21:04:10.000000000 +0200
+++ stgit/commands/mail.py	2005-09-17 14:57:23.000000000 +0200
@@ -78,11 +78,14 @@
                        metavar = '[PATCH1][:[PATCH2]]',
                        help = 'e-mail patches between PATCH1 and PATCH2'),
            make_option('--to',
-                       help = 'Add TO to the To: list'),
+                       help = 'Add TO to the To: list',
+                       action = 'append'),
            make_option('--cc',
-                       help = 'Add CC to the Cc: list'),
+                       help = 'Add CC to the Cc: list',
+                       action = 'append'),
            make_option('--bcc',
-                       help = 'Add BCC to the Bcc: list'),
+                       help = 'Add BCC to the Bcc: list',
+                       action = 'append'),
            make_option('-t', '--template', metavar = 'FILE',
                        help = 'use FILE as the message template'),
            make_option('-f', '--first', metavar = 'FILE',
@@ -112,7 +115,10 @@
     """Return a two elements tuple: (from, [to])
     """
     def __addr_list(string):
-        return re.split('.*?([\w\.]+@[\w\.]+)', string)[1:-1:2]
+    	m = re.search('[^@\s<,]+@[^>\s,]+', string);
+    	if (m == None):
+    		return []
+    	return [ m.group() ] + __addr_list(string[m.end():])
 
     from_addr_list = []
     to_addr_list = []
@@ -152,6 +158,25 @@
 
     s.quit()
 
+def __build_address_headers(options):
+    headers_end = ''
+    if options.to:
+    	headers_end += 'To: '
+    	for to in options.to:
+	        headers_end += '%s,' % to
+	headers_end = headers_end[:-1] + '\n'
+    if options.cc:
+    	headers_end += 'Cc: '
+    	for cc in options.cc:
+	        headers_end += '%s,' % cc
+	headers_end = headers_end[:-1] + '\n'
+    if options.bcc:
+    	headers_end += 'Bcc: '
+    	for bcc in options.bcc:
+	        headers_end += '%s,' % bcc
+	headers_end = headers_end[:-1] + '\n'
+    return headers_end
+
 def __build_first(tmpl, total_nr, msg_id, options):
     """Build the first message (series description) to be sent via SMTP
     """
@@ -160,12 +185,7 @@
         maintainer = ''
 
     headers_end = ''
-    if options.to:
-        headers_end += 'To: %s\n' % options.to
-    if options.cc:
-        headers_end += 'Cc: %s\n' % options.cc
-    if options.bcc:
-        headers_end += 'Bcc: %s\n' % options.bcc
+    headers_end += __build_address_headers(options)
     headers_end += 'Message-Id: %s\n' % msg_id
 
     total_nr_str = str(total_nr)
@@ -210,12 +230,7 @@
         maintainer = '%s <%s>' % (p.get_commname(), p.get_commemail())
 
     headers_end = ''
-    if options.to:
-        headers_end += 'To: %s\n' % options.to
-    if options.cc:
-        headers_end += 'Cc: %s\n' % options.cc
-    if options.bcc:
-        headers_end += 'Bcc: %s\n' % options.bcc
+    headers_end += __build_address_headers(options)
     headers_end += 'Message-Id: %s\n' % msg_id
     if ref_id:
         headers_end += "In-Reply-To: %s\n" % ref_id

--=_hermes.drzeus.cx-446-1126964079-0001-2--
