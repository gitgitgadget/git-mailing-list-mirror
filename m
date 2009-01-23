From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI BUG)] git-gui: Fix post-commit status with subject in non-locale encoding.
Date: Sat, 24 Jan 2009 00:18:13 +0300
Organization: HOME
Message-ID: <200901240018.13457.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 22:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQTQS-0005ft-Qu
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 22:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbZAWVR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 16:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755229AbZAWVR2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 16:17:28 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:48251 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135AbZAWVR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 16:17:27 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1422063fkf.5
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 13:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/ZInuf94hxG+K2MIxLKTAAK4qoQirDrV235xLvLNmyU=;
        b=b53D8KUNcb9n5uWD9BWtRt4amaeoNkDteLdrZtNah3z0T2kkJR/T8ujeDfCv4z+M+j
         7ad/ayspUhn4xjtSCqXS8R/yMHPD4imngsJYKMBj/Pi1M1ieCLZGs3IxYkEhL4ENjKjU
         arm27e5OdSCEsO7/tDSu7f2lAcZecQbhAANyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=jQrGSt+YkdKWhZ+a7dbGb6ht2A1Gtwfqj7WJcd+orsu2qqC2M14Vq2KL5+EfsGmeIR
         /CDlXSCgfoPOwzBbq7jNPsgHPaVaQX5XadX6bgvE2JH/4RtzxbcRdW28mRUWke1ddast
         JcVhAZSrYde+2VAK/jA/yuq0uqAhSbSRksyUc=
Received: by 10.223.124.209 with SMTP id v17mr137531far.6.1232745444151;
        Fri, 23 Jan 2009 13:17:24 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id y15sm10730707fkd.32.2009.01.23.13.17.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 13:17:23 -0800 (PST)
User-Agent: KMail/1.10.4 (Linux/2.6.27.9-159.fc10.i686; KDE/4.1.4; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106916>

As pointed out in msysgit bug #181, when a non-locale encoding
is used for commits, post-commit status messages display the
subject incorrectly. It happens because the file handle is
not properly configured before the subject is read back.

This patch fixes it by factoring out the code that is
used to setup the output handle into a separate function,
and calling it from the reading code.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	The original bug report:

	http://code.google.com/p/msysgit/issues/detail?id=181


 lib/commit.tcl |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index 9cc8410..17aba91 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -115,6 +115,23 @@ proc create_new_commit {} {
 	rescan ui_ready
 }
 
+proc setup_commit_encoding {msg_wt {quiet 0}} {
+	global repo_config
+
+	if {[catch {set enc $repo_config(i18n.commitencoding)}]} {
+		set enc utf-8
+	}
+	set use_enc [tcl_encoding $enc]
+	if {$use_enc ne {}} {
+		fconfigure $msg_wt -encoding $use_enc
+	} else {
+		if {!$quiet} {
+			error_popup [mc "warning: Tcl does not support encoding '%s'." $enc]
+		}
+		fconfigure $msg_wt -encoding utf-8
+	}
+}
+
 proc commit_tree {} {
 	global HEAD commit_type file_states ui_comm repo_config
 	global pch_error
@@ -200,16 +217,7 @@ A good commit message has the following format:
 	set msg_p [gitdir GITGUI_EDITMSG]
 	set msg_wt [open $msg_p w]
 	fconfigure $msg_wt -translation lf
-	if {[catch {set enc $repo_config(i18n.commitencoding)}]} {
-		set enc utf-8
-	}
-	set use_enc [tcl_encoding $enc]
-	if {$use_enc ne {}} {
-		fconfigure $msg_wt -encoding $use_enc
-	} else {
-		error_popup [mc "warning: Tcl does not support encoding '%s'." $enc]
-		fconfigure $msg_wt -encoding utf-8
-	}
+	setup_commit_encoding $msg_wt
 	puts $msg_wt $msg
 	close $msg_wt
 
@@ -362,6 +370,7 @@ A rescan will be automatically started now.
 		append reflogm " ($commit_type)"
 	}
 	set msg_fd [open $msg_p r]
+	setup_commit_encoding $msg_fd 1
 	gets $msg_fd subject
 	close $msg_fd
 	append reflogm {: } $subject
-- 
1.6.1.63.g950db
