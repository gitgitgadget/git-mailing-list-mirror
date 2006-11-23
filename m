X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/4] Allows to refresh a non-top applied patch.
Date: Fri, 24 Nov 2006 00:16:53 +0100
Message-ID: <20061123231649.9769.46624.stgit@gandelf.nowhere.earth>
References: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 23:17:49 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32170>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNpA-0001eR-IQ for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934246AbWKWXRk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934250AbWKWXRk
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:17:40 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:44780 "EHLO
 smtp1-g19.free.fr") by vger.kernel.org with ESMTP id S934246AbWKWXRj (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:17:39 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp1-g19.free.fr (Postfix) with ESMTP id B0D529B406;
 Fri, 24 Nov 2006 00:17:38 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GnNpO-0002sy-G6; Fri, 24 Nov 2006 00:17:58 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/refresh.py |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 610d18a..ea0fe6f 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -66,6 +66,8 @@ options = [make_option('-f', '--force',
            make_option('--commemail',
                        help = 'use COMMEMAIL as the committer ' \
                        'e-mail'),
+           make_option('-p', '--patch',
+                       help = 'refresh named (applied) PATCH instead of the top one'),
            make_option('--sign',
                        help = 'add Signed-off-by line',
                        action = 'store_true'),
@@ -80,9 +82,15 @@ def func(parser, options, args):
     if autoresolved != 'yes':
         check_conflicts()
 
-    patch = crt_series.get_current()
-    if not patch:
-        raise CmdException, 'No patches applied'
+    if options.patch:
+        patch = options.patch
+        if not crt_series.patch_applied(patch):
+            raise CmdException, 'Patches "%s" not applied' % patch
+        origpatch = crt_series.get_current()
+    else:
+        patch = crt_series.get_current()
+        if not patch:
+            raise CmdException, 'No patches applied'
 
     if not options.force:
         check_head_top_equal()
@@ -110,6 +118,13 @@ def func(parser, options, args):
            or options.authname or options.authemail or options.authdate \
            or options.commname or options.commemail \
            or options.sign or options.ack:
+
+        if options.patch:
+            applied = crt_series.get_applied()
+            between = applied[applied.index(patch)+1:]
+            between.reverse()
+            pop_patches(between)
+
         print 'Refreshing patch "%s"...' % patch,
         sys.stdout.flush()
 
@@ -126,6 +141,10 @@ def func(parser, options, args):
                                  committer_email = options.commemail,
                                  backup = True, sign_str = sign_str)
 
+        if options.patch:
+            between.reverse()
+            push_patches(between)
+
         print 'done'
     else:
