From: Remi Rampin <remirampin@gmail.com>
Subject: [PATCH 2/2] Makes chooser set 'gitdir' to the resolved path
Date: Thu,  5 Feb 2015 11:20:15 -0500
Message-ID: <1423153215-9706-3-git-send-email-remirampin@gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>
 <1423153215-9706-1-git-send-email-remirampin@gmail.com>
Cc: patthoyts@users.sourceforge.net, Remi Rampin <remirampin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 17:20:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJPAM-0006nu-OJ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 17:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167AbbBEQU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 11:20:27 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:48441 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893AbbBEQU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 11:20:26 -0500
Received: by mail-qc0-f177.google.com with SMTP id p6so7124060qcv.8
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNm7NbXHQGi82PZKGrOqt8X+xtcVbbfFVNFGU2jBudo=;
        b=npxmmlvMd0kD/qA6jQ0A//Vbvo7AQscoQwe7l/jPPsnAXP33Lx2pjs/Q5xS/I8UUfW
         hXsvbryhn02j6cakmyFUfDLH7EOZon+DwRo4m1JwOVSpVHkqXdT0QXPZxcSOpp1a0gSK
         0hkv+/EKSoebwL3eOTbGzYq7PBMQvmvQSxDxsah/XNGVyjVFrQzTtKIJJDcMKmU6eP7N
         5yFXbFxuwGIUrqsLbBqwxfL3+5ov9imi1hwHTnHpnM409CX66XC5UPxqZqNpmrcmMwZn
         ajozV56pdhX8Jn5+e/fLwWnD7v1L4klYY4sA1rnWQTN2Zfgrc/xCNxaXnPrU/QTEKVHh
         zbew==
X-Received: by 10.224.72.8 with SMTP id k8mr10183117qaj.26.1423153225982;
        Thu, 05 Feb 2015 08:20:25 -0800 (PST)
Received: from debian-78-amd64.poly.edu ([128.238.102.81])
        by mx.google.com with ESMTPSA id c16sm5333798qge.24.2015.02.05.08.20.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2015 08:20:25 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1423153215-9706-1-git-send-email-remirampin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263377>

If _is_git follows a "gitdir: ..." file link to get to the actual
repository, we want _gitdir to be set to that final path.
---
 lib/choose_repository.tcl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index abc6b1d..75d1da8 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -338,7 +338,10 @@ method _git_init {} {
 	return 1
 }
 
-proc _is_git {path} {
+proc _is_git {path {outdir_var ""}} {
+	if {$outdir_var ne ""} {
+		upvar 1 $outdir_var outdir
+	}
 	if {[file isfile $path]} {
 		set fp [open $path r]
 		gets $fp line
@@ -352,12 +355,14 @@ proc _is_git {path} {
 	if {[file exists [file join $path HEAD]]
 	 && [file exists [file join $path objects]]
 	 && [file exists [file join $path config]]} {
+		set outdir $path
 		return 1
 	}
 	if {[is_Cygwin]} {
 		if {[file exists [file join $path HEAD]]
 		 && [file exists [file join $path objects.lnk]]
 		 && [file exists [file join $path config.lnk]]} {
+			set outdir $path
 			return 1
 		}
 	}
@@ -1103,7 +1108,7 @@ method _open_local_path {} {
 }
 
 method _do_open2 {} {
-	if {![_is_git [file join $local_path .git]]} {
+	if {![_is_git [file join $local_path .git] actualgit]} {
 		error_popup [mc "Not a Git repository: %s" [file tail $local_path]]
 		return
 	}
@@ -1116,7 +1121,7 @@ method _do_open2 {} {
 	}
 
 	_append_recentrepos [pwd]
-	set ::_gitdir .git
+	set ::_gitdir $actualgit
 	set ::_prefix {}
 	set done 1
 }
-- 
1.9.5.msysgit.0
