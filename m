From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: Add ability to define an alternate temporary directory
Date: Tue, 10 Nov 2009 17:49:08 -0800
Message-ID: <1257904149-44381-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Nov 11 02:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N82Kr-0000k1-Lh
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 02:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523AbZKKBtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 20:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756506AbZKKBtN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 20:49:13 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:35399 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756490AbZKKBtM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 20:49:12 -0500
Received: by ywh40 with SMTP id 40so580740ywh.33
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=r+N1Agcg2df6QXPaRKHWeDdAMC3wf11yLrRvQ1zwFe4=;
        b=lo7nyS6nSqqrQdm16/WJYTyfwdglEMUBF0giiVuWTiG4g6GB8HqfKZBROcrDLukek5
         bKpqdH2XfvTCpb8dJIvg0flhGJqNTMgxY3hKWgoEyOjkfzCPKCp+qb+7MabJp2bFFWPZ
         2dyQvCiUM6wuT9RhoZOAs6YhwDwmfdP6xLM4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cgRgZiRRQKGGb3VAAoxHZyRCUqc4EPQNJzycdYV5ZSJNEy/8FZjt31b/bRn9+BpX5q
         Gea8i+hSOpVIQJ9rUp6iuHrLrqVja2PF/7/T4Ut8u/JHzEXysgCa4Cdfbd4NkrzUTQFf
         xbOWj5DNN/SDdpMK+fi1QJ637fEO9tn8bmmns=
Received: by 10.150.80.16 with SMTP id d16mr1673887ybb.0.1257904158357;
        Tue, 10 Nov 2009 17:49:18 -0800 (PST)
Received: from localhost (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id 15sm579053gxk.0.2009.11.10.17.49.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 17:49:17 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.180.gc5b3e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132609>

gitk fails to show diffs when browsing a repository for which
we have read-only access.  This is due to gitk's assumption
that the current directory is always writable.

This teaches gitk to honor the GITK_TMPDIR environment
variable.  This allows users to override the default location
used for writing temporary files.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index db5ec54..9139ace 100755
--- a/gitk
+++ b/gitk
@@ -3170,11 +3170,15 @@ proc flist_hl {only} {
 }
 
 proc gitknewtmpdir {} {
-    global diffnum gitktmpdir gitdir
+    global diffnum env gitktmpdir gitdir
 
     if {![info exists gitktmpdir]} {
-	set gitktmpdir [file join [file dirname $gitdir] \
-			    [format ".gitk-tmp.%s" [pid]]]
+	if {[info exists env(GITK_TMPDIR)]} {
+	    set tmpdir $env(GITK_TMPDIR)
+	} else {
+	    set tmpdir [file dirname $gitdir]
+	}
+	set gitktmpdir [file join $tmpdir [format ".gitk-tmp.%s" [pid]]]
 	if {[catch {file mkdir $gitktmpdir} err]} {
 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
 	    unset gitktmpdir
-- 
1.6.5.2.180.gc5b3e
