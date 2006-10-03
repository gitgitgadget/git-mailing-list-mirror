From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGIT PATCH 2/3] Add an optional prefix to the PATCH subject when mailing.
Date: Tue, 03 Oct 2006 23:34:55 +0200
Message-ID: <20061003213455.26195.63109.stgit@lathund.dewire.com>
References: <20061003213453.26195.54830.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 03 23:34:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUruS-0003OJ-QW
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 23:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWJCVeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWJCVeg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 17:34:36 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18462 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1030562AbWJCVef
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 17:34:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id EA8B28028A3
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:39 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22665-07 for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:38 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 48A7980286A
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:38 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C56A928F59
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:34:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id T2cD3XqSyIuZ for <git@vger.kernel.org>;
	Tue,  3 Oct 2006 23:34:55 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id A966228AF4
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:34:55 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20061003213453.26195.54830.stgit@lathund.dewire.com>
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28306>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

This is for submitting patches to mailing lists with multiple
projects.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 stgit/commands/mail.py   |   15 +++++++++++++++
 templates/covermail.tmpl |    2 +-
 templates/patchmail.tmpl |    2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index bd56f16..8a713a1 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -65,6 +65,7 @@ the following variables:
   %(diffstat)s     - diff statistics
   %(date)s         - current date/time
   %(version)s      - ' version' string passed on the command line (or empty)
+  %(prefix)s       - prefix the subject lines's "PATCH" with this
   %(patchnr)s      - patch number
   %(totalnr)s      - total number of patches to be sent
   %(number)s       - empty if only one patch is sent or ' patchnr/totalnr'
@@ -95,6 +96,8 @@ options = [make_option('-a', '--all',
                        action = 'store_true'),
            make_option('-v', '--version', metavar = 'VERSION',
                        help = 'add VERSION to the [PATCH ...] prefix'),
+           make_option('--prefix', metavar = 'PREFIX',
+                       help = 'add PREFIX to the [...PATCH ...] prefix'),
            make_option('-t', '--template', metavar = 'FILE',
                        help = 'use FILE as the message template'),
            make_option('-c', '--cover', metavar = 'FILE',
@@ -232,6 +235,11 @@ def __build_cover(tmpl, total_nr, msg_id
     else:
         version_str = ''
 
+    if options.prefix:
+        prefix_str = options.prefix + ' '
+    else:
+        prefix_str = ''
+        
     total_nr_str = str(total_nr)
     patch_nr_str = '0'.zfill(len(total_nr_str))
     if total_nr > 1:
@@ -243,6 +251,7 @@ def __build_cover(tmpl, total_nr, msg_id
                  'endofheaders': headers_end,
                  'date':         email.Utils.formatdate(localtime = True),
                  'version':      version_str,
+                 'prefix':	 prefix_str,
                  'patchnr':      patch_nr_str,
                  'totalnr':      total_nr_str,
                  'number':       number_str}
@@ -312,6 +321,11 @@ def __build_message(tmpl, patch, patch_n
     else:
         version_str = ''
 
+    if options.prefix:
+        prefix_str = options.prefix + ' '
+    else:
+        prefix_str = ''
+        
     total_nr_str = str(total_nr)
     patch_nr_str = str(patch_nr).zfill(len(total_nr_str))
     if total_nr > 1:
@@ -330,6 +344,7 @@ def __build_message(tmpl, patch, patch_n
                                               rev2 = git_id('%s//top' % patch)),
                  'date':         email.Utils.formatdate(localtime = True),
                  'version':      version_str,
+                 'prefix':       prefix_str,
                  'patchnr':      patch_nr_str,
                  'totalnr':      total_nr_str,
                  'number':       number_str,
diff --git a/templates/covermail.tmpl b/templates/covermail.tmpl
index 44cd19e..ba1dd9d 100644
--- a/templates/covermail.tmpl
+++ b/templates/covermail.tmpl
@@ -1,5 +1,5 @@
 From: %(maintainer)s
-Subject: [PATCH%(version)s%(number)s] Series short description
+Subject: [%(prefix)sPATCH%(version)s%(number)s] Series short description
 Date: %(date)s
 %(endofheaders)s
 The following series implements...
diff --git a/templates/patchmail.tmpl b/templates/patchmail.tmpl
index 7881993..b0df904 100644
--- a/templates/patchmail.tmpl
+++ b/templates/patchmail.tmpl
@@ -1,5 +1,5 @@
 From: %(maintainer)s
-Subject: [PATCH%(version)s%(number)s] %(shortdescr)s
+Subject: [%(prefix)sPATCH%(version)s%(number)s] %(shortdescr)s
 Date: %(date)s
 %(endofheaders)s
 From: %(authname)s <%(authemail)s>
