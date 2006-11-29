X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/2] Don't require config file for "stg mail"
Date: Tue, 28 Nov 2006 22:59:30 -0500
Message-ID: <20061129035930.6118.88435.stgit@dv.roinet.com>
References: <20061129035925.6118.78329.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 03:59:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061129035925.6118.78329.stgit@dv.roinet.com>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32613>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpGbi-0002Ig-MS for gcvg-git@gmane.org; Wed, 29 Nov
 2006 04:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758644AbWK2D7d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 22:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758650AbWK2D7d
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 22:59:33 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:29880 "EHLO
 fencepost.gnu.org") by vger.kernel.org with ESMTP id S1758644AbWK2D7c (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 22:59:32 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.52) id
 1GpGbb-0006L1-Sh for git@vger.kernel.org; Tue, 28 Nov 2006 22:59:32 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com) by gnu.org with
 esmtp (Exim 4.63) (envelope-from <proski@gnu.org>) id 1GpGba-0001cI-Ta; Tue,
 28 Nov 2006 22:59:30 -0500
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

When calculating the string to be used in the From: field, don't require
it to come from the configuration file.  Instead, reuse already known
authname and authemail values as the default.  They can be taken from
the GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL environment variables.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/commands/mail.py |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 176d7a2..70b091f 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -122,18 +122,13 @@ options = [make_option('-a', '--all',
                        action = 'store_true')]
 
 
-def __get_sender():
-    """Return the 'authname <authemail>' string as read from the
-    configuration file
+def __get_sender(authname, authemail):
+    """Return the string to be used in the From: field
     """
     if config.has_option('stgit', 'sender'):
         return config.get('stgit', 'sender')
-    elif config.has_option('stgit', 'authname') \
-             and config.has_option('stgit', 'authemail'):
-        return '%s <%s>' % (config.get('stgit', 'authname'),
-                            config.get('stgit', 'authemail'))
     else:
-        raise CmdException, 'unknown sender details'
+        return '%s <%s>' % (authname, authemail)
 
 def __parse_addresses(addresses):
     """Return a two elements tuple: (from, [to])
@@ -298,7 +293,7 @@ def __edit_message(msg):
 def __build_cover(tmpl, total_nr, msg_id, options):
     """Build the cover message (series description) to be sent via SMTP
     """
-    sender = __get_sender()
+    sender = __get_sender(authname, authemail)
 
     if options.version:
         version_str = ' %s' % options.version
@@ -372,7 +367,7 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
     commname = p.get_commname();
     commemail = p.get_commemail();
 
-    sender = __get_sender()
+    sender = __get_sender(authname, authemail)
 
     fromauth = '%s <%s>' % (authname, authemail)
     if fromauth != sender:
