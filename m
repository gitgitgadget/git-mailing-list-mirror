From: Aaron Crane <git@aaroncrane.co.uk>
Subject: [PATCH] Documentation/SubmittingPatches: fix Gmail workaround advice
Date: Sun,  7 Feb 2010 15:14:02 +0000
Message-ID: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 16:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne8q1-0007Us-RX
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 16:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633Ab0BGPOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 10:14:12 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56559 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0BGPOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 10:14:10 -0500
Received: by vws20 with SMTP id 20so1847589vws.19
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 07:14:10 -0800 (PST)
Received: by 10.220.108.27 with SMTP id d27mr4424883vcp.64.1265555649666;
        Sun, 07 Feb 2010 07:14:09 -0800 (PST)
Received: from localhost (marchmont.aaroncrane.co.uk [87.194.157.167])
        by mx.google.com with ESMTPS id 36sm34160624vws.6.2010.02.07.07.14.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 07:14:07 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139240>

The suggested approach to dealing with Gmail's propensity for breaking
patches doesn't seem to work.  Recommend an alternative technique which
does.

Signed-off-by: Aaron Crane <git@aaroncrane.co.uk>
---
Thanks to Sverre Rabbelier, Jacob Helwig, David Aguilar, and Jay Soffian for
their suggestions; the advice here comes from them.

 Documentation/SubmittingPatches |   88 +++++++++++++++++++++++++--------------
 1 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c686f86..4d3c45f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -517,35 +517,59 @@ message, complete the addressing and subject fields, and press send.
 Gmail
 -----
 
-GMail does not appear to have any way to turn off line wrapping in the web
-interface, so this will mangle any emails that you send.  You can however
-use any IMAP email client to connect to the google imap server, and forward
-the emails through that.  Just make sure to disable line wrapping in that
-email client.  Alternatively, use "git send-email" instead.
-
-Submitting properly formatted patches via Gmail is simple now that
-IMAP support is available. First, edit your ~/.gitconfig to specify your
-account settings:
-
-[imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	pass = p4ssw0rd
-	port = 993
-	sslverify = false
-
-You might need to instead use: folder = "[Google Mail]/Drafts" if you get an error
-that the "Folder doesn't exist".
-
-Next, ensure that your Gmail settings are correct. In "Settings" the
-"Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
-
-Once your commits are ready to send to the mailing list, run the following
-command to send the patch emails to your Gmail Drafts folder.
-
-	$ git format-patch -M --stdout origin/master | git imap-send
-
-Go to your Gmail account, open the Drafts folder, find the patch email, fill
-in the To: and CC: fields and send away!
-
+Gmail does not appear to have any way to turn off line wrapping in the web
+interface, so this will mangle any emails that you send.  Nor can you use
+"git imap-send" to upload an email to your Drafts folder; the web interface
+will still mangle your message when you send it.
+
+The best approach is to send the email using Gmail's SMTP submission
+servers.  Configuring "git send-email" to do that looks like this:
+
+    [sendemail]
+        smtpencryption = tls
+        smtpserver = smtp.gmail.com
+        smtpuser = [YOURADDRESSHERE]@gmail.com
+        smtpserverport = 587
+
+Then sending will look like this:
+
+    $ git format-patch --no-color -C -M origin/master..topic -o outgoing/
+    $ git send-email --compose outgoing/00*
+
+"git send-email" will then prompt you for your password.
+
+However, "git send-email" needs the Net::SMTP::SSL Perl module to send to
+TLS-encrypted servers.  On some operating systems (like Mac OS X with
+MacPorts), it may be hard to install that module.  In such cases, the
+third-party "msmtp" program might be easier to install.  If so, configure
+"git send-email" like this:
+
+    [sendemail]
+        smtpserver = /opt/local/bin/msmtp
+        # adjust the path if necessary
+
+and then configure msmtp to use the Gmail servers, in your ~/.msmtprc file:
+
+    # Set default values for all following accounts
+    defaults
+    tls on
+    tls_trust_file /opt/local/share/curl/curl-ca-bundle.crt
+        # with MacPorts, install the curl-ca-bundle port for this file
+
+    # Configure a "gmail" account
+    account gmail
+    host smtp.gmail.com
+    port 587
+    from [YOURADDRESSHERE]@gmail.com
+    auth on
+    user [YOURADDRESSHERE]@gmail.com
+
+    # Set the "gmail" account as the default
+    account default : gmail
+
+If you're using either Gnome or Mac OS X, msmtp will look up your password
+from your OS keychain; otherwise, or if that fails, it prompts you for your
+password.
+
+For more details, see
+http://git.wiki.kernel.org/index.php/GitTips#Using_gmail_to_send_your_patches
-- 
1.6.6.1
