From: Sergei Golubchik <vuvova@gmail.com>
Subject: [PATCH] bzr per-file comments in git-remote-bzr
Date: Thu, 15 May 2014 18:07:04 +0200
Message-ID: <20140515160704.GA6028@meddwl.wlan.t-mobile.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 18:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyLM-0005jA-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbaEOQRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:17:13 -0400
Received: from mail.askmonty.org ([173.203.201.185]:49764 "EHLO
	mail.askmonty.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbaEOQRM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:17:12 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 May 2014 12:17:12 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.askmonty.org (Postfix) with ESMTP id 664CC2C420B
	for <git@vger.kernel.org>; Thu, 15 May 2014 16:07:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.askmonty.org
Received: from mail.askmonty.org ([127.0.0.1])
	by localhost (mail.askmonty.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBq0kZx-F7Pt for <git@vger.kernel.org>;
	Thu, 15 May 2014 16:07:15 +0000 (UTC)
Received: from meddwl (2E6B6683.dsl.pool.telekom.hu [46.107.102.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: serg)
	by mail.askmonty.org (Postfix) with ESMTPSA id 77B392C4144
	for <git@vger.kernel.org>; Thu, 15 May 2014 16:07:15 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249106>

>From 7fd7360ef5b4f453ceb8e32b18f73f9fbcaa95b7 Mon Sep 17 00:00:00 2001
From: Sergei Golubchik <vuvova@gmail.com>
Date: Thu, 15 May 2014 17:50:16 +0200
Subject: [PATCH] git-remote-bzr: support bzr per-file comments

Bazaar supports per-file comments in revisions - using bzr-gtk one can
write a global revisions comment and comments for individual files too
(this was apparently modelled after a similar feature in BitKeeper).
When exporting a bzr repository to git these file comments are lost.

This patch makes them to be not lost but appear as a part of the commit
comment instead. Empty file comments and file comments identical to the
commit comment are skipped (they add no value as a part of the commit
comment). Corrupted file comments are ignored too (there is one old
revision corrupted like that in the MariaDB/MySQL tree).
---
 contrib/remote-helpers/git-remote-bzr | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 9abb58e..c659cf6 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -311,6 +311,22 @@ def export_branch(repo, name):
         else:
             author = committer
         msg = rev.message.encode('utf-8')
+        if rev.properties.has_key('file-info'):
+            from bzrlib import bencode
+            try:
+                files = bencode.bdecode(rev.properties['file-info'].encode('utf-8'))
+            except Exception, e:
+                warn ('file-info for revid:%s ignored, decoding error: %s', rev.revision_id, e)
+                files = ()
+
+            rmsg = msg.rstrip('\r\n ')
+            msg += '\n'
+            for file in files:
+              fmsg = file['message'].rstrip('\r\n ')
+              if fmsg != '' and fmsg != rmsg:
+                  msg += '\n%s:' % (file['path'],)
+                  for l in fmsg.split('\n'):
+                      msg += '\n  %s' % (l,)
 
         msg += '\n'
 
-- 
1.9.3
