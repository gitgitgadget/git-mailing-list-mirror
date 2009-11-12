From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: Honor TMPDIR when viewing diffs externally
Date: Thu, 12 Nov 2009 01:37:49 -0800
Message-ID: <1258018669-47405-1-git-send-email-davvid@gmail.com>
Cc: peff@peff.net, sam@vilain.net, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Nov 12 10:38:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8W81-0002nb-44
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbZKLJhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbZKLJhx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:37:53 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:34421 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZKLJhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:37:52 -0500
Received: by pzk1 with SMTP id 1so416936pzk.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 01:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ymAXtg3Tr+t2h5EMwWLOTC2b6OE1eM+AopilVe22gY8=;
        b=aLOkHTHaW5z4QiubAXmwsf4YLFIFPDhlQT9eLMdOimh0m27zxT0ME4tZ0XH4GrKBmP
         v7TDZU08VFpICDgTjYUvZvW/75SpWGHL5FKZQJieHIQv2a/Whulme7fXAmXGnbHAjBQ6
         hBWyAgFVBehnha6GCAIEkO5hvExiERiuuB278=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TsDZDOjFpViyLhDPONpr0c3iosCZNJi4GbS4CMunbMRD/6N5Mi+vmkemgSxC3s4Jvl
         F6D2whugn1d6BfUmoKyNt/gN6N4EFJGMNsuFdVtECJgHf6xecRmupkJ4kgXigS7lO7Lf
         feQA+S+WLIv1DnxqwQJmw1tMqVapzRsxi50M0=
Received: by 10.115.86.7 with SMTP id o7mr5852883wal.50.1258018676251;
        Thu, 12 Nov 2009 01:37:56 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 21sm1552006pzk.11.2009.11.12.01.37.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 01:37:55 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.180.gc5b3e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132755>

gitk's external diff fails when browsing read-only repositories.
This is due to gitk's assumption that the current directory is
always writable.  By honoring TMPDIR we avoid this problem and
allow users to define the location used for temporary files.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index db5ec54..a065e94 100755
--- a/gitk
+++ b/gitk
@@ -3170,11 +3170,15 @@ proc flist_hl {only} {
 }
 
 proc gitknewtmpdir {} {
-    global diffnum gitktmpdir gitdir
+    global diffnum gitktmpdir gitdir env
 
     if {![info exists gitktmpdir]} {
-	set gitktmpdir [file join [file dirname $gitdir] \
-			    [format ".gitk-tmp.%s" [pid]]]
+	if {[info exists env(TMPDIR)]} {
+	    set tmpdir $env(TMPDIR)
+	} else {
+	    set tmpdir [file dirname $gitdir]
+	}
+	set gitktmpdir [file join $tmpdir [format ".gitk-tmp.%s" [pid]]]
 	if {[catch {file mkdir $gitktmpdir} err]} {
 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
 	    unset gitktmpdir
-- 
1.6.5.2.180.gc5b3e
